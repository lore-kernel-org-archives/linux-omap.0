From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Fri, 08 Mar 2013 17:44:48 +0100
Message-ID: <513A1580.90303@gmail.com>
References: <cover.1351870620.git.afzal@ti.com> <509420D8.1030307@gmail.com> <C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com> <51312430.6060306@gmail.com> <87sj4cunp6.fsf@dell.be.48ers.dk> <5133E268.5010604@gmail.com> <51388D64.9000005@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000001080908080802020701"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51388D64.9000005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Santhapuri, Damodar" <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000001080908080802020701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07.03.2013 13:51, Daniel Mack wrote:
> On 04.03.2013 00:53, Daniel Mack wrote:
>> Hi Peter,
>>
>> On 03.03.2013 23:24, Peter Korsgaard wrote:
>>>>>>>> "Daniel" == Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>
>>> Hi,
>>>
>>>  Daniel> On my board, the USB is purely used as host interface, with a
>>>  Daniel> type B plug soldered. In the DT, I'm using the following
>>>  Daniel> sniplet in accordance to the documentation of the bindings:
>>>
>>>  Daniel> 	usb_otg_hs: usb@47400000 {
>>>  Daniel> 		compatible = "ti,musb-am33xx";
>>>  Daniel> 		reg = <0x47400000 0x1000	/* usbss */
>>>  Daniel> 		       0x47401000 0x800		/* musb instance 0 */
>>>  Daniel> 		       0x47401800 0x800>;	/* musb instance 1 */
>>>  Daniel> 		interrupt-parent = <&intc>;
>>>  Daniel> 		interrupts = <17		/* usbss */
>>>  Daniel> 			      18		/* musb instance 0 */
>>>  19> ;		/* musb instance 1 */
>>>  Daniel> 		multipoint = <1>;
>>>  Daniel> 		num-eps = <16>;
>>>  Daniel> 		ram-bits = <12>;
>>>  Daniel> 		port0-mode = <3>;
>>>  Daniel> 		port1-mode = <3>;
>>>  Daniel> 		power = <250>;
>>>  Daniel> 		ti,hwmods = "usb_otg_hs";
>>>  Daniel> 	};
>>>
>>>  Daniel> The relevant config options are
>>>
>>>  Daniel> CONFIG_USB_MUSB_HDRC=y
>>>  Daniel> # CONFIG_USB_MUSB_TUSB6010 is not set
>>>  Daniel> # CONFIG_USB_MUSB_OMAP2PLUS is not set
>>>  Daniel> # CONFIG_USB_MUSB_AM35X is not set
>>>  Daniel> CONFIG_USB_MUSB_DSPS=y
>>>  Daniel> CONFIG_MUSB_PIO_ONLY=y
>>>  Daniel> CONFIG_USB_GADGET=y
>>>  Daniel> CONFIG_USB_GADGET_DEBUG=y
>>>  Daniel> CONFIG_USB_GADGET_DEBUG_FILES=y
>>>  Daniel> CONFIG_USB_GADGET_DEBUG_FS=y
>>>  Daniel> CONFIG_USB_GADGET_VBUS_DRAW=2
>>>  Daniel> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
>>>  Daniel> CONFIG_USB_GADGET_MUSB_HDRC=y
>>>
>>> Ehh, I'm confused here. You talk about host mode, a single 'B' (gadget)
>>> connector
>>
>> I'm sorry for the confusion caused. This is a stupid mistake - I'm in
>> fact talking about an 'A' type plug of course (host mode).
>>
>>> and your device tree mentions 2 OTG ports.
>>
>> That's what I said in a follow up - the same happens for mode '1'.
>>
>>> What is the configuration exactly?
>>
>> Again to summarize: host-only mode, type 'A' plug.
>>
>> The gadget driver is is enabled in the config because the only
>> occurrence of usb_add_hcd() in the musb driver is in the gagdget part,
>> so supposedly, there has to be a gadget driver loaded in order to make
>> the host interface going.
> 
> Just be clear: I'd happily help and dig for the reason of this, I'd just
> need to know how things are _supposed_ to work ...

So I dug a little on this topic, and restored the behaviour I need with
the attached patch.

The funny part is that the value set in the port0-mode/port1-mode DT
properties are not even looked at by the code.

