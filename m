From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH 2/7] usb: ehci-omap: don't execute OMAP3-specific code on non-OMAP3
Date: Thu, 19 Aug 2010 05:19:32 +0530
Message-ID: <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282175377-2784-2-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Formats the code so that omap4 ehci host driver can be inserted
in TODO location later. The function cpu_is_omap44xx is used to determine
the OMAP3 or OAMP4 processor. This function will be later replaced by
hwmode changes.

There are No functional changes in this patch.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |  295 +++++++++++++++++++++----------------------
 1 file changed, 150 insertions(+), 145 deletions(-)

Index: linux-2.6/drivers/usb/host/ehci-omap.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ehci-omap.c
+++ linux-2.6/drivers/usb/host/ehci-omap.c
@@ -297,194 +297,184 @@ static int omap_start_ehc(struct ehci_hc
 		udelay(10);
 	}
 
-	/* Enable Clocks for USBHOST */
-	omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
-	if (IS_ERR(omap->usbhost_ick)) {
-		ret =  PTR_ERR(omap->usbhost_ick);
-		goto err_host_ick;
-	}
-	clk_enable(omap->usbhost_ick);
+	if (cpu_is_omap44xx()) {
+		/* TODO */
+	} else {
+		/* Enable Clocks for USBHOST */
+		omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
+		if (IS_ERR(omap->usbhost_ick)) {
+			ret =  PTR_ERR(omap->usbhost_ick);
+			goto err_host;
+		}
+		clk_enable(omap->usbhost_ick);
 
-	omap->usbhost_hs_fck = clk_get(omap->dev, "usbhost_120m_fck");
-	if (IS_ERR(omap->usbhost_hs_fck)) {
-		ret = PTR_ERR(omap->usbhost_hs_fck);
-		goto err_host_hs_fck;
-	}
-	clk_enable(omap->usbhost_hs_fck);
+		omap->usbhost_hs_fck = clk_get(omap->dev, "usbhost_120m_fck");
+		if (IS_ERR(omap->usbhost_hs_fck)) {
+			ret = PTR_ERR(omap->usbhost_hs_fck);
+			goto err_host_hs_fck;
+		}
+		clk_enable(omap->usbhost_hs_fck);
 
-	omap->usbhost_fs_fck = clk_get(omap->dev, "usbhost_48m_fck");
-	if (IS_ERR(omap->usbhost_fs_fck)) {
-		ret = PTR_ERR(omap->usbhost_fs_fck);
-		goto err_host_fs_fck;
-	}
-	clk_enable(omap->usbhost_fs_fck);
+		omap->usbhost_fs_fck = clk_get(omap->dev, "usbhost_48m_fck");
+		if (IS_ERR(omap->usbhost_fs_fck)) {
+			ret = PTR_ERR(omap->usbhost_fs_fck);
+			goto err_host_fs_fck;
+		}
+		clk_enable(omap->usbhost_fs_fck);
 
-	/* Configure TLL for 60Mhz clk for ULPI */
-	omap->usbtll_fck = clk_get(omap->dev, "usbtll_fck");
-	if (IS_ERR(omap->usbtll_fck)) {
-		ret = PTR_ERR(omap->usbtll_fck);
-		goto err_tll_fck;
-	}
-	clk_enable(omap->usbtll_fck);
+		/* Configure TLL for 60Mhz clk for ULPI */
+		omap->usbtll_fck = clk_get(omap->dev, "usbtll_fck");
+		if (IS_ERR(omap->usbtll_fck)) {
+			ret = PTR_ERR(omap->usbtll_fck);
+			goto err_tll_fck;
+		}
+		clk_enable(omap->usbtll_fck);
 
-	omap->usbtll_ick = clk_get(omap->dev, "usbtll_ick");
-	if (IS_ERR(omap->usbtll_ick)) {
-		ret = PTR_ERR(omap->usbtll_ick);
-		goto err_tll_ick;
-	}
-	clk_enable(omap->usbtll_ick);
+		omap->usbtll_ick = clk_get(omap->dev, "usbtll_ick");
+		if (IS_ERR(omap->usbtll_ick)) {
+			ret = PTR_ERR(omap->usbtll_ick);
+			goto err_tll_ick;
+		}
+		clk_enable(omap->usbtll_ick);
 
-	/* perform TLL soft reset, and wait until reset is complete */
-	ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
+		/* perform TLL soft reset, and wait until reset is complete */
+		ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
 			OMAP_USBTLL_SYSCONFIG_SOFTRESET);
 
