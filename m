From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/8] usb: dwc3: use BIT() macro where possible
Date: Mon, 23 Jan 2017 13:19:36 +0200
Message-ID: <1485170381-32110-4-git-send-email-rogerq@ti.com>
References: <1485170381-32110-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485170381-32110-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, tony@atomide.com
Cc: peter.chen@freescale.com, vivek.gautam@codeaurora.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

To avoid checkpatch warnings with new patches let's
start using the BIT() macro wherever possible.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.h      | 192 +++++++++++++++++++++----------------------
 drivers/usb/dwc3/dwc3-omap.c |  48 +++++------
 drivers/usb/dwc3/gadget.h    |  20 ++---
 3 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 14b7602..d514dca 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -65,7 +65,7 @@
 #define DWC3_DEVICE_EVENT_OVERFLOW		11
 
 #define DWC3_GEVNTCOUNT_MASK	0xfffc
-#define DWC3_GEVNTCOUNT_EHB	(1 << 31)
+#define DWC3_GEVNTCOUNT_EHB	BIT(31)
 #define DWC3_GSNPSID_MASK	0xffff0000
 #define DWC3_GSNPSREV_MASK	0xffff
 
@@ -175,11 +175,11 @@
 /* Global RX Threshold Configuration Register */
 #define DWC3_GRXTHRCFG_MAXRXBURSTSIZE(n) (((n) & 0x1f) << 19)
 #define DWC3_GRXTHRCFG_RXPKTCNT(n) (((n) & 0xf) << 24)
-#define DWC3_GRXTHRCFG_PKTCNTSEL (1 << 29)
+#define DWC3_GRXTHRCFG_PKTCNTSEL BIT(29)
 
 /* Global Configuration Register */
 #define DWC3_GCTL_PWRDNSCALE(n)	((n) << 19)
-#define DWC3_GCTL_U2RSTECN	(1 << 16)
+#define DWC3_GCTL_U2RSTECN	BIT(16)
 #define DWC3_GCTL_RAMCLKSEL(x)	(((x) & DWC3_GCTL_CLK_MASK) << 6)
 #define DWC3_GCTL_CLK_BUS	(0)
 #define DWC3_GCTL_CLK_PIPE	(1)
@@ -192,24 +192,24 @@
 #define DWC3_GCTL_PRTCAP_DEVICE	2
 #define DWC3_GCTL_PRTCAP_OTG	3
 
-#define DWC3_GCTL_CORESOFTRESET		(1 << 11)
-#define DWC3_GCTL_SOFITPSYNC		(1 << 10)
+#define DWC3_GCTL_CORESOFTRESET		BIT(11)
+#define DWC3_GCTL_SOFITPSYNC		BIT(10)
 #define DWC3_GCTL_SCALEDOWN(n)		((n) << 4)
 #define DWC3_GCTL_SCALEDOWN_MASK	DWC3_GCTL_SCALEDOWN(3)
-#define DWC3_GCTL_DISSCRAMBLE		(1 << 3)
-#define DWC3_GCTL_U2EXIT_LFPS		(1 << 2)
-#define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
-#define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
+#define DWC3_GCTL_DISSCRAMBLE		BIT(3)
+#define DWC3_GCTL_U2EXIT_LFPS		BIT(2)
+#define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
+#define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
 /* Global User Control 1 Register */
-#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	(1 << 24)
+#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
 /* Global USB2 PHY Configuration Register */
