From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 3/5] gpio: omap: add a GPIO_OMAP option instead of using ARCH_OMAP
Date: Sun,  6 Apr 2014 16:58:15 +0200
Message-ID: <1396796297-13002-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40483 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbaDFO65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2014 10:58:57 -0400
In-Reply-To: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The ARCH_OMAP config option was used to built the GPIO OMAP
driver but this is not consistent with the rest of the GPIO
drivers that have their own Kconfig option.

Also, this make it harder to add dependencies or reverse
dependencies (i.e: select) since that would mean touching the
sub-arch config option.

So is better to add a boolean Kconfig option for this driver
that defaults to true if ARCH_OMAP is enabled.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpio/Kconfig  | 7 +++++++
 drivers/gpio/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 92d8e9a..bfe5cf0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -243,6 +243,13 @@ config GPIO_OCTEON
 	  Say yes here to support the on-chip GPIO lines on the OCTEON
 	  family of SOCs.
 
+config GPIO_OMAP
+	bool "TI OMAP GPIO support"
+	default y if ARCH_OMAP
+	depends on ARM && ARCH_OMAP
+	help
+	  Say yes here to enable GPIO support for TI OMAP SoCs.
+
 config GPIO_PL061
 	bool "PrimeCell PL061 GPIO support"
 	depends on ARM_AMBA
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 6309aff..d10f6a9 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -58,7 +58,7 @@ obj-$(CONFIG_GPIO_MVEBU)        += gpio-mvebu.o
 obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
 obj-$(CONFIG_GPIO_MXS)		+= gpio-mxs.o
 obj-$(CONFIG_GPIO_OCTEON)	+= gpio-octeon.o
-obj-$(CONFIG_ARCH_OMAP)		+= gpio-omap.o
+obj-$(CONFIG_GPIO_OMAP)		+= gpio-omap.o
 obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
 obj-$(CONFIG_GPIO_PCH)		+= gpio-pch.o
-- 
1.9.0

