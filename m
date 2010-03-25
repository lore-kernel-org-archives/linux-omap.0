From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [RFC] Initial attempt to make ARM use LMB
Date: Thu, 25 Mar 2010 23:32:48 +0000
Message-ID: <20100325233248.GM24984@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49680 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab0CYXdG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 19:33:06 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

LMB... logical memory blocks.

LM is a different method of managing memory regions during the early
boot period when the usual kernel memory allocators are not up and
running.  LMB has been in the kernel for quite some time, and is
already being used by Microblaze, PPC, SH and Sparc.  Maybe soon x86
as well.

The motivation for this is that there appears to be plans to kill off
the other method - bootmem.  (see discussions on the linux-arch ml.)

Plus points:
1. LMB can be told about all memory areas, and all reserved areas.

2. As a result, we get rid of the "guess where to put the bootmem bitmap"
   code which can sometimes end up overwriting initrds by asking lmb to
   find a suitable place which doesn't conflict with reserved areas.

3. Overall reduction in arch code.

Minus points:
1. breaks OMAP2,3,4 since it fiddles with bootmem in its map_io function
   for framebuffer stuff.  This needs reworking.

2. highmem is probably broken by this.

3. the highmem boundary (as far as lowmem lmb allocations are concerned)
   is set at PHYS_OFFSET + 32MB

4. sparsemem requires bootmem, so we can't get away from bootmem at the
   moment.

The patch below is the combined patch; individual patches can be found
in the arm:lmb patches on the website or the lmb branch of my git tree;
this should be considered unstable.

 arch/arm/Kconfig                         |    1 +
 arch/arm/include/asm/lmb.h               |   13 ++
 arch/arm/include/asm/mach/arch.h         |    1 +
 arch/arm/kernel/setup.c                  |   12 ++
 arch/arm/mach-clps711x/edb7211-arch.c    |    8 ++
 arch/arm/mach-clps711x/mm.c              |    1 -
 arch/arm/mach-integrator/common.h        |    1 +
 arch/arm/mach-integrator/core.c          |   11 ++
 arch/arm/mach-integrator/integrator_ap.c |    1 +
 arch/arm/mach-integrator/integrator_cp.c |    1 +
 arch/arm/mach-ixp4xx/common.c            |    1 -
 arch/arm/mach-omap1/board-htcherald.c    |    1 -
 arch/arm/mach-omap2/omap_hwmod.c         |    1 -
 arch/arm/mach-pxa/palmt5.c               |    7 +
 arch/arm/mach-pxa/palmtreo.c             |    9 ++
 arch/arm/mach-s3c2410/mach-h1940.c       |    9 ++
 arch/arm/mach-s3c2440/mach-rx3715.c      |    9 ++
 arch/arm/mach-u300/u300.c                |   17 +++
 arch/arm/mm/init.c                       |  184 +++++------------------------
 arch/arm/mm/mm.h                         |    8 +-
 arch/arm/mm/mmu.c                        |  153 ++++++++++---------------
 arch/arm/mm/nommu.c                      |   22 +---
 22 files changed, 198 insertions(+), 273 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c5408bf..48254a4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -10,6 +10,7 @@ config ARM
 	default y
 	select HAVE_AOUT
 	select HAVE_IDE
+	select HAVE_LMB
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
 	select GENERIC_ATOMIC64 if (!CPU_32v6K)
