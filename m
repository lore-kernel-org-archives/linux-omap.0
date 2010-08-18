From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 8/8 v2] usb : musb: Using runtime pm apis for musb.
Date: Wed, 18 Aug 2010 19:41:19 +0530
Message-ID: <1282140679-29963-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Calling runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
for enabling/disabling the clocks,sysconfig settings.

used omap_hwmod_enable_wakeup & omap_hwmod_disable_wakeup apis to set/clear
the wakeup enable bit.
Also need to put the USB in force standby and force idle mode when usb not used
and set it back to smart idle and smart stndby after wakeup.
these cases are handled using the oh flags.
For omap3430 auto idle bit has to be disabled because of the errata.So using
HWMOD_NO_OCP_AUTOIDLE flag for OMAP3430.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Basak, Partha <p-basak2-l0cyMroinI0@public.gmane.org>

Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/pm34xx.c          |    8 ++-
 arch/arm/mach-omap2/usb-musb.c        |   86 ++++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/usb.h |    9 +++-
 drivers/usb/musb/musb_core.c          |   12 +++++
 drivers/usb/musb/omap2430.c           |   65 +++++--------------------
 include/linux/usb/musb.h              |    8 +++
 6 files changed, 127 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7b34201..0eb39b3 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -418,7 +418,9 @@ void omap_sram_idle(void)
 			omap3_core_save_context();
 			omap3_prcm_save_context();
 			/* Save MUSB context */
-			musb_context_save_restore(1);
+			musb_context_save_restore(save_context);
+		} else {
+			musb_context_save_restore(disable_clk);
 		}
 	}
 
@@ -462,7 +464,9 @@ void omap_sram_idle(void)
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 			/* restore MUSB context */
-			musb_context_save_restore(0);
+			musb_context_save_restore(restore_context);
+		} else {
+			musb_context_save_restore(enable_clk);
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 9d10440..b7736d2 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/usb/musb.h>
 
@@ -64,13 +65,32 @@ static struct musb_hdrc_platform_data musb_plat = {
 	/* supports clock autogating */
 	.clk_autogated	= 1,
 };
+static int usb_idle_hwmod(struct omap_device *od)
+{
+	struct omap_hwmod *oh = *od->hwmods;
+	if (irqs_disabled())
+		_omap_hwmod_idle(oh);
+	else
+		omap_device_idle_hwmods(od);
+	return 0;
+}
+
+static int usb_enable_hwmod(struct omap_device *od)
+{
+	struct omap_hwmod *oh = *od->hwmods;
+	if (irqs_disabled())
+		_omap_hwmod_enable(oh);
+	else
+		omap_device_enable_hwmods(od);
+	return 0;
+}
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
 
 static struct omap_device_pm_latency omap_musb_latency[] = {
 	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func   = omap_device_enable_hwmods,
+		.deactivate_func = usb_idle_hwmod,
+		.activate_func   = usb_enable_hwmod,
 		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
 };
@@ -100,6 +120,8 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 	musb_plat.power = board_data->power >> 1;
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
+	musb_plat.enable_wakeup = omap_device_enable_wakeup;
+	musb_plat.disable_wakeup = omap_device_disable_wakeup;
 	pdata = &musb_plat;
 	oh_p = oh;
 	od = omap_device_build(name, bus_id, oh, pdata,
@@ -120,7 +142,7 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 
 }
 
-void musb_context_save_restore(int save)
+void musb_context_save_restore(enum musb_state state)
 {
 	struct omap_hwmod *oh = oh_p;
 	struct omap_device *od;
@@ -145,10 +167,62 @@ void musb_context_save_restore(int save)
 
 		if (!pdata->is_usb_active(dev)) {
 
-			if (save)
+			switch (state) {
+			case save_context:
+				/* As per the OMAP USBOTG specicifcation,
+				 * if USB device is not active and attempting
+				 * to core off then save the context,
+				 * set the sysconfig reg to force standby
+				 * force idle and disable the clock.
+				 */
+				oh->flags |= HWMOD_SWSUP_SIDLE
+						| HWMOD_SWSUP_MSTANDBY;
 				pm->suspend(dev);
-			else
+				pm_runtime_put_sync(dev);
+
+				break;
+
+			case disable_clk:
+				/* If the USB device not active then
+				 * set the sysconfig setting
+				 * to force standby force idle and
+				 * disable the clock.
+				 */
+				oh->flags |= HWMOD_SWSUP_SIDLE
+					| HWMOD_SWSUP_MSTANDBY;
+				pm_runtime_put_sync(dev);
+
+				break;
+
+			case restore_context:
+				/* As per the OMAP USBOTG specicifcation,
+				 * configure the USB into smart idle and smart
+				 * standbyduring active. Enable the
+				 * clock, set the sysconfig back to smart idle
+				 * and smart stndby and restore the context
+				 * after wakeup from core-off.
+				 */
+				oh->flags &= ~(HWMOD_SWSUP_SIDLE
+					| HWMOD_SWSUP_MSTANDBY);
+				pm_runtime_get_sync(dev);
 				pm->resume_noirq(dev);
+
+				break;
+
+			case enable_clk:
+				/* Set the sysconfig back to smart
+				 * idle and smart stndby after wakeup and
+				 * enable the clock.
+				 */
+				oh->flags &= ~(HWMOD_SWSUP_SIDLE
+					| HWMOD_SWSUP_MSTANDBY);
+				pm_runtime_get_sync(dev);
+
+				break;
+
+			default:
+				break;
+			}
 		}
 	}
 }
