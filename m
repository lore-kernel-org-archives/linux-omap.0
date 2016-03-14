From: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Subject: [PATCH v2 1/2] usb: dwc3: add disable receiver detection in P3 quirk
Date: Mon, 14 Mar 2016 14:40:50 +0530
Message-ID: <1457946651-23381-2-git-send-email-rajesh.bhagat@nxp.com>
References: <1457946651-23381-1-git-send-email-rajesh.bhagat@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457946651-23381-1-git-send-email-rajesh.bhagat@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sriram.dash@nxp.com, Rajesh Bhagat <rajesh.bhagat@nxp.com>
List-Id: linux-omap@vger.kernel.org

Some freescale QorIQ platforms require to disable receiver detection
in P3 for correct detection of USB devices. If GUSB3PIPECTL(DISRXDETINP3)
is set, Core will change PHY power state to P2 and then perform receiver
detection. After receiver detection, Core will change PHY power state to
P3. Same quirk would be added in dts file in future patches.

Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
---
Changes for v2 : 
	- added the property code in alphabetical order.

 drivers/usb/dwc3/core.c          | 6 ++++++
 drivers/usb/dwc3/core.h          | 2 ++
 drivers/usb/dwc3/platform_data.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index de5e01f..c840df0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -446,6 +446,9 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
 
+	if (dwc->dis_rxdet_inp3_quirk)
+		reg |= DWC3_GUSB3PIPECTL_DISRXDETINP3;
+
 	if (dwc->req_p1p2p3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_REQP1P2P3;
 
@@ -919,6 +922,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,dis_u2_susphy_quirk");
 	dwc->dis_enblslpm_quirk = device_property_read_bool(dev,
 				"snps,dis_enblslpm_quirk");
+	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
+				"snps,dis_rxdet_inp3_quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
@@ -953,6 +958,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->dis_u3_susphy_quirk = pdata->dis_u3_susphy_quirk;
 		dwc->dis_u2_susphy_quirk = pdata->dis_u2_susphy_quirk;
 		dwc->dis_enblslpm_quirk = pdata->dis_enblslpm_quirk;
+		dwc->dis_rxdet_inp3_quirk = pdata->dis_rxdet_inp3_quirk;
 
 		dwc->tx_de_emphasis_quirk = pdata->tx_de_emphasis_quirk;
 		if (pdata->tx_de_emphasis)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e4f8b90..494119c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -193,6 +193,7 @@
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
+#define DWC3_GUSB3PIPECTL_DISRXDETINP3	(1 << 28)
 #define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
@@ -870,6 +871,7 @@ struct dwc3 {
 	unsigned		dis_u3_susphy_quirk:1;
 	unsigned		dis_u2_susphy_quirk:1;
 	unsigned		dis_enblslpm_quirk:1;
+	unsigned		dis_rxdet_inp3_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 2bb4d3a..aaa44db 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -43,6 +43,7 @@ struct dwc3_platform_data {
 	unsigned dis_u3_susphy_quirk:1;
 	unsigned dis_u2_susphy_quirk:1;
 	unsigned dis_enblslpm_quirk:1;
+	unsigned dis_rxdet_inp3_quirk:1;
 
 	unsigned tx_de_emphasis_quirk:1;
 	unsigned tx_de_emphasis:2;
-- 
2.6.2.198.g614a2ac
