From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
Date: Tue, 04 Jan 2011 20:22:17 +0000
Message-ID: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110104202052.GE24935@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Viresh Kumar <viresh.kumar@st.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Kevin Hilman <khilman@deeprootsystems.com>, Anton Vorontsov <avorontsov@mvista.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, Erik Gilling <konkers@android.com>, linux-sh@vger.kernel.org, Vincent Sanders <support@simtec.co.uk>, "Hans J. Koch" <hjk@linutronix.de>, Magnus Damm <magnus.damm@gmail.com>, Marc Singer <elf@buici.com>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Jiandong Zheng <jdzheng@broadcom.com>, Wan ZongShun <mcuos.com@gmail.com>, linux-arm-msm@vger.kernel.org, Olof Johansson <olof@lixom.net>, Ryan Mallon <ryan@bluewatersys.com>, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel
List-Id: linux-omap@vger.kernel.org

This uncouple PHYS_OFFSET from the platform definitions, thereby
facilitating run-time computation of the physical memory offset.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/memory.h                  |    2 ++
 arch/arm/kernel/tcm.c                          |    2 +-
 arch/arm/mach-aaec2000/include/mach/memory.h   |    2 +-
 arch/arm/mach-at91/include/mach/memory.h       |    2 +-
 arch/arm/mach-bcmring/include/mach/hardware.h  |    2 +-
 arch/arm/mach-bcmring/include/mach/memory.h    |    2 +-
 arch/arm/mach-clps711x/include/mach/memory.h   |    2 +-
 arch/arm/mach-cns3xxx/include/mach/memory.h    |    2 +-
 arch/arm/mach-davinci/include/mach/memory.h    |    4 ++--
 arch/arm/mach-dove/include/mach/memory.h       |    2 +-
 arch/arm/mach-ebsa110/include/mach/memory.h    |    2 +-
 arch/arm/mach-ep93xx/include/mach/memory.h     |   10 +++++-----
 arch/arm/mach-footbridge/include/mach/memory.h |    2 +-
 arch/arm/mach-h720x/include/mach/memory.h      |    2 +-
 arch/arm/mach-integrator/include/mach/memory.h |    2 +-
 arch/arm/mach-iop13xx/include/mach/memory.h    |    2 +-
 arch/arm/mach-iop32x/include/mach/memory.h     |    2 +-
 arch/arm/mach-iop33x/include/mach/memory.h     |    2 +-
 arch/arm/mach-ixp2000/include/mach/memory.h    |    2 +-
 arch/arm/mach-ixp23xx/include/mach/memory.h    |    2 +-
 arch/arm/mach-ixp4xx/include/mach/memory.h     |    2 +-
 arch/arm/mach-kirkwood/include/mach/memory.h   |    2 +-
 arch/arm/mach-ks8695/include/mach/memory.h     |    2 +-
 arch/arm/mach-lh7a40x/include/mach/memory.h    |    2 +-
 arch/arm/mach-loki/include/mach/memory.h       |    2 +-
 arch/arm/mach-lpc32xx/include/mach/memory.h    |    2 +-
 arch/arm/mach-mmp/include/mach/memory.h        |    2 +-
 arch/arm/mach-msm/board-msm7x30.c              |    2 +-
 arch/arm/mach-msm/include/mach/memory.h        |   10 +++++-----
 arch/arm/mach-mv78xx0/include/mach/memory.h    |    2 +-
 arch/arm/mach-mx3/mach-kzm_arm11_01.c          |    2 +-
 arch/arm/mach-netx/include/mach/memory.h       |    2 +-
 arch/arm/mach-nomadik/include/mach/memory.h    |    2 +-
 arch/arm/mach-ns9xxx/include/mach/memory.h     |    2 +-
 arch/arm/mach-nuc93x/include/mach/memory.h     |    2 +-
 arch/arm/mach-orion5x/include/mach/memory.h    |    2 +-
 arch/arm/mach-pnx4008/include/mach/memory.h    |    2 +-
 arch/arm/mach-pxa/include/mach/memory.h        |    2 +-
 arch/arm/mach-realview/include/mach/memory.h   |    4 ++--
 arch/arm/mach-rpc/include/mach/memory.h        |    2 +-
 arch/arm/mach-s3c2400/include/mach/memory.h    |    2 +-
 arch/arm/mach-s3c2410/include/mach/memory.h    |    2 +-
 arch/arm/mach-s3c24a0/include/mach/memory.h    |    2 +-
 arch/arm/mach-s3c64xx/include/mach/memory.h    |    2 +-
 arch/arm/mach-s5p6442/include/mach/memory.h    |    2 +-
 arch/arm/mach-s5p64x0/include/mach/memory.h    |    2 +-
 arch/arm/mach-s5pc100/include/mach/memory.h    |    2 +-
 arch/arm/mach-s5pv210/include/mach/memory.h    |    2 +-
 arch/arm/mach-s5pv310/include/mach/memory.h    |    2 +-
 arch/arm/mach-sa1100/include/mach/memory.h     |    2 +-
 arch/arm/mach-shark/include/mach/memory.h      |    2 +-
 arch/arm/mach-shmobile/include/mach/memory.h   |    2 +-
 arch/arm/mach-tegra/include/mach/memory.h      |    2 +-
 arch/arm/mach-u300/include/mach/memory.h       |    6 +++---
 arch/arm/mach-u300/u300.c                      |    2 +-
 arch/arm/mach-ux500/include/mach/memory.h      |    2 +-
 arch/arm/mach-versatile/include/mach/memory.h  |    2 +-
 arch/arm/mach-vexpress/include/mach/memory.h   |    2 +-
 arch/arm/mach-w90x900/include/mach/memory.h    |    2 +-
 arch/arm/plat-omap/include/plat/memory.h       |    4 ++--
 arch/arm/plat-spear/include/plat/memory.h      |    2 +-
 arch/arm/plat-stmp3xxx/include/mach/memory.h   |    2 +-
 arch/arm/plat-tcc/include/mach/memory.h        |    2 +-
 63 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 23c2e8e..00b04ae 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -24,6 +24,8 @@
  */
 #define UL(x) _AC(x, UL)
 
