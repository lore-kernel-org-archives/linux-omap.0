From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] musb: am35x: fix compile error due to control apis
Date: Fri,  3 Dec 2010 23:42:45 +0530
Message-ID: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

As the control.h have been moved to new location and it's
uses are not allowed to drivers directly so moving the phy
control, interrupt clear and reset functionality to board
files.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Patch created against today's linus tree.

 arch/arm/mach-omap2/board-am3517evm.c |   13 +++-
 arch/arm/mach-omap2/usb-musb.c        |   79 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/usb.h |    3 +
 drivers/usb/musb/am35x.c              |  127 ++++++++++-----------------------
 4 files changed, 133 insertions(+), 89 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 0739950..da9a70a 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -403,7 +403,18 @@ static struct omap_musb_board_data musb_board_data = {
 
 static __init void am3517_evm_musb_init(void)
 {
-	u32 devconf2;
+	u32 devconf2, regval;
+
+	/* Reset the musb interface */
+	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
+
+	regval |= AM35XX_USBOTGSS_SW_RST;
+	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
+
+	regval &= ~AM35XX_USBOTGSS_SW_RST;
+	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
+
+	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
 
 	/*
 	 * Set up USB clock/mode in the DEVCONF2 register.
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 7260558..1f32fdb 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -33,6 +33,82 @@
 
 #ifdef CONFIG_USB_MUSB_SOC
 
+static void am35x_musb_phy_power(u8 on)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+	u32 devconf2;
+
+	if (on) {
+		/*
+		 * Start the on-chip PHY and its PLL.
+		 */
+		devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
+
+		devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN);
+		devconf2 |= CONF2_PHY_PLLON;
+
+		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
+
+		printk(KERN_INFO "Waiting for PHY clock good...\n");
+		while (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
+				& CONF2_PHYCLKGD)) {
+			cpu_relax();
+
+			if (time_after(jiffies, timeout)) {
+				printk(KERN_ERR "musb PHY clock good timed out\n");
+				break;
+			}
+		}
+	} else {
+		/*
+		 * Power down the on-chip PHY.
+		 */
+		devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
+
+		devconf2 &= ~CONF2_PHY_PLLON;
+		devconf2 |=  CONF2_PHYPWRDN | CONF2_OTGPWRDN;
+		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
+	}
+}
+
+static void am35x_musb_clear_irq(void)
+{
+	u32 regval;
+
+	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
+	regval |= AM35XX_USBOTGSS_INT_CLR;
+	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
+	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
+}
+
+static void am35x_musb_set_mode(u8 musb_mode)
+{
+	u32 devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
+
+	devconf2 &= ~CONF2_OTGMODE;
+	switch (musb_mode) {
+#ifdef	CONFIG_USB_MUSB_HDRC_HCD
+	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
+		devconf2 |= CONF2_FORCE_HOST;
+		break;
+#endif
+#ifdef	CONFIG_USB_GADGET_MUSB_HDRC
+	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
+		devconf2 |= CONF2_FORCE_DEVICE;
+		break;
+#endif
+#ifdef	CONFIG_USB_MUSB_OTG
+	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
+		devconf2 |= CONF2_NO_OVERRIDE;
+		break;
+#endif
+	default:
+		printk(KERN_INFO "Unsupported mode %u\n", musb_mode);
+	}
+
+	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
+}
+
 static struct resource musb_resources[] = {
 	[0] = { /* start and end set dynamically */
 		.flags	= IORESOURCE_MEM,
@@ -93,6 +169,9 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 	} else if (cpu_is_omap3517() || cpu_is_omap3505()) {
 		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
 		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
+		board_data->set_phy_power = am35x_musb_phy_power,
+		board_data->clear_irq = am35x_musb_clear_irq,
+		board_data->set_mode = am35x_musb_set_mode,
 	} else if (cpu_is_omap34xx()) {
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
 	} else if (cpu_is_omap44xx()) {
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 59c7fe7..4299097 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -69,6 +69,9 @@ struct omap_musb_board_data {
 	u8	mode;
 	u16	power;
 	unsigned extvbus:1;
+	void	(*set_phy_power) (u8 on);
+	void	(*clear_irq) (void);
+	void	(*set_mode) (u8 mode);
 };
 
 enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index b0aabf3..66fc08a 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -30,7 +30,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/control.h>
 #include <plat/usb.h>
 
 #include "musb_core.h"
@@ -80,47 +79,6 @@
 
 #define USB_MENTOR_CORE_OFFSET	0x400
 
-static inline void phy_on(void)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(100);
-	u32 devconf2;
-
-	/*
-	 * Start the on-chip PHY and its PLL.
-	 */
-	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
-
-	devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN);
-	devconf2 |= CONF2_PHY_PLLON;
-
-	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
-
-	DBG(1, "Waiting for PHY clock good...\n");
-	while (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
-			& CONF2_PHYCLKGD)) {
-		cpu_relax();
-
-		if (time_after(jiffies, timeout)) {
-			DBG(1, "musb PHY clock good timed out\n");
-			break;
-		}
-	}
-}
-
-static inline void phy_off(void)
-{
-	u32 devconf2;
-
-	/*
-	 * Power down the on-chip PHY.
-	 */
-	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
-
-	devconf2 &= ~CONF2_PHY_PLLON;
-	devconf2 |=  CONF2_PHYPWRDN | CONF2_OTGPWRDN;
-	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
-}
-
 /*
  * musb_platform_enable - enable interrupts
  */
