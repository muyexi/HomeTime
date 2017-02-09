import UIKit
import ObjectMapper
import DateTools

class ViewController: UITableViewController {
    
    lazy var northTramsAPI: TramsAPI = {
        let api = TramsAPI(stopId: "4055")
        api.completionHandler = { [unowned self] json in
            self.tableView.reloadData()
        }
        api.failureHandler = { json in
            
        }
        
        return api
    }()
    
    lazy var southTramsAPI: TramsAPI = {
        let api = TramsAPI(stopId: "4155")
        api.completionHandler = { [unowned self] json in
            self.tableView.reloadData()
        }
        api.failureHandler = { json in
            
        }
        
        return api
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func clearTramData(_ sender: Any) {
        northTramsAPI.trams = []
        southTramsAPI.trams = []
        
        tableView.reloadData()
    }
    
    @IBAction func loadTramData(_ sender: Any) {
        northTramsAPI.request()
        southTramsAPI.request()
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = String(describing: TramCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! TramCell
        
        let trams = indexPath.section == 0 ? northTramsAPI.trams : southTramsAPI.trams
        let isLoading = indexPath.section == 0 ? northTramsAPI.isLoading : southTramsAPI.isLoading
     
        cell.detailTextLabel?.text = ""
        if trams.count != 0 {
            let tram = trams[indexPath.row]
            cell.setup(tram: tram)
        } else if isLoading {
            cell.textLabel?.text = "Loading upcoming trams..."
        } else {
            cell.textLabel?.text = "No upcoming trams. Tap load to fetch"
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "North" : "South"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let trams = section == 0 ? northTramsAPI.trams : southTramsAPI.trams
        return trams.count == 0 ? 1 : trams.count
    }
    
}
