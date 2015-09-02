From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 2/9] usb: dwc3: core.h: add some register definitions
Date: Wed, 2 Sep 2015 17:24:17 +0300
Message-ID: <1441203864-15786-3-git-send-email-rogerq@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441203864-15786-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add OTG and GHWPARAMS6 register definitions

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.h | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5ca2b25..4b85330 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -173,6 +173,15 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
 #define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
 
+/* Global Status Register */
+#define DWC3_GSTS_OTG_IP	(1 << 10)
+#define DWC3_GSTS_BC_IP		(1 << 9)
+#define DWC3_GSTS_ADP_IP	(1 << 8)
+#define DWC3_GSTS_HOST_IP	(1 << 7)
+#define DWC3_GSTS_DEVICE_IP	(1 << 6)
+#define DWC3_GSTS_CSR_TIMEOUT	(1 << 5)
+#define DWC3_GSTS_BUS_ERR_ADDR_VLD	(1 << 4)
+
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
@@ -234,6 +243,11 @@
 #define DWC3_MAX_HIBER_SCRATCHBUFS		15
 
 /* Global HWPARAMS6 Register */
+#define DWC3_GHWPARAMS6_BCSUPPORT		(1 << 14)
+#define DWC3_GHWPARAMS6_OTG3SUPPORT		(1 << 13)
+#define DWC3_GHWPARAMS6_ADPSUPPORT		(1 << 12)
+#define DWC3_GHWPARAMS6_HNPSUPPORT		(1 << 11)
+#define DWC3_GHWPARAMS6_SRPSUPPORT		(1 << 10)
 #define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
 
 /* Device Configuration Register */
@@ -393,6 +407,74 @@
 #define DWC3_DEPCMD_TYPE_BULK		2
 #define DWC3_DEPCMD_TYPE_INTR		3
 
+/* OTG Configuration Register */
+#define DWC3_OCFG_DISPWRCUTTOFF		(1 << 5)
+#define DWC3_OCFG_HIBDISMASK		(1 << 4)
+#define DWC3_OCFG_SFTRSTMASK		(1 << 3)
+#define DWC3_OCFG_OTGVERSION		(1 << 2)
+#define DWC3_OCFG_HNPCAP		(1 << 1)
+#define DWC3_OCFG_SRPCAP		(1 << 0)
+
+/* OTG CTL Register */
+#define DWC3_OCTL_OTG3GOERR		(1 << 7)
+#define DWC3_OCTL_PERIMODE		(1 << 6)
+#define DWC3_OCTL_PRTPWRCTL		(1 << 5)
+#define DWC3_OCTL_HNPREQ		(1 << 4)
+#define DWC3_OCTL_SESREQ		(1 << 3)
+#define DWC3_OCTL_TERMSELIDPULSE	(1 << 2)
+#define DWC3_OCTL_DEVSETHNPEN		(1 << 1)
+#define DWC3_OCTL_HSTSETHNPEN		(1 << 0)
+
+/* OTG Event Register */
+#define DWC3_OEVT_DEVICEMODE		(1 << 31)
+#define DWC3_OEVT_XHCIRUNSTPSET		(1 << 27)
+#define DWC3_OEVT_DEVRUNSTPSET		(1 << 26)
+#define DWC3_OEVT_HIBENTRY		(1 << 25)
+#define DWC3_OEVT_CONIDSTSCHNG		(1 << 24)
+#define DWC3_OEVT_HRRCONFNOTIF		(1 << 23)
+#define DWC3_OEVT_HRRINITNOTIF		(1 << 22)
+#define DWC3_OEVT_ADEVIDLE		(1 << 21)
+#define DWC3_OEVT_ADEVBHOSTEND		(1 << 20)
+#define DWC3_OEVT_ADEVHOST		(1 << 19)
+#define DWC3_OEVT_ADEVHNPCHNG		(1 << 18)
+#define DWC3_OEVT_ADEVSRPDET		(1 << 17)
+#define DWC3_OEVT_ADEVSESSENDDET	(1 << 16)
+#define DWC3_OEVT_BDEVBHOSTEND		(1 << 11)
+#define DWC3_OEVT_BDEVHNPCHNG		(1 << 10)
+#define DWC3_OEVT_BDEVSESSVLDDET	(1 << 9)
+#define DWC3_OEVT_BDEVVBUSCHNG		(1 << 8)
+#define DWC3_OEVT_BSESSVLD		(1 << 3)
+#define DWC3_OEVT_HSTNEGSTS		(1 << 2)
+#define DWC3_OEVT_SESREQSTS		(1 << 1)
+#define DWC3_OEVT_ERROR			(1 << 0)
+
+/* OTG Event Enable Register */
+#define DWC3_OEVTEN_XHCIRUNSTPSETEN	(1 << 27)
+#define DWC3_OEVTEN_DEVRUNSTPSETEN	(1 << 26)
+#define DWC3_OEVTEN_HIBENTRYEN		(1 << 25)
+#define DWC3_OEVTEN_CONIDSTSCHNGEN	(1 << 24)
+#define DWC3_OEVTEN_HRRCONFNOTIFEN	(1 << 23)
+#define DWC3_OEVTEN_HRRINITNOTIFEN	(1 << 22)
+#define DWC3_OEVTEN_ADEVIDLEEN		(1 << 21)
+#define DWC3_OEVTEN_ADEVBHOSTENDEN	(1 << 20)
+#define DWC3_OEVTEN_ADEVHOSTEN		(1 << 19)
+#define DWC3_OEVTEN_ADEVHNPCHNGEN	(1 << 18)
+#define DWC3_OEVTEN_ADEVSRPDETEN	(1 << 17)
+#define DWC3_OEVTEN_ADEVSESSENDDETEN	(1 << 16)
+#define DWC3_OEVTEN_BDEVHOSTENDEN	(1 << 11)
+#define DWC3_OEVTEN_BDEVHNPCHNGEN	(1 << 10)
+#define DWC3_OEVTEN_BDEVSESSVLDDETEN	(1 << 9)
+#define DWC3_OEVTEN_BDEVVBUSCHNGE	(1 << 8)
+
+/* OTG Status Register */
+#define DWC3_OSTS_DEVRUNSTP		(1 << 13)
+#define DWC3_OSTS_XHCIRUNSTP		(1 << 12)
+#define DWC3_OSTS_PERIPHERALSTATE	(1 << 4)
+#define DWC3_OSTS_XHCIPRTPOWER		(1 << 3)
+#define DWC3_OSTS_BSESVLD		(1 << 2)
+#define DWC3_OSTS_VBUSVLD		(1 << 1)
+#define DWC3_OSTS_CONIDSTS		(1 << 0)
+
 /* Structures */
 
 struct dwc3_trb;
-- 
2.1.4
