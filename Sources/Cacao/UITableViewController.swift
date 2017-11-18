//
//  UITableViewController.swift
//  Cacao
//
//  Created by Alsey Coleman Miller on 11/18/17.
//

import Foundation
import Silica

/// A controller object that manages a table view.
open class UITableViewController: UIViewController {
    
    // MARK: - Initializing the UITableViewController Object
    
    public convenience init() {
        
        // If you use the standard init method to initialize a UITableViewController object,
        // a table view in the plain style is created.
        // https://developer.apple.com/documentation/uikit/uitableviewcontroller/1614754-init
        self.init(style: .plain)
    }
    
    /// Initializes a table-view controller to manage a table view of a given style.
    public init(style: UITableViewStyle) {
        
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Getting the Table View
    
    /// Returns the table view managed by the controller object.
    public var tableView: UITableView! {
        
        get { return self.view as? UITableView }
        
        set { self.view = newValue }
    }
    
    // MARK: - Configuring the Table Behavior
    
    /// A Boolean value indicating if the controller clears the selection when the table appears.
    ///
    /// The default value of this property is `true`.
    /// When `true`, the table view controller clears the table’s current selection
    /// when it receives a `viewWillAppear(_:)` message.
    /// Setting this property to `false` preserves the selection.
    public var clearsSelectionOnViewWillAppear: Bool = true
    
    // MARK: - Refreshing the Table View
    
    /// The refresh control used to update the table contents.
    ///
    /// - Note: The default value of this property is nil.
    ///
    /// Assigning a refresh control to this property adds the control to the view controller’s associated interface.
    /// You do not need to set the frame of the refresh control before associating it with the view controller.
    /// The view controller updates the control’s height and width and sets its position appropriately.
    ///
    /// The table view controller does not automatically update table’s contents in response to user interactions
    /// with the refresh control. When the user initiates a refresh operation, the control generates a valueChanged event.
    /// You must associate a target and action method with this event and use them to refresh your table’s contents.
    public var refreshControl: UIRefreshControl? {
        
        get { return self.tableView.refreshControl }
        
        set { self.tableView.refreshControl = newValue }
    }
    
    // MARK: - Overriden Methods
    
    open override func loadView() {
        
        self.tableView = UITableView(frame: .zero, style: style)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(self.tableView != nil, "Table View not loaded")
    }
    
    open override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated: animated)
        
        /// Reload on first appearance
        if self.didReload == false {
            
            self.tableView.reloadData()
            self.didReload = true
        }
        
        // clear selection
        if self.clearsSelectionOnViewWillAppear,
            let selectedRow = self.tableView.indexPathForSelectedRow {
            
            self.tableView.deselectRow(at: selectedRow, animated: animated)
        }
    }
    
    open override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated: animated)
        
        // flash scroll indicators
        self.tableView.flashScrollIndicators()
    }
    
    open override var description: String {
        
        return String(format: "<%@: %p; tableView = %@>", self.className, self, self.tableView)
    }
    
    // MARK: - Private
    
    private let style: UITableViewStyle
    
    private var didReload = false
}

extension UITableViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        fatalError("\(type(of: self)) cannot provide cells for \(#function)")
    }
}

extension UITableViewController: UITableViewDelegate { } // nothing to implement
