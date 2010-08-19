From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH 1/5] usb: ohci-omap3: seperate the OMAP3-specific code
Date: Fri, 20 Aug 2010 00:48:06 +0530
Message-ID: <1282245490-24339-2-git-send-email-keshava_mgowda@ti.com>
References: <1282245490-24339-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282245490-24339-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Formats the code so that omap4 ohci host specific code changes can be
inserted in TODO location later.The function cpu_is_omap44xx is used
to determine the OMAP3 or OMAP4 processor. This function will be
later replaced by HWMOD changes.

No functional changes.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ohci-omap3.c |  236 +++++++++++++++++++++---------------------
 1 file changed, 120 insertions(+), 116 deletions(-)

Index: linux-2.6/drivers/usb/host/ohci-omap3.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ohci-omap3.c
+++ linux-2.6/drivers/usb/host/ohci-omap3.c
@@ -290,161 +290,165 @@ static int omap3_start_ohci(struct ohci_
 
 	dev_dbg(omap->dev, "starting TI OHCI USB Controller\n");
 
-	/* Get all the clock handles we need */
-	omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
-	if (IS_ERR(omap->usbhost_ick)) {
-		dev_err(omap->dev, "could not get usbhost_ick\n");
-		ret =  PTR_ERR(omap->usbhost_ick);
-		goto err_host_ick;
-	}
-
-	omap->usbhost_hs_fck = clk_get(omap->dev, "usbhost_120m_fck");
-	if (IS_ERR(omap->usbhost_hs_fck)) {
-		dev_err(omap->dev, "could not get usbhost_120m_fck\n");
-		ret = PTR_ERR(omap->usbhost_hs_fck);
-		goto err_host_hs_fck;
-	}
-
-	omap->usbhost_fs_fck = clk_get(omap->dev, "usbhost_48m_fck");
-	if (IS_ERR(omap->usbhost_fs_fck)) {
-		dev_err(omap->dev, "could not get usbhost_48m_fck\n");
-		ret = PTR_ERR(omap->usbhost_fs_fck);
-		goto err_host_fs_fck;
-	}
+	if (cpu_is_omap44xx()) {
+		/* TODO */
+	} else {
+		/* Get all the clock handles we need */
+		omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
+		if (IS_ERR(omap->usbhost_ick)) {
+			dev_err(omap->dev, "could not get usbhost_ick\n");
+			ret =  PTR_ERR(omap->usbhost_ick);
+			goto err_host_ick;
+		}
 
-	omap->usbtll_fck = clk_get(omap->dev, "usbtll_fck");
-	if (IS_ERR(omap->usbtll_fck)) {
-		dev_err(omap->dev, "could not get usbtll_fck\n");
-		ret = PTR_ERR(omap->usbtll_fck);
-		goto err_tll_fck;
-	}
+		omap->usbhost_hs_fck = clk_get(omap->dev, "usbhost_120m_fck");
+		if (IS_ERR(omap->usbhost_hs_fck)) {
+			dev_err(omap->dev, "could not get usbhost_120m_fck\n");
+			ret = PTR_ERR(omap->usbhost_hs_fck);
+			goto err_host_hs_fck;
+		}
 
-	omap->usbtll_ick = clk_get(omap->dev, "usbtll_ick");
-	if (IS_ERR(omap->usbtll_ick)) {
-		dev_err(omap->dev, "could not get usbtll_ick\n");
-		ret = PTR_ERR(omap->usbtll_ick);
-		goto err_tll_ick;
-	}
+		omap->usbhost_fs_fck = clk_get(omap->dev, "usbhost_48m_fck");
+		if (IS_ERR(omap->usbhost_fs_fck)) {
+			dev_err(omap->dev, "could not get usbhost_48m_fck\n");
+			ret = PTR_ERR(omap->usbhost_fs_fck);
+			goto err_host_fs_fck;
+		}
 
-	/* Now enable all the clocks in the correct order */
-	ohci_omap3_clock_power(omap, 1);
+		omap->usbtll_fck = clk_get(omap->dev, "usbtll_fck");
+		if (IS_ERR(omap->usbtll_fck)) {
+			dev_err(omap->dev, "could not get usbtll_fck\n");
+			ret = PTR_ERR(omap->usbtll_fck);
+			goto err_tll_fck;
+		}
 
-	/* perform TLL soft reset, and wait until reset is complete */
-	ohci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
-			OMAP_USBTLL_SYSCONFIG_SOFTRESET);
+		omap->usbtll_ick = clk_get(omap->dev, "usbtll_ick");
+		if (IS_ERR(omap->usbtll_ick)) {
+			dev_err(omap->dev, "could not get usbtll_ick\n");
+			ret = PTR_ERR(omap->usbtll_ick);
+			goto err_tll_ick;
+		}
 
-	/* Wait for TLL reset to complete */
-	while (!(ohci_omap_readl(omap->tll_base, OMAP_USBTLL_SYSSTATUS)
-			& OMAP_USBTLL_SYSSTATUS_RESETDONE)) {
-		cpu_relax();
+		/* Now enable all the clocks in the correct order */
+		ohci_omap3_clock_power(omap, 1);
 
-		if (time_after(jiffies, timeout)) {
-			dev_dbg(omap->dev, "operation timed out\n");
-			ret = -EINVAL;
-			goto err_sys_status;
+		/* perform TLL soft reset, and wait until reset is complete */
+		ohci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
+				OMAP_USBTLL_SYSCONFIG_SOFTRESET);
+
+		/* Wait for TLL reset to complete */
+		while (!(ohci_omap_readl(omap->tll_base, OMAP_USBTLL_SYSSTATUS)
+				& OMAP_USBTLL_SYSSTATUS_RESETDONE)) {
+			cpu_relax();
+
+			if (time_after(jiffies, timeout)) {
+				dev_dbg(omap->dev, "operation timed out\n");
+				ret = -EINVAL;
+				goto err_sys_status;
+			}
 		}
-	}
 
-	dev_dbg(omap->dev, "TLL reset done\n");
+		dev_dbg(omap->dev, "TLL reset done\n");
 
-	/* (1<<3) = no idle mode only for initial debugging */
-	ohci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
-			OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
-			OMAP_USBTLL_SYSCONFIG_SIDLEMODE |
-			OMAP_USBTLL_SYSCONFIG_CACTIVITY);
+		/* (1<<3) = no idle mode only for initial debugging */
+		ohci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
+				OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
+				OMAP_USBTLL_SYSCONFIG_SIDLEMODE |
+				OMAP_USBTLL_SYSCONFIG_CACTIVITY);
 
 
-	/* Put UHH in NoIdle/NoStandby mode */
-	reg = ohci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
-	reg |= (OMAP_UHH_SYSCONFIG_ENAWAKEUP
+		/* Put UHH in NoIdle/NoStandby mode */
+		reg = ohci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
+		reg |= (OMAP_UHH_SYSCONFIG_ENAWAKEUP
 			| OMAP_UHH_SYSCONFIG_SIDLEMODE
 			| OMAP_UHH_SYSCONFIG_CACTIVITY
 			| OMAP_UHH_SYSCONFIG_MIDLEMODE);
-	reg &= ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
-	reg &= ~OMAP_UHH_SYSCONFIG_SOFTRESET;
+		reg &= ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
+		reg &= ~OMAP_UHH_SYSCONFIG_SOFTRESET;
 
-	ohci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
+		ohci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
 
-	reg = ohci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
+		reg = ohci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 
-	/* setup ULPI bypass and burst configurations */
-	reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
+		/* setup ULPI bypass and burst configurations */
+		reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
 			| OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN
 			| OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN);
