From: Philippe De Swert <philippe.deswert-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Subject: RE: [PATCH 1/1] usb: Include generic_interrupt for OMAP2_PLUS
Date: Wed, 26 Sep 2012 14:06:16 +0000
Message-ID: <02DC685EFE4B1942A41870A0F2608047A65157@ORD2MBX02B.mex05.mlsrvr.com>
References: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
	<20120924121538.GH2892@arwen.pp.htv.fi>
	<CAPsFW+RTLpgXFOOh9fD=K1wCPMpBe4MummhWoqEBEEYYzMay=Q@mail.gmail.com>
	<20120924130216.GA5603@arwen.pp.htv.fi>	<20120924160914.GB28835@atomide.com>
	<20120925080420.GH9137@arwen.pp.htv.fi>
	<CAPsFW+T_ezWAxO9StSf9cu9nJ6Gw8T9Dk1H3g6+bwJ-PKtn-cQ@mail.gmail.com>,<CAPe0uWoX92e6Hbazji+s9DPiZnfxqE=a=5Hnu39SrD6qZnRWzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPe0uWoX92e6Hbazji+s9DPiZnfxqE=a=5Hnu39SrD6qZnRWzg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "praveen.nadahally-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org" <praveen.nadahally-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Philippe De Swert <philippedeswert-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, "heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "kishon-l0cyMroinI0@public.gmane.org" <kishon-l0cyMroinI0@public.gmane.org>, "marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "shubhrajyoti-l0cyMroinI0@public.gmane.org" <shubhrajyoti-l0cyMroinI0@public.gmane.org>, "nsekhar-l0cyMroinI0@public.gmane.org" <nsekhar-l0cyMroinI0@public.gmane.org>, "notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "vikram.pandita-l0cyMroinI0@public.gmane.org" <vikram.pandita-l0cyMroinI0@public.gmane.org>, "ravibabu-l0cyMroinI0@public.gmane.org" <ravibabu-l0cyMroinI0@public.gmane.org>, "mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org" <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>, "mian.yousaf.kaukab-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org" <mian.yousaf.kaukab-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
________________________________________
>On Tue, Sep 25, 2012 at 2:39 PM, Philippe De Swert
>>> Then maybe it's best to just remove the ifdefs and always provide
>>> generic_interrupt() ?
>>>
>>> Anyone against it ?
>
>Providing generic_interrupt seems fine.
>
>> Well it seems there are only two drivers that use it omap2430 and
>> ux500. Maybe we somehow link it to the drivers that need it? (I might
>> have missed other drivers but it looks like it is just those two)
>
>One way I see is that omap2430 and ux500 implement the isr handler
>in platform glue driver and then call the musb_interrupt() as done in
>daxxx, amxxx, ti8xxx platforms. Then generic_interrupt can be removed.

So something along those lines? (If this is the right way I will resend as a real patch)

>From deae78e1084749f340ae8b8aaeca51818d5bfc55 Mon Sep 17 00:00:00 2001
From: Philippe De Swert <philippe.deswert-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Date: Wed, 26 Sep 2012 17:00:46 +0300
Subject: [PATCH 1/1] musb: Move generic_interrupt out of the way

Have all musb drivers define their own isr.

Signed-off-by: Philippe De Swert <philippe.deswert-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |   33 ++-------------------------------
 drivers/usb/musb/omap2430.c  |   22 ++++++++++++++++++++++
 drivers/usb/musb/ux500.c     |   21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 26f1bef..1d5ee34 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1496,35 +1496,6 @@ static int __devinit musb_core_init(u16 musb_type, struct musb *musb)
 	return 0;
 }
 
-/*-------------------------------------------------------------------------*/
-
-#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430) || \
-	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500)
-
-static irqreturn_t generic_interrupt(int irq, void *__hci)
-{
-	unsigned long	flags;
-	irqreturn_t	retval = IRQ_NONE;
-	struct musb	*musb = __hci;
-
-	spin_lock_irqsave(&musb->lock, flags);
-
-	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
-	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
-	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
-
-	if (musb->int_usb || musb->int_tx || musb->int_rx)
-		retval = musb_interrupt(musb);
-
-	spin_unlock_irqrestore(&musb->lock, flags);
-
-	return retval;
-}
-
-#else
-#define generic_interrupt	NULL
-#endif
-
 /*
  * handle all the irqs defined by the HDRC core. for now we expect:  other
  * irq sources (phy, dma, etc) will be handled first, musb->int_* values
@@ -1907,7 +1878,8 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	musb->ops = plat->platform_ops;
 
 	/* The musb_platform_init() call:
-	 *   - adjusts musb->mregs and musb->isr if needed,
+	 *   - adjusts musb->mregs if needed 
+	 *   - sets the musb->isr 
 	 *   - may initialize an integrated tranceiver
 	 *   - initializes musb->xceiv, usually by otg_get_phy()
 	 *   - stops powering VBUS
@@ -1917,7 +1889,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	 * external/discrete ones in various flavors (twl4030 family,
 	 * isp1504, non-OTG, etc) mostly hooking up through ULPI.
 	 */
-	musb->isr = generic_interrupt;
 	status = musb_platform_init(musb);
 	if (status < 0)
 		goto fail1;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 5fdb9da..5461619d 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -306,6 +306,26 @@ static void omap_musb_mailbox_work(struct work_struct *mailbox_work)
 	omap_musb_set_mailbox(glue);
 }
 
+static irqreturn_t omap2430_musb_interrupt(int irq, void *__hci)
+{
+        unsigned long   flags;
+        irqreturn_t     retval = IRQ_NONE;
+        struct musb     *musb = __hci;
+
+        spin_lock_irqsave(&musb->lock, flags);
+
+        musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
+        musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
+        musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
+
+        if (musb->int_usb || musb->int_tx || musb->int_rx)
+                retval = musb_interrupt(musb);
+
+        spin_unlock_irqrestore(&musb->lock, flags);
+
+        return retval;
+}
+
 static int omap2430_musb_init(struct musb *musb)
 {
 	u32 l;
@@ -325,6 +345,8 @@ static int omap2430_musb_init(struct musb *musb)
 		return -ENODEV;
 	}
 
+	musb->isr = omap2430_musb_interrupt;
+
 	status = pm_runtime_get_sync(dev);
 	if (status < 0) {
 		dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index a8c0fad..ec9aaec 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -36,6 +36,26 @@ struct ux500_glue {
 };
 #define glue_to_musb(g)	platform_get_drvdata(g->musb)
 
+static irqreturn_t ux500_musb_interrupt(int irq, void *__hci)
+{
+        unsigned long   flags;
+        irqreturn_t     retval = IRQ_NONE;
+        struct musb     *musb = __hci;
+
+        spin_lock_irqsave(&musb->lock, flags);
+
+        musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
+        musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
+        musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
+
+        if (musb->int_usb || musb->int_tx || musb->int_rx)
+                retval = musb_interrupt(musb);
+
+        spin_unlock_irqrestore(&musb->lock, flags);
+
+        return retval;
+}
+
 static int ux500_musb_init(struct musb *musb)
 {
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
@@ -43,6 +63,7 @@ static int ux500_musb_init(struct musb *musb)
 		pr_err("HS USB OTG: no transceiver configured\n");
 		return -ENODEV;
 	}
+	musb->isr = ux500_musb_interrupt;
 
 	return 0;
 }
-- 
1.7.10.4


Cheers,

Philippe--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