+#define PHYS_OFFSET	PLAT_PHYS_OFFSET
+
 #ifdef CONFIG_MMU
 
 /*
diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index 26685c2..f5cf660 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -15,7 +15,7 @@
 #include <linux/string.h> /* memcpy */
 #include <asm/cputype.h>
 #include <asm/mach/map.h>
-#include <mach/memory.h>
+#include <asm/memory.h>
 #include "tcm.h"
 
 static struct gen_pool *tcm_pool;
diff --git a/arch/arm/mach-aaec2000/include/mach/memory.h b/arch/arm/mach-aaec2000/include/mach/memory.h
index 4f93c56..4a10bf0 100644
--- a/arch/arm/mach-aaec2000/include/mach/memory.h
+++ b/arch/arm/mach-aaec2000/include/mach/memory.h
@@ -12,6 +12,6 @@
 #define __ASM_ARCH_MEMORY_H
 
 
-#define PHYS_OFFSET	UL(0xf0000000)
+#define PLAT_PHYS_OFFSET	UL(0xf0000000)
 
 #endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-at91/include/mach/memory.h b/arch/arm/mach-at91/include/mach/memory.h
index 14f4ef4..c2cfe50 100644
--- a/arch/arm/mach-at91/include/mach/memory.h
+++ b/arch/arm/mach-at91/include/mach/memory.h
@@ -23,6 +23,6 @@
 
 #include <mach/hardware.h>
 
-#define PHYS_OFFSET	(AT91_SDRAM_BASE)
+#define PLAT_PHYS_OFFSET	(AT91_SDRAM_BASE)
 
 #endif
diff --git a/arch/arm/mach-bcmring/include/mach/hardware.h b/arch/arm/mach-bcmring/include/mach/hardware.h
index 447eb34..8bf3564 100644
--- a/arch/arm/mach-bcmring/include/mach/hardware.h
+++ b/arch/arm/mach-bcmring/include/mach/hardware.h
@@ -31,7 +31,7 @@
  *  *_SIZE  is the size of the region
  *  *_BASE  is the virtual address
  */
-#define RAM_START               PHYS_OFFSET
+#define RAM_START               PLAT_PHYS_OFFSET
 
 #define RAM_SIZE                (CFG_GLOBAL_RAM_SIZE-CFG_GLOBAL_RAM_SIZE_RESERVED)
 #define RAM_BASE                PAGE_OFFSET
diff --git a/arch/arm/mach-bcmring/include/mach/memory.h b/arch/arm/mach-bcmring/include/mach/memory.h
index 114f942..15162e4 100644
--- a/arch/arm/mach-bcmring/include/mach/memory.h
+++ b/arch/arm/mach-bcmring/include/mach/memory.h
@@ -23,7 +23,7 @@
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
  */
 
