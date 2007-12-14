From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH Resend 3/3] ARM: OMAP: Add MUSB support for OMAP34xx
Date: Fri, 14 Dec 2007 19:33:43 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A088050666B9@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

MUSB support for OMAP34XX
This depends on the previous two patches:
[PATCH 1/3] Add support for USB on OMAP34XX
[PATCH 2/3] Add support for TWL4030 USB Transceiver on OMAP34xx

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Nishant Kamat <nskamat@ti.com>
---
 drivers/usb/musb/Kconfig     |    1=20
 drivers/usb/musb/Makefile    |    4 +
 drivers/usb/musb/musb_core.c |    3 -
 drivers/usb/musb/musb_core.h |    9 ++-
 drivers/usb/musb/omap2430.c  |  119 =
++++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/musb/omap2430.h  |   11 +++
 6 files changed, 141 insertions(+), 6 deletions(-)

Index: linux-omap-dec10/drivers/usb/musb/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-dec10.orig/drivers/usb/musb/Makefile	2007-12-14 =
19:06:40.152971986 +0530
+++ linux-omap-dec10/drivers/usb/musb/Makefile	2007-12-14 =
19:22:16.508200754 +0530
@@ -18,6 +18,10 @@
 	musb_hdrc-objs	+=3D omap2430.o
 endif
=20
+ifeq ($(CONFIG_ARCH_OMAP3430),y)
+	musb_hdrc-objs	+=3D omap2430.o
+endif
+
 ifeq ($(CONFIG_USB_GADGET_MUSB_HDRC),y)
 	musb_hdrc-objs		+=3D musb_gadget_ep0.o musb_gadget.o
 endif
Index: linux-omap-dec10/drivers/usb/musb/omap2430.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-dec10.orig/drivers/usb/musb/omap2430.c	2007-12-14 =
19:06:40.152971986 +0530
+++ linux-omap-dec10/drivers/usb/musb/omap2430.c	2007-12-14 =
19:22:41.236415643 +0530
@@ -1,5 +1,10 @@
 /*
- * Copyright (C) 2005-2006 by Texas Instruments
+ * Copyright (C) 2005-2007 by Texas Instruments
+ * Some code has been taken from tusb6010.c
+ * Copyrights for that are attributable to:
+ * Copyright (C) 2006 Nokia Corporation
+ * Jarkko Nikula <jarkko.nikula@nokia.com>
+ * Tony Lindgren <tony@atomide.com>
  *
  * This file is part of the Inventra Controller Driver for Linux.
  *
@@ -40,6 +45,101 @@
 #define	get_cpu_rev()	2
 #endif
=20
+#define MUSB_TIMEOUT_A_WAIT_BCON	1100
+
+static struct timer_list musb_idle_timer;
+
+static void musb_do_idle(unsigned long _musb)
+{
+	struct musb	*musb =3D (void *)_musb;
+	unsigned long	flags;
+	u8	power;
+	u8	devctl;
+
+	devctl =3D musb_readb(musb->mregs, MUSB_DEVCTL);
+
+	spin_lock_irqsave(&musb->lock, flags);
+
+	switch (musb->xceiv.state) {
+	case OTG_STATE_A_WAIT_BCON:
+		devctl &=3D ~MUSB_DEVCTL_SESSION;
+		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+
+		devctl =3D musb_readb(musb->mregs, MUSB_DEVCTL);
+		if (devctl & MUSB_DEVCTL_BDEVICE) {
+			musb->xceiv.state =3D OTG_STATE_B_IDLE;
+			MUSB_DEV_MODE(musb);
+		} else {
+			musb->xceiv.state =3D OTG_STATE_A_IDLE;
+			MUSB_HST_MODE(musb);
+		}
+		break;
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+	case OTG_STATE_A_SUSPEND:
+		/* finish RESUME signaling? */
+		if (musb->port1_status & MUSB_PORT_STAT_RESUME) {
+			power =3D musb_readb(musb->mregs, MUSB_POWER);
+			power &=3D ~MUSB_POWER_RESUME;
+			DBG(1, "root port resume stopped, power %02x\n",
+									power);
+			musb_writeb(musb->mregs, MUSB_POWER, power);
+			musb->is_active =3D 1;
+			musb->port1_status &=3D ~(USB_PORT_STAT_SUSPEND
+						| MUSB_PORT_STAT_RESUME);
+			musb->port1_status |=3D USB_PORT_STAT_C_SUSPEND << 16;
+			usb_hcd_poll_rh_status(musb_to_hcd(musb));
+			/* NOTE: it might really be A_WAIT_BCON ... */
+			musb->xceiv.state =3D OTG_STATE_A_HOST;
+		}
+		break;
+#endif
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+	case OTG_STATE_A_HOST:
+		devctl =3D musb_readb(musb->mregs, MUSB_DEVCTL);
+		if (devctl &  MUSB_DEVCTL_BDEVICE)
+			musb->xceiv.state =3D OTG_STATE_B_IDLE;
+		else
+			musb->xceiv.state =3D OTG_STATE_A_WAIT_BCON;
+#endif
+	default:
+		break;
+	}
+	spin_unlock_irqrestore(&musb->lock, flags);
+}
+
+
+void musb_platform_try_idle(struct musb *musb, unsigned long timeout)
+{
+	unsigned long		default_timeout =3D jiffies + msecs_to_jiffies(3);
+	static unsigned long	last_timer;
+
+	if (timeout =3D=3D 0)
+		timeout =3D default_timeout;
+
+	/* Never idle if active, or when VBUS timeout is not set as host */
+	if (musb->is_active || ((musb->a_wait_bcon =3D=3D 0)
+			&& (musb->xceiv.state =3D=3D OTG_STATE_A_WAIT_BCON))) {
+		DBG(4, "%s active, deleting timer\n", otg_state_string(musb));
+		del_timer(&musb_idle_timer);
+		last_timer =3D jiffies;
+		return;
+	}
+
+	if (time_after(last_timer, timeout)) {
+		if (!timer_pending(&musb_idle_timer))
+			last_timer =3D timeout;
+		else {
+			DBG(4, "Longer idle timer already pending, ignoring\n");
+			return;
+		}
+	}
+	last_timer =3D timeout;
+
+	DBG(4, "%s inactive, for idle timer for %lu ms\n",
+		otg_state_string(musb),
+		(unsigned long)jiffies_to_msecs(timeout - jiffies));
+	mod_timer(&musb_idle_timer, timeout);
+}
=20
 void musb_platform_enable(struct musb *musb)
 {
@@ -93,6 +193,15 @@
 	return 0;
 }