-#define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
-#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	(1 << 30)
-#define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
-#define DWC3_GUSB2PHYCFG_ULPI_UTMI	(1 << 4)
-#define DWC3_GUSB2PHYCFG_ENBLSLPM	(1 << 8)
+#define DWC3_GUSB2PHYCFG_PHYSOFTRST	BIT(31)
+#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	BIT(30)
+#define DWC3_GUSB2PHYCFG_SUSPHY		BIT(6)
+#define DWC3_GUSB2PHYCFG_ULPI_UTMI	BIT(4)
+#define DWC3_GUSB2PHYCFG_ENBLSLPM	BIT(8)
 #define DWC3_GUSB2PHYCFG_PHYIF(n)	(n << 3)
 #define DWC3_GUSB2PHYCFG_PHYIF_MASK	DWC3_GUSB2PHYCFG_PHYIF(1)
 #define DWC3_GUSB2PHYCFG_USBTRDTIM(n)	(n << 10)
@@ -220,25 +220,25 @@
 #define UTMI_PHYIF_8_BIT		0
 
 /* Global USB2 PHY Vendor Control Register */
-#define DWC3_GUSB2PHYACC_NEWREGREQ	(1 << 25)
-#define DWC3_GUSB2PHYACC_BUSY		(1 << 23)
-#define DWC3_GUSB2PHYACC_WRITE		(1 << 22)
+#define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
+#define DWC3_GUSB2PHYACC_BUSY		BIT(23)
+#define DWC3_GUSB2PHYACC_WRITE		BIT(22)
 #define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
 #define DWC3_GUSB2PHYACC_EXTEND_ADDR(n)	(n << 8)
 #define DWC3_GUSB2PHYACC_DATA(n)	(n & 0xff)
 
 /* Global USB3 PIPE Control Register */
-#define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
-#define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
-#define DWC3_GUSB3PIPECTL_DISRXDETINP3	(1 << 28)
-#define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
+#define DWC3_GUSB3PIPECTL_PHYSOFTRST	BIT(31)
+#define DWC3_GUSB3PIPECTL_U2SSINP3OK	BIT(29)
+#define DWC3_GUSB3PIPECTL_DISRXDETINP3	BIT(28)
+#define DWC3_GUSB3PIPECTL_REQP1P2P3	BIT(24)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_EN	DWC3_GUSB3PIPECTL_DEP1P2P3(1)
-#define DWC3_GUSB3PIPECTL_DEPOCHANGE	(1 << 18)
-#define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
-#define DWC3_GUSB3PIPECTL_LFPSFILT	(1 << 9)
-#define DWC3_GUSB3PIPECTL_RX_DETOPOLL	(1 << 8)
+#define DWC3_GUSB3PIPECTL_DEPOCHANGE	BIT(18)
+#define DWC3_GUSB3PIPECTL_SUSPHY	BIT(17)
+#define DWC3_GUSB3PIPECTL_LFPSFILT	BIT(9)
+#define DWC3_GUSB3PIPECTL_RX_DETOPOLL	BIT(8)
 #define DWC3_GUSB3PIPECTL_TX_DEEPH_MASK	DWC3_GUSB3PIPECTL_TX_DEEPH(3)
 #define DWC3_GUSB3PIPECTL_TX_DEEPH(n)	((n) << 1)
 
@@ -247,7 +247,7 @@
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
 /* Global Event Size Registers */
-#define DWC3_GEVNTSIZ_INTMASK		(1 << 31)
+#define DWC3_GEVNTSIZ_INTMASK		BIT(31)
 #define DWC3_GEVNTSIZ_SIZE(n)		((n) & 0xffff)
 
 /* Global HWPARAMS0 Register */
@@ -288,18 +288,18 @@
 #define DWC3_MAX_HIBER_SCRATCHBUFS		15
 
 /* Global HWPARAMS6 Register */
-#define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
+#define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)
 
 /* Global HWPARAMS7 Register */
 #define DWC3_GHWPARAMS7_RAM1_DEPTH(n)	((n) & 0xffff)
 #define DWC3_GHWPARAMS7_RAM2_DEPTH(n)	(((n) >> 16) & 0xffff)
 
 /* Global Frame Length Adjustment Register */
-#define DWC3_GFLADJ_30MHZ_SDBND_SEL		(1 << 7)
+#define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 
 /* Global User Control Register 2 */
