From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/8] ARM: OMAP2+: Add minimal support for booting vexpress
Date: Wed, 19 Dec 2012 11:26:35 -0800
Message-ID: <20121219192635.22098.74663.stgit@muffinssi.local>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:62535 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754307Ab2LST0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 14:26:36 -0500
In-Reply-To: <20121219192354.22098.33408.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

With multiplatform support enabled we are now always
building in vexpress. Let's enable few drivers also as
this allows us to boot omap2plus zImage in qemu for
testing multiplaform related changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index db05745..5be2e4b 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -23,6 +23,7 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX_DEBUG=y
+CONFIG_ARCH_VEXPRESS_CA9X4=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
 CONFIG_NO_HZ=y
@@ -121,6 +122,8 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_SPI=y
@@ -194,6 +197,7 @@ CONFIG_USB_ZERO=m
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_SDIO_UART=y
+CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_RTC_CLASS=y

