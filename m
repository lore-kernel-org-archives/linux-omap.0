From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: [PATCH] arm: fix compilation warning during compilation
Date: Sat, 06 Nov 2010 10:06:35 +0100
Message-ID: <4CD51A9B.7010806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Marco Stornelli <marco.stornelli@gmail.com>

During compilation of 2.6.36 for Beagle board, there a are a couple of warnings. This patch fix them.

Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
---

--- linux-2.6.36-orig/arch/arm/plat-omap/include/plat/usb.h	2010-10-20 22:30:22.000000000 +0200
+++ linux-2.6.36/arch/arm/plat-omap/include/plat/usb.h	2010-11-01 09:44:13.000000000 +0100
@@ -105,7 +105,7 @@ static inline void omap1_usb_init(struct
 #if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP_OTG_MODULE)
 void omap2_usbfs_init(struct omap_usb_config *pdata);
 #else
-static inline omap2_usbfs_init(struct omap_usb_config *pdata)
+static inline void omap2_usbfs_init(struct omap_usb_config *pdata)
 {
 }
 #endif
--- linux-2.6.36-orig/arch/arm/mach-omap2/mux.c	2010-10-20 22:30:22.000000000 +0200
+++ linux-2.6.36/arch/arm/mach-omap2/mux.c	2010-11-01 10:21:29.000000000 +0100
@@ -87,7 +87,7 @@ static char *omap_mux_options;
 int __init omap_mux_init_gpio(int gpio, int val)
 {
 	struct omap_mux_entry *e;
-	struct omap_mux *gpio_mux;
+	struct omap_mux *gpio_mux = NULL;
 	u16 old_mode;
 	u16 mux_mode;
 	int found = 0;
