From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 5/5] omap2plus: voltage: Trivial linking fix for 'EINVAL' undeclared
Date: Wed,  5 Jan 2011 16:27:04 +0530
Message-ID: <1294225024-21857-5-git-send-email-santosh.shilimkar@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40942 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926Ab1AEK5R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 05:57:17 -0500
In-Reply-To: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>

CC      arch/arm/mach-omap2/omap_hwmod_common_data.o
In file included from arch/arm/plat-omap/include/plat/omap_hwmod.h:38,
                 from arch/arm/mach-omap2/omap_hwmod_common_data.c:20:
arch/arm/plat-omap/include/plat/voltage.h: In function 'omap_voltage_late_init':
arch/arm/plat-omap/include/plat/voltage.h:145: error: 'EINVAL' undeclared (first use in this function)
arch/arm/plat-omap/include/plat/voltage.h:145: error: (Each undeclared identifier is reported only once
arch/arm/plat-omap/include/plat/voltage.h:145: error: for each function it appears in.)
make[1]: *** [arch/arm/mach-omap2/omap_hwmod_common_data.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

The error is reported when omap2plus_defconfig built with CONFIG_PM disabled

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/plat/voltage.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 4b02227..5bd204e 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -14,6 +14,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
 #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
 
+#include <linux/err.h>
+
 #define VOLTSCALE_VPFORCEUPDATE		1
 #define VOLTSCALE_VCBYPASS		2
 
-- 
1.6.0.4