-#define DWC3_GUCTL2_RST_ACTBITLATER		(1 << 14)
+#define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
@@ -309,23 +309,23 @@
 #define DWC3_DCFG_SUPERSPEED_PLUS (5 << 0)  /* DWC_usb31 only */
 #define DWC3_DCFG_SUPERSPEED	(4 << 0)
 #define DWC3_DCFG_HIGHSPEED	(0 << 0)
-#define DWC3_DCFG_FULLSPEED	(1 << 0)
+#define DWC3_DCFG_FULLSPEED	BIT(0)
 #define DWC3_DCFG_LOWSPEED	(2 << 0)
 
 #define DWC3_DCFG_NUMP_SHIFT	17
 #define DWC3_DCFG_NUMP(n)	(((n) >> DWC3_DCFG_NUMP_SHIFT) & 0x1f)
 #define DWC3_DCFG_NUMP_MASK	(0x1f << DWC3_DCFG_NUMP_SHIFT)
-#define DWC3_DCFG_LPM_CAP	(1 << 22)
+#define DWC3_DCFG_LPM_CAP	BIT(22)
 
 /* Device Control Register */
-#define DWC3_DCTL_RUN_STOP	(1 << 31)
-#define DWC3_DCTL_CSFTRST	(1 << 30)
-#define DWC3_DCTL_LSFTRST	(1 << 29)
+#define DWC3_DCTL_RUN_STOP	BIT(31)
+#define DWC3_DCTL_CSFTRST	BIT(30)
+#define DWC3_DCTL_LSFTRST	BIT(29)
 
 #define DWC3_DCTL_HIRD_THRES_MASK	(0x1f << 24)
 #define DWC3_DCTL_HIRD_THRES(n)	((n) << 24)
 
-#define DWC3_DCTL_APPL1RES	(1 << 23)
+#define DWC3_DCTL_APPL1RES	BIT(23)
 
 /* These apply for core versions 1.87a and earlier */
 #define DWC3_DCTL_TRGTULST_MASK		(0x0f << 17)
@@ -340,15 +340,15 @@
 #define DWC3_DCTL_LPM_ERRATA_MASK	DWC3_DCTL_LPM_ERRATA(0xf)
 #define DWC3_DCTL_LPM_ERRATA(n)		((n) << 20)
 
-#define DWC3_DCTL_KEEP_CONNECT		(1 << 19)
-#define DWC3_DCTL_L1_HIBER_EN		(1 << 18)
-#define DWC3_DCTL_CRS			(1 << 17)
-#define DWC3_DCTL_CSS			(1 << 16)
+#define DWC3_DCTL_KEEP_CONNECT		BIT(19)
+#define DWC3_DCTL_L1_HIBER_EN		BIT(18)
+#define DWC3_DCTL_CRS			BIT(17)
+#define DWC3_DCTL_CSS			BIT(16)
 
-#define DWC3_DCTL_INITU2ENA		(1 << 12)
-#define DWC3_DCTL_ACCEPTU2ENA		(1 << 11)
-#define DWC3_DCTL_INITU1ENA		(1 << 10)
-#define DWC3_DCTL_ACCEPTU1ENA		(1 << 9)
+#define DWC3_DCTL_INITU2ENA		BIT(12)
+#define DWC3_DCTL_ACCEPTU2ENA		BIT(11)
+#define DWC3_DCTL_INITU1ENA		BIT(10)
+#define DWC3_DCTL_ACCEPTU1ENA		BIT(9)
 #define DWC3_DCTL_TSTCTRL_MASK		(0xf << 1)
 
 #define DWC3_DCTL_ULSTCHNGREQ_MASK	(0x0f << 5)
@@ -363,36 +363,36 @@
 #define DWC3_DCTL_ULSTCHNG_LOOPBACK	(DWC3_DCTL_ULSTCHNGREQ(11))
 
 /* Device Event Enable Register */