=20
+static int omap_set_suspend(struct otg_transceiver *x, int suspend)
+{
+	if (suspend)
+		twl4030_phy_suspend(1);
+	else
+		twl4030_phy_resume();
+	return 0;
+}
+
 int musb_platform_resume(struct musb *musb);
=20
 int __init musb_platform_init(struct musb *musb)
@@ -102,11 +211,12 @@
 	/* get the clock */
 	musb->clock =3D clk_get((struct device *)musb->controller, =
"usbhs_ick");
 #else
-	musb->clock =3D clk_get((struct device *)musb->controller, =
"hsusb_ick");
+	musb->clock =3D clk_get((struct device *)musb->controller, =
"hsotgusb_ick");
 #endif
 	if(IS_ERR(musb->clock))
 		return PTR_ERR(musb->clock);
=20
+	musb->xceiv.set_suspend =3D omap_set_suspend;
 	musb_platform_resume(musb);
=20
 	OTG_INTERFSEL_REG |=3D ULPI_12PIN;
@@ -123,6 +233,9 @@
 		musb->board_set_vbus =3D omap_set_vbus;
 	if (is_peripheral_enabled(musb))
 		musb->xceiv.set_power =3D omap_set_power;
+	musb->a_wait_bcon =3D MUSB_TIMEOUT_A_WAIT_BCON;
+
+	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
=20
 	return 0;
 }
@@ -137,6 +250,7 @@
 	OTG_FORCESTDBY_REG |=3D ENABLEFORCE; /* enable MSTANDBY */
 	OTG_SYSCONFIG_REG |=3D AUTOIDLE;		/* enable auto idle */
=20
+	musb->xceiv.set_suspend(&musb->xceiv, 1);
 	clk_disable(musb->clock);
 	return 0;
 }
