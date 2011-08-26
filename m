From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 6/6] usb: musb: Add support for ti81xx platform
Date: Fri, 26 Aug 2011 16:41:48 +0530
Message-ID: <1314357108-2279-7-git-send-email-ajay.gupta@ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1314357108-2279-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>

TI81XX platform has two musb interfaces and uses CPPI4.1 DMA engine.
It has builtin USB PHYs as AM35x. The current set of patches adds support
for one instance and only in PIO mode.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/Kconfig     |    6 +
 drivers/usb/musb/Makefile    |    1 +
 drivers/usb/musb/musb_core.c |    4 +-
 drivers/usb/musb/ti81xx.c    |  637 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 647 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/musb/ti81xx.c

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 6192b45..d6d5bed 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -11,6 +11,7 @@ config USB_MUSB_HDRC
 	depends on USB && USB_GADGET
 	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
+	select NOP_USB_XCEIV if SOC_OMAPTI81XX
 	select TWL4030_USB if MACH_OMAP_3430SDP
 	select TWL6030_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
 	select USB_OTG_UTILS
@@ -57,6 +58,10 @@ config USB_MUSB_AM35X
 	tristate "AM35x"
 	depends on ARCH_OMAP
 
+config USB_MUSB_TI81XX
+	bool "TI81XX"
+	depends on SOC_OMAPTI81XX
+
 config USB_MUSB_BLACKFIN
 	tristate "Blackfin"
 	depends on (BF54x && !BF544) || (BF52x && ! BF522 && !BF523)
@@ -71,6 +76,7 @@ config MUSB_PIO_ONLY
 	bool 'Disable DMA (always use PIO)'
 	depends on USB_MUSB_HDRC
 	default USB_MUSB_TUSB6010 || USB_MUSB_DA8XX || USB_MUSB_AM35X
+	default SOC_OMAPTI81XX
 	help
 	  All data is copied between memory and FIFO by the CPU.
 	  DMA controllers are ignored.
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index d8fd9d0..2df01b4 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -13,6 +13,7 @@ musb_hdrc-$(CONFIG_DEBUG_FS)			+= musb_debugfs.o
 # Hardware Glue Layer
 obj-$(CONFIG_USB_MUSB_OMAP2PLUS)		+= omap2430.o
 obj-$(CONFIG_USB_MUSB_AM35X)			+= am35x.o
+obj-$(CONFIG_USB_MUSB_TI81XX)			+= ti81xx.o
 obj-$(CONFIG_USB_MUSB_TUSB6010)			+= tusb6010.o
 obj-$(CONFIG_USB_MUSB_DAVINCI)			+= davinci.o
 obj-$(CONFIG_USB_MUSB_DA8XX)			+= da8xx.o
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 20a2873..07f3faf 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1014,7 +1014,9 @@ static void musb_shutdown(struct platform_device *pdev)
 	|| defined(CONFIG_USB_MUSB_OMAP2PLUS)		\
 	|| defined(CONFIG_USB_MUSB_OMAP2PLUS_MODULE)	\
 	|| defined(CONFIG_USB_MUSB_AM35X)		\
-	|| defined(CONFIG_USB_MUSB_AM35X_MODULE)
+	|| defined(CONFIG_USB_MUSB_AM35X_MODULE)	\
+	|| defined(CONFIG_USB_MUSB_TI81XX)		\
+	|| defined(CONFIG_USB_MUSB_TI81XX_MODULE)
 static ushort __initdata fifo_mode = 4;
 #elif defined(CONFIG_USB_MUSB_UX500)			\
 	|| defined(CONFIG_USB_MUSB_UX500_MODULE)