-	/* Wait for TLL reset to complete */
-	while (!(ehci_omap_readl(omap->tll_base, OMAP_USBTLL_SYSSTATUS)
+		/* Wait for TLL reset to complete */
+		while (!(ehci_omap_readl(omap->tll_base, OMAP_USBTLL_SYSSTATUS)
 			& OMAP_USBTLL_SYSSTATUS_RESETDONE)) {
-		cpu_relax();
+			cpu_relax();
 
-		if (time_after(jiffies, timeout)) {
-			dev_dbg(omap->dev, "operation timed out\n");
-			ret = -EINVAL;
-			goto err_sys_status;
+			if (time_after(jiffies, timeout)) {
+				dev_dbg(omap->dev, "operation timed out\n");
+				ret = -EINVAL;
+				goto err_sys_status;
+			}
 		}
-	}
 
-	dev_dbg(omap->dev, "TLL RESET DONE\n");
+		dev_dbg(omap->dev, "TLL RESET DONE\n");
 
-	/* (1<<3) = no idle mode only for initial debugging */
-	ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
+		/* (1<<3) = no idle mode only for initial debugging */
+		ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
 			OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
 			OMAP_USBTLL_SYSCONFIG_SIDLEMODE |
 			OMAP_USBTLL_SYSCONFIG_CACTIVITY);
 
-
-	/* Put UHH in NoIdle/NoStandby mode */
-	reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
-	reg |= (OMAP_UHH_SYSCONFIG_ENAWAKEUP
+		/* Put UHH in NoIdle/NoStandby mode */
+		reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
+		reg |= (OMAP_UHH_SYSCONFIG_ENAWAKEUP
 			| OMAP_UHH_SYSCONFIG_SIDLEMODE
 			| OMAP_UHH_SYSCONFIG_CACTIVITY
 			| OMAP_UHH_SYSCONFIG_MIDLEMODE);
-	reg &= ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
+		reg &= ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
 
-	ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
+		ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
 
-	reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
+		reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 
-	/* setup ULPI bypass and burst configurations */
-	reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
+		/* setup ULPI bypass and burst configurations */
+		reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
 			| OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN
 			| OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN);
-	reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
+		reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
 
-	if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_UNKNOWN)
-		reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
-	if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_UNKNOWN)
-		reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
-	if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_UNKNOWN)
-		reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
-
-	/* Bypass the TLL module for PHY mode operation */
-	if (cpu_is_omap3430() && (omap_rev() <= OMAP3430_REV_ES2_1)) {
-		dev_dbg(omap->dev, "OMAP3 ES version <= ES2.1\n");
-		if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY) ||
-			(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY) ||
+		if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+			reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
+		if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+			reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
+		if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+			reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
+
+		/* Bypass the TLL module for PHY mode operation */
+		if (cpu_is_omap3430() && (omap_rev() <= OMAP3430_REV_ES2_1)) {
+			dev_dbg(omap->dev, "OMAP3 ES version <= ES2.1\n");
+			if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY)
+				||
+				(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY)
+				||
 				(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY))