-#define PHYS_OFFSET CFG_GLOBAL_RAM_BASE
+#define PLAT_PHYS_OFFSET CFG_GLOBAL_RAM_BASE
 
 /*
  * Maximum DMA memory allowed is 14M
diff --git a/arch/arm/mach-clps711x/include/mach/memory.h b/arch/arm/mach-clps711x/include/mach/memory.h
index f45c8e8..3a032a6 100644
--- a/arch/arm/mach-clps711x/include/mach/memory.h
+++ b/arch/arm/mach-clps711x/include/mach/memory.h
@@ -23,7 +23,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0xc0000000)
+#define PLAT_PHYS_OFFSET	UL(0xc0000000)
 
 #if !defined(CONFIG_ARCH_CDB89712) && !defined (CONFIG_ARCH_AUTCPU12)
 
diff --git a/arch/arm/mach-cns3xxx/include/mach/memory.h b/arch/arm/mach-cns3xxx/include/mach/memory.h
index 3b6b769..dc16c5c 100644
--- a/arch/arm/mach-cns3xxx/include/mach/memory.h
+++ b/arch/arm/mach-cns3xxx/include/mach/memory.h
@@ -13,7 +13,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET		UL(0x00000000)
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
 
 #define __phys_to_bus(x)	((x) + PHYS_OFFSET)
 #define __bus_to_phys(x)	((x) - PHYS_OFFSET)
diff --git a/arch/arm/mach-davinci/include/mach/memory.h b/arch/arm/mach-davinci/include/mach/memory.h
index 22eb97c..7882272 100644
--- a/arch/arm/mach-davinci/include/mach/memory.h
+++ b/arch/arm/mach-davinci/include/mach/memory.h
@@ -26,9 +26,9 @@
 #if defined(CONFIG_ARCH_DAVINCI_DA8XX) && defined(CONFIG_ARCH_DAVINCI_DMx)
 #error Cannot enable DaVinci and DA8XX platforms concurrently
 #elif defined(CONFIG_ARCH_DAVINCI_DA8XX)
-#define PHYS_OFFSET DA8XX_DDR_BASE
+#define PLAT_PHYS_OFFSET DA8XX_DDR_BASE
 #else
-#define PHYS_OFFSET DAVINCI_DDR_BASE
+#define PLAT_PHYS_OFFSET DAVINCI_DDR_BASE
 #endif
 
 #define DDR2_SDRCR_OFFSET	0xc
diff --git a/arch/arm/mach-dove/include/mach/memory.h b/arch/arm/mach-dove/include/mach/memory.h
index d668720..bbc93fe 100644
--- a/arch/arm/mach-dove/include/mach/memory.h
+++ b/arch/arm/mach-dove/include/mach/memory.h
@@ -5,6 +5,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET		UL(0x00000000)
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-ebsa110/include/mach/memory.h b/arch/arm/mach-ebsa110/include/mach/memory.h
index 0ca66d0..8e49066 100644
--- a/arch/arm/mach-ebsa110/include/mach/memory.h
+++ b/arch/arm/mach-ebsa110/include/mach/memory.h
@@ -19,7 +19,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 /*
  * Cache flushing area - SRAM
diff --git a/arch/arm/mach-ep93xx/include/mach/memory.h b/arch/arm/mach-ep93xx/include/mach/memory.h
index 554064e..c9400cf 100644
--- a/arch/arm/mach-ep93xx/include/mach/memory.h
+++ b/arch/arm/mach-ep93xx/include/mach/memory.h
@@ -6,15 +6,15 @@
 #define __ASM_ARCH_MEMORY_H
 
 #if defined(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)
-#define PHYS_OFFSET		UL(0x00000000)
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
 #elif defined(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)
-#define PHYS_OFFSET		UL(0xc0000000)
+#define PLAT_PHYS_OFFSET		UL(0xc0000000)
 #elif defined(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)
-#define PHYS_OFFSET		UL(0xd0000000)
+#define PLAT_PHYS_OFFSET		UL(0xd0000000)
 #elif defined(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)
-#define PHYS_OFFSET		UL(0xe0000000)
+#define PLAT_PHYS_OFFSET		UL(0xe0000000)
 #elif defined(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)
-#define PHYS_OFFSET		UL(0xf0000000)
+#define PLAT_PHYS_OFFSET		UL(0xf0000000)
 #else
 #error "Kconfig bug: No EP93xx PHYS_OFFSET set"
 #endif
diff --git a/arch/arm/mach-footbridge/include/mach/memory.h b/arch/arm/mach-footbridge/include/mach/memory.h
index 8d64f45..5c6df37 100644
--- a/arch/arm/mach-footbridge/include/mach/memory.h
+++ b/arch/arm/mach-footbridge/include/mach/memory.h
@@ -62,7 +62,7 @@ extern unsigned long __bus_to_pfn(unsigned long);
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET		UL(0x00000000)
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
 
 #define FLUSH_BASE_PHYS		0x50000000
 
diff --git a/arch/arm/mach-h720x/include/mach/memory.h b/arch/arm/mach-h720x/include/mach/memory.h
index ef4c1e2..9d36876 100644
--- a/arch/arm/mach-h720x/include/mach/memory.h
+++ b/arch/arm/mach-h720x/include/mach/memory.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET	UL(0x40000000)
+#define PLAT_PHYS_OFFSET	UL(0x40000000)
 /*
  * This is the maximum DMA address that can be DMAd to.
  * There should not be more than (0xd0000000 - 0xc0000000)
diff --git a/arch/arm/mach-integrator/include/mach/memory.h b/arch/arm/mach-integrator/include/mach/memory.h
index 991f24d..334d5e2 100644
--- a/arch/arm/mach-integrator/include/mach/memory.h
+++ b/arch/arm/mach-integrator/include/mach/memory.h
@@ -23,7 +23,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #define BUS_OFFSET	UL(0x80000000)
 #define __virt_to_bus(x)	((x) - PAGE_OFFSET + BUS_OFFSET)
diff --git a/arch/arm/mach-iop13xx/include/mach/memory.h b/arch/arm/mach-iop13xx/include/mach/memory.h
index 3ad4553..1afa99e 100644
--- a/arch/arm/mach-iop13xx/include/mach/memory.h
+++ b/arch/arm/mach-iop13xx/include/mach/memory.h
@@ -6,7 +6,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mach-iop32x/include/mach/memory.h b/arch/arm/mach-iop32x/include/mach/memory.h
index c30f645..169cc23 100644
--- a/arch/arm/mach-iop32x/include/mach/memory.h
+++ b/arch/arm/mach-iop32x/include/mach/memory.h
@@ -8,6 +8,6 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0xa0000000)
+#define PLAT_PHYS_OFFSET	UL(0xa0000000)
 
 #endif
diff --git a/arch/arm/mach-iop33x/include/mach/memory.h b/arch/arm/mach-iop33x/include/mach/memory.h
index a30a96a..8e1daf7 100644
--- a/arch/arm/mach-iop33x/include/mach/memory.h
+++ b/arch/arm/mach-iop33x/include/mach/memory.h
@@ -8,6 +8,6 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-ixp2000/include/mach/memory.h b/arch/arm/mach-ixp2000/include/mach/memory.h
index 98e3471..5f0c4fd 100644
--- a/arch/arm/mach-ixp2000/include/mach/memory.h
+++ b/arch/arm/mach-ixp2000/include/mach/memory.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #include <mach/ixp2000-regs.h>
 
diff --git a/arch/arm/mach-ixp23xx/include/mach/memory.h b/arch/arm/mach-ixp23xx/include/mach/memory.h
index 6ef65d8..6cf0704 100644
--- a/arch/arm/mach-ixp23xx/include/mach/memory.h
+++ b/arch/arm/mach-ixp23xx/include/mach/memory.h
@@ -17,7 +17,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET		(0x00000000)
+#define PLAT_PHYS_OFFSET		(0x00000000)
 
 #define IXP23XX_PCI_SDRAM_OFFSET (*((volatile int *)IXP23XX_PCI_SDRAM_BAR) & 0xfffffff0)
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/memory.h b/arch/arm/mach-ixp4xx/include/mach/memory.h
index 0136eaa..6d388c9 100644
--- a/arch/arm/mach-ixp4xx/include/mach/memory.h
+++ b/arch/arm/mach-ixp4xx/include/mach/memory.h
@@ -12,7 +12,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #if !defined(__ASSEMBLY__) && defined(CONFIG_PCI)
 
diff --git a/arch/arm/mach-kirkwood/include/mach/memory.h b/arch/arm/mach-kirkwood/include/mach/memory.h
index 45431e1..4600b44 100644
--- a/arch/arm/mach-kirkwood/include/mach/memory.h
+++ b/arch/arm/mach-kirkwood/include/mach/memory.h
@@ -5,6 +5,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET		UL(0x00000000)
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-ks8695/include/mach/memory.h b/arch/arm/mach-ks8695/include/mach/memory.h
index bace9a6..f7e1b9b 100644
--- a/arch/arm/mach-ks8695/include/mach/memory.h
+++ b/arch/arm/mach-ks8695/include/mach/memory.h
@@ -18,7 +18,7 @@
 /*
  * Physical SRAM offset.
  */
