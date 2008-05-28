From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] Misc fixes to this series (CF: Change omap_cf.c to use
	omap_readw/writew instead of __REG for multi-omap)
Date: Tue, 27 May 2008 17:51:46 -0700
Message-ID: <20080528005145.GQ8845@atomide.com>
References: <1210972076-23911-1-git-send-email-tony@atomide.com> <1210972076-23911-2-git-send-email-tony@atomide.com> <200805161426.18409.david-b@pacbell.net> <20080516214909.GC23002@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63246 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbYE1Avs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2008 20:51:48 -0400
Content-Disposition: inline
In-Reply-To: <20080516214909.GC23002@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Tony Lindgren <tony@atomide.com> [080516 14:49]:
> * David Brownell <david-b@pacbell.net> [080516 14:26]:
> > On Friday 16 May 2008, Tony Lindgren wrote:
> > > @@ -38,19 +38,19 @@
> > >  #define        CF_BASE 0xfffe2800
> > >  
> > >  /* status; read after IRQ */
> > > -#define CF_STATUS_REG          __REG16(CF_BASE + 0x00)
> > > +#define CF_STATUS                      (CF_BASE + 0x00)
> > >  #      define  CF_STATUS_BAD_READ      (1 << 2)
> > >  #      define  CF_STATUS_BAD_WRITE     (1 << 1)
> > >  #      define  CF_STATUS_CARD_DETECT   (1 << 0)
> > >  
> > >  /* which chipselect (CS0..CS3) is used for CF (active low) */
> > > -#define CF_CFG_REG             __REG16(CF_BASE + 0x02)
> > > +#define CF_CFG                         (CF_BASE + 0x02)
> > >  
> > >	...
> > 
> > Trying to understand the plan here.  This first patches
> > are to remove __REG*() access, we hillater patches will 
> > be needed to convert things to omap_readl(BASE + OFFSET)
> > style accessors?  (BASE being SOC-specific, and passed
> > down from system init code.)
> > 
> > Not that CF is a good example of that.  I don't think
> > it exists on current chips.  ;)
> 
> Well ideally we would set the base offset during driver init, then
> just use  __raw_read/write().
> 
> But that's lot of work, so it's easier first to convert __REG access
> to use omap_read/write(). I'll post multi-omap series as soon as I have
> it booting.. But to give you and idea, we can have something like following
> work for multi-omap.

...

Turns out there were bunch of issues with the patches above..
Here's a patch fixing them. I will repost this series soon, just FYI.

Tony

--cNdxnHkX5QqsyA0e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fixes.patch"

--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -193,13 +193,10 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 
 		l = omap_readl(USB_TRANSCEIVER_CTRL);
 		l &= ~(7 << 4);
-		omap_writel(l, USB_TRANSCEIVER_CTRL);
-
 		if (!is_device) {
-			l = omap_readl(USB_TRANSCEIVER_CTRL);
 			l |= (3 << 1);
-			omap_writel(l, USB_TRANSCEIVER_CTRL);
 		}
+		omap_writel(l, USB_TRANSCEIVER_CTRL);
 
 		return 3 << 16;
 	}
@@ -643,9 +640,6 @@ omap_otg_init(struct omap_usb_config *config)
 
 		w = omap_readw(ULPD_CLOCK_CTRL);
 		w &= ~USB_MCLK_EN;
-		omap_writew(w, ULPD_CLOCK_CTRL);
-
-		w = omap_readw(ULPD_CLOCK_CTRL);
 		w |= DIS_USB_PVCI_CLK;
 		omap_writew(w, ULPD_CLOCK_CTRL);
 	}
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -520,7 +520,7 @@ static void update_otg1(struct isp1301 *isp, u8 int_src)
 
 	otg_ctrl = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
 	otg_ctrl &= ~OTG_XCEIV_INPUTS;
-	otg_ctrl &= (OTG_ID|OTG_ASESSVLD|OTG_VBUSVLD);
+	otg_ctrl &= ~(OTG_ID|OTG_ASESSVLD|OTG_VBUSVLD);
 
 
 	if (int_src & INTR_SESS_VLD)
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2858,7 +2858,6 @@ static int __init omap_udc_probe(struct platform_device *pdev)
 			 * means we always "need" the 48MHz clock.
 			 */
 			u32 tmp = omap_readl(FUNC_MUX_CTRL_0);
-
 			tmp &= ~VBUS_CTRL_1510;
 			omap_writel(tmp, FUNC_MUX_CTRL_0);
 			tmp |= VBUS_MODE_1510;
--- a/drivers/usb/gadget/omap_udc.h
+++ b/drivers/usb/gadget/omap_udc.h
@@ -202,6 +202,6 @@ struct omap_udc {
 #define	VBUS_MODE_1510		(1 << 18)	/* 0 hardware, 1 software */
 
 #define	HMC_1510	((omap_readl(MOD_CONF_CTRL_0) >> 1) & 0x3f)
-#define	HMC_1610	omap_readl(OTG_SYSCON_2 & 0x3f)
+#define	HMC_1610	(omap_readl(OTG_SYSCON_2) & 0x3f)
 #define	HMC		(cpu_is_omap15xx() ? HMC_1510 : HMC_1610)
 
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2003,7 +2003,7 @@ static irqreturn_t omap_udc_pio_irq(int irq, void *_dev)
 		ep->irqs++;
 
 		omap_writew(epnum | UDC_EP_DIR | UDC_EP_SEL, UDC_EP_NUM);
-		if (omap_readw(UDC_STAT_FLG & UDC_ACK)) {
+		if (omap_readw(UDC_STAT_FLG) & UDC_ACK) {
 			ep->ackwait = 0;
 			if (!list_empty(&ep->queue)) {
 				req = container_of(ep->queue.next,


--cNdxnHkX5QqsyA0e--
