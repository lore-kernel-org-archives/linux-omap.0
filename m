From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/3] ARM: OMAP1: USB: delete redundant CPU class checks
Date: Mon,  2 Jan 2017 22:57:05 +0200
Message-ID: <20170102205705.19001-3-aaro.koskinen@iki.fi>
References: <20170102205705.19001-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102205705.19001-1-aaro.koskinen@iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Delete redundant CPU class checks. This code is only used
on OMAP1 nowadays.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/usb.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 0b4ed94..455e2cf 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -1,5 +1,5 @@
 /*
- * Platform level USB initialization for FS USB OTG controller on omap1 and 24xx
+ * Platform level USB initialization for FS USB OTG controller on omap1
  *
  * Copyright (C) 2004 Texas Instruments, Inc.
  *
@@ -63,6 +63,7 @@ omap_otg_init(struct omap_usb_config *config)
 {
 	u32		syscon;
 	int		alt_pingroup = 0;
+	u16		w;
 
 	/* NOTE:  no bus or clock setup (yet?) */
 
@@ -87,9 +88,8 @@ omap_otg_init(struct omap_usb_config *config)
 	if (config->otg)
 		syscon |= OTG_EN;
 #endif
-	if (cpu_class_is_omap1())
-		pr_debug("USB_TRANSCEIVER_CTRL = %03x\n",
-			 omap_readl(USB_TRANSCEIVER_CTRL));
+	pr_debug("USB_TRANSCEIVER_CTRL = %03x\n",
+		 omap_readl(USB_TRANSCEIVER_CTRL));
 	pr_debug("OTG_SYSCON_2 = %08x\n", omap_readl(OTG_SYSCON_2));
 	omap_writel(syscon, OTG_SYSCON_2);
 
@@ -107,19 +107,16 @@ omap_otg_init(struct omap_usb_config *config)
 		pr_cont(", Mini-AB on usb%d", config->otg - 1);
 	pr_cont("\n");
 
-	if (cpu_class_is_omap1()) {
-		u16 w;
+	/* leave USB clocks/controllers off until needed */
+	w = omap_readw(ULPD_SOFT_REQ);
+	w &= ~SOFT_USB_CLK_REQ;
+	omap_writew(w, ULPD_SOFT_REQ);
 
-		/* leave USB clocks/controllers off until needed */
-		w = omap_readw(ULPD_SOFT_REQ);
-		w &= ~SOFT_USB_CLK_REQ;
-		omap_writew(w, ULPD_SOFT_REQ);
+	w = omap_readw(ULPD_CLOCK_CTRL);
+	w &= ~USB_MCLK_EN;
+	w |= DIS_USB_PVCI_CLK;
+	omap_writew(w, ULPD_CLOCK_CTRL);
 
-		w = omap_readw(ULPD_CLOCK_CTRL);
-		w &= ~USB_MCLK_EN;
-		w |= DIS_USB_PVCI_CLK;
-		omap_writew(w, ULPD_CLOCK_CTRL);
-	}
 	syscon = omap_readl(OTG_SYSCON_1);
 	syscon |= HST_IDLE_EN|DEV_IDLE_EN|OTG_IDLE_EN;
 
-- 
2.9.2
