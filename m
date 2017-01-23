From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/8] usb: dwc3: core.h: add some register definitions
Date: Mon, 23 Jan 2017 13:19:37 +0200
Message-ID: <1485170381-32110-5-git-send-email-rogerq@ti.com>
References: <1485170381-32110-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485170381-32110-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, tony@atomide.com
Cc: peter.chen@freescale.com, vivek.gautam@codeaurora.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add OTG and GHWPARAMS6 register definitions

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.h | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d514dca..fc82d2e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -204,6 +204,15 @@
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
+/* Global Status Register */
+#define DWC3_GSTS_OTG_IP	BIT(10)
+#define DWC3_GSTS_BC_IP		BIT(9)
+#define DWC3_GSTS_ADP_IP	BIT(8)
+#define DWC3_GSTS_HOST_IP	BIT(7)
+#define DWC3_GSTS_DEVICE_IP	BIT(6)
+#define DWC3_GSTS_CSR_TIMEOUT	BIT(5)
+#define DWC3_GSTS_BUS_ERR_ADDR_VLD	BIT(4)
+
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	BIT(31)
 #define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	BIT(30)
@@ -288,6 +297,11 @@
 #define DWC3_MAX_HIBER_SCRATCHBUFS		15
 
 /* Global HWPARAMS6 Register */
+#define DWC3_GHWPARAMS6_BCSUPPORT		BIT(14)
+#define DWC3_GHWPARAMS6_OTG3SUPPORT		BIT(13)
+#define DWC3_GHWPARAMS6_ADPSUPPORT		BIT(12)
+#define DWC3_GHWPARAMS6_HNPSUPPORT		BIT(11)
+#define DWC3_GHWPARAMS6_SRPSUPPORT		BIT(10)
 #define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)
 
 /* Global HWPARAMS7 Register */
@@ -469,6 +483,74 @@
 #define DWC3_DEV_IMOD_INTERVAL_SHIFT	0
 #define DWC3_DEV_IMOD_INTERVAL_MASK	(0xffff << 0)
 
+/* OTG Configuration Register */
+#define DWC3_OCFG_DISPWRCUTTOFF		BIT(5)
+#define DWC3_OCFG_HIBDISMASK		BIT(4)
+#define DWC3_OCFG_SFTRSTMASK		BIT(3)
+#define DWC3_OCFG_OTGVERSION		BIT(2)
+#define DWC3_OCFG_HNPCAP		BIT(1)
+#define DWC3_OCFG_SRPCAP		BIT(0)
+
+/* OTG CTL Register */
+#define DWC3_OCTL_OTG3GOERR		BIT(7)
+#define DWC3_OCTL_PERIMODE		BIT(6)
+#define DWC3_OCTL_PRTPWRCTL		BIT(5)
+#define DWC3_OCTL_HNPREQ		BIT(4)
+#define DWC3_OCTL_SESREQ		BIT(3)
+#define DWC3_OCTL_TERMSELIDPULSE	BIT(2)
+#define DWC3_OCTL_DEVSETHNPEN		BIT(1)
+#define DWC3_OCTL_HSTSETHNPEN		BIT(0)
+
+/* OTG Event Register */
+#define DWC3_OEVT_DEVICEMODE		BIT(31)
+#define DWC3_OEVT_XHCIRUNSTPSET		BIT(27)
+#define DWC3_OEVT_DEVRUNSTPSET		BIT(26)
+#define DWC3_OEVT_HIBENTRY		BIT(25)
+#define DWC3_OEVT_CONIDSTSCHNG		BIT(24)
+#define DWC3_OEVT_HRRCONFNOTIF		BIT(23)
+#define DWC3_OEVT_HRRINITNOTIF		BIT(22)
+#define DWC3_OEVT_ADEVIDLE		BIT(21)
+#define DWC3_OEVT_ADEVBHOSTEND		BIT(20)
+#define DWC3_OEVT_ADEVHOST		BIT(19)
+#define DWC3_OEVT_ADEVHNPCHNG		BIT(18)
+#define DWC3_OEVT_ADEVSRPDET		BIT(17)
+#define DWC3_OEVT_ADEVSESSENDDET	BIT(16)
+#define DWC3_OEVT_BDEVBHOSTEND		BIT(11)
+#define DWC3_OEVT_BDEVHNPCHNG		BIT(10)
+#define DWC3_OEVT_BDEVSESSVLDDET	BIT(9)
+#define DWC3_OEVT_BDEVVBUSCHNG		BIT(8)
+#define DWC3_OEVT_BSESSVLD		BIT(3)
+#define DWC3_OEVT_HSTNEGSTS		BIT(2)
+#define DWC3_OEVT_SESREQSTS		BIT(1)
+#define DWC3_OEVT_ERROR			BIT(0)
+
+/* OTG Event Enable Register */
+#define DWC3_OEVTEN_XHCIRUNSTPSETEN	BIT(27)
+#define DWC3_OEVTEN_DEVRUNSTPSETEN	BIT(26)
+#define DWC3_OEVTEN_HIBENTRYEN		BIT(25)
+#define DWC3_OEVTEN_CONIDSTSCHNGEN	BIT(24)
+#define DWC3_OEVTEN_HRRCONFNOTIFEN	BIT(23)
+#define DWC3_OEVTEN_HRRINITNOTIFEN	BIT(22)
+#define DWC3_OEVTEN_ADEVIDLEEN		BIT(21)
+#define DWC3_OEVTEN_ADEVBHOSTENDEN	BIT(20)
+#define DWC3_OEVTEN_ADEVHOSTEN		BIT(19)
+#define DWC3_OEVTEN_ADEVHNPCHNGEN	BIT(18)
+#define DWC3_OEVTEN_ADEVSRPDETEN	BIT(17)
+#define DWC3_OEVTEN_ADEVSESSENDDETEN	BIT(16)
+#define DWC3_OEVTEN_BDEVHOSTENDEN	BIT(11)
+#define DWC3_OEVTEN_BDEVHNPCHNGEN	BIT(10)
+#define DWC3_OEVTEN_BDEVSESSVLDDETEN	BIT(9)
+#define DWC3_OEVTEN_BDEVVBUSCHNGE	BIT(8)
+
+/* OTG Status Register */
+#define DWC3_OSTS_DEVRUNSTP		BIT(13)
+#define DWC3_OSTS_XHCIRUNSTP		BIT(12)
+#define DWC3_OSTS_PERIPHERALSTATE	BIT(4)
+#define DWC3_OSTS_XHCIPRTPOWER		BIT(3)
+#define DWC3_OSTS_BSESVLD		BIT(2)
+#define DWC3_OSTS_VBUSVLD		BIT(1)
+#define DWC3_OSTS_CONIDSTS		BIT(0)
+
 /* Structures */
 
 struct dwc3_trb;
-- 
2.7.4
