From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/7] ARM: davinci: make headers more local
Date: Tue,  1 Dec 2015 00:00:54 +0100
Message-ID: <1448924458-3279040-4-git-send-email-arnd@arndb.de>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Wan ZongShun <mcuos.com@gmail.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@uclinux.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some header files are never included outside of a mach-davinci
directory and do not need to be made visible in include/mach,
so let's just move them all down one level.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/board-da830-evm.c            | 2 +-
 arch/arm/mach-davinci/board-da850-evm.c            | 4 ++--
 arch/arm/mach-davinci/board-mityomapl138.c         | 2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        | 2 +-
 arch/arm/mach-davinci/clock.c                      | 2 +-
 arch/arm/mach-davinci/cp_intc.c                    | 2 +-
 arch/arm/mach-davinci/{include/mach => }/cp_intc.h | 0
 arch/arm/mach-davinci/cpuidle.c                    | 4 ++--
 arch/arm/mach-davinci/{include/mach => }/cpuidle.h | 0
 arch/arm/mach-davinci/da830.c                      | 2 +-
 arch/arm/mach-davinci/da850.c                      | 2 +-
 arch/arm/mach-davinci/da8xx-dt.c                   | 2 +-
 arch/arm/mach-davinci/{include/mach => }/ddr2.h    | 0
 arch/arm/mach-davinci/devices-da8xx.c              | 4 ++--
 arch/arm/mach-davinci/dm355.c                      | 2 +-
 arch/arm/mach-davinci/dm365.c                      | 2 +-
 arch/arm/mach-davinci/dm644x.c                     | 2 +-
 arch/arm/mach-davinci/dm646x.c                     | 2 +-
 arch/arm/mach-davinci/pm.c                         | 2 +-
 arch/arm/mach-davinci/psc.c                        | 2 +-
 arch/arm/mach-davinci/{include/mach => }/psc.h     | 0
 arch/arm/mach-davinci/sleep.S                      | 4 ++--
 arch/arm/mach-davinci/sram.c                       | 2 +-
 arch/arm/mach-davinci/{include/mach => }/sram.h    | 0
 24 files changed, 23 insertions(+), 23 deletions(-)
 rename arch/arm/mach-davinci/{include/mach => }/cp_intc.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/cpuidle.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/ddr2.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/psc.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/sram.h (100%)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index f8f62fbaa915..3d8cf8cbd98a 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -32,7 +32,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/cp_intc.h>
+#include "cp_intc.h"
 #include <mach/mux.h>
 #include <mach/da8xx.h>
 
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 9cc7b818fbf6..8e4539f69fdc 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -40,10 +40,10 @@
 #include <linux/spi/flash.h>
 
 #include <mach/common.h>
-#include <mach/cp_intc.h>
+#include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <mach/mux.h>
-#include <mach/sram.h>
+#include "sram.h"
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 8cfbfe084535..de1316bf643a 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -26,7 +26,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/common.h>
-#include <mach/cp_intc.h>
+#include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 2aac51d0e853..ee624861ca66 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -19,7 +19,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/cp_intc.h>
+#include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <mach/mux.h>
 
diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 47281f5c12ea..a23e21aa0d8b 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -23,7 +23,7 @@
 #include <mach/hardware.h>
 
 #include <mach/clock.h>
-#include <mach/psc.h>
+#include "psc.h"
 #include <mach/cputype.h>
 #include "clock.h"
 
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 507aad4b8dd9..1a68d2477de6 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -19,7 +19,7 @@
 #include <linux/of_irq.h>
 
 #include <mach/common.h>
