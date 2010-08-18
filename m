From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH 3/7] usb: ehci-omap: omap: Add OMAP4 support
Date: Thu, 19 Aug 2010 05:19:33 +0530
Message-ID: <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282175377-2784-3-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Update the ehci-omap driver to add support for OMAP4.

The OMAP4 has two ports compared to 3 on the OMAP3.
Each port has its own functional clock, compared to a single clock
for all ports on OMAP3. The clock can be internally sourced 
(TLL mode, HSIC mode), or externally provided (ULPI PHY).

Register bit positions for mode selections
(TLL, HSIC or ULPI PHY) have changed.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |  208 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 205 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/usb/host/ehci-omap.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ehci-omap.c
+++ linux-2.6/drivers/usb/host/ehci-omap.c
@@ -127,6 +127,31 @@
 #define	EHCI_INSNREG05_ULPI_EXTREGADD_SHIFT		8
 #define	EHCI_INSNREG05_ULPI_WRDATA_SHIFT		0
 
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
 
 static inline void ehci_omap_writel(void __iomem *base, u32 reg, u32 val)
@@ -160,6 +185,10 @@ struct ehci_hcd_omap {
 	struct clk		*usbhost_fs_fck;
 	struct clk		*usbtll_fck;
 	struct clk		*usbtll_ick;
+	struct clk		*xclk60mhsp1_ck;
+	struct clk		*xclk60mhsp2_ck;
+	struct clk		*utmi_p1_fck;
+	struct clk		*utmi_p2_fck;
 
 	/* FIXME the following two workarounds are
 	 * board specific not silicon-specific so these
@@ -298,7 +327,163 @@ static int omap_start_ehc(struct ehci_hc
 	}
 
 	if (cpu_is_omap44xx()) {
-		/* TODO */
+		/* Enable clocks for OMAP4 USBHOST */
+		omap->usbhost_hs_fck = clk_get(omap->dev, "usb_host_fck");
+		if (IS_ERR(omap->usbhost_hs_fck)) {
+			ret = PTR_ERR(omap->usbhost_hs_fck);
+			goto err_host;
+		}
+		clk_enable(omap->usbhost_hs_fck);
+
+		omap->usbhost_fs_fck = clk_get(omap->dev, "usb_host_fs_fck");
+		if (IS_ERR(omap->usbhost_fs_fck)) {
+			ret = PTR_ERR(omap->usbhost_fs_fck);
+			goto err_44host_fs_fck;
+		}
+		clk_enable(omap->usbhost_fs_fck);
+
+		omap->xclk60mhsp1_ck = clk_get(omap->dev, "xclk60mhsp1_ck");
+		if (IS_ERR(omap->xclk60mhsp1_ck)) {
+			ret = PTR_ERR(omap->xclk60mhsp1_ck);
+			goto err_xclk60mhsp1_ck;
+		}
+
+		omap->utmi_p1_fck = clk_get(omap->dev, "utmi_p1_gfclk_ck");
+		if (IS_ERR(omap->utmi_p1_fck)) {
+			ret = PTR_ERR(omap->utmi_p1_fck);
+			goto err_xclk60mhsp1_ck;
+		}
+
+		/* Set the clock parent as External clock  */
+		ret = clk_set_parent(omap->utmi_p1_fck, omap->xclk60mhsp1_ck);
+		if (ret != 0)
+			goto err_xclk60mhsp1_ck;
+
+		clk_enable(omap->utmi_p1_fck);
+
+		omap->xclk60mhsp2_ck = clk_get(omap->dev, "xclk60mhsp2_ck");
+		if (IS_ERR(omap->xclk60mhsp2_ck)) {
+			ret = PTR_ERR(omap->xclk60mhsp2_ck);
+			goto err_xclk60mhsp2_ck;
+		}
+
+		omap->utmi_p2_fck = clk_get(omap->dev, "utmi_p2_gfclk_ck");
+		if (IS_ERR(omap->utmi_p2_fck)) {
+			ret = PTR_ERR(omap->utmi_p2_fck);
+			goto err_xclk60mhsp2_ck;
+		}
+
+		/* Set the clock parent as External clock  */
+		ret = clk_set_parent(omap->utmi_p2_fck, omap->xclk60mhsp2_ck);
+
+		if (ret != 0)
+			goto err_xclk60mhsp2_ck;
+
+		clk_enable(omap->utmi_p2_fck);
+
+		/* Put UHH in NoIdle/NoStandby mode */
+		reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
+		reg &= OMAP_UHH_SYSCONFIG_IDLEMODE_RESET;
+		reg |= OMAP_UHH_SYSCONFIG_NIDLEMODE_SET;
+
+		reg &= OMAP_UHH_SYSCONFIG_STDYMODE_RESET;
+		reg |= OMAP_UHH_SYSCONFIG_NSTDYMODE_SET;
+
+		ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
+		reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
+		/* setup ULPI bypass and burst configurations */
+		reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN |
+			OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN |
+			OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN);
+		reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
+
+		/* set p1 & p2 modes */
+		reg &= OMAP_UHH_HOST_PORTS_RESET;
+		if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY)
+			reg |= OMAP_UHH_HOST_P1_SET_ULPIPHY;
+		else if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL)
+			reg |= OMAP_UHH_HOST_P1_SET_ULPITLL;
+
+		if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY)
+			reg |= OMAP_UHH_HOST_P2_SET_ULPIPHY;
+		else if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)
+			reg |= OMAP_UHH_HOST_P2_SET_ULPITLL;
+
+		ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
+		dev_dbg(omap->dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
+
+		if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL) ||
+			(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)) {
+			omap->usbtll_ick = clk_get(omap->dev, "usb_tll_ick");
+			if (IS_ERR(omap->usbtll_ick)) {
+				ret = PTR_ERR(omap->usbtll_ick);
+				goto err_44tll_ick;
+			}
+			clk_enable(omap->usbtll_ick);
+
+			/* perform TLL soft reset, and wait
+			 * until reset is complete */
+			ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
+					OMAP_USBTLL_SYSCONFIG_SOFTRESET);
+
+			/* Wait for TLL reset to complete */
+			while (!(ehci_omap_readl(omap->tll_base,
+				OMAP_USBTLL_SYSSTATUS) &
+				OMAP_USBTLL_SYSSTATUS_RESETDONE)) {
+				cpu_relax();
+
+				if (time_after(jiffies, timeout)) {
+					dev_dbg(omap->dev,
+						"operation timed out\n");
+					ret = -EINVAL;
+					goto err_44sys_status;
+				}
+			}
+
+			dev_dbg(omap->dev, "TLL RESET DONE\n");
+
+			/* (1<<3) = no idle mode only for initial debugging */
+			ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
+					OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
+					OMAP_USBTLL_SYSCONFIG_SIDLEMODE |
+					OMAP_USBTLL_SYSCONFIG_CACTIVITY);
+
+			if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL)
+				tll_ch_mask |= OMAP_TLL_CHANNEL_1_EN_MASK;
+
+			if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)
+				tll_ch_mask |= OMAP_TLL_CHANNEL_2_EN_MASK;
+
+			/* Enable UTMI mode for required TLL channels */
+			omap_usb_utmi_init(omap, tll_ch_mask,
+						OMAP4_TLL_CHANNEL_COUNT);
+		}
+
+		goto ok_host;
+
+err_44sys_status:
+		clk_disable(omap->usbtll_ick);
+		clk_put(omap->usbtll_ick);
+
+err_44tll_ick:
+		clk_disable(omap->utmi_p2_fck);
+		clk_put(omap->utmi_p2_fck);
+		clk_put(omap->xclk60mhsp2_ck);
+
+err_xclk60mhsp2_ck:
+		clk_disable(omap->utmi_p1_fck);
+		clk_put(omap->utmi_p1_fck);
+		clk_put(omap->xclk60mhsp1_ck);
+
+err_xclk60mhsp1_ck:
+		clk_disable(omap->usbhost_fs_fck);
+		clk_put(omap->usbhost_fs_fck);
+
+err_44host_fs_fck:
+		clk_disable(omap->usbhost_hs_fck);
+		clk_put(omap->usbhost_hs_fck);
+
+		goto err_host;
 	} else {
 		/* Enable Clocks for USBHOST */
 		omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
@@ -508,8 +693,13 @@ static void omap_stop_ehc(struct ehci_hc
 	dev_dbg(omap->dev, "stopping TI EHCI USB Controller\n");
 
 	/* Reset OMAP modules for insmod/rmmod to work */
-	ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG,
-			OMAP_UHH_SYSCONFIG_SOFTRESET);
+	if (cpu_is_omap44xx())
+		ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG,
+					OMAP4_UHH_SYSCONFIG_SOFTRESET);
+	else
+		ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG,
+					OMAP_UHH_SYSCONFIG_SOFTRESET);
+
 	while (!(ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSSTATUS)
 				& (1 << 0))) {
 		cpu_relax();
@@ -556,6 +746,18 @@ static void omap_stop_ehc(struct ehci_hc
 		omap->usbhost_ick = NULL;
 	}
 
+	if (omap->utmi_p2_fck != NULL) {
+		clk_disable(omap->utmi_p2_fck);
+		clk_put(omap->utmi_p2_fck);
+		omap->utmi_p2_fck = NULL;
+	}
+
+	if (omap->utmi_p1_fck != NULL) {
+		clk_disable(omap->utmi_p1_fck);
+		clk_put(omap->utmi_p1_fck);
+		omap->utmi_p1_fck = NULL;
+	}
+
 	if (omap->usbhost_fs_fck != NULL) {
 		clk_disable(omap->usbhost_fs_fck);
 		clk_put(omap->usbhost_fs_fck);
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