@@ -157,7 +231,7 @@ void musb_context_save_restore(int save)
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
 }
-void musb_context_save_restore(int save)
+void musb_context_save_restore(enum musb_state state)
 {
 }
 #endif /* CONFIG_USB_MUSB_SOC */
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index ed2b41a..82b8618 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -71,6 +71,13 @@ struct omap_musb_board_data {
 	unsigned extvbus:1;
 };
 
+enum musb_state {
+	save_context = 1,
+	disable_clk,
+	restore_context,
+	enable_clk,
+	};
+
 enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
 
 extern void usb_musb_init(struct omap_musb_board_data *board_data);
@@ -80,7 +87,7 @@ extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata);
 extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata);
 
 /* For saving and restoring the musb context during off/wakeup*/
-extern void musb_context_save_restore(int save);
+extern void musb_context_save_restore(enum musb_state state);
 #endif
 
 
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 8510e55..e875c83 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2456,9 +2456,21 @@ static int musb_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static int musb_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int musb_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
 static const struct dev_pm_ops musb_dev_pm_ops = {
 	.suspend	= musb_suspend,
 	.resume_noirq	= musb_resume_noirq,
+	.runtime_suspend = musb_runtime_suspend,
+	.runtime_resume	 = musb_runtime_resume,
 };
 
 #define MUSB_DEV_PM_OPS (&musb_dev_pm_ops)
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index dcba935..d83b644 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -31,6 +31,8 @@
 #include <linux/list.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
 
 #include <plat/mux.h>
 
@@ -219,22 +221,6 @@ int __init musb_platform_init(struct musb *musb)
 	}
 
 	musb_platform_resume(musb);
-
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
-	l &= ~NOSTDBY;		/* remove possible nostdby */
-	l |= SMARTSTDBY;	/* enable smart standby */
-	l &= ~AUTOIDLE;		/* disable auto idle */
-	l &= ~NOIDLE;		/* remove possible noidle */
-	l |= SMARTIDLE;		/* enable smart idle */
-	/*
-	 * MUSB AUTOIDLE don't work in 3430.
-	 * Workaround by Richard Woodruff/TI
-	 */
-	if (!cpu_is_omap3430())
-		l |= AUTOIDLE;		/* enable auto idle */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
-
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
 	if (data->interface_type == MUSB_INTERFACE_UTMI) {
@@ -274,16 +260,6 @@ void musb_platform_save_context(struct musb *musb,
 	 */
 	void __iomem *musb_base = musb->mregs;
 
-	musb_writel(musb_base, OTG_FORCESTDBY, 0);
-
-	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
-				OTG_SYSCONFIG) & ~(NOSTDBY | SMARTSTDBY));
-
-	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
-					OTG_SYSCONFIG) & ~AUTOIDLE);
-
-	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
-				OTG_SYSCONFIG) & ~(NOIDLE | SMARTIDLE));
 
 	musb_writel(musb_base, OTG_FORCESTDBY, 1);
 }
@@ -298,18 +274,15 @@ void musb_platform_restore_context(struct musb *musb,
 	void __iomem *musb_base = musb->mregs;
 
 	musb_writel(musb_base, OTG_FORCESTDBY, 0);
-
-	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
-				OTG_SYSCONFIG) | SMARTSTDBY);
-
-	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
-				OTG_SYSCONFIG) | SMARTIDLE | ENABLEWAKEUP);
 }
 #endif
 
 static int musb_platform_suspend(struct musb *musb)
 {
 	u32 l;
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *pdata = dev->platform_data;
+	struct platform_device *pdev = to_platform_device(dev);
 
 	if (!musb->clock)
 		return 0;
@@ -318,17 +291,9 @@ static int musb_platform_suspend(struct musb *musb)
 	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
 	l |= ENABLEFORCE;	/* enable MSTANDBY */
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
-
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l |= ENABLEWAKEUP;	/* enable wakeup */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
-
+	pdata->enable_wakeup(pdev);
 	otg_set_suspend(musb->xceiv, 1);
-
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 0);
-	else
-		clk_disable(musb->clock);
+	pm_runtime_put_sync(dev);
 
 	return 0;
 }
@@ -336,21 +301,17 @@ static int musb_platform_suspend(struct musb *musb)
 static int musb_platform_resume(struct musb *musb)
 {
 	u32 l;
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *pdata = dev->platform_data;
+	struct platform_device *pdev = to_platform_device(dev);
 
 	if (!musb->clock)
 		return 0;
 
 	otg_set_suspend(musb->xceiv, 0);
-
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 1);
-	else
-		clk_enable(musb->clock);
-
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
-
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+	pdata->enable_wakeup(pdev);
 	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
 	l &= ~ENABLEFORCE;	/* disable MSTANDBY */
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index da134ab..20b2cc8 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -93,6 +93,8 @@ struct musb_hdrc_config {
 
 };
 
+struct platform_device;
+
 struct musb_hdrc_platform_data {
 	/* MUSB_HOST, MUSB_PERIPHERAL, or MUSB_OTG */
 	u8		mode;
@@ -132,6 +134,12 @@ struct musb_hdrc_platform_data {
 
 	/*  indiates whether clock is autogated */
 	int		clk_autogated;
+
+	/* set the enable wakeup bit of sysconfig register */
+	int		(*enable_wakeup)(struct platform_device *pdev);
+
+	/* Clear the enable wakeup bit  of sysconfig register */
+	int		(*disable_wakeup)(struct platform_device *pdev);
 };
 
 
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
