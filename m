From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP2+: Fix random config build break with !ARM_CPU_SUSPEND
Date: Fri, 13 Jul 2012 16:15:07 +0530
Message-ID: <1342176307-6435-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51716 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030272Ab2GMKpX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 06:45:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>

The random config builds with PM and !ARM_CPU_SUSPEND breaks with below
error on omap2plus_defconfig.

arch/arm/mach-omap2/sleep44xx.S:323: undefined reference to `cpu_resume'
arch/arm/mach-omap2/omap-mpuss-lowpower.c:278: undefined reference to `cpu_suspend'

This is because recently merged OMAP5 platform shares the common files
with OMAP4 but doesn't select ARM_CPU_SUSPEND. Without the ARM_CPU_SUSPEND
the sleep code is meaningless.

Fix the same by adding ARM_CPU_SUSPEND for OMAP5. The suggestion came from
Russell King in an off-list discussion.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Applies against linux-omap master at commit cb07e339457.

 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2c73f38..976050d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -68,6 +68,7 @@ config SOC_OMAP5
 	select CPU_V7
 	select ARM_GIC
 	select HAVE_SMP
+	select ARM_CPU_SUSPEND if PM
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
-- 
1.7.9.5

