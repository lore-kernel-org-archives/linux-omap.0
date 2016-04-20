From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Wed, 20 Apr 2016 05:08:39 +0000
Message-ID: <TY1PR06MB0928A9A8113F63C1191D9AA3D86D0@TY1PR06MB0928.apcprd06.prod.outlook.com>
References: <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <SG2PR06MB091922CDE73AE061A79E90E4D8900@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <57064850.3060405@ti.com>
 <SG2PR06MB09197595F9D810CF8A22D860D8910@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570B8268.6090700@ti.com>
 <SG2PR06MB0919398D3CF4944A6EA2754DD8970@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570F7827.8050707@ti.com>
 <SG2PR06MB09195754753D7FDDAB05D3FDD8970@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570F7FB3.2040807@ti.com>
 <SG2PR06MB091917060D7951EB304808CFD8680@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <20160419091807.GC15789@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160419091807.GC15789@shlinux2.ap.freescale.net>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>, Roger Quadros <rogerq@ti.com>
Cc: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> From: Peter Chen
> Sent: Tuesday, April 19, 2016 6:18 PM
> 
> On Fri, Apr 15, 2016 at 10:03:16AM +0000, Yoshihiro Shimoda wrote:
> > Hi,
> >
> > > From: Yoshihiro Shimoda
> > > Sent: Friday, April 15, 2016 6:59 PM
> > >
> > > Hi,
> > >
> > > > From: Roger Quadros
> > > > Sent: Thursday, April 14, 2016 8:32 PM
> > > >
> > > > On 14/04/16 14:15, Yoshihiro Shimoda wrote:
> > > > > Hi,
> > > > >
> > > < snip >
> > > > >>> @@ -865,7 +867,8 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
> > > > >>>  	 * we're ready only if we have shared HCD
> > > > >>>  	 * or we don't need shared HCD.
> > > > >>>  	 */
> > > > >>> -	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
> > > > >>> +	if (otg->shared_hcd.hcd || (!otg->caps->needs_companion &&
> > > > >>> +				    !otg->primary_hcd.hcd->shared_hcd)) {
> > > > >>>  		otg->host = hcd_to_bus(hcd);
> > > > >>>  		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
> > > > >>>
> > > > >>
> > > > >> These changes look good to me. Thanks.
> > > > >
> > > > > Thank you for the comment.
> > > > > If we change the "needs_companion" place to the otg_config,
> > > > > do we need to add a flag into the otg, instead of otg->caps?
> > > >
> > > > Yes we can add a flag in struct usb_otg.
> > >
> > > Thank you for the comment.
> > >
> > > I made a fixed patch.
> > > So, should I send this patch to ML after you sent v7 patches?
> > > Or, would you apply this patch before you send v7 patches?
> >
> > Oops, I sent this email without my patch...
> >
> > ---
> > Subject: [PATCH] usb: otg: add hcd companion support
> >
> > Since some host controller (e.g. EHCI) needs a companion host controller
> > (e.g. OHCI), this patch adds such a configuration to use it in the OTG
> > core.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/usb/generic.txt |  3 +++
> >  drivers/usb/common/usb-otg.c                      | 17 +++++++++++++----
> >  include/linux/usb/otg.h                           |  7 ++++++-
> >  3 files changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> > index f6866c1..1db1c33 100644
> > --- a/Documentation/devicetree/bindings/usb/generic.txt
> > +++ b/Documentation/devicetree/bindings/usb/generic.txt
> > @@ -27,6 +27,9 @@ Optional properties:
> >   - otg-controller: phandle to otg controller. Host or gadget controllers can
> >  			contain this property to link it to a particular OTG
> >  			controller.
> > + - hcd-needs-companion: must be present if otg controller is dealing with
> > +			EHCI host controller that needs a companion OHCI host
> > +			controller.
> >
> >  This is an attribute to a USB controller such as:
> >
> > diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
> > index 41e762a..83c8c96 100644
> > --- a/drivers/usb/common/usb-otg.c
> > +++ b/drivers/usb/common/usb-otg.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/list.h>
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/usb/of.h>
> >  #include <linux/usb/otg.h>
> >  #include <linux/usb/gadget.h>
> >  #include <linux/workqueue.h>
> > @@ -600,6 +601,10 @@ struct usb_otg *usb_otg_register(struct device *dev,
> >  	else
> >  		INIT_WORK(&otg->work, usb_otg_work);
> >
> > +	if (of_find_property(dev->of_node, "hcd-needs-companion", NULL) ||
> > +	    config->hcd_needs_companion)	/* needs comanion ? */
> 
> %s/comanion/companion

Thank you for pointing it out!

Roger, would you fix this in your v7 patch set?

> I have a little puzzled with companion controller and shared hcd, let me
> post a topic for it.

I looked at the email thread.
It is very useful information to me! :)

Best regards,
Yoshihiro Shimoda

> Peter
> 
> > +		otg->flags |= OTG_FLAG_HCD_NEEDS_COMPANION;
> > +
> >  	otg->wq = create_singlethread_workqueue("usb_otg");
> >  	if (!otg->wq) {
> >  		dev_err(dev, "otg: %s: can't create workqueue\n",
> > @@ -823,13 +828,15 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
> >  	/* HCD will be started by OTG fsm when needed */
> >  	mutex_lock(&otg->fsm.lock);
> >  	if (otg->primary_hcd.hcd) {
> > -		/* probably a shared HCD ? */
> > -		if (usb_otg_hcd_is_primary_hcd(hcd)) {
> > +		/* probably a shared HCD or a companion OHCI HCD ? */
> > +		if (!(otg->flags & OTG_FLAG_HCD_NEEDS_COMPANION) &&
> > +		    usb_otg_hcd_is_primary_hcd(hcd)) {
> >  			dev_err(otg_dev, "otg: primary host already registered\n");
> >  			goto err;
> >  		}
> >
> > -		if (hcd->shared_hcd == otg->primary_hcd.hcd) {
> > +		if (otg->flags & OTG_FLAG_HCD_NEEDS_COMPANION ||
> > +		    (hcd->shared_hcd == otg->primary_hcd.hcd)) {
> >  			if (otg->shared_hcd.hcd) {
> >  				dev_err(otg_dev, "otg: shared host already registered\n");
> >  				goto err;
> > @@ -865,7 +872,9 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
> >  	 * we're ready only if we have shared HCD
> >  	 * or we don't need shared HCD.
> >  	 */
> > -	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
> > +	if (otg->shared_hcd.hcd ||
> > +	    (!(otg->flags & OTG_FLAG_HCD_NEEDS_COMPANION) &&
> > +	     !otg->primary_hcd.hcd->shared_hcd)) {
> >  		otg->host = hcd_to_bus(hcd);
> >  		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
> >
> > diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> > index b094352..6f4ca77 100644
> > --- a/include/linux/usb/otg.h
> > +++ b/include/linux/usb/otg.h
> > @@ -57,7 +57,8 @@ struct otg_hcd {
> >   * @list: list of otg controllers
> >   * @work: otg state machine work
> >   * @wq: otg state machine work queue
> > - * @flags: to track if host/gadget is running
> > + * @flags: to track if host/gadget is running, or to indicate if hcd needs
> > + *	   companion
> >   */
> >  struct usb_otg {
> >  	u8			default_a;
> > @@ -84,6 +85,7 @@ struct usb_otg {
> >  	u32 flags;
> >  #define OTG_FLAG_GADGET_RUNNING (1 << 0)
> >  #define OTG_FLAG_HOST_RUNNING (1 << 1)
> > +#define OTG_FLAG_HCD_NEEDS_COMPANION (1 << 2)
> >  	/* use otg->fsm.lock for serializing access */
> >
> >  /*------------- deprecated interface -----------------------------*/
> > @@ -125,11 +127,14 @@ struct usb_otg_caps {
> >   * @caps: otg capabilities of the controller
> >   * @ops: otg fsm operations
> >   * @otg_work: optional custom otg state machine work function
> > + * @hcd_needs_companion: Indicates if host controller needs a companion
> > + *			 controller
> >   */
> >  struct usb_otg_config {
> >  	struct usb_otg_caps *otg_caps;
> >  	struct otg_fsm_ops *fsm_ops;
> >  	void (*otg_work)(struct work_struct *work);
> > +	bool hcd_needs_companion;
> >  };
> >
> >  extern const char *usb_otg_state_string(enum usb_otg_state state);
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> 
> Best Regards,
> Peter Chen