-#define DWC3_DEVTEN_VNDRDEVTSTRCVEDEN	(1 << 12)
-#define DWC3_DEVTEN_EVNTOVERFLOWEN	(1 << 11)
-#define DWC3_DEVTEN_CMDCMPLTEN		(1 << 10)
-#define DWC3_DEVTEN_ERRTICERREN		(1 << 9)
-#define DWC3_DEVTEN_SOFEN		(1 << 7)
-#define DWC3_DEVTEN_EOPFEN		(1 << 6)
-#define DWC3_DEVTEN_HIBERNATIONREQEVTEN	(1 << 5)
-#define DWC3_DEVTEN_WKUPEVTEN		(1 << 4)
-#define DWC3_DEVTEN_ULSTCNGEN		(1 << 3)
-#define DWC3_DEVTEN_CONNECTDONEEN	(1 << 2)
-#define DWC3_DEVTEN_USBRSTEN		(1 << 1)
-#define DWC3_DEVTEN_DISCONNEVTEN	(1 << 0)
+#define DWC3_DEVTEN_VNDRDEVTSTRCVEDEN	BIT(12)
+#define DWC3_DEVTEN_EVNTOVERFLOWEN	BIT(11)
+#define DWC3_DEVTEN_CMDCMPLTEN		BIT(10)
+#define DWC3_DEVTEN_ERRTICERREN		BIT(9)
+#define DWC3_DEVTEN_SOFEN		BIT(7)
+#define DWC3_DEVTEN_EOPFEN		BIT(6)
+#define DWC3_DEVTEN_HIBERNATIONREQEVTEN	BIT(5)
+#define DWC3_DEVTEN_WKUPEVTEN		BIT(4)
+#define DWC3_DEVTEN_ULSTCNGEN		BIT(3)
+#define DWC3_DEVTEN_CONNECTDONEEN	BIT(2)
+#define DWC3_DEVTEN_USBRSTEN		BIT(1)
+#define DWC3_DEVTEN_DISCONNEVTEN	BIT(0)
 
 /* Device Status Register */
-#define DWC3_DSTS_DCNRD			(1 << 29)
+#define DWC3_DSTS_DCNRD			BIT(29)
 
 /* This applies for core versions 1.87a and earlier */
-#define DWC3_DSTS_PWRUPREQ		(1 << 24)
+#define DWC3_DSTS_PWRUPREQ		BIT(24)
 
 /* These apply for core versions 1.94a and later */
-#define DWC3_DSTS_RSS			(1 << 25)
-#define DWC3_DSTS_SSS			(1 << 24)
+#define DWC3_DSTS_RSS			BIT(25)
+#define DWC3_DSTS_SSS			BIT(24)
 
-#define DWC3_DSTS_COREIDLE		(1 << 23)
-#define DWC3_DSTS_DEVCTRLHLT		(1 << 22)
+#define DWC3_DSTS_COREIDLE		BIT(23)
+#define DWC3_DSTS_DEVCTRLHLT		BIT(22)
 
 #define DWC3_DSTS_USBLNKST_MASK		(0x0f << 18)
 #define DWC3_DSTS_USBLNKST(n)		(((n) & DWC3_DSTS_USBLNKST_MASK) >> 18)
 
-#define DWC3_DSTS_RXFIFOEMPTY		(1 << 17)
+#define DWC3_DSTS_RXFIFOEMPTY		BIT(17)
 
 #define DWC3_DSTS_SOFFN_MASK		(0x3fff << 3)
 #define DWC3_DSTS_SOFFN(n)		(((n) & DWC3_DSTS_SOFFN_MASK) >> 3)
@@ -402,7 +402,7 @@
 #define DWC3_DSTS_SUPERSPEED_PLUS	(5 << 0) /* DWC_usb31 only */
 #define DWC3_DSTS_SUPERSPEED		(4 << 0)
 #define DWC3_DSTS_HIGHSPEED		(0 << 0)
