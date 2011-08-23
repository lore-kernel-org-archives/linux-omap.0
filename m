From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 3.1-rc3] gpio/omap: fix build error with certain OMAP1 configs
Date: Tue, 23 Aug 2011 13:42:24 +0200
Message-ID: <201108231342.25101.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>
List-Id: linux-omap@vger.kernel.org

With commit f64ad1a0e21a, "gpio/omap: cleanup _set_gpio_wakeup(), remove 
ifdefs", access to build time conditionally omitted 'suspend_wakeup' 
member of the 'gpio_bank' structure has been placed unconditionally in 
function _set_gpio_wakeup(), which is always built. This resulted in the 
driver compilation broken for certain OMAP1, i.e., non-OMAP16xx, 
configurations.

Really required or not in previously excluded cases, define this 
structure member unconditionally as a fix.

Tested with a custom OMAP1510 only configuration.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 drivers/gpio/gpio-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- git/drivers/gpio/gpio-omap.c.orig	2011-08-22 08:34:02.000000000 +0200
+++ git/drivers/gpio/gpio-omap.c	2011-08-23 12:47:36.000000000 +0200
@@ -34,8 +34,8 @@ struct gpio_bank {
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 	u32 suspend_wakeup;
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 	u32 saved_wakeup;
 #endif
 	u32 non_wakeup_gpios;
