From: Nikhil Badola <nikhil.badola@freescale.com>
Subject: [PATCH 2/3][v4] drivers: usb: dwc3: Add frame length adjustment quirk
Date: Fri, 4 Sep 2015 10:15:58 +0530
Message-ID: <1441341958-17379-1-git-send-email-nikhil.badola@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, gregkh@linuxfoundation.org, Nikhil Badola <nikhil.badola@freescale.com>
List-Id: linux-omap@vger.kernel.org

Add adjust_frame_length_quirk for writing to fladj register
which adjusts (micro)frame length to value provided by
"snps,quirk-frame-length-adjustment" property thus avoiding
USB 2.0 devices to time-out over a longer run

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
---
Changes for v4: Removed mixed declerations and code

 drivers/usb/dwc3/core.c          | 34 ++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h          |  5 +++++
 drivers/usb/dwc3/platform_data.h |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 064123e..6270581 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -143,6 +143,32 @@ static int dwc3_soft_reset(struct dwc3 *dwc)
 	return 0;
 }
 
+/*
+ * dwc3_frame_length_adjustment - Adjusts frame length if required
+ * @dwc3: Pointer to our controller context structure
+ * @fladj: Value of GFLADJ_30MHZ to adjust frame length
+ */
+static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
+{
+	u32 reg;
+	u32 dft;
+
+	if (dwc->revision < DWC3_REVISION_250A)
+		return;
+
+	if (fladj == 0)
+		return;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
+	dft = reg & DWC3_GFLADJ_30MHZ_MASK;
+	if (!dev_WARN_ONCE(dwc->dev, dft == fladj,
+	    "request value same as default, ignoring\n")) {
+		reg &= ~DWC3_GFLADJ_30MHZ_MASK;
+		reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL | fladj;
+		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
+	}
+}
+
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
@@ -779,6 +805,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
+	u32			fladj = 0;
 
 	int			ret;
 
@@ -886,6 +913,9 @@ static int dwc3_probe(struct platform_device *pdev)
 				&tx_de_emphasis);
 		of_property_read_string(node, "snps,hsphy_interface",
 					&dwc->hsphy_interface);
+		of_property_read_u32(node,
+				     "snps,quirk-frame-length-adjustment",
+				     &fladj);
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -915,6 +945,7 @@ static int dwc3_probe(struct platform_device *pdev)
 			tx_de_emphasis = pdata->tx_de_emphasis;
 
 		dwc->hsphy_interface = pdata->hsphy_interface;
+		fladj = pdata->fladj_value;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
@@ -971,6 +1002,9 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	/* Adjust Frame Length */
+	dwc3_frame_length_adjustment(dwc, fladj);
+
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 0447788..9188745 100644
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
+#define DWC3_GFLADJ_30MHZ_SDBND_SEL		(1 << 7)
+#define DWC3_GFLADJ_30MHZ_MASK			0x3f
+
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index d3614ec..400b197 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -46,5 +46,7 @@ struct dwc3_platform_data {
 	unsigned tx_de_emphasis_quirk:1;
 	unsigned tx_de_emphasis:2;
 
+	u32 fladj_value;
+
 	const char *hsphy_interface;
 };
-- 
2.1.0