-#define PHYS_OFFSET		KS8695_SDRAM_PA
+#define PLAT_PHYS_OFFSET		KS8695_SDRAM_PA
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mach-lh7a40x/include/mach/memory.h b/arch/arm/mach-lh7a40x/include/mach/memory.h
index edb8f5f..f77bde8 100644
--- a/arch/arm/mach-lh7a40x/include/mach/memory.h
+++ b/arch/arm/mach-lh7a40x/include/mach/memory.h
@@ -17,7 +17,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0xc0000000)
+#define PLAT_PHYS_OFFSET	UL(0xc0000000)
 
 /*
  * Sparsemem version of the above
diff --git a/arch/arm/mach-loki/include/mach/memory.h b/arch/arm/mach-loki/include/mach/memory.h
index 2ed7e6e..6636665 100644
--- a/arch/arm/mach-loki/include/mach/memory.h
+++ b/arch/arm/mach-loki/include/mach/memory.h
@@ -5,6 +5,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET		UL(0x00000000)
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/memory.h b/arch/arm/mach-lpc32xx/include/mach/memory.h
index 044e1ac..a647dd6 100644
--- a/arch/arm/mach-lpc32xx/include/mach/memory.h
+++ b/arch/arm/mach-lpc32xx/include/mach/memory.h
@@ -22,6 +22,6 @@
 /*
  * Physical DRAM offset of bank 0
  */