-	reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
+		reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
 
-	/*
-	 * REVISIT: Pi_CONNECT_STATUS controls MStandby
-	 * assertion and Swakeup generation - let us not
-	 * worry about this for now. OMAP HWMOD framework
-	 * might take care of this later. If not, we can
-	 * update these registers when adding aggressive
-	 * clock management code.
-	 *
-	 * For now, turn off all the Pi_CONNECT_STATUS bits
-	 *
-	if (omap->port_mode[0] == OMAP_OHCI_PORT_MODE_UNUSED)
-		reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
-	if (omap->port_mode[1] == OMAP_OHCI_PORT_MODE_UNUSED)
-		reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
-	if (omap->port_mode[2] == OMAP_OHCI_PORT_MODE_UNUSED)
-		reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
-	 */
-	reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
-	reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
-	reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
-
-	 if (omap->es2_compatibility) {
 		/*
-		 * All OHCI modes need to go through the TLL,
-		 * unlike in the EHCI case. So use UTMI mode
-		 * for all ports for OHCI, on ES2.x silicon
-		 */
-		dev_dbg(omap->dev, "OMAP3 ES version <= ES2.1\n");
-		reg |= OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
-	} else {
-		dev_dbg(omap->dev, "OMAP3 ES version > ES2.1\n");
+		 * REVISIT: Pi_CONNECT_STATUS controls MStandby
+		 * assertion and Swakeup generation - let us not
+		 * worry about this for now. OMAP HWMOD framework
+		 * might take care of this later. If not, we can
+		 * update these registers when adding aggressive
+		 * clock management code.
+		 *
+		 * For now, turn off all the Pi_CONNECT_STATUS bits
+		 *
 		if (omap->port_mode[0] == OMAP_OHCI_PORT_MODE_UNUSED)
-			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
-		else
-			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
-
+			reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
 		if (omap->port_mode[1] == OMAP_OHCI_PORT_MODE_UNUSED)
-			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
-		else
-			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
-
+			reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
 		if (omap->port_mode[2] == OMAP_OHCI_PORT_MODE_UNUSED)
-			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
-		else
-			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
+			reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
+		 */
+		reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
+		reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
+		reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
 
-	}
-	ohci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
-	dev_dbg(omap->dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
+		 if (omap->es2_compatibility) {
+			/*
+			 * All OHCI modes need to go through the TLL,
+			 * unlike in the EHCI case. So use UTMI mode
+			 * for all ports for OHCI, on ES2.x silicon
+			 */
+			dev_dbg(omap->dev, "OMAP3 ES version <= ES2.1\n");
+			reg |= OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
+		} else {
+			dev_dbg(omap->dev, "OMAP3 ES version > ES2.1\n");
+			if (omap->port_mode[0] == OMAP_OHCI_PORT_MODE_UNUSED)
+				reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
+			else
+				reg |= OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
+
+			if (omap->port_mode[1] == OMAP_OHCI_PORT_MODE_UNUSED)
+				reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
+			else
+				reg |= OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
+
+			if (omap->port_mode[2] == OMAP_OHCI_PORT_MODE_UNUSED)
+				reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
+			else
+				reg |= OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
 
-	ohci_omap3_tll_config(omap, OMAP_TLL_CHANNEL_COUNT);
+		}
+		ohci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
+		dev_dbg(omap->dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
 
-	return 0;
+		ohci_omap3_tll_config(omap, OMAP_TLL_CHANNEL_COUNT);
+
+		return 0;
 
 err_sys_status:
-	ohci_omap3_clock_power(omap, 0);
-	clk_put(omap->usbtll_ick);
+		ohci_omap3_clock_power(omap, 0);
+		clk_put(omap->usbtll_ick);
 
 err_tll_ick:
-	clk_put(omap->usbtll_fck);
+		clk_put(omap->usbtll_fck);
 
 err_tll_fck:
-	clk_put(omap->usbhost_fs_fck);
+		clk_put(omap->usbhost_fs_fck);
 
 err_host_fs_fck:
-	clk_put(omap->usbhost_hs_fck);
+		clk_put(omap->usbhost_hs_fck);
 
 err_host_hs_fck:
-	clk_put(omap->usbhost_ick);
+		clk_put(omap->usbhost_ick);
 
 err_host_ick:
-	return ret;
+		return ret;
+	}
 }
 
 static void omap3_stop_ohci(struct ohci_hcd_omap3 *omap, struct usb_hcd *hcd)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
