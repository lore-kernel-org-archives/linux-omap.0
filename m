From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH 2/5] usb: ohci: omap: Add OMAP4 support
Date: Fri, 20 Aug 2010 00:48:07 +0530
Message-ID: <1282245490-24339-3-git-send-email-keshava_mgowda@ti.com>
References: <1282245490-24339-1-git-send-email-keshava_mgowda@ti.com>
 <1282245490-24339-2-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282245490-24339-2-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Update the ohci-omap3 driver to add support for OMAP4.

The OMAP4 has two ports compared to 3 on the OMAP3.
Each port has its own functional clock, compared to a single clock
for all ports on OMAP3. 

Register bit positions for mode selections (TLL or PHY) 
have changed.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ohci-omap3.c |  213 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 194 insertions(+), 19 deletions(-)

Index: linux-2.6/drivers/usb/host/ohci-omap3.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ohci-omap3.c
+++ linux-2.6/drivers/usb/host/ohci-omap3.c
@@ -106,6 +106,31 @@
 
 #define	OMAP_UHH_DEBUG_CSR				(0x44)
 
+/* OMAP4 specific */
+#define OMAP_UHH_SYSCONFIG_IDLEMODE_RESET		(~(0xC))
+#define OMAP_UHH_SYSCONFIG_FIDLEMODE_SET		(0 << 2)
+#define OMAP_UHH_SYSCONFIG_NIDLEMODE_SET		(1 << 2)
+#define OMAP_UHH_SYSCONFIG_SIDLEMODE_SET		(2 << 2)
+#define OMAP_UHH_SYSCONFIG_SWIDLMODE_SET		(3 << 2)
+
+#define OMAP_UHH_SYSCONFIG_STDYMODE_RESET		(~(3 << 4))
+#define OMAP_UHH_SYSCONFIG_FSTDYMODE_SET		(0 << 4)
+#define OMAP_UHH_SYSCONFIG_NSTDYMODE_SET		(1 << 4)
+#define OMAP_UHH_SYSCONFIG_SSTDYMODE_SET		(2 << 4)
+#define OMAP_UHH_SYSCONFIG_SWSTDMODE_SET		(3 << 4)
+
+#define OMAP_UHH_HOST_PORTS_RESET			(~(0xF << 16))
+#define OMAP_UHH_HOST_P1_SET_ULPIPHY			(0 << 16)
+#define OMAP_UHH_HOST_P1_SET_ULPITLL			(1 << 16)
+#define OMAP_UHH_HOST_P1_SET_HSIC			(3 << 16)
+
+#define OMAP_UHH_HOST_P2_SET_ULPIPHY			(0 << 18)
+#define OMAP_UHH_HOST_P2_SET_ULPITLL			(1 << 18)
+#define OMAP_UHH_HOST_P2_SET_HSIC			(3 << 18)
+#define OMAP4_UHH_SYSCONFIG_SOFTRESET			(1 << 0)
+
+#define OMAP4_TLL_CHANNEL_COUNT				2
+
 /*-------------------------------------------------------------------------*/
 
 static inline void ohci_omap_writel(void __iomem *base, u32 reg, u32 val)
@@ -128,8 +153,6 @@ static inline u8 ohci_omap_readb(void __
 	return __raw_readb(base + reg);
 }
 