-#define PHYS_OFFSET	UL(0x80000000)
+#define PLAT_PHYS_OFFSET	UL(0x80000000)
 
 #endif
diff --git a/arch/arm/mach-mmp/include/mach/memory.h b/arch/arm/mach-mmp/include/mach/memory.h
index bdb21d7..d68b50a 100644
--- a/arch/arm/mach-mmp/include/mach/memory.h
+++ b/arch/arm/mach-mmp/include/mach/memory.h
@@ -9,6 +9,6 @@
 #ifndef __ASM_MACH_MEMORY_H
 #define __ASM_MACH_MEMORY_H
 
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #endif /* __ASM_MACH_MEMORY_H */
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index 05241df..1931e07 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -25,11 +25,11 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/memory.h>
 #include <asm/setup.h>
 
 #include <mach/gpio.h>
 #include <mach/board.h>
-#include <mach/memory.h>
 #include <mach/msm_iomap.h>
 #include <mach/dma.h>
 
diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
index 070e17d..176875d 100644
--- a/arch/arm/mach-msm/include/mach/memory.h
+++ b/arch/arm/mach-msm/include/mach/memory.h
@@ -18,15 +18,15 @@
 
 /* physical offset of RAM */
 #if defined(CONFIG_ARCH_QSD8X50) && defined(CONFIG_MSM_SOC_REV_A)
-#define PHYS_OFFSET		UL(0x00000000)
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
 #elif defined(CONFIG_ARCH_QSD8X50)
-#define PHYS_OFFSET		UL(0x20000000)
+#define PLAT_PHYS_OFFSET		UL(0x20000000)
 #elif defined(CONFIG_ARCH_MSM7X30)
-#define PHYS_OFFSET		UL(0x00200000)
+#define PLAT_PHYS_OFFSET		UL(0x00200000)
 #elif defined(CONFIG_ARCH_MSM8X60)
-#define PHYS_OFFSET		UL(0x40200000)
+#define PLAT_PHYS_OFFSET		UL(0x40200000)
 #else
-#define PHYS_OFFSET		UL(0x10000000)
+#define PLAT_PHYS_OFFSET		UL(0x10000000)
 #endif
 
 #endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/memory.h b/arch/arm/mach-mv78xx0/include/mach/memory.h
index e663042..a648c51 100644
--- a/arch/arm/mach-mv78xx0/include/mach/memory.h
+++ b/arch/arm/mach-mv78xx0/include/mach/memory.h
@@ -5,6 +5,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET		UL(0x00000000)
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
index 042cd56..d8ebde8 100644
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -27,6 +27,7 @@
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
+#include <asm/memory.h>
 #include <asm/setup.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
@@ -36,7 +37,6 @@
 #include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
-#include <mach/memory.h>
 
 #include "devices-imx31.h"
 #include "devices.h"
diff --git a/arch/arm/mach-netx/include/mach/memory.h b/arch/arm/mach-netx/include/mach/memory.h
index 9a363f2..5956149 100644
--- a/arch/arm/mach-netx/include/mach/memory.h
+++ b/arch/arm/mach-netx/include/mach/memory.h
@@ -20,7 +20,7 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET UL(0x80000000)
+#define PLAT_PHYS_OFFSET UL(0x80000000)
 
 #endif
 
diff --git a/arch/arm/mach-nomadik/include/mach/memory.h b/arch/arm/mach-nomadik/include/mach/memory.h
index 1e5689d..d332521 100644
--- a/arch/arm/mach-nomadik/include/mach/memory.h
+++ b/arch/arm/mach-nomadik/include/mach/memory.h
@@ -23,6 +23,6 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-ns9xxx/include/mach/memory.h b/arch/arm/mach-ns9xxx/include/mach/memory.h
index 6107193..5c65aee 100644
--- a/arch/arm/mach-ns9xxx/include/mach/memory.h
+++ b/arch/arm/mach-ns9xxx/include/mach/memory.h
@@ -19,6 +19,6 @@
 #define NS9XXX_CS2STAT_LENGTH	UL(0x1000)
 #define NS9XXX_CS3STAT_LENGTH	UL(0x1000)
 
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-nuc93x/include/mach/memory.h b/arch/arm/mach-nuc93x/include/mach/memory.h
index 323ab0d..ef9864b 100644
--- a/arch/arm/mach-nuc93x/include/mach/memory.h
+++ b/arch/arm/mach-nuc93x/include/mach/memory.h
@@ -16,6 +16,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-orion5x/include/mach/memory.h b/arch/arm/mach-orion5x/include/mach/memory.h
index 52a2955..6769917 100644
--- a/arch/arm/mach-orion5x/include/mach/memory.h
+++ b/arch/arm/mach-orion5x/include/mach/memory.h
@@ -7,6 +7,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-pnx4008/include/mach/memory.h b/arch/arm/mach-pnx4008/include/mach/memory.h
index 0e87700..1275db6 100644
--- a/arch/arm/mach-pnx4008/include/mach/memory.h
+++ b/arch/arm/mach-pnx4008/include/mach/memory.h
@@ -16,6 +16,6 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x80000000)
+#define PLAT_PHYS_OFFSET	UL(0x80000000)
 
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/memory.h b/arch/arm/mach-pxa/include/mach/memory.h
index 92361a6..7f68724 100644
--- a/arch/arm/mach-pxa/include/mach/memory.h
+++ b/arch/arm/mach-pxa/include/mach/memory.h
@@ -15,7 +15,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0xa0000000)
+#define PLAT_PHYS_OFFSET	UL(0xa0000000)
 
 #if !defined(__ASSEMBLY__) && defined(CONFIG_MACH_ARMCORE) && defined(CONFIG_PCI)
 void cmx2xx_pci_adjust_zones(unsigned long *size, unsigned long *holes);
diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
index 5dafc15..e05fc2c 100644
--- a/arch/arm/mach-realview/include/mach/memory.h
+++ b/arch/arm/mach-realview/include/mach/memory.h
@@ -24,9 +24,9 @@
  * Physical DRAM offset.
  */
 #ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
-#define PHYS_OFFSET		UL(0x70000000)
+#define PLAT_PHYS_OFFSET		UL(0x70000000)
 #else
-#define PHYS_OFFSET		UL(0x00000000)
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
 #endif
 
 #if !defined(__ASSEMBLY__) && defined(CONFIG_ZONE_DMA)
diff --git a/arch/arm/mach-rpc/include/mach/memory.h b/arch/arm/mach-rpc/include/mach/memory.h
index 78191bf..18a2210 100644
--- a/arch/arm/mach-rpc/include/mach/memory.h
+++ b/arch/arm/mach-rpc/include/mach/memory.h
@@ -21,7 +21,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x10000000)
+#define PLAT_PHYS_OFFSET	UL(0x10000000)
 
 /*
  * Cache flushing area - ROM
diff --git a/arch/arm/mach-s3c2400/include/mach/memory.h b/arch/arm/mach-s3c2400/include/mach/memory.h
index cf5901f..3f33670 100644
--- a/arch/arm/mach-s3c2400/include/mach/memory.h
+++ b/arch/arm/mach-s3c2400/include/mach/memory.h
@@ -15,6 +15,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET	UL(0x0C000000)
+#define PLAT_PHYS_OFFSET	UL(0x0C000000)
 
 #endif
diff --git a/arch/arm/mach-s3c2410/include/mach/memory.h b/arch/arm/mach-s3c2410/include/mach/memory.h
index 6f1e587..f92b97b 100644
--- a/arch/arm/mach-s3c2410/include/mach/memory.h
+++ b/arch/arm/mach-s3c2410/include/mach/memory.h
@@ -11,6 +11,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET	UL(0x30000000)
+#define PLAT_PHYS_OFFSET	UL(0x30000000)
 
 #endif
diff --git a/arch/arm/mach-s3c24a0/include/mach/memory.h b/arch/arm/mach-s3c24a0/include/mach/memory.h
index 7d74fd5..7d208a7 100644
--- a/arch/arm/mach-s3c24a0/include/mach/memory.h
+++ b/arch/arm/mach-s3c24a0/include/mach/memory.h
@@ -11,7 +11,7 @@
 #ifndef __ASM_ARCH_24A0_MEMORY_H
 #define __ASM_ARCH_24A0_MEMORY_H __FILE__
 
-#define PHYS_OFFSET UL(0x10000000)
+#define PLAT_PHYS_OFFSET UL(0x10000000)
 
 #define __virt_to_bus(x) __virt_to_phys(x)
 #define __bus_to_virt(x) __phys_to_virt(x)
diff --git a/arch/arm/mach-s3c64xx/include/mach/memory.h b/arch/arm/mach-s3c64xx/include/mach/memory.h
index 42cc54e..4760cda 100644
--- a/arch/arm/mach-s3c64xx/include/mach/memory.h
+++ b/arch/arm/mach-s3c64xx/include/mach/memory.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET     UL(0x50000000)
+#define PLAT_PHYS_OFFSET     UL(0x50000000)
 
 #define CONSISTENT_DMA_SIZE	SZ_8M
 
diff --git a/arch/arm/mach-s5p6442/include/mach/memory.h b/arch/arm/mach-s5p6442/include/mach/memory.h
index 9ddd877..cfe259d 100644
--- a/arch/arm/mach-s5p6442/include/mach/memory.h
+++ b/arch/arm/mach-s5p6442/include/mach/memory.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET		UL(0x20000000)
+#define PLAT_PHYS_OFFSET		UL(0x20000000)
 #define CONSISTENT_DMA_SIZE	SZ_8M
 
 #endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/memory.h b/arch/arm/mach-s5p64x0/include/mach/memory.h
index 1b036b0..365a6eb 100644
--- a/arch/arm/mach-s5p64x0/include/mach/memory.h
+++ b/arch/arm/mach-s5p64x0/include/mach/memory.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H __FILE__
 
-#define PHYS_OFFSET		UL(0x20000000)
+#define PLAT_PHYS_OFFSET		UL(0x20000000)
 #define CONSISTENT_DMA_SIZE	SZ_8M
 
 #endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/memory.h b/arch/arm/mach-s5pc100/include/mach/memory.h
index 4b60d18..bda4e79 100644
--- a/arch/arm/mach-s5pc100/include/mach/memory.h
+++ b/arch/arm/mach-s5pc100/include/mach/memory.h
@@ -13,6 +13,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET     	UL(0x20000000)
+#define PLAT_PHYS_OFFSET     	UL(0x20000000)
 
 #endif
diff --git a/arch/arm/mach-s5pv210/include/mach/memory.h b/arch/arm/mach-s5pv210/include/mach/memory.h
index d503e0c..7b5fcf0 100644
--- a/arch/arm/mach-s5pv210/include/mach/memory.h
+++ b/arch/arm/mach-s5pv210/include/mach/memory.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET		UL(0x20000000)
+#define PLAT_PHYS_OFFSET		UL(0x20000000)
 #define CONSISTENT_DMA_SIZE	(SZ_8M + SZ_4M + SZ_2M)
 
 /*
diff --git a/arch/arm/mach-s5pv310/include/mach/memory.h b/arch/arm/mach-s5pv310/include/mach/memory.h
index 1dffb48..470b01b 100644
--- a/arch/arm/mach-s5pv310/include/mach/memory.h
+++ b/arch/arm/mach-s5pv310/include/mach/memory.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H __FILE__
 
-#define PHYS_OFFSET		UL(0x40000000)
+#define PLAT_PHYS_OFFSET		UL(0x40000000)
 
 /* Maximum of 256MiB in one bank */
 #define MAX_PHYSMEM_BITS	32
