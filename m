From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP2+: Fix unmet direct dependencies for
 SERIAL_OMAP
Date: Thu, 18 Apr 2013 10:54:29 -0700
Message-ID: <20130418175428.7436.87525.stgit@muffinssi.local>
References: <20130418175303.7436.75241.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56530 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab3DRRyc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 13:54:32 -0400
In-Reply-To: <20130418175303.7436.75241.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Commit 8a6201b9 (ARM: OMAP2+: Fix unmet direct dependencies for zoom
for 8250 serial) fixed unmet direct dependencies for 8250, but failed
to do the same for omap serial. This can cause the following warning:

warning: (ARCH_OMAP2PLUS_TYPICAL) selects SERIAL_OMAP which has
unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQS &&
ARCH_OMAP2PLUS).

We should not select drivers, they should be selected by the
user. Fix the issue by removing the select and adding them to
omap2plus_defconfig instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 arch/arm/mach-omap2/Kconfig          |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 33903ca..51a20a4 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -137,6 +137,8 @@ CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_OMAP=y
+CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_SPI=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a897b44..03b0b27 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -37,8 +37,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
 	select PM_RUNTIME
 	select REGULATOR
-	select SERIAL_OMAP
-	select SERIAL_OMAP_CONSOLE
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
 	select VFP