-#define DWC3_DSTS_FULLSPEED		(1 << 0)
+#define DWC3_DSTS_FULLSPEED		BIT(0)
 #define DWC3_DSTS_LOWSPEED		(2 << 0)
 
 /* Device Generic Command Register */
@@ -420,26 +420,26 @@
 #define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
 
 #define DWC3_DGCMD_STATUS(n)		(((n) >> 12) & 0x0F)
-#define DWC3_DGCMD_CMDACT		(1 << 10)
-#define DWC3_DGCMD_CMDIOC		(1 << 8)
+#define DWC3_DGCMD_CMDACT		BIT(10)
+#define DWC3_DGCMD_CMDIOC		BIT(8)
 
 /* Device Generic Command Parameter Register */
-#define DWC3_DGCMDPAR_FORCE_LINKPM_ACCEPT	(1 << 0)
+#define DWC3_DGCMDPAR_FORCE_LINKPM_ACCEPT	BIT(0)
 #define DWC3_DGCMDPAR_FIFO_NUM(n)		((n) << 0)
 #define DWC3_DGCMDPAR_RX_FIFO			(0 << 5)
-#define DWC3_DGCMDPAR_TX_FIFO			(1 << 5)
+#define DWC3_DGCMDPAR_TX_FIFO			BIT(5)
 #define DWC3_DGCMDPAR_LOOPBACK_DIS		(0 << 0)
-#define DWC3_DGCMDPAR_LOOPBACK_ENA		(1 << 0)
+#define DWC3_DGCMDPAR_LOOPBACK_ENA		BIT(0)
 
 /* Device Endpoint Command Register */
 #define DWC3_DEPCMD_PARAM_SHIFT		16
 #define DWC3_DEPCMD_PARAM(x)		((x) << DWC3_DEPCMD_PARAM_SHIFT)
 #define DWC3_DEPCMD_GET_RSC_IDX(x)	(((x) >> DWC3_DEPCMD_PARAM_SHIFT) & 0x7f)
 #define DWC3_DEPCMD_STATUS(x)		(((x) >> 12) & 0x0F)
-#define DWC3_DEPCMD_HIPRI_FORCERM	(1 << 11)
-#define DWC3_DEPCMD_CLEARPENDIN		(1 << 11)
-#define DWC3_DEPCMD_CMDACT		(1 << 10)
-#define DWC3_DEPCMD_CMDIOC		(1 << 8)
+#define DWC3_DEPCMD_HIPRI_FORCERM	BIT(11)
+#define DWC3_DEPCMD_CLEARPENDIN		BIT(11)
+#define DWC3_DEPCMD_CMDACT		BIT(10)
+#define DWC3_DEPCMD_CMDIOC		BIT(8)
 
 #define DWC3_DEPCMD_DEPSTARTCFG		(0x09 << 0)
 #define DWC3_DEPCMD_ENDTRANSFER		(0x08 << 0)
@@ -457,7 +457,7 @@
 #define DWC3_DEPCMD_CMD(x)		((x) & 0xf)
 
 /* The EP number goes 0..31 so ep0 is always out and ep1 is always in */
-#define DWC3_DALEPENA_EP(n)		(1 << n)
+#define DWC3_DALEPENA_EP(n)		BIT(n)
 
 #define DWC3_DEPCMD_TYPE_CONTROL	0
 #define DWC3_DEPCMD_TYPE_ISOC		1
@@ -499,8 +499,8 @@ struct dwc3_event_buffer {
 	struct dwc3		*dwc;
 };
 
-#define DWC3_EP_FLAG_STALLED	(1 << 0)
-#define DWC3_EP_FLAG_WEDGED	(1 << 1)
+#define DWC3_EP_FLAG_STALLED	BIT(0)
+#define DWC3_EP_FLAG_WEDGED	BIT(1)
 
 #define DWC3_EP_DIRECTION_TX	true
 #define DWC3_EP_DIRECTION_RX	false
