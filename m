From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] usb: phy: twl6030-usb: Remove unused irq_enabled
Date: Thu, 28 Aug 2014 11:19:02 -0700
Message-ID: <20140828181901.GL16006@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: kishon@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

It's not being used any longer.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Felipe, here's the twl6030 only version for you to pick.

--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -104,7 +104,6 @@ struct twl6030_usb {
 	int			irq2;
 	enum omap_musb_vbus_id_status linkstat;
 	u8			asleep;
-	bool			irq_enabled;
 	bool			vbus_enable;
 	const char		*regulator;
 };
@@ -373,7 +372,6 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 
 	INIT_WORK(&twl->set_vbus_work, otg_set_vbus_work);
 
-	twl->irq_enabled = true;
 	status = request_threaded_irq(twl->irq1, NULL, twl6030_usbotg_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 			"twl6030_usb", twl);
