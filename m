From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [balbi-usb:testing/next 35/35]
 drivers/usb/gadget/udc/snps_udc_core.c:197:11: warning: format '%x' expects
 argument of type 'unsigned int', but argument 4 has type 'long unsigned int'
Date: Sat, 3 Jun 2017 12:07:15 +0800
Message-ID: <201706031203.Lz9V7x4C%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Raviteja Garimella <raviteja.garimella-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
head:   ad9721fbf4c4dd7e57372662b91adb8ba0c3a9fc
commit: ad9721fbf4c4dd7e57372662b91adb8ba0c3a9fc [35/35] usb: gadget: udc: Add Synopsys UDC Platform driver
config: m32r-allmodconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ad9721fbf4c4dd7e57372662b91adb8ba0c3a9fc
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:329:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/usb/gadget/udc/snps_udc_core.c:23:
   drivers/usb/gadget/udc/snps_udc_core.c: In function 'print_regs':
>> drivers/usb/gadget/udc/snps_udc_core.c:197:11: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
     DBG(dev, "dev config     = %08x\n", readl(&dev->regs->cfg));
              ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/usb/gadget/udc/amd5536udc.h:658:28: note: in expansion of macro 'dev_dbg'
    #define DBG(udc , args...) dev_dbg(udc->dev, args)
                               ^~~~~~~