-#include <mach/cp_intc.h>
+#include "cp_intc.h"
 
 static inline unsigned int cp_intc_read(unsigned offset)
 {
diff --git a/arch/arm/mach-davinci/include/mach/cp_intc.h b/arch/arm/mach-davinci/cp_intc.h
similarity index 100%
rename from arch/arm/mach-davinci/include/mach/cp_intc.h
rename to arch/arm/mach-davinci/cp_intc.h
diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 306ebc51599a..1b8f08532455 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -19,8 +19,8 @@
 #include <linux/export.h>
 #include <asm/cpuidle.h>
 
-#include <mach/cpuidle.h>
-#include <mach/ddr2.h>
+#include "cpuidle.h"
+#include "ddr2.h"
 
 #define DAVINCI_CPUIDLE_MAX_STATES	2
 
diff --git a/arch/arm/mach-davinci/include/mach/cpuidle.h b/arch/arm/mach-davinci/cpuidle.h
similarity index 100%
rename from arch/arm/mach-davinci/include/mach/cpuidle.h
rename to arch/arm/mach-davinci/cpuidle.h
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 115d5736da80..7187e7fc2822 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -15,7 +15,7 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/psc.h>
+#include "psc.h"
 #include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <mach/common.h>
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 676997895e13..97d8779a9a65 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -22,7 +22,7 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/psc.h>
+#include "psc.h"
 #include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <mach/common.h>
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 06b6451225c1..c4b5808ca7c1 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -15,7 +15,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/cp_intc.h>
+#include "cp_intc.h"
 #include <mach/da8xx.h>
 
 #define DA8XX_NUM_UARTS	3
diff --git a/arch/arm/mach-davinci/include/mach/ddr2.h b/arch/arm/mach-davinci/ddr2.h
similarity index 100%
rename from arch/arm/mach-davinci/include/mach/ddr2.h
rename to arch/arm/mach-davinci/ddr2.h
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 28c90bc372bd..e88b7a5cde99 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -22,8 +22,8 @@
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
-#include <mach/cpuidle.h>
-#include <mach/sram.h>
+#include "cpuidle.h"
+#include "sram.h"
 
 #include "clock.h"
 #include "asp.h"
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 609950b8c191..c7c1458df23c 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -21,7 +21,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/cputype.h>
-#include <mach/psc.h>
+#include "psc.h"
 #include <mach/mux.h>
 #include <mach/irqs.h>
 #include <mach/time.h>
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2068cbeaeb03..01843fbcc9ea 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -26,7 +26,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/cputype.h>
-#include <mach/psc.h>
+#include "psc.h"
 #include <mach/mux.h>
 #include <mach/irqs.h>
 #include <mach/time.h>
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index d38f5049d56e..b28071ae3a57 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -19,7 +19,7 @@
 
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include <mach/psc.h>
+#include "psc.h"
 #include <mach/mux.h>
 #include <mach/time.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 70eb42725eec..cf80786e2471 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -20,7 +20,7 @@
 
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include <mach/psc.h>
+#include "psc.h"
 #include <mach/mux.h>
 #include <mach/time.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 07e23ba61f3a..8929569b1f8a 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -21,7 +21,7 @@
 
 #include <mach/common.h>
 #include <mach/da8xx.h>
-#include <mach/sram.h>
+#include "sram.h"
 #include <mach/pm.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index 82fdc69d5728..e5dc6bfde5f3 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 
 #include <mach/cputype.h>
-#include <mach/psc.h>
+#include "psc.h"
 
 #include "clock.h"
 
diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/psc.h
similarity index 100%
rename from arch/arm/mach-davinci/include/mach/psc.h
rename to arch/arm/mach-davinci/psc.h
diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index a5336a5e2739..cd350dee4df3 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -21,8 +21,8 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <mach/psc.h>
-#include <mach/ddr2.h>
+#include "psc.h"
+#include "ddr2.h"
 
 #include "clock.h"
 
diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
index 8540dddf1fbd..668b6e749768 100644
--- a/arch/arm/mach-davinci/sram.c
+++ b/arch/arm/mach-davinci/sram.c
@@ -14,7 +14,7 @@
 #include <linux/genalloc.h>
 
 #include <mach/common.h>
-#include <mach/sram.h>
+#include "sram.h"
 
 static struct gen_pool *sram_pool;
 
diff --git a/arch/arm/mach-davinci/include/mach/sram.h b/arch/arm/mach-davinci/sram.h
similarity index 100%
rename from arch/arm/mach-davinci/include/mach/sram.h
rename to arch/arm/mach-davinci/sram.h
-- 
2.1.0.rc2