diff --git a/arch/arm/include/asm/lmb.h b/arch/arm/include/asm/lmb.h
new file mode 100644
index 0000000..df083f1
--- /dev/null
+++ b/arch/arm/include/asm/lmb.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_ARM_LMB_H
+#define _ASM_ARM_LMB_H
+
+#ifdef CONFIG_MMU
+extern phys_addr_t lowmem_end_addr;
+#define LMB_REAL_LIMIT	lowmem_end_addr
+#else
+#define LMB_REAL_LIMIT	0
+#endif
+
+extern void arm_lmb_reserve(void);
+
+#endif
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index c59842d..f634dbe 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -37,6 +37,7 @@ struct machine_desc {
 	void			(*fixup)(struct machine_desc *,
 					 struct tag *, char **,
 					 struct meminfo *);
+	void			(*reserve)(void);/* reserve lmb blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;		/* system tick timer	*/
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c91c77b..23633ee 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <linux/smp.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
+#include <linux/lmb.h>
 
 #include <asm/unified.h>
 #include <asm/cpu.h>
@@ -666,6 +667,7 @@ void __init setup_arch(char **cmdline_p)
 	struct tag *tags = (struct tag *)&init_tags;
 	struct machine_desc *mdesc;
 	char *from = default_command_line;
+	int i;
 
 	unwind_init();
 
@@ -714,6 +716,16 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	lmb_init();
+	for (i = 0; i < meminfo.nr_banks; i++)
+		lmb_add(meminfo.bank[i].start, meminfo.bank[i].size);
+
+	arm_lmb_reserve();
+
+	/* reserve any lmb areas */
+	if (mdesc->reserve)
+		mdesc->reserve();
+
 	paging_init(mdesc);
 	request_standard_resources(&meminfo, mdesc);
 
diff --git a/arch/arm/mach-clps711x/edb7211-arch.c b/arch/arm/mach-clps711x/edb7211-arch.c
index dc81cc6..aba952c 100644
--- a/arch/arm/mach-clps711x/edb7211-arch.c
+++ b/arch/arm/mach-clps711x/edb7211-arch.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
+#include <linux/lmb.h>
 #include <linux/types.h>
 #include <linux/string.h>
 
@@ -29,6 +30,12 @@
 
 extern void edb7211_map_io(void);
 
+/* Reserve screen memory region at the start of main system memory. */
+static void __init edb7211_reserve(void)
+{
+	lmb_reserve(PHYS_OFFSET, 0x00020000);
+}
+
 static void __init
 fixup_edb7211(struct machine_desc *desc, struct tag *tags,
 	      char **cmdline, struct meminfo *mi)
@@ -57,6 +64,7 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.boot_params	= 0xc0020100,	/* 0xc0000000 - 0xc001ffff can be video RAM */
 	.fixup		= fixup_edb7211,
 	.map_io		= edb7211_map_io,
+	.reserve	= edb7211_reserve,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/mm.c b/arch/arm/mach-clps711x/mm.c
index a7b4591..9865921 100644
--- a/arch/arm/mach-clps711x/mm.c
+++ b/arch/arm/mach-clps711x/mm.c
@@ -22,7 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 
 #include <asm/sizes.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
index 609c49d..87cfeed 100644
--- a/arch/arm/mach-integrator/common.h
+++ b/arch/arm/mach-integrator/common.h
@@ -1,2 +1,3 @@
 extern void integrator_time_init(unsigned long, unsigned int);
 extern unsigned long integrator_gettimeoffset(void);
+void integrator_reserve(void);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 8b390e3..417c772 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -14,6 +14,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/lmb.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/termios.h>
@@ -334,3 +335,13 @@ void __init integrator_time_init(unsigned long reload, unsigned int ctrl)
 	 */
 	setup_irq(IRQ_TIMERINT1, &integrator_timer_irq);
 }
