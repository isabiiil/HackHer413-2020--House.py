//
//  StartUpViewController.swift
//  LehmanHacks2019
//
//  Created by Sabri Sönmez on 11/16/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getStartedBtn: UIButton!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    //data for the slides
    var titles = ["Disability is a matter of perception.","Dyscalculia","Fun and Educational"]
    var descs = ["Our mission is to spread awareness of dyscalculia along with accessibility to resources that help children with LD. Using our app, children will improve the visual spatial component that is the root cause of dyscalculia, allowing them to create a sense of key math properties.","Dyscalculia is a common learning difference that makes it hard to do math. In comparison to dyslexia, there is much less awareness that dyscalculia exists. When looking at the research literature, for every fourteen research papers on dyslexia, there is only one on dyscalculia","Our sets of challenges builds cognitive, logical and spatial reasoning skills as well as visual perception skills while playing a game! Because it has a rule of logic (three cards that are all the same or all different in each individual feature), and because players must apply this rule to the spatial array of patterns all at once, they must use both left brain and right brain thought processes. This fun game actually exercises your brain!"]
    var imgs = ["mathsPic1","mathsPic2","mathsPic3"]
    
    //get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        
        //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
            
            let slide = UIView(frame: frame)
            
            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:0,y:0,width:200,height:200)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
            
            let txt1 = UILabel.init(frame: CGRect(x:0,y:imageView.frame.maxY+2,width:scrollWidth-5,height:30))
            txt1.textAlignment = .center
            txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
            txt1.text = titles[index]
            
            let txt2 = UILabel.init(frame: CGRect(x:0,y:txt1.frame.maxY,width:scrollWidth-5,height:200))
            txt2.textAlignment = .center
            txt2.numberOfLines = 0
            
            txt2.font = UIFont.systemFont(ofSize: 15.0)
            txt2.text = descs[index]
            
            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            scrollView.addSubview(slide)
            
        }
        
        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)
        
        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0
        
        //initial state
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
        
    }
    
    //indicator
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }
    
    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
        pageChanged(page)
    }
    
    @IBAction func getStartedPressed(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        self.performSegue(withIdentifier: "firstSegue", sender: nil)
    }
}