@@ -549,17 +549,17 @@ struct dwc3_ep {
 
 	u32			saved_state;
 	unsigned		flags;
-#define DWC3_EP_ENABLED		(1 << 0)
-#define DWC3_EP_STALL		(1 << 1)
-#define DWC3_EP_WEDGE		(1 << 2)
-#define DWC3_EP_BUSY		(1 << 4)
-#define DWC3_EP_PENDING_REQUEST	(1 << 5)
-#define DWC3_EP_MISSED_ISOC	(1 << 6)
-#define DWC3_EP_END_TRANSFER_PENDING	(1 << 7)
-#define DWC3_EP_TRANSFER_STARTED (1 << 8)
+#define DWC3_EP_ENABLED		BIT(0)
+#define DWC3_EP_STALL		BIT(1)
+#define DWC3_EP_WEDGE		BIT(2)
+#define DWC3_EP_BUSY		BIT(4)
+#define DWC3_EP_PENDING_REQUEST	BIT(5)
+#define DWC3_EP_MISSED_ISOC	BIT(6)
+#define DWC3_EP_END_TRANSFER_PENDING	BIT(7)
+#define DWC3_EP_TRANSFER_STARTED BIT(8)
 
 	/* This last one is specific to EP0 */
-#define DWC3_EP0_DIR_IN		(1 << 31)
+#define DWC3_EP0_DIR_IN		BIT(31)
 
 	/*
 	 * IMPORTANT: we *know* we have 256 TRBs in our @trb_pool, so we will
@@ -637,13 +637,13 @@ enum dwc3_link_state {
 #define DWC3_TRB_STS_XFER_IN_PROG	4
 
 /* TRB Control */
-#define DWC3_TRB_CTRL_HWO		(1 << 0)
-#define DWC3_TRB_CTRL_LST		(1 << 1)
-#define DWC3_TRB_CTRL_CHN		(1 << 2)
-#define DWC3_TRB_CTRL_CSP		(1 << 3)
+#define DWC3_TRB_CTRL_HWO		BIT(0)
+#define DWC3_TRB_CTRL_LST		BIT(1)
+#define DWC3_TRB_CTRL_CHN		BIT(2)
+#define DWC3_TRB_CTRL_CSP		BIT(3)
 #define DWC3_TRB_CTRL_TRBCTL(n)		(((n) & 0x3f) << 4)
-#define DWC3_TRB_CTRL_ISP_IMI		(1 << 10)
-#define DWC3_TRB_CTRL_IOC		(1 << 11)
+#define DWC3_TRB_CTRL_ISP_IMI		BIT(10)
+#define DWC3_TRB_CTRL_IOC		BIT(11)
 #define DWC3_TRB_CTRL_SID_SOFN(n)	(((n) & 0xffff) << 14)
 
 #define DWC3_TRBCTL_TYPE(n)		((n) & (0x3f << 4))
@@ -1049,13 +1049,13 @@ struct dwc3_event_depevt {
 	u32	status:4;
 
 /* Within XferNotReady */
-#define DEPEVT_STATUS_TRANSFER_ACTIVE	(1 << 3)
+#define DEPEVT_STATUS_TRANSFER_ACTIVE	BIT(3)
 
 /* Within XferComplete */
-#define DEPEVT_STATUS_BUSERR	(1 << 0)
-#define DEPEVT_STATUS_SHORT	(1 << 1)
-#define DEPEVT_STATUS_IOC	(1 << 2)
-#define DEPEVT_STATUS_LST	(1 << 3)
+#define DEPEVT_STATUS_BUSERR	BIT(0)
+#define DEPEVT_STATUS_SHORT	BIT(1)
+#define DEPEVT_STATUS_IOC	BIT(2)
+#define DEPEVT_STATUS_LST	BIT(3)
 
 /* Stream event only */
 #define DEPEVT_STREAMEVT_FOUND		1
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 35b6351..fe4efb8 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -79,40 +79,40 @@
 #define USBOTGSS_DEBUG_OFFSET			0x0600
 
 /* SYSCONFIG REGISTER */
-#define USBOTGSS_SYSCONFIG_DMADISABLE		(1 << 16)
+#define USBOTGSS_SYSCONFIG_DMADISABLE		BIT(16)
 
 /* IRQ_EOI REGISTER */
-#define USBOTGSS_IRQ_EOI_LINE_NUMBER		(1 << 0)
+#define USBOTGSS_IRQ_EOI_LINE_NUMBER		BIT(0)
 
 /* IRQS0 BITS */
-#define USBOTGSS_IRQO_COREIRQ_ST		(1 << 0)
+#define USBOTGSS_IRQO_COREIRQ_ST		BIT(0)
 
 /* IRQMISC BITS */
-#define USBOTGSS_IRQMISC_DMADISABLECLR		(1 << 17)
-#define USBOTGSS_IRQMISC_OEVT			(1 << 16)
-#define USBOTGSS_IRQMISC_DRVVBUS_RISE		(1 << 13)
-#define USBOTGSS_IRQMISC_CHRGVBUS_RISE		(1 << 12)
-#define USBOTGSS_IRQMISC_DISCHRGVBUS_RISE	(1 << 11)
-#define USBOTGSS_IRQMISC_IDPULLUP_RISE		(1 << 8)
-#define USBOTGSS_IRQMISC_DRVVBUS_FALL		(1 << 5)
-#define USBOTGSS_IRQMISC_CHRGVBUS_FALL		(1 << 4)
-#define USBOTGSS_IRQMISC_DISCHRGVBUS_FALL		(1 << 3)
-#define USBOTGSS_IRQMISC_IDPULLUP_FALL		(1 << 0)
+#define USBOTGSS_IRQMISC_DMADISABLECLR		BIT(17)
+#define USBOTGSS_IRQMISC_OEVT			BIT(16)
+#define USBOTGSS_IRQMISC_DRVVBUS_RISE		BIT(13)
+#define USBOTGSS_IRQMISC_CHRGVBUS_RISE		BIT(12)
+#define USBOTGSS_IRQMISC_DISCHRGVBUS_RISE	BIT(11)
+#define USBOTGSS_IRQMISC_IDPULLUP_RISE		BIT(8)
+#define USBOTGSS_IRQMISC_DRVVBUS_FALL		BIT(5)
+#define USBOTGSS_IRQMISC_CHRGVBUS_FALL		BIT(4)
+#define USBOTGSS_IRQMISC_DISCHRGVBUS_FALL		BIT(3)
+#define USBOTGSS_IRQMISC_IDPULLUP_FALL		BIT(0)
 
 /* UTMI_OTG_STATUS REGISTER */
-#define USBOTGSS_UTMI_OTG_STATUS_DRVVBUS	(1 << 5)
-#define USBOTGSS_UTMI_OTG_STATUS_CHRGVBUS	(1 << 4)
-#define USBOTGSS_UTMI_OTG_STATUS_DISCHRGVBUS	(1 << 3)
-#define USBOTGSS_UTMI_OTG_STATUS_IDPULLUP	(1 << 0)
+#define USBOTGSS_UTMI_OTG_STATUS_DRVVBUS	BIT(5)
+#define USBOTGSS_UTMI_OTG_STATUS_CHRGVBUS	BIT(4)
+#define USBOTGSS_UTMI_OTG_STATUS_DISCHRGVBUS	BIT(3)
+#define USBOTGSS_UTMI_OTG_STATUS_IDPULLUP	BIT(0)
 
 /* UTMI_OTG_CTRL REGISTER */
-#define USBOTGSS_UTMI_OTG_CTRL_SW_MODE		(1 << 31)
-#define USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT	(1 << 9)
-#define USBOTGSS_UTMI_OTG_CTRL_TXBITSTUFFENABLE (1 << 8)
-#define USBOTGSS_UTMI_OTG_CTRL_IDDIG		(1 << 4)
-#define USBOTGSS_UTMI_OTG_CTRL_SESSEND		(1 << 3)
-#define USBOTGSS_UTMI_OTG_CTRL_SESSVALID	(1 << 2)
-#define USBOTGSS_UTMI_OTG_CTRL_VBUSVALID	(1 << 1)
+#define USBOTGSS_UTMI_OTG_CTRL_SW_MODE		BIT(31)
+#define USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT	BIT(9)
+#define USBOTGSS_UTMI_OTG_CTRL_TXBITSTUFFENABLE BIT(8)
+#define USBOTGSS_UTMI_OTG_CTRL_IDDIG		BIT(4)
+#define USBOTGSS_UTMI_OTG_CTRL_SESSEND		BIT(3)
+#define USBOTGSS_UTMI_OTG_CTRL_SESSVALID	BIT(2)
+#define USBOTGSS_UTMI_OTG_CTRL_VBUSVALID	BIT(1)
 
 struct dwc3_omap {
 	struct device		*dev;
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 3129bcf..97f53de 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -29,16 +29,16 @@ struct dwc3;
 
 /* DEPCFG parameter 1 */
 #define DWC3_DEPCFG_INT_NUM(n)		((n) << 0)
-#define DWC3_DEPCFG_XFER_COMPLETE_EN	(1 << 8)
-#define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	(1 << 9)
-#define DWC3_DEPCFG_XFER_NOT_READY_EN	(1 << 10)
-#define DWC3_DEPCFG_FIFO_ERROR_EN	(1 << 11)
-#define DWC3_DEPCFG_STREAM_EVENT_EN	(1 << 13)
+#define DWC3_DEPCFG_XFER_COMPLETE_EN	BIT(8)
+#define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	BIT(9)
+#define DWC3_DEPCFG_XFER_NOT_READY_EN	BIT(10)
+#define DWC3_DEPCFG_FIFO_ERROR_EN	BIT(11)
+#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(13)
 #define DWC3_DEPCFG_BINTERVAL_M1(n)	((n) << 16)
-#define DWC3_DEPCFG_STREAM_CAPABLE	(1 << 24)
+#define DWC3_DEPCFG_STREAM_CAPABLE	BIT(24)
 #define DWC3_DEPCFG_EP_NUMBER(n)	((n) << 25)
-#define DWC3_DEPCFG_BULK_BASED		(1 << 30)
-#define DWC3_DEPCFG_FIFO_BASED		(1 << 31)
+#define DWC3_DEPCFG_BULK_BASED		BIT(30)
+#define DWC3_DEPCFG_FIFO_BASED		BIT(31)
 
 /* DEPCFG parameter 0 */
 #define DWC3_DEPCFG_EP_TYPE(n)		((n) << 1)
@@ -47,10 +47,10 @@ struct dwc3;
 #define DWC3_DEPCFG_BURST_SIZE(n)	((n) << 22)
 #define DWC3_DEPCFG_DATA_SEQ_NUM(n)	((n) << 26)
 /* This applies for core versions earlier than 1.94a */
-#define DWC3_DEPCFG_IGN_SEQ_NUM		(1 << 31)
+#define DWC3_DEPCFG_IGN_SEQ_NUM		BIT(31)
 /* These apply for core versions 1.94a and later */
 #define DWC3_DEPCFG_ACTION_INIT		(0 << 30)
-#define DWC3_DEPCFG_ACTION_RESTORE	(1 << 30)
+#define DWC3_DEPCFG_ACTION_RESTORE	BIT(30)
 #define DWC3_DEPCFG_ACTION_MODIFY	(2 << 30)
 
 /* DEPXFERCFG parameter 0 */
-- 
2.7.4
