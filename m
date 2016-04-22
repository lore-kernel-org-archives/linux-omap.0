From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Fri, 22 Apr 2016 05:57:56 +0000
Message-ID: <SG2PR06MB091932D7F837BCD2FDBD81E7D86F0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <SG2PR06MB091922CDE73AE061A79E90E4D8900@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <57064850.3060405@ti.com>
 <SG2PR06MB09197595F9D810CF8A22D860D8910@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570B8268.6090700@ti.com>
 <SG2PR06MB0919398D3CF4944A6EA2754DD8970@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570F7827.8050707@ti.com>
 <SG2PR06MB09195754753D7FDDAB05D3FDD8970@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570F7FB3.2040807@ti.com>
 <SG2PR06MB091917060D7951EB304808CFD8680@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <20160422012646.GA29299@shlinux2.ap.freescale.net>
 <20160422033414.GB29299@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160422033414.GB29299-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Content-Language: ja-JP
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> From: Peter Chen
> Sent: Friday, April 22, 2016 12:34 PM
> 
> On Fri, Apr 22, 2016 at 09:26:46AM +0800, Peter Chen wrote:
> > On Fri, Apr 15, 2016 at 10:03:16AM +0000, Yoshihiro Shimoda wrote:
> > > Hi,
> > >
> > > > From: Yoshihiro Shimoda
> > > > Sent: Friday, April 15, 2016 6:59 PM
> > > >
> > > > Hi,
> > > >
> > > > > From: Roger Quadros
> > > > > Sent: Thursday, April 14, 2016 8:32 PM
> > > > >
> > > > > On 14/04/16 14:15, Yoshihiro Shimoda wrote:
> > > > > > Hi,
> > > > > >
> > > > < snip >
> > > > > >>> @@ -865,7 +867,8 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
> > > > > >>>  	 * we're ready only if we have shared HCD
> > > > > >>>  	 * or we don't need shared HCD.
> > > > > >>>  	 */
> > > > > >>> -	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
> > > > > >>> +	if (otg->shared_hcd.hcd || (!otg->caps->needs_companion &&
> > > > > >>> +				    !otg->primary_hcd.hcd->shared_hcd)) {
> > > > > >>>  		otg->host = hcd_to_bus(hcd);
> > > > > >>>  		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
> > > > > >>>
> > > > > >>
> > > > > >> These changes look good to me. Thanks.
> > > > > >
> > > > > > Thank you for the comment.
> > > > > > If we change the "needs_companion" place to the otg_config,
> > > > > > do we need to add a flag into the otg, instead of otg->caps?
> > > > >
> > > > > Yes we can add a flag in struct usb_otg.
> > > >
> > > > Thank you for the comment.
> > > >
> > > > I made a fixed patch.
> > > > So, should I send this patch to ML after you sent v7 patches?
> > > > Or, would you apply this patch before you send v7 patches?
> > >
> > > Oops, I sent this email without my patch...
> > >
> > > ---
> > > Subject: [PATCH] usb: otg: add hcd companion support
> > >
> > > Since some host controller (e.g. EHCI) needs a companion host controller
> > > (e.g. OHCI), this patch adds such a configuration to use it in the OTG
> > > core.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > >  Documentation/devicetree/bindings/usb/generic.txt |  3 +++
> > >  drivers/usb/common/usb-otg.c                      | 17 +++++++++++++----
> > >  include/linux/usb/otg.h                           |  7 ++++++-
> > >  3 files changed, 22 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> > > index f6866c1..1db1c33 100644
> > > --- a/Documentation/devicetree/bindings/usb/generic.txt
> > > +++ b/Documentation/devicetree/bindings/usb/generic.txt
> > > @@ -27,6 +27,9 @@ Optional properties:
> > >   - otg-controller: phandle to otg controller. Host or gadget controllers can
> > >  			contain this property to link it to a particular OTG
> > >  			controller.
> > > + - hcd-needs-companion: must be present if otg controller is dealing with
> > > +			EHCI host controller that needs a companion OHCI host
> > > +			controller.
> > >
> > >  This is an attribute to a USB controller such as:
> > >
> > > diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
> > > index 41e762a..83c8c96 100644
> > > --- a/drivers/usb/common/usb-otg.c
> > > +++ b/drivers/usb/common/usb-otg.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/list.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_platform.h>
> > > +#include <linux/usb/of.h>
> > >  #include <linux/usb/otg.h>
> > >  #include <linux/usb/gadget.h>
> > >  #include <linux/workqueue.h>
> > > @@ -600,6 +601,10 @@ struct usb_otg *usb_otg_register(struct device *dev,
> > >  	else
> > >  		INIT_WORK(&otg->work, usb_otg_work);
> > >
> > > +	if (of_find_property(dev->of_node, "hcd-needs-companion", NULL) ||
> > > +	    config->hcd_needs_companion)	/* needs comanion ? */
> > > +		otg->flags |= OTG_FLAG_HCD_NEEDS_COMPANION;
> > > +
> > >  	otg->wq = create_singlethread_workqueue("usb_otg");
> > >  	if (!otg->wq) {
> > >  		dev_err(dev, "otg: %s: can't create workqueue\n",
> > > @@ -823,13 +828,15 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
> > >  	/* HCD will be started by OTG fsm when needed */
> > >  	mutex_lock(&otg->fsm.lock);
> > >  	if (otg->primary_hcd.hcd) {
> > > -		/* probably a shared HCD ? */
> > > -		if (usb_otg_hcd_is_primary_hcd(hcd)) {
> > > +		/* probably a shared HCD or a companion OHCI HCD ? */
> > > +		if (!(otg->flags & OTG_FLAG_HCD_NEEDS_COMPANION) &&
> > > +		    usb_otg_hcd_is_primary_hcd(hcd)) {
> > >  			dev_err(otg_dev, "otg: primary host already registered\n");
> > >  			goto err;
> > >  		}
> > >
> > > -		if (hcd->shared_hcd == otg->primary_hcd.hcd) {
> > > +		if (otg->flags & OTG_FLAG_HCD_NEEDS_COMPANION ||
> > > +		    (hcd->shared_hcd == otg->primary_hcd.hcd)) {
> > >  			if (otg->shared_hcd.hcd) {
> > >  				dev_err(otg_dev, "otg: shared host already registered\n");
> > >  				goto err;
> > > @@ -865,7 +872,9 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
> > >  	 * we're ready only if we have shared HCD
> > >  	 * or we don't need shared HCD.
> > >  	 */
> > > -	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
> > > +	if (otg->shared_hcd.hcd ||
> > > +	    (!(otg->flags & OTG_FLAG_HCD_NEEDS_COMPANION) &&
> > > +	     !otg->primary_hcd.hcd->shared_hcd)) {
> > >  		otg->host = hcd_to_bus(hcd);
> > >  		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
> > >
> > > diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> > > index b094352..6f4ca77 100644
> > > --- a/include/linux/usb/otg.h
> > > +++ b/include/linux/usb/otg.h
> > > @@ -57,7 +57,8 @@ struct otg_hcd {
> > >   * @list: list of otg controllers
> > >   * @work: otg state machine work
> > >   * @wq: otg state machine work queue
> > > - * @flags: to track if host/gadget is running
> > > + * @flags: to track if host/gadget is running, or to indicate if hcd needs
> > > + *	   companion
> > >   */
> > >  struct usb_otg {
> > >  	u8			default_a;
> > > @@ -84,6 +85,7 @@ struct usb_otg {
> > >  	u32 flags;
> > >  #define OTG_FLAG_GADGET_RUNNING (1 << 0)
> > >  #define OTG_FLAG_HOST_RUNNING (1 << 1)
> > > +#define OTG_FLAG_HCD_NEEDS_COMPANION (1 << 2)
> > >  	/* use otg->fsm.lock for serializing access */
> > >
> > >  /*------------- deprecated interface -----------------------------*/
> > > @@ -125,11 +127,14 @@ struct usb_otg_caps {
> > >   * @caps: otg capabilities of the controller
> > >   * @ops: otg fsm operations
> > >   * @otg_work: optional custom otg state machine work function
> > > + * @hcd_needs_companion: Indicates if host controller needs a companion
> > > + *			 controller
> > >   */
> > >  struct usb_otg_config {
> > >  	struct usb_otg_caps *otg_caps;
> > >  	struct otg_fsm_ops *fsm_ops;
> > >  	void (*otg_work)(struct work_struct *work);
> > > +	bool hcd_needs_companion;
> > >  };
> > >
> > >  extern const char *usb_otg_state_string(enum usb_otg_state state);
> > > --
> >
> > Hi Yoshihiro, the shared_hcd is used for USB3 only [1], this patch may
> > not be suitable for supporting companion controller at OTG framework.
> > For companion or other USB2 controllers, both primary hcd and shard hcd
> > are NULL for HCD core.
> >
> 
> Oh, I may be wrong. It should be ok for companion controller by using
> this patch. Yoshihiro, do all below variables are NULL after both hcds
> call usb_otg_register_hcd?
> 
> otg->primary_hcd.hcd->shared_hcd
> otg->primary_hcd.hcd->primary_hcd
> otg->shared_hcd.hcd->shared_hcd
> otg->shared_hcd.hcd->primary_hcd

Thank you for the review twice! :)
I checked these variables and the variables was set to NULL after both
hcds call usb_otg_register_hcd.

< a patch for the check >
diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
index 83c8c96..1fb7ea0 100644
--- a/drivers/usb/common/usb-otg.c
+++ b/drivers/usb/common/usb-otg.c
@@ -884,6 +884,19 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
 		dev_dbg(otg_dev, "otg: can't start till shared host registers\n");
 	}
 
+	if (otg->primary_hcd.hcd) {
+		dev_info(otg_dev, "primary_hcd.hcd->shared_hcd = %p\n",
+				otg->primary_hcd.hcd->shared_hcd);
+		dev_info(otg_dev, "primary_hcd.hcd->primary_hcd = %p\n",
+				otg->primary_hcd.hcd->primary_hcd);
+	}
+	if (otg->shared_hcd.hcd) {
+		dev_info(otg_dev, "shared_hcd.hcd->shared_hcd = %p\n",
+				otg->shared_hcd.hcd->shared_hcd);
+		dev_info(otg_dev, "shared_hcd.hcd->primary_hcd = %p\n",
+				otg->shared_hcd.hcd->primary_hcd);
+	}
+
 	mutex_unlock(&otg->fsm.lock);
 
 	return 0;

< result >
[    1.797122] phy_rcar_gen3_usb2 ee080200.usb-phy: otg: limiting to dual-role
[    1.804228] phy_rcar_gen3_usb2 ee080200.usb-phy: otg: primary host ee080100.usb registered
[    1.812168] phy_rcar_gen3_usb2 ee080200.usb-phy: primary_hcd.hcd->shared_hcd =           (null)
[    1.820520] phy_rcar_gen3_usb2 ee080200.usb-phy: primary_hcd.hcd->primary_hcd =           (null)
[    1.829136] phy_rcar_gen3_usb2 ee080200.usb-phy: otg: shared host ee080000.usb registered
[    1.836993] phy_rcar_gen3_usb2 ee080200.usb-phy: otg: can't start till gadget registers
[    1.844675] phy_rcar_gen3_usb2 ee080200.usb-phy: primary_hcd.hcd->shared_hcd =           (null)
[    1.853024] phy_rcar_gen3_usb2 ee080200.usb-phy: primary_hcd.hcd->primary_hcd =           (null)
[    1.861458] phy_rcar_gen3_usb2 ee080200.usb-phy: shared_hcd.hcd->shared_hcd =           (null)
[    1.869724] phy_rcar_gen3_usb2 ee080200.usb-phy: shared_hcd.hcd->primary_hcd =           (null)

Best regards,
Yoshihiro Shimoda

> --
> 
> Best Regards,
> Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