+
+/*
+ * We need to stop things allocating the low memory; ideally we need a
+ * better implementation of GFP_DMA which does not assume that DMA-able
+ * memory starts at zero.
+ */
+void __init integrator_reserve(void)
+{
+	lmb_reserve(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
+}
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 8138a7e..9fbde0d 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -350,6 +350,7 @@ MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	.io_pg_offst	= ((0xf1600000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= ap_map_io,
+	.reserve	= integrator_reserve,
 	.init_irq	= ap_init_irq,
 	.timer		= &ap_timer,
 	.init_machine	= ap_init,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 66ef86d..8de5f35 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -585,6 +585,7 @@ MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	.io_pg_offst	= ((0xf1600000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= intcp_map_io,
+	.reserve	= integrator_reserve,
 	.init_irq	= intcp_init_irq,
 	.timer		= &cp_timer,
 	.init_machine	= intcp_init,
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 71728d3..0bce097 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -21,7 +21,6 @@
 #include <linux/tty.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
-#include <linux/bootmem.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/time.h>
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index e36639f..8e313b4 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -28,7 +28,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
-#include <linux/bootmem.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c664947..aa3e209 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -43,7 +43,6 @@
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
-#include <linux/bootmem.h>
 
 #include <plat/common.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index d902a81..b33fbe3 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -21,6 +21,7 @@
 #include <linux/irq.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/lmb.h>
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
@@ -396,6 +397,11 @@ static void __init palmt5_udc_init(void)
 	}
 }
 
+static void __init palmt5_reserve(void)
+{
+	lmb_reserve(0xa0200000, 0x1000);
+}
+
 static void __init palmt5_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmt5_pin_config));
@@ -421,6 +427,7 @@ MACHINE_START(PALMT5, "Palm Tungsten|T5")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
+	.reserve	= palmt5_reserve,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= palmt5_init
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index d8b4469..e712b86 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/lmb.h>
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
@@ -633,6 +634,12 @@ static void __init treo_lcd_power_init(void)
 	treo_lcd_screen.pxafb_lcd_power = treo_lcd_power;
 }
 
+static void __init treo_reserve(void)
+{
+	lmb_reserve(0xa0000000, 0x1000);
+	lmb_reserve(0xa2000000, 0x1000);
+}
+
 static void __init treo_init(void)
 {
 	pxa_set_ffuart_info(NULL);
@@ -668,6 +675,7 @@ MACHINE_START(TREO680, "Palm Treo 680")
 	.io_pg_offst    = io_p2v(0x40000000),
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.reserve	= treo_reserve,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = treo680_init,
@@ -691,6 +699,7 @@ MACHINE_START(CENTRO, "Palm Centro 685")
 	.io_pg_offst    = io_p2v(0x40000000),
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.reserve	= treo_reserve,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
        .init_machine   = centro_init,
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index fbedd07..bfbcdd0 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/lmb.h>
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/sysdev.h>
@@ -301,6 +302,13 @@ static void __init h1940_map_io(void)
 	s3c_pm_init();
 }
 
+/* H1940 and RX3715 need to reserve this for suspend */
+static void __init h1940_reserve(void)
+{
+	lmb_reserve(0x30003000, 0x1000);
+	lmb_reserve(0x30081000, 0x1000);
+}
+
 static void __init h1940_init_irq(void)
 {
 	s3c24xx_init_irq();
@@ -342,6 +350,7 @@ MACHINE_START(H1940, "IPAQ-H1940")
 	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= h1940_map_io,
+	.reserve	= h1940_reserve,
 	.init_irq	= h1940_init_irq,
 	.init_machine	= h1940_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index 1e836e5..76aa734 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/lmb.h>
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/tty.h>
@@ -191,6 +192,13 @@ static void __init rx3715_map_io(void)
 	s3c24xx_init_uarts(rx3715_uartcfgs, ARRAY_SIZE(rx3715_uartcfgs));
 }
 