diff --git a/arch/arm/mach-sa1100/include/mach/memory.h b/arch/arm/mach-sa1100/include/mach/memory.h
index 128a1df..a44da6a 100644
--- a/arch/arm/mach-sa1100/include/mach/memory.h
+++ b/arch/arm/mach-sa1100/include/mach/memory.h
@@ -12,7 +12,7 @@
 /*
  * Physical DRAM offset is 0xc0000000 on the SA1100
  */
-#define PHYS_OFFSET	UL(0xc0000000)
+#define PLAT_PHYS_OFFSET	UL(0xc0000000)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mach-shark/include/mach/memory.h b/arch/arm/mach-shark/include/mach/memory.h
index d9c4812..9afb170 100644
--- a/arch/arm/mach-shark/include/mach/memory.h
+++ b/arch/arm/mach-shark/include/mach/memory.h
@@ -15,7 +15,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET     UL(0x08000000)
+#define PLAT_PHYS_OFFSET     UL(0x08000000)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mach-shmobile/include/mach/memory.h b/arch/arm/mach-shmobile/include/mach/memory.h
index 377584e..ad00c3c 100644
--- a/arch/arm/mach-shmobile/include/mach/memory.h
+++ b/arch/arm/mach-shmobile/include/mach/memory.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_MEMORY_H
 #define __ASM_MACH_MEMORY_H
 
-#define PHYS_OFFSET	UL(CONFIG_MEMORY_START)
+#define PLAT_PHYS_OFFSET	UL(CONFIG_MEMORY_START)
 #define MEM_SIZE	UL(CONFIG_MEMORY_SIZE)
 
 /* DMA memory at 0xf6000000 - 0xffdfffff */
diff --git a/arch/arm/mach-tegra/include/mach/memory.h b/arch/arm/mach-tegra/include/mach/memory.h
index 6151bab..537db3a 100644
--- a/arch/arm/mach-tegra/include/mach/memory.h
+++ b/arch/arm/mach-tegra/include/mach/memory.h
@@ -22,7 +22,7 @@
 #define __MACH_TEGRA_MEMORY_H
 
 /* physical offset of RAM */
-#define PHYS_OFFSET		UL(0)
+#define PLAT_PHYS_OFFSET		UL(0)
 
 #endif
 
diff --git a/arch/arm/mach-u300/include/mach/memory.h b/arch/arm/mach-u300/include/mach/memory.h
index bf134bc..888e2e3 100644
--- a/arch/arm/mach-u300/include/mach/memory.h
+++ b/arch/arm/mach-u300/include/mach/memory.h
@@ -15,17 +15,17 @@
 
 #ifdef CONFIG_MACH_U300_DUAL_RAM
 
