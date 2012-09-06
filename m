From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] ARM: OMAP2+: select PINCTRL in Kconfig
Date: Thu, 06 Sep 2012 11:58:27 -0700
Message-ID: <20120906185827.1172.44397.stgit@muffinssi.local>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51116 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759426Ab2IFS63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 14:58:29 -0400
In-Reply-To: <20120906185615.1172.23588.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

From: AnilKumar Ch <anilkumar@ti.com>

Select PINCTRL in Kconfig under Typical OMAP configuration, this
is required to add pinctrl driver to omap2+ family of devices.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
[tony@atomide.com: updated to select pinctrl-single in defconfig]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/Kconfig          |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index e58edc3..6230304 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -123,6 +123,7 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_SPI=y
 CONFIG_SPI_OMAP24XX=y
+CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_TWL4030=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4a4d058..e45bbff 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -18,6 +18,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
 	select HIGHMEM
+	select PINCTRL
 	help
 	  Compile a kernel suitable for booting most boards
 

