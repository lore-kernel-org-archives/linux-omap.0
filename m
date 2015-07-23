From: Nikhil Badola <nikhil.badola-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/3] drivers: usb: dwc3: Add adjust_frame_length_quirk
Date: Thu, 23 Jul 2015 15:41:35 +0530
Message-ID: <1437646295-1858-1-git-send-email-nikhil.badola@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Nikhil Badola <nikhil.badola-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add adjust_frame_length_quirk for writing to fladj register
which adjusts (micro)frame length to value provided by
"snps,configure-fladj" property thus avoiding USB 2.0 devices
to time-out over a longer run

Signed-off-by: Nikhil Badola <nikhil.badola-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/usb/dwc3/core.c | 12 ++++++++++++
 drivers/usb/dwc3/core.h |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 5c110d8..72ba025 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -779,6 +779,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
+	u32			fladj_value;
 
 	int			ret;
 
@@ -886,6 +887,12 @@ static int dwc3_probe(struct platform_device *pdev)
 				&tx_de_emphasis);
 		of_property_read_string(node, "snps,hsphy_interface",
 					&dwc->hsphy_interface);
+		ret = of_property_read_u32(node, "snps,configure-fladj",
+					   &fladj_value);
+		if (!ret)
+			dwc->adjust_frame_length_quirk = 1;
+		else
+			dwc->adjust_frame_length_quirk = 0;
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -957,6 +964,11 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	/* Adjust Frame Length */
+	if (dwc->adjust_frame_length_quirk)
+		dwc3_writel(dwc->regs, DWC3_GFLADJ, GFLADJ_30MHZ_REG_SEL |
+			    GFLADJ_30MHZ(fladj_value));
+
 	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
 		dwc->dr_mode = USB_DR_MODE_HOST;
 	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 0447788..b7a5119 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -124,6 +124,7 @@
 #define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
 
 #define DWC3_GHWPARAMS8		0xc600
+#define DWC3_GFLADJ		0xc630
 
 /* Device Registers */
 #define DWC3_DCFG		0xc700
@@ -234,6 +235,10 @@
 /* Global HWPARAMS6 Register */
 #define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
 
+/* Global Frame Length Adjustment Register */
+#define GFLADJ_30MHZ_REG_SEL		(1 << 7)
+#define GFLADJ_30MHZ(n)			((n) & 0x3f)
+
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
@@ -712,6 +717,7 @@ struct dwc3_scratchpad_array {
  * @rx_detect_poll_quirk: set if we enable rx_detect to polling lfps quirk
  * @dis_u3_susphy_quirk: set if we disable usb3 suspend phy
  * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
+ * @adjust_frame_length_quirk: enables post-silicon frame length adjustment
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  * 	0	- -6dB de-emphasis
@@ -841,6 +847,7 @@ struct dwc3 {
 	unsigned		rx_detect_poll_quirk:1;
 	unsigned		dis_u3_susphy_quirk:1;
 	unsigned		dis_u2_susphy_quirk:1;
+	unsigned		adjust_frame_length_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