-#define PHYS_OFFSET		UL(0x48000000)
+#define PLAT_PHYS_OFFSET		UL(0x48000000)
 #define BOOT_PARAMS_OFFSET	(PHYS_OFFSET + 0x100)
 
 #else
 
 #ifdef CONFIG_MACH_U300_2MB_ALIGNMENT_FIX
-#define PHYS_OFFSET (0x28000000 + \
+#define PLAT_PHYS_OFFSET (0x28000000 + \
 	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE - \
 	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1))*1024*1024)
 #else
-#define PHYS_OFFSET (0x28000000 + \
+#define PLAT_PHYS_OFFSET (0x28000000 + \
 	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE +	\
 	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1))*1024*1024)
 #endif
diff --git a/arch/arm/mach-u300/u300.c b/arch/arm/mach-u300/u300.c
index 07c35a8..48b3b7f 100644
--- a/arch/arm/mach-u300/u300.c
+++ b/arch/arm/mach-u300/u300.c
@@ -19,9 +19,9 @@
 #include <linux/io.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <mach/memory.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/memory.h>
 
 static void __init u300_reserve(void)
 {
diff --git a/arch/arm/mach-ux500/include/mach/memory.h b/arch/arm/mach-ux500/include/mach/memory.h
index 510571a..2ef697a 100644
--- a/arch/arm/mach-ux500/include/mach/memory.h
+++ b/arch/arm/mach-ux500/include/mach/memory.h
@@ -12,7 +12,7 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 #define BUS_OFFSET	UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-versatile/include/mach/memory.h b/arch/arm/mach-versatile/include/mach/memory.h
index 79aeab8..dacc9d8 100644
--- a/arch/arm/mach-versatile/include/mach/memory.h
+++ b/arch/arm/mach-versatile/include/mach/memory.h
@@ -23,6 +23,6 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #endif
diff --git a/arch/arm/mach-vexpress/include/mach/memory.h b/arch/arm/mach-vexpress/include/mach/memory.h
index be28232..5b7fcd4 100644
--- a/arch/arm/mach-vexpress/include/mach/memory.h
+++ b/arch/arm/mach-vexpress/include/mach/memory.h
@@ -20,6 +20,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET		UL(0x60000000)
+#define PLAT_PHYS_OFFSET		UL(0x60000000)
 
 #endif
diff --git a/arch/arm/mach-w90x900/include/mach/memory.h b/arch/arm/mach-w90x900/include/mach/memory.h
index 971b807..f02905b 100644
--- a/arch/arm/mach-w90x900/include/mach/memory.h
+++ b/arch/arm/mach-w90x900/include/mach/memory.h
@@ -18,6 +18,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PHYS_OFFSET	UL(0x00000000)
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
 
 #endif
diff --git a/arch/arm/plat-omap/include/plat/memory.h b/arch/arm/plat-omap/include/plat/memory.h
index f8d922f..e6720aa 100644
--- a/arch/arm/plat-omap/include/plat/memory.h
+++ b/arch/arm/plat-omap/include/plat/memory.h
@@ -37,9 +37,9 @@
  * Physical DRAM offset.
  */
 #if defined(CONFIG_ARCH_OMAP1)
-#define PHYS_OFFSET		UL(0x10000000)
+#define PLAT_PHYS_OFFSET		UL(0x10000000)
 #else
-#define PHYS_OFFSET		UL(0x80000000)
+#define PLAT_PHYS_OFFSET		UL(0x80000000)
 #endif
 
 /*
diff --git a/arch/arm/plat-spear/include/plat/memory.h b/arch/arm/plat-spear/include/plat/memory.h
index 27a4aba..7e3599e 100644
--- a/arch/arm/plat-spear/include/plat/memory.h
+++ b/arch/arm/plat-spear/include/plat/memory.h
@@ -15,6 +15,6 @@
 #define __PLAT_MEMORY_H
 
 /* Physical DRAM offset */
-#define PHYS_OFFSET		UL(0x00000000)
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
 
 #endif /* __PLAT_MEMORY_H */
diff --git a/arch/arm/plat-stmp3xxx/include/mach/memory.h b/arch/arm/plat-stmp3xxx/include/mach/memory.h
index 7b875a0..61fa548 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/memory.h
+++ b/arch/arm/plat-stmp3xxx/include/mach/memory.h
@@ -17,6 +17,6 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET	UL(0x40000000)
+#define PLAT_PHYS_OFFSET	UL(0x40000000)
 
 #endif
diff --git a/arch/arm/plat-tcc/include/mach/memory.h b/arch/arm/plat-tcc/include/mach/memory.h
index cd91ba8..28a6e0c 100644
--- a/arch/arm/plat-tcc/include/mach/memory.h
+++ b/arch/arm/plat-tcc/include/mach/memory.h
@@ -13,6 +13,6 @@
 /*
  * Physical DRAM offset.
  */
-#define PHYS_OFFSET		UL(0x20000000)
+#define PLAT_PHYS_OFFSET		UL(0x20000000)
 
 #endif
-- 
1.6.2.5