+/* H1940 and RX3715 need to reserve this for suspend */
+static void __init rx3715_reserve(void)
+{
+	lmb_reserve(0x30003000, 0x1000);
+	lmb_reserve(0x30081000, 0x1000);
+}
+
 static void __init rx3715_init_irq(void)
 {
 	s3c24xx_init_irq();
@@ -214,6 +222,7 @@ MACHINE_START(RX3715, "IPAQ-RX3715")
 	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= rx3715_map_io,
+	.reserve	= rx3715_reserve,
 	.init_irq	= rx3715_init_irq,
 	.init_machine	= rx3715_init_machine,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-u300/u300.c b/arch/arm/mach-u300/u300.c
index d2a0b88..4fb8660 100644
--- a/arch/arm/mach-u300/u300.c
+++ b/arch/arm/mach-u300/u300.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/lmb.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
@@ -22,6 +23,21 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+static void __init u300_reserve(void)
+{
+	/*
+	 * U300 - This platform family can share physical memory
+	 * between two ARM cpus, one running Linux and the other
+	 * running another OS.
+	 */
+#ifdef CONFIG_MACH_U300_SINGLE_RAM
+#if ((CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1) == 1) && \
+	CONFIG_MACH_U300_2MB_ALIGNMENT_FIX
+        lmb_reserve(PHYS_OFFSET, 0x00100000);
+#endif
+#endif
+}
+
 static void __init u300_init_machine(void)
 {
 	u300_init_devices();
@@ -49,6 +65,7 @@ MACHINE_START(U300, MACH_U300_STRING)
 	.io_pg_offst	= ((U300_AHB_PER_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= BOOT_PARAMS_OFFSET,
 	.map_io		= u300_map_io,
+	.reserve	= u300_reserve,
 	.init_irq	= u300_init_irq,
 	.timer		= &u300_timer,
 	.init_machine	= u300_init_machine,
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 7829cb5..e714bb2 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -15,8 +15,8 @@
 #include <linux/mman.h>
 #include <linux/nodemask.h>
 #include <linux/initrd.h>
-#include <linux/sort.h>
 #include <linux/highmem.h>
+#include <linux/lmb.h>
 
 #include <asm/mach-types.h>
 #include <asm/sections.h>
@@ -150,119 +150,21 @@ static void __init find_node_limits(int node, struct meminfo *mi,
 	}
 }
 
-/*
- * FIXME: We really want to avoid allocating the bootmap bitmap
- * over the top of the initrd.  Hopefully, this is located towards
- * the start of a bank, so if we allocate the bootmap bitmap at
- * the end, we won't clash.
- */
-static unsigned int __init
-find_bootmap_pfn(int node, struct meminfo *mi, unsigned int bootmap_pages)
-{
-	unsigned int start_pfn, i, bootmap_pfn;
-
-	start_pfn   = PAGE_ALIGN(__pa(_end)) >> PAGE_SHIFT;
-	bootmap_pfn = 0;
-
-	for_each_nodebank(i, mi, node) {
-		struct membank *bank = &mi->bank[i];
-		unsigned int start, end;
-
-		start = bank_pfn_start(bank);
-		end   = bank_pfn_end(bank);
-
-		if (end < start_pfn)
-			continue;
-
-		if (start < start_pfn)
-			start = start_pfn;
-
-		if (end <= start)
-			continue;
-
-		if (end - start >= bootmap_pages) {
-			bootmap_pfn = start;
-			break;
-		}
-	}
-
-	if (bootmap_pfn == 0)
-		BUG();
-
-	return bootmap_pfn;
-}
-
-static int __init check_initrd(struct meminfo *mi)
-{
-	int initrd_node = -2;
-#ifdef CONFIG_BLK_DEV_INITRD
-	unsigned long end = phys_initrd_start + phys_initrd_size;
-
-	/*
-	 * Make sure that the initrd is within a valid area of
-	 * memory.
-	 */
-	if (phys_initrd_size) {
-		unsigned int i;
-
-		initrd_node = -1;
-
-		for (i = 0; i < mi->nr_banks; i++) {
-			struct membank *bank = &mi->bank[i];
-			if (bank_phys_start(bank) <= phys_initrd_start &&
-			    end <= bank_phys_end(bank))
-				initrd_node = bank->node;
-		}
-	}
-
-	if (initrd_node == -1) {
-		printk(KERN_ERR "INITRD: 0x%08lx+0x%08lx extends beyond "
-		       "physical memory - disabling initrd\n",
-		       phys_initrd_start, phys_initrd_size);
-		phys_initrd_start = phys_initrd_size = 0;
-	}
-#endif
-
-	return initrd_node;
-}
-
-static inline void map_memory_bank(struct membank *bank)
-{
-#ifdef CONFIG_MMU
-	struct map_desc map;
-
-	map.pfn = bank_pfn_start(bank);
-	map.virtual = __phys_to_virt(bank_phys_start(bank));
-	map.length = bank_phys_size(bank);
-	map.type = MT_MEMORY;
-
-	create_mapping(&map);
-#endif
-}
-
 static void __init bootmem_init_node(int node, struct meminfo *mi,
 	unsigned long start_pfn, unsigned long end_pfn)
 {
-	unsigned long boot_pfn;
 	unsigned int boot_pages;
+	phys_addr_t bitmap;
 	pg_data_t *pgdat;
 	int i;
 
 	/*
-	 * Map the memory banks for this node.
-	 */
-	for_each_nodebank(i, mi, node) {
-		struct membank *bank = &mi->bank[i];
-
-		if (!bank->highmem)
-			map_memory_bank(bank);
-	}
-
-	/*
-	 * Allocate the bootmem bitmap page.
+	 * Allocate the bootmem bitmap page.  This must be in a region
+	 * of memory which has already been mapped.
 	 */
 	boot_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
-	boot_pfn = find_bootmap_pfn(node, mi, boot_pages);
+	bitmap = lmb_alloc_base(boot_pages << PAGE_SHIFT, L1_CACHE_BYTES,
+				__pfn_to_phys(end_pfn));
 
 	/*
 	 * Initialise the bootmem allocator for this node, handing the
@@ -270,7 +172,7 @@ static void __init bootmem_init_node(int node, struct meminfo *mi,
 	 */
 	node_set_online(node);
 	pgdat = NODE_DATA(node);
-	init_bootmem_node(pgdat, boot_pfn, start_pfn, end_pfn);
+	init_bootmem_node(pgdat, __phys_to_pfn(bitmap), start_pfn, end_pfn);
 
 	for_each_nodebank(i, mi, node) {
 		struct membank *bank = &mi->bank[i];
@@ -279,31 +181,16 @@ static void __init bootmem_init_node(int node, struct meminfo *mi,
 	}
 
 	/*
-	 * Reserve the bootmem bitmap for this node.
+	 * Reserve the LMB reserved regions in bootmem for this node.
 	 */
-	reserve_bootmem_node(pgdat, boot_pfn << PAGE_SHIFT,
-			     boot_pages << PAGE_SHIFT, BOOTMEM_DEFAULT);
-}
-
-static void __init bootmem_reserve_initrd(int node)
-{
-#ifdef CONFIG_BLK_DEV_INITRD
-	pg_data_t *pgdat = NODE_DATA(node);
-	int res;
-
-	res = reserve_bootmem_node(pgdat, phys_initrd_start,
-			     phys_initrd_size, BOOTMEM_EXCLUSIVE);
-
-	if (res == 0) {
-		initrd_start = __phys_to_virt(phys_initrd_start);
-		initrd_end = initrd_start + phys_initrd_size;
-	} else {
-		printk(KERN_ERR
-			"INITRD: 0x%08lx+0x%08lx overlaps in-use "
-			"memory region - disabling initrd\n",
-			phys_initrd_start, phys_initrd_size);
+	for (i = 0; i < lmb.reserved.cnt; i++) {
+		phys_addr_t start = lmb_start_pfn(&lmb.reserved, i);
+		if (start >= start_pfn &&
+		    lmb_end_pfn(&lmb.reserved, i) <= end_pfn)
+			reserve_bootmem_node(pgdat, __pfn_to_phys(start),
+				lmb_size_bytes(&lmb.reserved, i),
+				BOOTMEM_DEFAULT);
 	}
-#endif
 }
 
 static void __init bootmem_free_node(int node, struct meminfo *mi)
@@ -387,25 +274,23 @@ static void arm_memory_present(struct meminfo *mi, int node)
 }
 #endif
 
-static int __init meminfo_cmp(const void *_a, const void *_b)
+void __init arm_lmb_reserve(void)
 {
-	const struct membank *a = _a, *b = _b;
-	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
-	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
+	/* Register the kernel text, kernel data and initrd with lmb. */
+#ifdef CONFIG_XIP_KERNEL
+	lmb_reserve(__pa(_data), _end - _data);
+#else
+	lmb_reserve(__pa(_stext), _end - _stext);
+#endif
+	lmb_reserve(phys_initrd_start, phys_initrd_size);
+	arm_mm_lmb_reserve();
 }
 
 void __init bootmem_init(void)
 {
 	struct meminfo *mi = &meminfo;
 	unsigned long min, max_low, max_high;
-	int node, initrd_node;
-
-	sort(&mi->bank, mi->nr_banks, sizeof(mi->bank[0]), meminfo_cmp, NULL);
-
-	/*
-	 * Locate which node contains the ramdisk image, if any.
-	 */
-	initrd_node = check_initrd(mi);
+	int node;
 
 	max_low = max_high = 0;
 
@@ -432,18 +317,6 @@ void __init bootmem_init(void)
 		bootmem_init_node(node, mi, min, node_low);
 
 		/*
-		 * Reserve any special node zero regions.
-		 */
-		if (node == 0)
-			reserve_node_zero(NODE_DATA(node));
-
-		/*
-		 * If the initrd is in this node, reserve its memory.
-		 */
-		if (node == initrd_node)
-			bootmem_reserve_initrd(node);
-
-		/*
 		 * Sparsemem tries to allocate bootmem in memory_present(),
 		 * so must be done after the fixed reservations
 		 */
@@ -566,6 +439,13 @@ void __init mem_init(void)
 	unsigned long reserved_pages, free_pages;
 	int i, node;
 
+#ifdef CONFIG_SA1111
+	lmb_free(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
+#endif
+
+	lmb_analyze();
+	lmb_dump_all();
+
 #ifndef CONFIG_DISCONTIGMEM
 	max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
 #endif
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index a888363..966dc45 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -28,10 +28,6 @@ extern void __flush_dcache_page(struct address_space *mapping, struct page *page
 
 #endif
 
-struct map_desc;
-struct meminfo;
-struct pglist_data;
-
-void __init create_mapping(struct map_desc *md);
 void __init bootmem_init(void);
-void reserve_node_zero(struct pglist_data *pgdat);
+void arm_lmb_reserve(void);
+void arm_mm_lmb_reserve(void);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9d4da6a..81eb08a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -11,9 +11,10 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
+#include <linux/lmb.h>
+#include <linux/sort.h>
 
 #include <asm/cputype.h>
 #include <asm/mach-types.h>
@@ -483,6 +484,13 @@ static void __init build_mem_type_table(void)
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
+static void __init *early_alloc(unsigned long sz)
+{
+	void *ptr = __va(lmb_alloc(sz, sz));
+	memset(ptr, 0, PAGE_SIZE);
+	return ptr;
+}
+
 static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
 				  const struct mem_type *type)
@@ -490,7 +498,7 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	pte_t *pte;
 
 	if (pmd_none(*pmd)) {
-		pte = alloc_bootmem_low_pages(2 * PTRS_PER_PTE * sizeof(pte_t));
+		pte = early_alloc(2 * PTRS_PER_PTE * sizeof(pte_t));
 		__pmd_populate(pmd, __pa(pte) | type->prot_l1);
 	}
 
@@ -599,7 +607,7 @@ static void __init create_36bit_mapping(struct map_desc *md,
  * offsets, and we take full advantage of sections and
  * supersections.
  */
-void __init create_mapping(struct map_desc *md)
+static void __init create_mapping(struct map_desc *md)
 {
 	unsigned long phys, addr, length, end;
 	const struct mem_type *type;
@@ -693,6 +701,9 @@ early_param("vmalloc", early_vmalloc);
 
 #define VMALLOC_MIN	(void *)(VMALLOC_END - vmalloc_reserve)
 
+/* FIXME: we need to teach LMB about the highmem boundary */
+phys_addr_t lowmem_end_addr = PHYS_OFFSET + 32*1048576;
+
 static void __init sanity_check_meminfo(void)
 {
 	int i, j, highmem = 0;
@@ -822,100 +833,23 @@ static inline void prepare_page_table(void)
 }
 
 /*
- * Reserve the various regions of node 0
+ * Reserve the special regions of memory
  */
-void __init reserve_node_zero(pg_data_t *pgdat)
+void __init arm_mm_lmb_reserve(void)
 {
-	unsigned long res_size = 0;
-
-	/*
-	 * Register the kernel text and data with bootmem.
-	 * Note that this can only be in node 0.
-	 */
-#ifdef CONFIG_XIP_KERNEL
-	reserve_bootmem_node(pgdat, __pa(_data), _end - _data,
-			BOOTMEM_DEFAULT);
-#else
-	reserve_bootmem_node(pgdat, __pa(_stext), _end - _stext,
-			BOOTMEM_DEFAULT);
-#endif
-
 	/*
 	 * Reserve the page tables.  These are already in use,
 	 * and can only be in node 0.
 	 */
-	reserve_bootmem_node(pgdat, __pa(swapper_pg_dir),
-			     PTRS_PER_PGD * sizeof(pgd_t), BOOTMEM_DEFAULT);
-
-	/*
-	 * Hmm... This should go elsewhere, but we really really need to
-	 * stop things allocating the low memory; ideally we need a better
-	 * implementation of GFP_DMA which does not assume that DMA-able
-	 * memory starts at zero.
-	 */
-	if (machine_is_integrator() || machine_is_cintegrator())
-		res_size = __pa(swapper_pg_dir) - PHYS_OFFSET;
-
-	/*
-	 * These should likewise go elsewhere.  They pre-reserve the
-	 * screen memory region at the start of main system memory.
-	 */
-	if (machine_is_edb7211())
-		res_size = 0x00020000;
-	if (machine_is_p720t())
-		res_size = 0x00014000;
-
-	/* H1940 and RX3715 need to reserve this for suspend */
-
-	if (machine_is_h1940() || machine_is_rx3715()) {
-		reserve_bootmem_node(pgdat, 0x30003000, 0x1000,
-				BOOTMEM_DEFAULT);
-		reserve_bootmem_node(pgdat, 0x30081000, 0x1000,
-				BOOTMEM_DEFAULT);
-	}
-
-	if (machine_is_palmld() || machine_is_palmtx()) {
-		reserve_bootmem_node(pgdat, 0xa0000000, 0x1000,
-				BOOTMEM_EXCLUSIVE);
-		reserve_bootmem_node(pgdat, 0xa0200000, 0x1000,
-				BOOTMEM_EXCLUSIVE);
-	}
-
-	if (machine_is_treo680() || machine_is_centro()) {
-		reserve_bootmem_node(pgdat, 0xa0000000, 0x1000,
-				BOOTMEM_EXCLUSIVE);
-		reserve_bootmem_node(pgdat, 0xa2000000, 0x1000,
-				BOOTMEM_EXCLUSIVE);
-	}
-
-	if (machine_is_palmt5())
-		reserve_bootmem_node(pgdat, 0xa0200000, 0x1000,
-				BOOTMEM_EXCLUSIVE);
-
-	/*
-	 * U300 - This platform family can share physical memory
-	 * between two ARM cpus, one running Linux and the other
-	 * running another OS.
-	 */
-	if (machine_is_u300()) {
-#ifdef CONFIG_MACH_U300_SINGLE_RAM
-#if ((CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1) == 1) &&	\
-	CONFIG_MACH_U300_2MB_ALIGNMENT_FIX
-		res_size = 0x00100000;
-#endif
-#endif
-	}
+	lmb_reserve(__pa(swapper_pg_dir), PTRS_PER_PGD * sizeof(pgd_t));
 
 #ifdef CONFIG_SA1111
 	/*
 	 * Because of the SA1111 DMA bug, we want to preserve our
 	 * precious DMA-able memory...
 	 */
-	res_size = __pa(swapper_pg_dir) - PHYS_OFFSET;
+	lmb_reserve(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
 #endif
-	if (res_size)
-		reserve_bootmem_node(pgdat, PHYS_OFFSET, res_size,
-				BOOTMEM_DEFAULT);
 }
 
 /*
@@ -934,7 +868,7 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	/*
 	 * Allocate the vector page early.
 	 */
-	vectors = alloc_bootmem_low_pages(PAGE_SIZE);
+	vectors = early_alloc(PAGE_SIZE);
 
 	for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
@@ -1006,13 +940,46 @@ static void __init kmap_init(void)
 {
 #ifdef CONFIG_HIGHMEM
 	pmd_t *pmd = pmd_off_k(PKMAP_BASE);
-	pte_t *pte = alloc_bootmem_low_pages(2 * PTRS_PER_PTE * sizeof(pte_t));
+	pte_t *pte = early_alloc(2 * PTRS_PER_PTE * sizeof(pte_t));
 	BUG_ON(!pmd_none(*pmd) || !pte);
 	__pmd_populate(pmd, __pa(pte) | _PAGE_KERNEL_TABLE);
 	pkmap_page_table = pte + PTRS_PER_PTE;
 #endif
 }
 
+static inline void map_memory_bank(struct membank *bank)
+{
+	struct map_desc map;
+
+	map.pfn = bank_pfn_start(bank);
+	map.virtual = __phys_to_virt(bank_phys_start(bank));
+	map.length = bank_phys_size(bank);
+	map.type = MT_MEMORY;
+
+	create_mapping(&map);
+}
+
+static void __init map_lowmem(void)
+{
+	struct meminfo *mi = &meminfo;
+	int i;
+
+	/* Map all the lowmem memory banks. */
+	for (i = 0; i < mi->nr_banks; i++) {
+		struct membank *bank = &mi->bank[i];
+
+		if (!bank->highmem)
+			map_memory_bank(bank);
+	}
+}
+
+static int __init meminfo_cmp(const void *_a, const void *_b)
+{
+	const struct membank *a = _a, *b = _b;
+	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
+	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
+}
+
 /*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps, and sets up the zero page, bad page and bad page tables.
@@ -1021,20 +988,22 @@ void __init paging_init(struct machine_desc *mdesc)
 {
 	void *zero_page;
 
+	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
+
 	build_mem_type_table();
 	sanity_check_meminfo();
 	prepare_page_table();
-	bootmem_init();
+	map_lowmem();
 	devicemaps_init(mdesc);
 	kmap_init();
 
 	top_pmd = pmd_off_k(0xffff0000);
 
-	/*
-	 * allocate the zero page.  Note that this always succeeds and
-	 * returns a zeroed result.
-	 */
-	zero_page = alloc_bootmem_low_pages(PAGE_SIZE);
+	/* allocate the zero page. */
+	zero_page = early_alloc(PAGE_SIZE);
+
+	bootmem_init();
+
 	empty_zero_page = virt_to_page(zero_page);
 	__flush_dcache_page(NULL, empty_zero_page);
 }
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 9bfeb6b..ce00558 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -6,8 +6,8 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
-#include <linux/bootmem.h>
 #include <linux/io.h>
+#include <linux/lmb.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
@@ -17,30 +17,14 @@
 
 #include "mm.h"
 
-/*
- * Reserve the various regions of node 0
- */
-void __init reserve_node_zero(pg_data_t *pgdat)
+void __init arm_mm_lmb_reserve(void)
 {
 	/*
-	 * Register the kernel text and data with bootmem.
-	 * Note that this can only be in node 0.
-	 */
-#ifdef CONFIG_XIP_KERNEL
-	reserve_bootmem_node(pgdat, __pa(_data), _end - _data,
-			BOOTMEM_DEFAULT);
-#else
-	reserve_bootmem_node(pgdat, __pa(_stext), _end - _stext,
-			BOOTMEM_DEFAULT);
-#endif
-
-	/*
 	 * Register the exception vector page.
 	 * some architectures which the DRAM is the exception vector to trap,
 	 * alloc_page breaks with error, although it is not NULL, but "0."
 	 */
-	reserve_bootmem_node(pgdat, CONFIG_VECTORS_BASE, PAGE_SIZE,
-			BOOTMEM_DEFAULT);
+	lmb_reserve(CONFIG_VECTORS_BASE, PAGE_SIZE);
 }
 
 /*