@@ -255,9 +213,12 @@ static irqreturn_t am35x_interrupt(int irq, void *hci)
 {
 	struct musb  *musb = hci;
 	void __iomem *reg_base = musb->ctrl_base;
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
-	u32 epintr, usbintr, lvl_intr;
+	u32 epintr, usbintr;
 
 	spin_lock_irqsave(&musb->lock, flags);
 
@@ -346,9 +307,8 @@ eoi:
 	/* EOI needs to be written for the IRQ to be re-asserted. */
 	if (ret == IRQ_HANDLED || epintr || usbintr) {
 		/* clear level interrupt */
-		lvl_intr = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-		lvl_intr |= AM35XX_USBOTGSS_INT_CLR;
-		omap_ctrl_writel(lvl_intr, AM35XX_CONTROL_LVL_INTR_CLEAR);
+		if (data->clear_irq)
+			data->clear_irq();
 		/* write EOI */
 		musb_writel(reg_base, USB_END_OF_INTR_REG, 0);
 	}
@@ -364,37 +324,21 @@ eoi:
 
 int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
 {
-	u32 devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
 
-	devconf2 &= ~CONF2_OTGMODE;
-	switch (musb_mode) {
-#ifdef	CONFIG_USB_MUSB_HDRC_HCD
-	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
-		devconf2 |= CONF2_FORCE_HOST;
-		break;
-#endif
-#ifdef	CONFIG_USB_GADGET_MUSB_HDRC
-	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
-		devconf2 |= CONF2_FORCE_DEVICE;
-		break;
-#endif
-#ifdef	CONFIG_USB_MUSB_OTG
-	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
-		devconf2 |= CONF2_NO_OVERRIDE;
-		break;
-#endif
-	default:
-		DBG(2, "Trying to set unsupported mode %u\n", musb_mode);
-	}
+	if (data->set_mode)
+		data->set_mode(musb_mode);
 
-	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
 	return 0;
 }
 
 int __init musb_platform_init(struct musb *musb, void *board_data)
 {
+	struct omap_musb_board_data *data = board_data;
 	void __iomem *reg_base = musb->ctrl_base;
-	u32 rev, lvl_intr, sw_reset;
+	u32 rev;
 	int status;
 
 	musb->mregs += USB_MENTOR_CORE_OFFSET;
@@ -429,29 +373,18 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
 
 	musb->board_set_vbus = am35x_set_vbus;
 
-	/* Global reset */
-	sw_reset = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
-
-	sw_reset |= AM35XX_USBOTGSS_SW_RST;
-	omap_ctrl_writel(sw_reset, AM35XX_CONTROL_IP_SW_RESET);
-
-	sw_reset &= ~AM35XX_USBOTGSS_SW_RST;
-	omap_ctrl_writel(sw_reset, AM35XX_CONTROL_IP_SW_RESET);
-
-	/* Reset the controller */
-	musb_writel(reg_base, USB_CTRL_REG, AM35X_SOFT_RESET_MASK);
-
 	/* Start the on-chip PHY and its PLL. */
-	phy_on();
+	if (data->set_phy_power)
+		data->set_phy_power(1);
 
 	msleep(5);
 
 	musb->isr = am35x_interrupt;
 
 	/* clear level interrupt */
-	lvl_intr = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-	lvl_intr |= AM35XX_USBOTGSS_INT_CLR;
-	omap_ctrl_writel(lvl_intr, AM35XX_CONTROL_LVL_INTR_CLEAR);
+	if (data->clear_irq)
+		data->clear_irq();
+
 	return 0;
 exit1:
 	clk_disable(musb->phy_clock);
@@ -463,10 +396,16 @@ exit0:
 
 int musb_platform_exit(struct musb *musb)
 {
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
+
 	if (is_host_enabled(musb))
 		del_timer_sync(&otg_workaround);
 
-	phy_off();
+	/* Shutdown the on-chip PHY and its PLL. */
+	if (data->set_phy_power)
+		data->set_phy_power(0);
 
 	otg_put_transceiver(musb->xceiv);
 	usb_nop_xceiv_unregister();
@@ -483,13 +422,25 @@ int musb_platform_exit(struct musb *musb)
 void musb_platform_save_context(struct musb *musb,
 	struct musb_context_registers *musb_context)
 {
-	phy_off();
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
+
+	/* Shutdown the on-chip PHY and its PLL. */
+	if (data->set_phy_power)
+		data->set_phy_power(0);
 }
 
 void musb_platform_restore_context(struct musb *musb,
 	struct musb_context_registers *musb_context)
 {
-	phy_on();
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
+
+	/* Start the on-chip PHY and its PLL. */
+	if (data->set_phy_power)
+		data->set_phy_power(1);
 }
 #endif
 
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
