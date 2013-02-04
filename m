From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 02/13] USB: phy: nop: Defer probe if device needs VCC/RESET
Date: Mon, 4 Feb 2013 17:58:49 +0200
Message-ID: <1359993540-20780-3-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359993540-20780-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add 2 flags, needs_vcc and needs_reset to platform data.
If the flag is set and the regulator couldn't be found
then we bail out with -EPROBE_DEFER.

For device tree boot we depend on presensce of vcc-supply/
reset-supply properties to decide if we should bail out
with -EPROBE_DEFER or just continue in case the regulator
can't be found.

This is required for proper functionality in cases where the
regulator is needed but is probed later than the PHY device.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/nop-usb-xceiv.c   |    8 ++++++++
 include/linux/usb/nop-usb-xceiv.h |    4 ++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index adbb7ab..7860e7569 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -147,6 +147,10 @@ static void nop_xeiv_get_dt_pdata(struct device *dev,
 
 	if (!of_property_read_u32(node, "clock-frequency", &clk_rate))
 		pdata->clk_rate = clk_rate;
+	if (of_property_read_bool(node, "vcc-supply"))
+		pdata->needs_vcc = true;
+	if (of_property_read_bool(node, "reset-supply"))
+		pdata->needs_reset = true;
 }
 
 static int nop_usb_xceiv_probe(struct platform_device *pdev)
@@ -205,12 +209,16 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
 	if (IS_ERR(nop->vcc)) {
 		dev_dbg(&pdev->dev, "Error getting vcc regulator: %ld\n",
 					PTR_ERR(nop->vcc));
+		if (pdata->needs_vcc)
+			return -EPROBE_DEFER;
 	}
 
 	nop->reset = devm_regulator_get(&pdev->dev, "reset");
 	if (IS_ERR(nop->reset)) {
 		dev_dbg(&pdev->dev, "Error getting reset regulator: %ld\n",
 					PTR_ERR(nop->reset));
+		if (pdata->needs_reset)
+			return -EPROBE_DEFER;
 	}
 
 	nop->dev		= &pdev->dev;
diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop-usb-xceiv.h
index 3265b61..148d351 100644
--- a/include/linux/usb/nop-usb-xceiv.h
+++ b/include/linux/usb/nop-usb-xceiv.h
@@ -6,6 +6,10 @@
 struct nop_usb_xceiv_platform_data {
 	enum usb_phy_type type;
 	unsigned long clk_rate;
+
+	/* if set fails with -EPROBE_DEFER if can't get regulator */
+	unsigned int needs_vcc:1;
+	unsigned int needs_reset:1;
 };
 
 #if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
