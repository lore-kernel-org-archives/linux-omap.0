From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] MUSB_HDRC: Allow selecting OTG,
	peripheral or host mode via sysfs
Date: Thu,  3 May 2007 16:41:52 +0000
Message-ID: <11782105222073-git-send-email-tony@atomide.com>
References: musb-2007-05-03-164131
	<11782105181141-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11782105181141-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This can be used on systems that don't use ID pin, or have mini-B
connector.

For example, to force N800 into host mode with non-standard mini-B
to mini-B cable connected to a powered hub:

Note that connected mini-A cable cannot be forced to peripheral
mode as the ID pin is grounded by the cable. Also note that
any VBUS load above the 100mA will cause the host mode to fail.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbdefs.h |    2 +
 drivers/usb/musb/plat_uds.c |   21 ++++++++++-
 drivers/usb/musb/tusb6010.c |   82 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musbdefs.h b/drivers/usb/musb/musbdefs.h
index f4be080..f641297 100644
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -506,9 +506,11 @@ extern void musb_platform_disable(struct musb *musb);
 #ifdef CONFIG_USB_TUSB6010
 extern void musb_platform_try_idle(struct musb *musb);
 extern int musb_platform_get_vbus_status(struct musb *musb);
+extern void musb_platform_set_mode(struct musb *musb, u8 musb_mode);
 #else
 #define musb_platform_try_idle(x)		do {} while (0)
 #define musb_platform_get_vbus_status(x)	0
+#define musb_platform_set_mode(x, y)		do {} while (0)
 #endif
 
 extern int __init musb_platform_init(struct musb *musb);
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index d208db8..14fbeba 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1511,7 +1511,26 @@ musb_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	return ret;
 }
-static DEVICE_ATTR(mode, S_IRUGO, musb_mode_show, NULL);
+
+static ssize_t
+musb_mode_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t n)
+{
+	struct musb	*musb = dev_to_musb(dev);
+	unsigned long	flags;
+
+	spin_lock_irqsave(&musb->Lock, flags);
+	if (!strncmp(buf, "host", 4))
+		musb_platform_set_mode(musb, MUSB_HOST);
+	if (!strncmp(buf, "peripheral", 10))
+		musb_platform_set_mode(musb, MUSB_PERIPHERAL);
+	if (!strncmp(buf, "otg", 3))
+		musb_platform_set_mode(musb, MUSB_OTG);
+	spin_unlock_irqrestore(&musb->Lock, flags);
+
+	return n;
+}
+static DEVICE_ATTR(mode, 0644, musb_mode_show, musb_mode_store);
 
 static ssize_t
 musb_cable_show(struct device *dev, struct device_attribute *attr, char *buf)
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index eeaeb16..9f01329 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -400,6 +400,88 @@ static void tusb_source_power(struct musb *musb, int is_on)
 		conf, prcm);
 }
 
+/*
+ * Sets the mode to OTG, peripheral or host by changing the ID detection.
+ * Caller must take care of locking.
+ *
+ * Note that if a mini-A cable is plugged in the ID line will stay down as
+ * the weak ID pull-up is not able to pull the ID up.
+ *
+ * REVISIT: It would be possible to add support for changing between host
+ * and peripheral modes in non-OTG configurations by reconfiguring hardware
+ * and then setting musb->board_mode. For now, only support OTG mode.
+ */
+void musb_platform_set_mode(struct musb *musb, u8 musb_mode)
+{
+	void __iomem	*base = musb->ctrl_base;
+	u32		otg_stat, phy_otg_ena, phy_otg_ctrl, dev_conf;
+	int		vbus = 0;
+
+	if (musb->board_mode != MUSB_OTG) {
+		ERR("Changing mode currently only supported in OTG mode\n");
+		return;
+	}
+
+	otg_stat = musb_readl(base, TUSB_DEV_OTG_STAT);
+	phy_otg_ena = musb_readl(base, TUSB_PHY_OTG_CTRL_ENABLE);
+	phy_otg_ctrl = musb_readl(base, TUSB_PHY_OTG_CTRL);
+	dev_conf = musb_readl(base, TUSB_DEV_CONF);
+
+	switch (musb_mode) {
+
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+	case MUSB_HOST:		/* Disable PHY ID detect, ground ID */
+		if (!(otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS)) {
+			ERR("Already in host mode otg_stat: %08x\n", otg_stat);
+			return;
+		}
+		phy_otg_ena |= TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
+		phy_otg_ctrl &= ~TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
+		dev_conf |= TUSB_DEV_CONF_ID_SEL;
+		dev_conf &= ~TUSB_DEV_CONF_SOFT_ID;
+		vbus = 1;
+		break;
+#endif
+
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
+	case MUSB_PERIPHERAL:	/* Disable PHY ID detect, keep ID pull-up on */
+		if (otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS) {
+			ERR("Already in peripheral mode otg_stat: %08x\n",
+				otg_stat);
+			return;
+		}
+		phy_otg_ena |= TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
+		phy_otg_ctrl |= TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
+		dev_conf |= (TUSB_DEV_CONF_ID_SEL | TUSB_DEV_CONF_SOFT_ID);
+		break;
+#endif
+
+#ifdef CONFIG_USB_MUSB_OTG
+	case MUSB_OTG:		/* Use PHY ID detection */
+		phy_otg_ena &= ~TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
+		phy_otg_ctrl &= ~TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
+		dev_conf &= ~(TUSB_DEV_CONF_ID_SEL | TUSB_DEV_CONF_SOFT_ID);
+		break;
+#endif
+
+	default:
+		DBG(2, "Trying to set unknown mode %i\n", musb_mode);
+	}
+
+	musb_writel(base, TUSB_PHY_OTG_CTRL_ENABLE,
+			TUSB_PHY_OTG_CTRL_WRPROTECT | phy_otg_ena);
+	musb_writel(base, TUSB_PHY_OTG_CTRL,
+			TUSB_PHY_OTG_CTRL_WRPROTECT | phy_otg_ctrl);
+	musb_writel(base, TUSB_DEV_CONF, dev_conf);
+
+	msleep(1);
+	otg_stat = musb_readl(base, TUSB_DEV_OTG_STAT);
+	if ((musb_mode == MUSB_PERIPHERAL) &&
+		!(otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS))
+			ERR("Cannot be peripheral with mini-A cable "
+			"otg_stat: %08x\n", otg_stat);
+}
+
 static inline void
 tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *base)
 {
-- 
1.4.4.2
