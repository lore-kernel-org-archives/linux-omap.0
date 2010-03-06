From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: Add omap-specific barrier implementation
Date: Sat,  6 Mar 2010 14:43:04 +0530
Message-ID: <1267866784-10465-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch defines ARCH_HAS_BARRIERS for the OMAP4 platform if
CACHE_L2X0 is enabled and adds the mach/barriers.h file. The mb() and
wmb() barriers perform an L2 cache sync in addition to the DSB.

The patch is based on top of Catalin's below series
	- [PATCH v3 0/4] ARM mandatory barriers
	- http://permalink.gmane.org/gmane.linux.ports.arm.kernel/75425

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/include/mach/barriers.h |   32 +++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig                  |    1 +
 2 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/barriers.h

diff --git a/arch/arm/mach-omap2/include/mach/barriers.h b/arch/arm/mach-omap2/include/mach/barriers.h
new file mode 100644
index 0000000..e29aebf
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/barriers.h
@@ -0,0 +1,32 @@
+/*
+ * omap barriers.h
+ *
+ * Copyright (C) 2010 Texas Instruments Ltd.
+ * Copyright (C) 2010 ARM Ltd.
+ * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * based on realview version of Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __MACH_BARRIERS_H
+#define __MACH_BARRIERS_H
+
+#include <asm/outercache.h>
+
+#define rmb()		dmb()
+#define wmb()		do { dsb(); outer_sync(); } while (0)
+#define mb()		wmb()
+
+#endif	/* __MACH_BARRIERS_H */
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6da796e..4812da4 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -38,6 +38,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select ARCH_HAS_BARRIERS if CACHE_L2X0
 
 endchoice
 
-- 
1.6.0.4