diff --git a/drivers/usb/musb/ti81xx.c b/drivers/usb/musb/ti81xx.c
new file mode 100644
index 0000000..f95774e
--- /dev/null
+++ b/drivers/usb/musb/ti81xx.c
@@ -0,0 +1,637 @@
+/*
+ * Texas Instruments TI81XX "glue layer"
+ *
+ * Copyright (C) 2011, by Texas Instruments
+ *
+ * Based on the am35x "glue layer" code.
+ *
+ * This file is part of the Inventra Controller Driver for Linux.
+ *
+ * The Inventra Controller Driver for Linux is free software; you
+ * can redistribute it and/or modify it under the terms of the GNU
+ * General Public License version 2 as published by the Free Software
+ * Foundation.
+ *
+ * The Inventra Controller Driver for Linux is distributed in
+ * the hope that it will be useful, but WITHOUT ANY WARRANTY;
+ * without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+ * License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with The Inventra Controller Driver for Linux ; if not,
+ * write to the Free Software Foundation, Inc., 59 Temple Place,
+ * Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+
+#include <plat/usb.h>
+
+#include "musb_core.h"
+
+/**
+ * TI81XX specific definitions
+ */
+/* USB 2.0 OTG module registers */
+#define USB_REVISION_REG        0x00
+#define USB_CTRL_REG            0x14
+#define USB_STAT_REG            0x18
+#define USB_IRQ_MERGED_STATUS	0x20
+#define USB_IRQ_EOI		0x24
+#define USB_IRQ_STATUS_RAW_0	0x28
+#define USB_IRQ_STATUS_RAW_1	0x2c
+#define USB_IRQ_STATUS_0	0x30
+#define USB_IRQ_STATUS_1	0x34
+#define USB_IRQ_ENABLE_SET_0	0x38
+#define USB_IRQ_ENABLE_SET_1	0x3c
+#define USB_IRQ_ENABLE_CLR_0	0x40
+#define USB_IRQ_ENABLE_CLR_1	0x44
+
+#define USB_EP_INTR_SET_REG		USB_IRQ_ENABLE_SET_0
+#define USB_EP_INTR_CLEAR_REG		USB_IRQ_ENABLE_CLR_0
+#define USB_EP_INTR_STATUS_REG		USB_IRQ_STATUS_0
+#define USB_CORE_INTR_SET_REG		USB_IRQ_ENABLE_SET_1
+#define USB_CORE_INTR_CLEAR_REG		USB_IRQ_ENABLE_CLR_1
+#define USB_CORE_INTR_STATUS_REG	USB_IRQ_STATUS_1
+
+#define USB_SRP_FIX_TIME_REG    0xd4
+#define USB_PHY_UTMI_REG	0xe0
+#define USB_PHY_UTMI_LB_REG	0xe4
+#define USB_MODE_REG		0xe8
+
+/* PHY UTMI register bits */
+#define USB_PHY_UTMI_OTG_DISABLE	(1 << 21)
+
+/* USB MODE register bits */
+#define USB_MODE_IDDIG		(1 << 8)
+
+/* Control register bits */
+#define USB_SOFT_RESET_MASK     1
+
+/* USB interrupt register bits */
+#define USB_INTR_USB_SHIFT      0
+#define USB_INTR_USB_MASK       (0x1ff << USB_INTR_USB_SHIFT)
+#define USB_INTR_DRVVBUS        0x100
+#define USB_INTR_RX_SHIFT       16
+#define USB_INTR_TX_SHIFT       0
+#define USB_TX_EP_MASK		0xffff		/* EP0 + 15 Tx EPs */
+#define USB_RX_EP_MASK		0xfffe		/* 15 Rx EPs */
+#define USB_TX_INTR_MASK	(USB_TX_EP_MASK << USB_INTR_TX_SHIFT)
+#define USB_RX_INTR_MASK	(USB_RX_EP_MASK << USB_INTR_RX_SHIFT)
+
+#define USB_MENTOR_CORE_OFFSET  0x400
+
+/**
+ * avoid using musb_readx()/musb_writex() as glue layer should not be
+ * dependent on musb core layer symbols.
+ */
+static inline u8 ti81xx_readb(const void __iomem *addr, unsigned offset)
+	{ return __raw_readb(addr + offset); }
+
+static inline u32 ti81xx_readl(const void __iomem *addr, unsigned offset)
+	{ return __raw_readl(addr + offset); }
+
+static inline void ti81xx_writeb(void __iomem *addr, unsigned offset, u8 data)
+	{ __raw_writeb(data, addr + offset); }
+
+static inline void ti81xx_writel(void __iomem *addr, unsigned offset, u32 data)
+	{ __raw_writel(data, addr + offset); }
+
+/**
+ * TI81XX glue has one interface clock and two seperate clocks to individual
+ * PHY.
+ */
+struct ti81xx_glue {
+	struct device *dev;
+	struct clk *ick;		/* common usbss interface clk */
+	void __iomem *usbss_base;	/* ioremapped virtual address */
+	struct platform_device *musb[2];/* child musb pdevs */
+};
+
+/**
+ * ti81xx_musb_enable - enable interrupts
+ */
+static void ti81xx_musb_enable(struct musb *musb)
+{
+	void __iomem *reg_base = musb->ctrl_base;
+	u32 epmask, coremask;
+
+	/* Workaround: setup IRQs through both register sets. */
+	epmask = ((musb->epmask & USB_TX_EP_MASK) << USB_INTR_TX_SHIFT) |
+	       ((musb->epmask & USB_RX_EP_MASK) << USB_INTR_RX_SHIFT);
+	coremask = (USB_INTR_USB_MASK & ~MUSB_INTR_SOF);
+
+	ti81xx_writel(reg_base, USB_EP_INTR_SET_REG, epmask);
+	ti81xx_writel(reg_base, USB_CORE_INTR_SET_REG, coremask);
+	/* Force the DRVVBUS IRQ so we can start polling for ID change. */
+	if (is_otg_enabled(musb))
+		ti81xx_writel(reg_base, USB_CORE_INTR_SET_REG,
+			    USB_INTR_DRVVBUS << USB_INTR_USB_SHIFT);
+}
+
+/**
+ * ti81xx_musb_disable - disable HDRC and flush interrupts
+ */
+static void ti81xx_musb_disable(struct musb *musb)
+{
+	void __iomem *reg_base = musb->ctrl_base;
+
+	ti81xx_writel(reg_base, USB_CORE_INTR_CLEAR_REG, USB_INTR_USB_MASK);
+	ti81xx_writel(reg_base, USB_EP_INTR_CLEAR_REG,
+			 USB_TX_INTR_MASK | USB_RX_INTR_MASK);
+	ti81xx_writeb(musb->mregs, MUSB_DEVCTL, 0);
+	ti81xx_writel(reg_base, USB_IRQ_EOI, 0);
+}
+
+#define portstate(stmt)	stmt
+
+#define	POLL_SECONDS	2
+
+static struct timer_list otg_workaround;
+
+static void otg_timer(unsigned long _musb)
+{
+	struct musb		*musb = (void *)_musb;
+	void __iomem		*mregs = musb->mregs;
+	u8			devctl;
+	unsigned long		flags;
+
+	/*
+	 * We poll because DaVinci's won't expose several OTG-critical
+	 * status change events (from the transceiver) otherwise.
+	 */
+	devctl = ti81xx_readb(mregs, MUSB_DEVCTL);
+	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl,
+				otg_state_string(musb->xceiv->state));
+
+	spin_lock_irqsave(&musb->lock, flags);
+	switch (musb->xceiv->state) {
+	case OTG_STATE_A_WAIT_BCON:
+		devctl &= ~MUSB_DEVCTL_SESSION;
+		ti81xx_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+
+		devctl = ti81xx_readb(musb->mregs, MUSB_DEVCTL);
+		if (devctl & MUSB_DEVCTL_BDEVICE) {
+			musb->xceiv->state = OTG_STATE_B_IDLE;
+			MUSB_DEV_MODE(musb);
+		} else {
+			musb->xceiv->state = OTG_STATE_A_IDLE;
+			MUSB_HST_MODE(musb);
+		}
+		break;
+	case OTG_STATE_A_WAIT_VFALL:
+		musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
+		ti81xx_writel(musb->ctrl_base, USB_CORE_INTR_SET_REG,
+			    MUSB_INTR_VBUSERROR << USB_INTR_USB_SHIFT);
+		break;
+	case OTG_STATE_B_IDLE:
+		if (!is_peripheral_enabled(musb))
+			break;
+
+		devctl = ti81xx_readb(mregs, MUSB_DEVCTL);
+		if (devctl & MUSB_DEVCTL_BDEVICE)
+			mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
+		else
+			musb->xceiv->state = OTG_STATE_A_IDLE;
+		break;
+	default:
+		break;
+	}
+	spin_unlock_irqrestore(&musb->lock, flags);
+}
+
+static void ti81xx_musb_try_idle(struct musb *musb, unsigned long timeout)
+{
+	static unsigned long last_timer;
+
+	if (!is_otg_enabled(musb))
+		return;
+
+	if (timeout == 0)
+		timeout = jiffies + msecs_to_jiffies(3);
+
+	/* Never idle if active, or when VBUS timeout is not set as host */
+	if (musb->is_active || (musb->a_wait_bcon == 0 &&
+				musb->xceiv->state == OTG_STATE_A_WAIT_BCON)) {
+		dev_dbg(musb->controller, "%s active, deleting timer\n",
+				otg_state_string(musb->xceiv->state));
+		del_timer(&otg_workaround);
+		last_timer = jiffies;
+		return;
+	}
+
+	if (time_after(last_timer, timeout) && timer_pending(&otg_workaround)) {
+		dev_dbg(musb->controller,
+			"Longer idle timer already pending, ignoring...\n");
+		return;
+	}
+	last_timer = timeout;
+
+	dev_dbg(musb->controller, "%s inactive, starting idle timer for %u ms\n",
+		otg_state_string(musb->xceiv->state),
+			jiffies_to_msecs(timeout - jiffies));
+	mod_timer(&otg_workaround, timeout);
+}
+
+static irqreturn_t ti81xx_interrupt(int irq, void *hci)
+{
+	struct musb  *musb = hci;
+	void __iomem *reg_base = musb->ctrl_base;
+	unsigned long flags;
+	irqreturn_t ret = IRQ_NONE;
+	u32 epintr, usbintr;
+
+	spin_lock_irqsave(&musb->lock, flags);
+
+	/* Get endpoint interrupts */
+	epintr = ti81xx_readl(reg_base, USB_EP_INTR_STATUS_REG);
+	musb->int_rx = (epintr & USB_RX_INTR_MASK) >> USB_INTR_RX_SHIFT;
+	musb->int_tx = (epintr & USB_TX_INTR_MASK) >> USB_INTR_TX_SHIFT;
+
+	if (epintr)
+		ti81xx_writel(reg_base, USB_EP_INTR_STATUS_REG, epintr);
+
+	/* Get usb core interrupts */
+	usbintr = ti81xx_readl(reg_base, USB_CORE_INTR_STATUS_REG);
+	if (!usbintr && !epintr)
+		goto eoi;
+
+	musb->int_usb =	(usbintr & USB_INTR_USB_MASK) >> USB_INTR_USB_SHIFT;
+	if (usbintr)
+		ti81xx_writel(reg_base, USB_CORE_INTR_STATUS_REG, usbintr);
+
+	dev_dbg(musb->controller, "usbintr (%x) epintr(%x)\n",
+			usbintr, epintr);
+	/*
+	 * DRVVBUS IRQs are the only proxy we have (a very poor one!) for
+	 * TI81XX's missing ID change IRQ.  We need an ID change IRQ to
+	 * switch appropriately between halves of the OTG state machine.
+	 * Managing DEVCTL.SESSION per Mentor docs requires that we know its
+	 * value but DEVCTL.BDEVICE is invalid without DEVCTL.SESSION set.
+	 * Also, DRVVBUS pulses for SRP (but not at 5V) ...
+	 */
+	if ((usbintr & MUSB_INTR_BABBLE) && is_host_enabled(musb))
+		pr_info("CAUTION: musb: Babble Interrupt Occured\n");
+
+	if (usbintr & (USB_INTR_DRVVBUS << USB_INTR_USB_SHIFT)) {
+		int drvvbus = ti81xx_readl(reg_base, USB_STAT_REG);
+		void __iomem *mregs = musb->mregs;
+		u8 devctl = ti81xx_readb(mregs, MUSB_DEVCTL);
+		int err;
+
+		err = is_host_enabled(musb) && (musb->int_usb &
+						MUSB_INTR_VBUSERROR);
+		if (err) {
+			/*
+			 * The Mentor core doesn't debounce VBUS as needed
+			 * to cope with device connect current spikes. This
+			 * means it's not uncommon for bus-powered devices
+			 * to get VBUS errors during enumeration.
+			 *
+			 * This is a workaround, but newer RTL from Mentor
+			 * seems to allow a better one: "re"-starting sessions
+			 * without waiting for VBUS to stop registering in
+			 * devctl.
+			 */
+			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
+			musb->xceiv->state = OTG_STATE_A_WAIT_VFALL;
+			mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
+			WARNING("VBUS error workaround (delay coming)\n");
+		} else if (is_host_enabled(musb) && drvvbus) {
+			musb->is_active = 1;
+			MUSB_HST_MODE(musb);
+			musb->xceiv->default_a = 1;
+			musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
+			portstate(musb->port1_status |= USB_PORT_STAT_POWER);
+			del_timer(&otg_workaround);
+		} else {
+			musb->is_active = 0;
+			MUSB_DEV_MODE(musb);
+			musb->xceiv->default_a = 0;
+			musb->xceiv->state = OTG_STATE_B_IDLE;
+			portstate(musb->port1_status &= ~USB_PORT_STAT_POWER);
+		}
+
+		/* NOTE: this must complete power-on within 100 ms. */
+		dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
+				drvvbus ? "on" : "off",
+				otg_state_string(musb->xceiv->state),
+				err ? " ERROR" : "",
+				devctl);
+		ret = IRQ_HANDLED;
+	}
+
+	if (musb->int_tx || musb->int_rx || musb->int_usb)
+		ret |= musb_interrupt(musb);
+
+ eoi:
+	/* EOI needs to be written for the IRQ to be re-asserted. */
+	if (ret == IRQ_HANDLED || epintr || usbintr)
+		ti81xx_writel(reg_base, USB_IRQ_EOI, 1);
+
+	/* Poll for ID change */
+	if (is_otg_enabled(musb) && musb->xceiv->state == OTG_STATE_B_IDLE)
+		mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
+
+	spin_unlock_irqrestore(&musb->lock, flags);
+
+	return ret;
+}
+
+static int ti81xx_musb_init(struct musb *musb)
+{
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
+	void __iomem *reg_base = musb->ctrl_base;
+	u32 rev, val;
+	int status;
+
+	/* mentor core register starts at offset of 0x400 from musb base */
+	musb->mregs += USB_MENTOR_CORE_OFFSET;
+
+	/* NOP driver needs change if supporting dual instance */
+	usb_nop_xceiv_register();
+	musb->xceiv = otg_get_transceiver();
+	if (!musb->xceiv)
+		return -ENODEV;
+
+	status = pm_runtime_get_sync(dev);
+	if (status < 0) {
+		dev_err(dev, "pm_runtime_get_sync FAILED");
+		goto err0;
+	}
+
+	/* Returns zero if e.g. not clocked */
+	rev = ti81xx_readl(reg_base, USB_REVISION_REG);
+	if (!rev) {
+		status = -ENODEV;
+		goto err0;
+	}
+
+	if (is_host_enabled(musb))
+		setup_timer(&otg_workaround, otg_timer, (unsigned long) musb);
+
+	/* Reset the musb */
+	ti81xx_writel(reg_base, USB_CTRL_REG, USB_SOFT_RESET_MASK);
+
+	/* Start the on-chip PHY and its PLL. */
+	if (data->set_phy_power)
+		data->set_phy_power(1);
+
+	musb->isr = ti81xx_interrupt;
+
+	/* reset the otgdisable bit, needed for host mode to work */
+	val = ti81xx_readl(reg_base, USB_PHY_UTMI_REG);
+	val &= ~USB_PHY_UTMI_OTG_DISABLE;
+	ti81xx_writel(musb->ctrl_base, USB_PHY_UTMI_REG, val);
+
+	/* clear level interrupt */
+	ti81xx_writel(reg_base, USB_IRQ_EOI, 0);
+
+	return 0;
+err0:
+	pm_runtime_disable(dev);
+	return status;
+}
+
+static int ti81xx_musb_exit(struct musb *musb)
+{
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
+
+	if (is_host_enabled(musb))
+		del_timer_sync(&otg_workaround);
+
+	/* Shutdown the on-chip PHY and its PLL. */
+	if (data->set_phy_power)
+		data->set_phy_power(0);
+
+	/* NOP driver needs change if supporting dual instance */
+	otg_put_transceiver(musb->xceiv);
+	usb_nop_xceiv_unregister();
+
+	return 0;
+}
+
+static struct musb_platform_ops ti81xx_ops = {
+	.init		= ti81xx_musb_init,
+	.exit		= ti81xx_musb_exit,
+
+	.enable		= ti81xx_musb_enable,
+	.disable	= ti81xx_musb_disable,
+
+	.try_idle	= ti81xx_musb_try_idle,
+};
+
+static u64 musb_dmamask = DMA_BIT_MASK(32);
+
+static int __devinit ti81xx_create_musb_pdev(struct ti81xx_glue *glue, u8 id)
+{
+	struct device *dev = glue->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct musb_hdrc_platform_data  *pdata = dev->platform_data;
+	struct platform_device	*musb;
+	struct resource *res;
+	struct resource	resources[2];
+	char res_name[10];
+	int ret;
+
+	/* get memory resource */
+	sprintf(res_name, "musb%d", id);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
+	if (!res) {
+		dev_err(dev, "%s get mem resource failed\n", res_name);
+		ret = -ENODEV;
+		goto err0;
+	}
+	resources[0] = *res;
+
+	/* get irq resource */
+	sprintf(res_name, "musb%d-irq", id);
+	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, res_name);
+	if (!res) {
+		dev_err(dev, "%s get irq resource failed\n", res_name);
+		ret = -ENODEV;
+		goto err0;
+	}
+	strcpy((u8 *)res->name, "mc");
+	resources[1] = *res;
+
+	/* allocate the child platform device */
+	musb = platform_device_alloc("musb-hdrc", -1);
+	if (!musb) {
+		dev_err(dev, "failed to allocate musb device\n");
+		goto err0;
+	}
+
+	musb->dev.parent		= dev;
+	musb->dev.dma_mask		= &musb_dmamask;
+	musb->dev.coherent_dma_mask	= musb_dmamask;
+
+	glue->musb[id]			= musb;
+
+	pdata->platform_ops		= &ti81xx_ops;
+
+	ret = platform_device_add_resources(musb, resources, 2);
+	if (ret) {
+		dev_err(dev, "failed to add resources\n");
+		goto err1;
+	}
+
+	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
+	if (ret) {
+		dev_err(dev, "failed to add platform_data\n");
+		goto err1;
+	}
+
+	ret = platform_device_add(musb);
+	if (ret) {
+		dev_err(dev, "failed to register musb device\n");
+		goto err1;
+	}
+
+	return 0;
+
+err1:
+	platform_device_put(musb);
+err0:
+	return ret;
+}
+
+static void __devexit ti81xx_delete_musb_pdev(struct ti81xx_glue *glue, u8 id)
+{
+	platform_device_del(glue->musb[id]);
+	platform_device_put(glue->musb[id]);
+}
+
+static int __init ti81xx_probe(struct platform_device *pdev)
+{
+	struct ti81xx_glue *glue;
+	struct resource *iomem;
+	int ret;
+
+	/* allocate glue */
+	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
+	if (!glue) {
+		dev_err(&pdev->dev, "unable to allocate glue memory\n");
+		ret = -ENOMEM;
+		goto err0;
+	}
+
+	/* get memory resource */
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iomem) {
+		dev_err(&pdev->dev, "failed to get usbss mem resourse\n");
+		ret = -ENODEV;
+		goto err1;
+	}
+
+	/* iomap for usbss mem space */
+	glue->usbss_base =
+		ioremap(iomem->start, resource_size(iomem));
+	if (!glue->usbss_base) {
+		dev_err(&pdev->dev, "usbss ioremap failed\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	glue->dev = &pdev->dev;
+	platform_set_drvdata(pdev, glue);
+
+	/* create the child platform device for first instances of musb */
+	ret = ti81xx_create_musb_pdev(glue, 0);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "failed to create child pdev\n");
+		goto err2;
+	}
+
+	/* enable the usbss clocks */
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+err2:
+	iounmap(glue->usbss_base);
+err1:
+	kfree(glue);
+err0:
+	return ret;
+}
+static int __exit ti81xx_remove(struct platform_device *pdev)
+{
+	struct ti81xx_glue *glue = platform_get_drvdata(pdev);
+
+	/* delete the child platform device for first instances of musb */
+	ti81xx_delete_musb_pdev(glue, 0);
+
+	/* iounmap */
+	iounmap(glue->usbss_base);
+
+	/* disable usbss clocks */
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	kfree(glue);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ti81xx_suspend(struct device *dev)
+{
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
+
+	/* Shutdown the on-chip PHY and its PLL. */
+	if (data->set_phy_power)
+		data->set_phy_power(0);
+
+	return 0;
+}
+
+static int ti81xx_resume(struct device *dev)
+{
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
+
+	/* Start the on-chip PHY and its PLL. */
+	if (data->set_phy_power)
+		data->set_phy_power(1);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(ti81xx_pm_ops, ti81xx_suspend, ti81xx_resume);
+
+static struct platform_driver ti81xx_usbss_driver = {
+	.remove         = __exit_p(ti81xx_remove),
+	.driver         = {
+		.name   = "ti81xx-usbss",
+		.pm	= &ti81xx_pm_ops,
+	},
+};
+
+MODULE_DESCRIPTION("TI81XX MUSB Glue Layer");
+MODULE_AUTHOR("Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>");
+MODULE_AUTHOR("Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
+
+static int __init ti81xx_init(void)
+{
+	return platform_driver_probe(&ti81xx_usbss_driver, ti81xx_probe);
+}
+subsys_initcall(ti81xx_init);
+
+static void __exit ti81xx_exit(void)
+{
+	platform_driver_unregister(&ti81xx_usbss_driver);
+}
+module_exit(ti81xx_exit);
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
