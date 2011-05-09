From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] omap: usbhs: Fixed the crash during rmmod of ehci and ohci
Date: Mon, 9 May 2011 14:40:03 +0530
Message-ID: <1304932203-31223-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-bask2-l0cyMroinI0@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>

the disabling of clocks and freeing GPIO are changed
to fix the occurence of the crash of rmmod of ehci and ohci
drivers

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 3ab9ffa..cda0797 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -939,6 +939,7 @@ static void usbhs_disable(struct device *dev)
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
 	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
 	unsigned long			flags = 0;
+	unsigned int			halt = 0;
 	unsigned long			timeout;
 
 	dev_dbg(dev, "stopping TI HSUSB Controller\n");
@@ -994,24 +995,31 @@ static void usbhs_disable(struct device *dev)
 			dev_dbg(dev, "operation timed out\n");
 	}
 
-	if (pdata->ehci_data->phy_reset) {
-		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
-			gpio_free(pdata->ehci_data->reset_gpio_port[0]);
-
-		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
-			gpio_free(pdata->ehci_data->reset_gpio_port[1]);
+	if (is_omap_usbhs_rev2(omap)) {
+		if (is_ehci_tll_mode(pdata->port_mode[0]))
+			clk_enable(omap->usbtll_p1_fck);
+		if (is_ehci_tll_mode(pdata->port_mode[1]))
+			clk_enable(omap->usbtll_p2_fck);
+		clk_disable(omap->utmi_p2_fck);
+		clk_disable(omap->utmi_p1_fck);
 	}
 
-	clk_disable(omap->utmi_p2_fck);
-	clk_disable(omap->utmi_p1_fck);
 	clk_disable(omap->usbtll_ick);
 	clk_disable(omap->usbtll_fck);
 	clk_disable(omap->usbhost_fs_fck);
 	clk_disable(omap->usbhost_hs_fck);
 	clk_disable(omap->usbhost_ick);
+	halt = 1;
 
 end_disble:
 	spin_unlock_irqrestore(&omap->lock, flags);
+	if (halt && pdata->ehci_data->phy_reset) {
+		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
+			gpio_free(pdata->ehci_data->reset_gpio_port[0]);
+
+		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
+			gpio_free(pdata->ehci_data->reset_gpio_port[1]);
+	}
 }
 
 int omap_usbhs_enable(struct device *dev)
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