-			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
-		else
-			reg |= OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
-	} else {
-		dev_dbg(omap->dev, "OMAP3 ES version > ES2.1\n");
-		if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY)
-			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
-		else if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL)
-			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
-
-		if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY)
-			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
-		else if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)
-			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
-
-		if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY)
-			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
-		else if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)
-			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
-
-	}
-	ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
-	dev_dbg(omap->dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
-
+				reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
+			else
+				reg |= OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
+		} else {
+			dev_dbg(omap->dev, "OMAP3 ES version > ES2.1\n");
+			if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY)
+				reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
+			else if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL)
+				reg |= OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
+
+			if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY)
+				reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
+			else if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)
+				reg |= OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
+
+			if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY)
+				reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
+			else if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)
+				reg |= OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
+		}
+		ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
+		dev_dbg(omap->dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
 
-	/*
-	 * An undocumented "feature" in the OMAP3 EHCI controller,
-	 * causes suspended ports to be taken out of suspend when
-	 * the USBCMD.Run/Stop bit is cleared (for example when
-	 * we do ehci_bus_suspend).
-	 * This breaks suspend-resume if the root-hub is allowed
-	 * to suspend. Writing 1 to this undocumented register bit
-	 * disables this feature and restores normal behavior.
-	 */
-	ehci_omap_writel(omap->ehci_base, EHCI_INSNREG04,
+		/*
+		 * An undocumented "feature" in the OMAP3 EHCI controller,
+		 * causes suspended ports to be taken out of suspend when
+		 * the USBCMD.Run/Stop bit is cleared (for example when
+		 * we do ehci_bus_suspend).
+		 * This breaks suspend-resume if the root-hub is allowed
+		 * to suspend. Writing 1 to this undocumented register bit
+		 * disables this feature and restores normal behavior.
+		 */
+		ehci_omap_writel(omap->ehci_base, EHCI_INSNREG04,
 				EHCI_INSNREG04_DISABLE_UNSUSPEND);
 
-	if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL) ||
-		(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL) ||
+		if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL) ||
+			(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL) ||
 			(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)) {
 
-		if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL)
-			tll_ch_mask |= OMAP_TLL_CHANNEL_1_EN_MASK;
-		if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)
-			tll_ch_mask |= OMAP_TLL_CHANNEL_2_EN_MASK;
-		if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)
-			tll_ch_mask |= OMAP_TLL_CHANNEL_3_EN_MASK;
-
-		/* Enable UTMI mode for required TLL channels */
-		omap_usb_utmi_init(omap, tll_ch_mask, OMAP_TLL_CHANNEL_COUNT);
-	}
-
-	if (omap->phy_reset) {
-		/* Refer ISSUE1:
-		 * Hold the PHY in RESET for enough time till
-		 * PHY is settled and ready
-		 */
-		udelay(10);
-
-		if (gpio_is_valid(omap->reset_gpio_port[0]))
-			gpio_set_value(omap->reset_gpio_port[0], 1);
-
-		if (gpio_is_valid(omap->reset_gpio_port[1]))
-			gpio_set_value(omap->reset_gpio_port[1], 1);
-	}
+			if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL)
+				tll_ch_mask |= OMAP_TLL_CHANNEL_1_EN_MASK;
+			if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)
+				tll_ch_mask |= OMAP_TLL_CHANNEL_2_EN_MASK;
+			if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)
+				tll_ch_mask |= OMAP_TLL_CHANNEL_3_EN_MASK;
+
+			/* Enable UTMI mode for required TLL channels */
+			omap_usb_utmi_init(omap, tll_ch_mask,
+					OMAP_TLL_CHANNEL_COUNT);
+		}
 
-	/* Soft reset the PHY using PHY reset command over ULPI */
-	if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY)
-		omap_ehci_soft_phy_reset(omap, 0);
-	if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY)
-		omap_ehci_soft_phy_reset(omap, 1);
+		/* Soft reset the PHY using PHY reset command over ULPI */
+		if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY)
+			omap_ehci_soft_phy_reset(omap, 0);
+		if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY)
+			omap_ehci_soft_phy_reset(omap, 1);
 
-	return 0;
+		goto ok_host;
 
 err_sys_status:
-	clk_disable(omap->usbtll_ick);
-	clk_put(omap->usbtll_ick);
+		clk_disable(omap->usbtll_ick);
+		clk_put(omap->usbtll_ick);
 
 err_tll_ick:
-	clk_disable(omap->usbtll_fck);
-	clk_put(omap->usbtll_fck);
+		clk_disable(omap->usbtll_fck);
+		clk_put(omap->usbtll_fck);
 
 err_tll_fck:
-	clk_disable(omap->usbhost_fs_fck);
-	clk_put(omap->usbhost_fs_fck);
+		clk_disable(omap->usbhost_fs_fck);
+		clk_put(omap->usbhost_fs_fck);
 
 err_host_fs_fck:
-	clk_disable(omap->usbhost_hs_fck);
-	clk_put(omap->usbhost_hs_fck);
+		clk_disable(omap->usbhost_hs_fck);
+		clk_put(omap->usbhost_hs_fck);
 
 err_host_hs_fck:
-	clk_disable(omap->usbhost_ick);
-	clk_put(omap->usbhost_ick);
+		clk_disable(omap->usbhost_ick);
+		clk_put(omap->usbhost_ick);
+	}
 
-err_host_ick:
+err_host:
 	if (omap->phy_reset) {
 		if (gpio_is_valid(omap->reset_gpio_port[0]))
 			gpio_free(omap->reset_gpio_port[0]);
@@ -492,8 +482,23 @@ err_host_ick:
 		if (gpio_is_valid(omap->reset_gpio_port[1]))
 			gpio_free(omap->reset_gpio_port[1]);
 	}