@@ -144,6 +258,7 @@
 int musb_platform_resume(struct musb *musb)
 {
 	clk_enable(musb->clock);
+	musb->xceiv.set_suspend(&musb->xceiv, 0);
=20
 	OTG_FORCESTDBY_REG &=3D ~ENABLEFORCE; /* disable MSTANDBY */
 	OTG_SYSCONFIG_REG |=3D SMARTSTDBY;	/* enable smart standby */
Index: linux-omap-dec10/drivers/usb/musb/musb_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-dec10.orig/drivers/usb/musb/musb_core.c	2007-12-14 =
19:06:40.152971986 +0530
+++ linux-omap-dec10/drivers/usb/musb/musb_core.c	2007-12-14 =
19:22:16.509200723 +0530
@@ -991,7 +991,8 @@
 #define	can_dynfifo()	0
 #endif
=20
-#ifdef CONFIG_USB_TUSB6010
+#if defined(CONFIG_USB_TUSB6010) || \
+	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
 static ushort __initdata fifo_mode =3D 4;
 #else
 static ushort __initdata fifo_mode =3D 2;
Index: linux-omap-dec10/drivers/usb/musb/musb_core.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-dec10.orig/drivers/usb/musb/musb_core.h	2007-12-14 =
19:06:40.152971986 +0530
+++ linux-omap-dec10/drivers/usb/musb/musb_core.h	2007-12-14 =
19:22:16.510200691 +0530
@@ -476,12 +476,17 @@
=20
 extern void musb_hnp_stop(struct musb *musb);
=20
-#ifdef CONFIG_USB_TUSB6010
+#if defined(CONFIG_USB_TUSB6010) || \
+	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
 extern void musb_platform_try_idle(struct musb *musb, unsigned long =
timeout);
+#else
+#define musb_platform_try_idle(x, y)		do {} while (0)
+#endif
+
+#ifdef CONFIG_USB_TUSB6010
 extern int musb_platform_get_vbus_status(struct musb *musb);
 extern void musb_platform_set_mode(struct musb *musb, u8 musb_mode);
 #else
-#define musb_platform_try_idle(x, y)		do {} while (0)
 #define musb_platform_get_vbus_status(x)	0
 #define musb_platform_set_mode(x, y)		do {} while (0)
 #endif
Index: linux-omap-dec10/drivers/usb/musb/omap2430.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-dec10.orig/drivers/usb/musb/omap2430.h	2007-12-14 =
19:06:40.152971986 +0530
+++ linux-omap-dec10/drivers/usb/musb/omap2430.h	2007-12-14 =
19:22:16.510200691 +0530
@@ -13,6 +13,15 @@
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
 #include <asm/arch/hardware.h>
 #include <asm/arch/usb.h>
+
+#if defined(CONFIG_TWL4030_USB_HS_ULPI)
+extern void twl4030_phy_suspend(int controller_off);
+extern void twl4030_phy_resume(void);
+#else
+#define twl4030_phy_suspend(x)  /* not defined */
+#define twl4030_phy_resume()    /* not defined */
+#endif
+
 /*
  * OMAP2430-specific definitions
  */
@@ -21,7 +30,7 @@
 #if	defined(CONFIG_ARCH_OMAP2430)
 #define	OMAP_HSOTG_BASE		(OMAP243X_HS_BASE)
 #elif	defined(CONFIG_ARCH_OMAP3430)
-#define	OMAP_HSOTG_BASE		(HS_BASE)
+#define	OMAP_HSOTG_BASE		(OMAP34XX_HSUSB_OTG_BASE)
 #endif
 #define OMAP_HSOTG(offset)	__REG32(OMAP_HSOTG_BASE + 0x400 + (offset))
 #define OTG_REVISION_REG	OMAP_HSOTG(0x0)
Index: linux-omap-dec10/drivers/usb/musb/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-dec10.orig/drivers/usb/musb/Kconfig	2007-12-14 =
19:06:40.152971986 +0530
+++ linux-omap-dec10/drivers/usb/musb/Kconfig	2007-12-14 =
19:22:16.510200691 +0530
@@ -9,6 +9,7 @@
 # (M)HDRC =3D (Multipoint) Highspeed Dual-Role Controller
 config USB_MUSB_HDRC
 	depends on USB || USB_GADGET
+	select TWL4030_USB if MACH_OMAP_3430SDP
 	tristate 'Inventra Highspeed Dual Role Controller (TI, ...)'
 	help
 	  Say Y here if your system has a dual role high speed USB