-/*-------------------------------------------------------------------------*/
-
 struct ohci_hcd_omap3 {
 	struct ohci_hcd		*ohci;
 	struct device		*dev;
@@ -139,6 +162,10 @@ struct ohci_hcd_omap3 {
 	struct clk		*usbhost_fs_fck;
 	struct clk		*usbtll_fck;
 	struct clk		*usbtll_ick;
+	struct clk		*xclk60mhsp1_ck;
+	struct clk		*xclk60mhsp2_ck;
+	struct clk		*utmi_p1_fck;
+	struct clk		*utmi_p2_fck;
 
 	/* port_mode: TLL/PHY, 2/3/4/6-PIN, DP-DM/DAT-SE0 */
 	enum ohci_omap3_port_mode	port_mode[OMAP3_HS_USB_PORTS];
@@ -154,17 +181,36 @@ struct ohci_hcd_omap3 {
 static void ohci_omap3_clock_power(struct ohci_hcd_omap3 *omap, int on)
 {
 	if (on) {
-		clk_enable(omap->usbtll_ick);
-		clk_enable(omap->usbtll_fck);
-		clk_enable(omap->usbhost_ick);
-		clk_enable(omap->usbhost_fs_fck);
-		clk_enable(omap->usbhost_hs_fck);
+		if (omap->usbtll_ick != NULL)
+			clk_enable(omap->usbtll_ick);
+		if (omap->usbtll_fck != NULL)
+			clk_enable(omap->usbtll_fck);
+		if (omap->usbhost_ick != NULL)
+			clk_enable(omap->usbhost_ick);
+		if (omap->usbhost_fs_fck != NULL)
+			clk_enable(omap->usbhost_fs_fck);
+		if (omap->usbhost_hs_fck != NULL)
+			clk_enable(omap->usbhost_hs_fck);
+		if (omap->utmi_p1_fck != NULL)
+			clk_enable(omap->utmi_p1_fck);
+		if (omap->utmi_p2_fck != NULL)
+			clk_enable(omap->utmi_p2_fck);
+
 	} else {
-		clk_disable(omap->usbhost_hs_fck);
-		clk_disable(omap->usbhost_fs_fck);
-		clk_disable(omap->usbhost_ick);
-		clk_disable(omap->usbtll_fck);
-		clk_disable(omap->usbtll_ick);
+		if (omap->usbtll_ick != NULL)
+			clk_disable(omap->usbtll_ick);
+		if (omap->usbtll_fck != NULL)
+			clk_disable(omap->usbtll_fck);
+		if (omap->usbhost_ick != NULL)
+			clk_disable(omap->usbhost_ick);
+		if (omap->usbhost_fs_fck != NULL)
+			clk_disable(omap->usbhost_fs_fck);
+		if (omap->usbhost_hs_fck != NULL)
+			clk_disable(omap->usbhost_hs_fck);
+		if (omap->utmi_p1_fck != NULL)
+			clk_disable(omap->utmi_p1_fck);
+		if (omap->utmi_p2_fck != NULL)
+			clk_disable(omap->utmi_p2_fck);
 	}
 }
 
@@ -291,14 +337,118 @@ static int omap3_start_ohci(struct ohci_
 	dev_dbg(omap->dev, "starting TI OHCI USB Controller\n");
 
 	if (cpu_is_omap44xx()) {
-		/* TODO */
+		/* Enable clocks for OMAP4 USBHOST */
+		omap->usbhost_fs_fck = clk_get(omap->dev, "usb_host_fs_fck");
+		if (IS_ERR(omap->usbhost_fs_fck)) {
+			ret = PTR_ERR(omap->usbhost_fs_fck);
+			goto err_host;
+		}
+
+		omap->utmi_p1_fck = clk_get(omap->dev, "utmi_p1_gfclk_ck");
+		if (IS_ERR(omap->utmi_p1_fck)) {
+			ret = PTR_ERR(omap->utmi_p1_fck);
+			goto err_utmi_p1_ck;
+		}
+
+		omap->utmi_p2_fck = clk_get(omap->dev, "utmi_p2_gfclk_ck");
+		if (IS_ERR(omap->utmi_p2_fck)) {
+			ret = PTR_ERR(omap->utmi_p2_fck);
+			goto err_utmi_p2_ck;
+		}
+
+		omap->usbtll_ick = clk_get(omap->dev, "usb_tll_ick");
+		if (IS_ERR(omap->usbtll_ick)) {
+			ret = PTR_ERR(omap->usbtll_ick);
+			goto err_44tll_ick;
+		}
+
+		omap->usbhost_hs_fck = NULL;
+		omap->xclk60mhsp2_ck = NULL;
+		omap->xclk60mhsp1_ck = NULL;
+		omap->usbhost_ick = NULL;
+
+		/* Now enable all the clocks in the correct order */
+		ohci_omap3_clock_power(omap, 1);
+
+		/* perform TLL soft reset, and wait
+		 * until reset is complete */
+		ohci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
+				OMAP_USBTLL_SYSCONFIG_SOFTRESET);
+
+		/* Wait for TLL reset to complete */
+		while (!(ohci_omap_readl(omap->tll_base,
+			OMAP_USBTLL_SYSSTATUS) &
+			OMAP_USBTLL_SYSSTATUS_RESETDONE)) {
+			cpu_relax();
+
+			if (time_after(jiffies, timeout)) {
+				dev_dbg(omap->dev, "operation timed out\n");
+				ret = -EINVAL;
+				goto err_44sys_status;
+			}
+		}
+
+		dev_dbg(omap->dev, "TLL RESET DONE\n");
+
+		/* Put UHH in NoIdle/NoStandby mode */
+		reg = ohci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
+		reg &= OMAP_UHH_SYSCONFIG_IDLEMODE_RESET;
+		reg |= OMAP_UHH_SYSCONFIG_NIDLEMODE_SET;
+
+		reg &= OMAP_UHH_SYSCONFIG_STDYMODE_RESET;
+		reg |= OMAP_UHH_SYSCONFIG_NSTDYMODE_SET;
+
+		ohci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
+
+		reg = ohci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
+
+		/* setup ULPI bypass and burst configurations */
+		reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN |
+			OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN |
+			OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN);
+		reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
+
+		/* set p1 & p2 modes */
+		/* OHCI has to go through USBTLL */
+		reg &= OMAP_UHH_HOST_PORTS_RESET;
+		if (omap->port_mode[0] != OMAP_OHCI_PORT_MODE_UNUSED)
+			reg |= OMAP_UHH_HOST_P1_SET_ULPITLL;
+		if (omap->port_mode[1] != OMAP_OHCI_PORT_MODE_UNUSED)
+			reg |= OMAP_UHH_HOST_P2_SET_ULPITLL;
+
+		ohci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
+		dev_dbg(omap->dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
+
+		/* (1<<3) = no idle mode only for initial debugging */
+		ohci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
+				OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
+				OMAP_USBTLL_SYSCONFIG_SIDLEMODE |
+				OMAP_USBTLL_SYSCONFIG_CACTIVITY);
+
+		ohci_omap3_tll_config(omap, OMAP4_TLL_CHANNEL_COUNT);
+
+		return 0;
+
+err_44sys_status:
+		ohci_omap3_clock_power(omap, 0);
+		clk_put(omap->usbtll_ick);
+
+err_44tll_ick:
+		clk_put(omap->utmi_p2_fck);
+
+err_utmi_p2_ck:
+		clk_put(omap->utmi_p1_fck);
+
+err_utmi_p1_ck:
+		clk_put(omap->usbhost_fs_fck);
+
 	} else {
 		/* Get all the clock handles we need */
 		omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
 		if (IS_ERR(omap->usbhost_ick)) {
 			dev_err(omap->dev, "could not get usbhost_ick\n");
 			ret =  PTR_ERR(omap->usbhost_ick);
-			goto err_host_ick;
+			goto err_host;
 		}
 
 		omap->usbhost_hs_fck = clk_get(omap->dev, "usbhost_120m_fck");
@@ -445,10 +595,10 @@ err_host_fs_fck:
 
 err_host_hs_fck:
 		clk_put(omap->usbhost_ick);
-
-err_host_ick:
-		return ret;
 	}
+
+err_host:
+	return ret;
 }
 
 static void omap3_stop_ohci(struct ohci_hcd_omap3 *omap, struct usb_hcd *hcd)
@@ -458,8 +608,13 @@ static void omap3_stop_ohci(struct ohci_
 	dev_dbg(omap->dev, "stopping TI EHCI USB Controller\n");
 
 	/* Reset USBHOST for insmod/rmmod to work */
-	ohci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG,
-			OMAP_UHH_SYSCONFIG_SOFTRESET);
+	if (cpu_is_omap44xx())
+		ohci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG,
+					OMAP4_UHH_SYSCONFIG_SOFTRESET);
+	else
+		ohci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG,
+					OMAP_UHH_SYSCONFIG_SOFTRESET);
+
 	while (!(ohci_omap_readl(omap->uhh_base, OMAP_UHH_SYSSTATUS)
 				& OMAP_UHH_SYSSTATUS_UHHRESETDONE)) {
 		cpu_relax();
@@ -501,6 +656,26 @@ static void omap3_stop_ohci(struct ohci_
 		omap->usbtll_fck = NULL;
 	}
 
+	if (omap->utmi_p2_fck != NULL) {
+		clk_put(omap->utmi_p2_fck);
+		omap->utmi_p2_fck = NULL;
+	}
+
+	if (omap->utmi_p1_fck != NULL) {
+		clk_put(omap->utmi_p1_fck);
+		omap->utmi_p1_fck = NULL;
+	}
+
+	if (omap->xclk60mhsp2_ck != NULL) {
+		clk_put(omap->xclk60mhsp2_ck);
+		omap->xclk60mhsp2_ck = NULL;
+	}
+
+	if (omap->xclk60mhsp1_ck != NULL) {
+		clk_put(omap->xclk60mhsp1_ck);
+		omap->xclk60mhsp1_ck = NULL;
+	}
+
 	if (omap->usbhost_ick != NULL) {
 		clk_put(omap->usbhost_ick);
 		omap->usbhost_ick = NULL;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
