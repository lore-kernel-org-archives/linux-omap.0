From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 8/9] ARM: OMAP: Move plat/i2c.h into mach-omap1 folder
Date: Mon, 12 Feb 2018 19:32:42 -0600
Message-ID: <20180213013243.8378-9-s-anna@ti.com>
References: <20180213013243.8378-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180213013243.8378-1-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The current contents of plat/i2c.h are only relevant for OMAP1
platforms, as all the equivalent functions for OMAP2 has been
dropped in commit 65fa3e719f36 ("ARM: OMAP2+: Remove legacy i2c.c
platform init code"), and which has also moved the left-over code
from plat-omap into mach-omap1. The hwmod is a concept only
applicable for OMAP2 platforms, and the omap_i2c_reset() is
already declared in mach-omap2/i2c.h. So, move the current
plat/i2c.h header file into the mach-omap1 folder, and adjust
the header usage accordingly.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap1/common.h                          | 3 +--
 arch/arm/mach-omap1/i2c.c                             | 2 --
 arch/arm/{plat-omap/include/plat => mach-omap1}/i2c.h | 9 +++------
 arch/arm/mach-omap2/i2c.h                             | 4 ++--
 4 files changed, 6 insertions(+), 12 deletions(-)
 rename arch/arm/{plat-omap/include/plat => mach-omap1}/i2c.h (90%)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 65bb6e8085de..d83ff257eaa8 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -32,11 +32,10 @@
 
 #include <asm/exception.h>
 
-#include <plat/i2c.h>
-
 #include <mach/irqs.h>
 
 #include "soc.h"
+#include "i2c.h"
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 void omap7xx_map_io(void);
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 32f6c53367bf..5bdf3c4190f9 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -24,8 +24,6 @@
 #include <mach/mux.h>
 #include "soc.h"
 
-#include <plat/i2c.h>
-
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
 
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/mach-omap1/i2c.h
similarity index 90%
rename from arch/arm/plat-omap/include/plat/i2c.h
rename to arch/arm/mach-omap1/i2c.h
index 810629d79668..54a2bce7879e 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/mach-omap1/i2c.h
@@ -19,8 +19,8 @@
  *
  */
 
-#ifndef __PLAT_OMAP_I2C_H
-#define __PLAT_OMAP_I2C_H
+#ifndef __ARCH_ARM_MACH_OMAP1_I2C_H
+#define __ARCH_ARM_MACH_OMAP1_I2C_H
 
 struct i2c_board_info;
 struct omap_i2c_bus_platform_data;
@@ -47,7 +47,4 @@ static inline int omap_register_i2c_bus_cmdline(void)
 }
 #endif
 
-struct omap_hwmod;
-int omap_i2c_reset(struct omap_hwmod *oh);
-
-#endif /* __PLAT_OMAP_I2C_H */
+#endif /* __ARCH_ARM_MACH_OMAP1_I2C_H */
diff --git a/arch/arm/mach-omap2/i2c.h b/arch/arm/mach-omap2/i2c.h
index f76ff790b435..4d085c7ad425 100644
--- a/arch/arm/mach-omap2/i2c.h
+++ b/arch/arm/mach-omap2/i2c.h
@@ -19,11 +19,11 @@
  *
  */
 
-#include <plat/i2c.h>
-
 #ifndef __MACH_OMAP2_I2C_H
 #define __MACH_OMAP2_I2C_H
 
+struct omap_hwmod;
+
 int omap_i2c_reset(struct omap_hwmod *oh);
 
 #endif	/* __MACH_OMAP2_I2C_H */
-- 
2.15.1