>> drivers/usb/gadget/udc/snps_udc_core.c:197:2: note: in expansion of macro 'DBG'
     DBG(dev, "dev config     = %08x\n", readl(&dev->regs->cfg));
     ^~~
   drivers/usb/gadget/udc/snps_udc_core.c:198:11: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
     DBG(dev, "dev control    = %08x\n", readl(&dev->regs->ctl));
              ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/usb/gadget/udc/amd5536udc.h:658:28: note: in expansion of macro 'dev_dbg'
    #define DBG(udc , args...) dev_dbg(udc->dev, args)
                               ^~~~~~~
   drivers/usb/gadget/udc/snps_udc_core.c:198:2: note: in expansion of macro 'DBG'
     DBG(dev, "dev control    = %08x\n", readl(&dev->regs->ctl));
     ^~~
   drivers/usb/gadget/udc/snps_udc_core.c:199:11: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
     DBG(dev, "dev status     = %08x\n", readl(&dev->regs->sts));
              ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/usb/gadget/udc/amd5536udc.h:658:28: note: in expansion of macro 'dev_dbg'
    #define DBG(udc , args...) dev_dbg(udc->dev, args)
                               ^~~~~~~
   drivers/usb/gadget/udc/snps_udc_core.c:199:2: note: in expansion of macro 'DBG'
     DBG(dev, "dev status     = %08x\n", readl(&dev->regs->sts));
     ^~~
   drivers/usb/gadget/udc/snps_udc_core.c:201:11: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
     DBG(dev, "dev int's      = %08x\n", readl(&dev->regs->irqsts));
              ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/usb/gadget/udc/amd5536udc.h:658:28: note: in expansion of macro 'dev_dbg'
    #define DBG(udc , args...) dev_dbg(udc->dev, args)
                               ^~~~~~~
   drivers/usb/gadget/udc/snps_udc_core.c:201:2: note: in expansion of macro 'DBG'
     DBG(dev, "dev int's      = %08x\n", readl(&dev->regs->irqsts));
     ^~~
   drivers/usb/gadget/udc/snps_udc_core.c:202:11: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
     DBG(dev, "dev intmask    = %08x\n", readl(&dev->regs->irqmsk));
              ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/usb/gadget/udc/amd5536udc.h:658:28: note: in expansion of macro 'dev_dbg'
    #define DBG(udc , args...) dev_dbg(udc->dev, args)
                               ^~~~~~~
   drivers/usb/gadget/udc/snps_udc_core.c:202:2: note: in expansion of macro 'DBG'
     DBG(dev, "dev intmask    = %08x\n", readl(&dev->regs->irqmsk));
     ^~~
   drivers/usb/gadget/udc/snps_udc_core.c:204:11: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
     DBG(dev, "dev ep int's   = %08x\n", readl(&dev->regs->ep_irqsts));
              ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/usb/gadget/udc/amd5536udc.h:658:28: note: in expansion of macro 'dev_dbg'
    #define DBG(udc , args...) dev_dbg(udc->dev, args)
                               ^~~~~~~
   drivers/usb/gadget/udc/snps_udc_core.c:204:2: note: in expansion of macro 'DBG'
     DBG(dev, "dev ep int's   = %08x\n", readl(&dev->regs->ep_irqsts));
     ^~~
   drivers/usb/gadget/udc/snps_udc_core.c:205:11: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
     DBG(dev, "dev ep intmask = %08x\n", readl(&dev->regs->ep_irqmsk));
              ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/usb/gadget/udc/amd5536udc.h:658:28: note: in expansion of macro 'dev_dbg'
    #define DBG(udc , args...) dev_dbg(udc->dev, args)
                               ^~~~~~~
   drivers/usb/gadget/udc/snps_udc_core.c:205:2: note: in expansion of macro 'DBG'
     DBG(dev, "dev ep intmask = %08x\n", readl(&dev->regs->ep_irqmsk));
     ^~~
   drivers/usb/gadget/udc/snps_udc_core.c: In function 'udc_data_out_isr':
   drivers/usb/gadget/udc/snps_udc_core.c:2105:13: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=]
       DBG(dev, "BNA ep%dout occurred - DESPTR = %x\n",
                ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/usb/gadget/udc/amd5536udc.h:658:28: note: in expansion of macro 'dev_dbg'
    #define DBG(udc , args...) dev_dbg(udc->dev, args)
                               ^~~~~~~
   drivers/usb/gadget/udc/snps_udc_core.c:2105:4: note: in expansion of macro 'DBG'
       DBG(dev, "BNA ep%dout occurred - DESPTR = %x\n",
       ^~~

vim +197 drivers/usb/gadget/udc/snps_udc_core.c

55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   17   */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   18  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   19  /* Driver strings */
97b3ffa2 drivers/usb/gadget/udc/amd5536udc.c Raviteja Garimella 2017-03-28   20  #define UDC_MOD_DESCRIPTION		"Synopsys USB Device Controller"
c15e03e1 drivers/usb/gadget/amd5536udc.c     Cyril Roelandt     2012-02-25   21  #define UDC_DRIVER_VERSION_STRING	"01.00.0206"
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   22  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  @23  #include <linux/module.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   24  #include <linux/pci.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   25  #include <linux/kernel.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   26  #include <linux/delay.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   27  #include <linux/ioport.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   28  #include <linux/sched.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   29  #include <linux/slab.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   30  #include <linux/errno.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   31  #include <linux/timer.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   32  #include <linux/list.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   33  #include <linux/interrupt.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   34  #include <linux/ioctl.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   35  #include <linux/fs.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   36  #include <linux/dmapool.h>
b38b03b3 drivers/usb/gadget/amd5536udc.c     Bryan Wu           2011-06-02   37  #include <linux/prefetch.h>
97b3ffa2 drivers/usb/gadget/udc/amd5536udc.c Raviteja Garimella 2017-03-28   38  #include <linux/moduleparam.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   39  #include <asm/byteorder.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   40  #include <asm/unaligned.h>
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   41  #include "amd5536udc.h"
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   42  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   43  static void udc_tasklet_disconnect(unsigned long);
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   44  static void udc_setup_endpoints(struct udc *dev);
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   45  static void udc_soft_reset(struct udc *dev);
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   46  static struct udc_request *udc_alloc_bna_dummy(struct udc_ep *ep);
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   47  static void udc_free_request(struct usb_ep *usbep, struct usb_request *usbreq);
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   48  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   49  /* description */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   50  static const char mod_desc[] = UDC_MOD_DESCRIPTION;
97b3ffa2 drivers/usb/gadget/udc/amd5536udc.c Raviteja Garimella 2017-03-28   51  static const char name[] = "udc";
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   52  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   53  /* structure to hold endpoint function pointers */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   54  static const struct usb_ep_ops udc_ep_ops;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   55  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   56  /* received setup data */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   57  static union udc_setup_data setup_data;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   58  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   59  /* pointer to device object */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   60  static struct udc *udc;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   61  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   62  /* irq spin lock for soft reset */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   63  static DEFINE_SPINLOCK(udc_irq_spinlock);
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   64  /* stall spin lock */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   65  static DEFINE_SPINLOCK(udc_stall_spinlock);
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   66  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   67  /*
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   68  * slave mode: pending bytes in rx fifo after nyet,
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   69  * used if EPIN irq came but no req was available
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   70  */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   71  static unsigned int udc_rxfifo_pending;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   72  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   73  /* count soft resets after suspend to avoid loop */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   74  static int soft_reset_occured;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   75  static int soft_reset_after_usbreset_occured;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   76  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   77  /* timer */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   78  static struct timer_list udc_timer;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   79  static int stop_timer;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   80  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   81  /* set_rde -- Is used to control enabling of RX DMA. Problem is
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   82   * that UDC has only one bit (RDE) to enable/disable RX DMA for
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   83   * all OUT endpoints. So we have to handle race conditions like
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   84   * when OUT data reaches the fifo but no request was queued yet.
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   85   * This cannot be solved by letting the RX DMA disabled until a
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   86   * request gets queued because there may be other OUT packets
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   87   * in the FIFO (important for not blocking control traffic).
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   88   * The value of set_rde controls the correspondig timer.
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   89   *
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   90   * set_rde -1 == not used, means it is alloed to be set to 0 or 1
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   91   * set_rde  0 == do not touch RDE, do no start the RDE timer
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   92   * set_rde  1 == timer function will look whether FIFO has data
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   93   * set_rde  2 == set by timer function to enable RX DMA on next call
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   94   */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   95  static int set_rde = -1;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   96  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   97  static DECLARE_COMPLETION(on_exit);
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   98  static struct timer_list udc_pollstall_timer;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16   99  static int stop_pollstall_timer;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  100  static DECLARE_COMPLETION(on_pollstall_exit);
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  101  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  102  /* tasklet for usb disconnect */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  103  static DECLARE_TASKLET(disconnect_tasklet, udc_tasklet_disconnect,
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  104  		(unsigned long) &udc);
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  105  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  106  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  107  /* endpoint names used for print */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  108  static const char ep0_string[] = "ep0in";
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  109  static const struct {
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  110  	const char *name;
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  111  	const struct usb_ep_caps caps;
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  112  } ep_info[] = {
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  113  #define EP_INFO(_name, _caps) \
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  114  	{ \
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  115  		.name = _name, \
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  116  		.caps = _caps, \
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  117  	}
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  118  
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  119  	EP_INFO(ep0_string,
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  120  		USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  121  	EP_INFO("ep1in-int",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  122  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  123  	EP_INFO("ep2in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  124  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  125  	EP_INFO("ep3in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  126  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  127  	EP_INFO("ep4in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  128  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  129  	EP_INFO("ep5in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  130  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  131  	EP_INFO("ep6in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  132  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  133  	EP_INFO("ep7in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  134  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  135  	EP_INFO("ep8in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  136  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  137  	EP_INFO("ep9in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  138  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  139  	EP_INFO("ep10in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  140  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  141  	EP_INFO("ep11in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  142  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  143  	EP_INFO("ep12in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  144  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  145  	EP_INFO("ep13in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  146  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  147  	EP_INFO("ep14in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  148  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  149  	EP_INFO("ep15in-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  150  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  151  	EP_INFO("ep0out",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  152  		USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  153  	EP_INFO("ep1out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  154  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  155  	EP_INFO("ep2out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  156  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  157  	EP_INFO("ep3out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  158  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  159  	EP_INFO("ep4out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  160  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  161  	EP_INFO("ep5out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  162  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  163  	EP_INFO("ep6out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  164  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  165  	EP_INFO("ep7out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  166  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  167  	EP_INFO("ep8out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  168  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  169  	EP_INFO("ep9out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  170  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  171  	EP_INFO("ep10out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  172  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  173  	EP_INFO("ep11out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  174  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  175  	EP_INFO("ep12out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  176  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  177  	EP_INFO("ep13out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  178  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  179  	EP_INFO("ep14out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  180  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  181  	EP_INFO("ep15out-bulk",
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  182  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  183  
6f02ac5a drivers/usb/gadget/udc/amd5536udc.c Robert Baldyga     2015-07-31  184  #undef EP_INFO
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  185  };
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  186  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  187  /* buffer fill mode */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  188  static int use_dma_bufferfill_mode;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  189  /* tx buffer size for high speed */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  190  static unsigned long hs_tx_buf = UDC_EPIN_BUFF_SIZE;
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  191  
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  192  /*---------------------------------------------------------------------------*/
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  193  /* Prints UDC device registers and endpoint irq registers */
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  194  static void print_regs(struct udc *dev)
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  195  {
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  196  	DBG(dev, "------- Device registers -------\n");
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16 @197  	DBG(dev, "dev config     = %08x\n", readl(&dev->regs->cfg));
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  198  	DBG(dev, "dev control    = %08x\n", readl(&dev->regs->ctl));
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  199  	DBG(dev, "dev status     = %08x\n", readl(&dev->regs->sts));
55d402d8 drivers/usb/gadget/amd5536udc.c     Thomas Dahlmann    2007-07-16  200  	DBG(dev, "\n");

:::::: The code at line 197 was first introduced by commit
:::::: 55d402d854ade6b63b26e958f201ee2ef00b7b15 USB: amd5536 UDC driver (in GEODE southbridge)

:::::: TO: Thomas Dahlmann <thomas.dahlmann-5C7GfCeVMHo@public.gmane.org>
:::::: CC: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--pWyiEgJYm5f9v55/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
72v8ZXp70PJ1AWMkDuoElKBxy/l/oLVfD8SkAgA=

--pWyiEgJYm5f9v55/--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