I know this patch reintroduces bits that have been intentionally removed
before, in particular by 032ec49f53 ("usb: musb: drop useless board_mode
usage"), but I don't know how this usb driver is supposed to work in
host mode without taking the configured port mode into account. If
anyone can explain to me which information I'm missing here, I can
happily test a patch. For now, this works for me.


Thanks,
Daniel


--------------000001080908080802020701
Content-Type: text/x-patch;
 name="0001-drivers-usb-musb-re-enable-host-only-mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drivers-usb-musb-re-enable-host-only-mode.patch"

>From a98a5d15332dc261bb3f366ccc2ef6e2cb924730 Mon Sep 17 00:00:00 2001
From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Fri, 8 Mar 2013 17:31:10 +0100
Subject: [PATCH] drivers: usb: musb: re-enable host-only mode

Currently, the port%d-mode properties in DT are completely unused, and
support code for enabling host-only mode configurations is missing,
partly due to the recent rework in the musb core driver.

Fix this with the following changes:

 - store the port mode information in struct musb
 - in case of host-only mode setups, add the HCD directly from
   musb_init_controller()
 - refuse to start a gadget on a host-only configured port

Store the port mode in struct musb and handle

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_core.c   | 47 ++++++++++++++++++++++++++++++++++--------
 drivers/usb/musb/musb_core.h   |  5 +++++
 drivers/usb/musb/musb_gadget.c |  5 +++++
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 60b41cc..726c4ec 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -937,15 +937,19 @@ void musb_start(struct musb *musb)
 	devctl = musb_readb(regs, MUSB_DEVCTL);
 	devctl &= ~MUSB_DEVCTL_SESSION;
 
-	/* session started after:
-	 * (a) ID-grounded irq, host mode;
-	 * (b) vbus present/connect IRQ, peripheral mode;
-	 * (c) peripheral initiates, using SRP
-	 */
-	if ((devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS)
-		musb->is_active = 1;
-	else
+	if (musb->port_mode == MUSB_PORT_MODE_HOST) {
 		devctl |= MUSB_DEVCTL_SESSION;
+	} else {
+		/* session started after:
+		 * (a) ID-grounded irq, host mode;
+		 * (b) vbus present/connect IRQ, peripheral mode;
+		 * (c) peripheral initiates, using SRP
+		 */
+		if ((devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS)
+			musb->is_active = 1;
+		else
+			devctl |= MUSB_DEVCTL_SESSION;
+	}
 
 	musb_platform_enable(musb);
 	musb_writeb(regs, MUSB_DEVCTL, devctl);
@@ -1007,6 +1011,9 @@ static void musb_shutdown(struct platform_device *pdev)
 
 	musb_gadget_cleanup(musb);
 
+	if (musb->port_mode == MUSB_PORT_MODE_HOST)
+		usb_remove_hcd(musb_to_hcd(musb));
+
 	spin_lock_irqsave(&musb->lock, flags);
 	musb_platform_disable(musb);
 	musb_generic_disable(musb);
@@ -1866,6 +1873,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	musb->board_set_power = plat->set_power;
 	musb->min_power = plat->min_power;
 	musb->ops = plat->platform_ops;
+	musb->port_mode = plat->mode;
 
 	/* The musb_platform_init() call:
 	 *   - adjusts musb->mregs
@@ -1944,7 +1952,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	/* host side needs more setup */
 	hcd = musb_to_hcd(musb);
 	otg_set_host(musb->xceiv->otg, &hcd->self);
-	hcd->self.otg_port = 1;
 	musb->xceiv->otg->host = &hcd->self;
 	hcd->power_budget = 2 * (plat->power ? : 250);
 
@@ -1960,6 +1967,26 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	musb->xceiv->state = OTG_STATE_B_IDLE;
 
 	status = musb_gadget_setup(musb);
+	if (status < 0)
+		goto fail3;
+
+	/*
+	 * If the port is configured to 'host' mode only,
+	 * start the HCD here.
+	 */
+	if (musb->port_mode == MUSB_PORT_MODE_HOST) {
+		MUSB_HST_MODE(musb);
+		musb->xceiv->otg->default_a = 1;
+		musb->xceiv->state = OTG_STATE_A_IDLE;
+
+		status = usb_add_hcd(hcd, 0, 0);
+		if (status < 0)
+			goto fail3;
+
+		hcd->self.uses_pio_for_control = 1;
+	} else {
+		hcd->self.otg_port = 1;
+	}
 
 	if (status < 0)
 		goto fail3;
@@ -1983,6 +2010,8 @@ fail5:
 
 fail4:
 	musb_gadget_cleanup(musb);
+	if (musb->port_mode == MUSB_PORT_MODE_HOST)
+		usb_remove_hcd(hcd);
 
 fail3:
 	pm_runtime_put_sync(musb->controller);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 7fb4819..f89318d 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -51,6 +51,10 @@ struct musb;
 struct musb_hw_ep;
 struct musb_ep;
 
+#define MUSB_PORT_MODE_HOST	1
+#define MUSB_PORT_MODE_DEV	2
+#define MUSB_PORT_MODE_OTG	3
+
 /* Helper defines for struct musb->hwvers */
 #define MUSB_HWVERS_MAJOR(x)	((x >> 10) & 0x1f)
 #define MUSB_HWVERS_MINOR(x)	(x & 0x3ff)
@@ -369,6 +373,7 @@ struct musb {
 	u16 epmask;
 	u8 nr_endpoints;
 
+	int			port_mode;	/* MUSB_PORT_MODE_* */
 	int			(*board_set_power)(int state);
 
 	u8			min_power;	/* vbus for periph, in mA/2 */
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index be18537..4e1e993 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1948,6 +1948,11 @@ static int musb_gadget_start(struct usb_gadget *g,
 		goto err;
 	}
 
+	if (musb->port_mode == MUSB_PORT_MODE_HOST) {
+		retval = -EINVAL;
+		goto err;
+	}
+
 	pm_runtime_get_sync(musb->controller);
 
 	dev_dbg(musb->controller, "registering driver %s\n", driver->function);
-- 
1.8.1.4


--------------000001080908080802020701--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
