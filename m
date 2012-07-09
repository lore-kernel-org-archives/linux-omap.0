From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Mon, 9 Jul 2012 19:56:58 +0530
Message-ID: <CAMQu2gyHTr8YrA9oiBw1op-QGXe_+izFWEK93q=B3a21pZEsjA@mail.gmail.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com> <20120709131156.GH1122@atomide.com>
 <20120709132501.GJ1122@atomide.com> <CAMQu2gyfh6+3KopeQFNFhKWdqJGK_AR=An19kKxt6n7Fv9iOUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:45014 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752349Ab2GIO1U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 10:27:20 -0400
Received: by qadz32 with SMTP id z32so1540403qad.7
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 07:27:18 -0700 (PDT)
In-Reply-To: <CAMQu2gyfh6+3KopeQFNFhKWdqJGK_AR=An19kKxt6n7Fv9iOUw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>

On Mon, Jul 9, 2012 at 6:56 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Mon, Jul 9, 2012 at 6:55 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Tony Lindgren <tony@atomide.com> [120709 06:17]:
>>> * Vaibhav Hiremath <hvaibhav@ti.com> [120709 01:55]:
>>> > On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
>>> > > --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
>>> > > +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
>>> > > @@ -39,6 +39,7 @@ struct omap_clk {
>>> > >  #define CK_443X          (1 << 11)
>>> > >  #define CK_TI816X        (1 << 12)
>>> > >  #define CK_446X          (1 << 13)
>>> > > +#define CK_54XX          (1 << 14)
>>> >
>>> > This is conflicting with AM33XX, you may want to rebase it again, since
>>> > AM33xx clock tree is already pushed and available in
>>> > linux-omap/devel-am33xx-part2.
>>>
>>> Heh these CK_XXXX defines are now running out of the u16 cpu_mask.
>>>
>>> They really should be replaced with SoC specific lists of clocks
>>> rather than bloating the cpu_mask and repeating it for every clock
>>> that's compiled in for 800+ times.
>>>
>>> Below (untested) is what could be done in the short term.
>>>
>>> I wonder if we could #define CK_OMAP_DUMMY 0 that's always set
>>> for non-shared clocks if they only get set in some *_data.c
>>> file in a unique way?
>>>
>>> Paul got any better ideas?
>>
>> Santosh, I suggest you just drop the CK_54XX change from your patches
>> as the clock fwk support will need further patching and is not used
>> yet.
>>
> Good idea. Will have a look at it.
>
I dropped the CK_54XX and RATE hunks from the patch. Updated
patch below for the record.

Regards
Santosh

-->>
>From 05e152c76a1efaa3165afecf5acf535c8283f386 Mon Sep 17 00:00:00 2001
From: R Sricharan <r.sricharan@ti.com>
Date: Tue, 5 Jun 2012 16:21:32 +0530
Subject: [PATCH 04/14] ARM: OMAP5: Add minimal support for OMAP5430 SOC

OMAP5430 is Texas Instrument's SOC based on ARM Cortex-A15 SMP
architecture. It's a dual core SOC with GIC used for interrupt
handling and with an integrated L2 cache controller.

OMAP5432 is another variant of OMAP5430, with a
memory controller supporting DDR3 and SATA.

Patch includes:
 - The machine specific headers and sources updates.
 - Platform header updates.
 - Minimum initialisation support for serial.
 - IO table init

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Makefile                   |   23 ++++++++++---
 arch/arm/mach-omap2/common.c                   |   24 +++++++++++++
 arch/arm/mach-omap2/common.h                   |   11 ++++++
 arch/arm/mach-omap2/include/mach/debug-macro.S |    8 ++---
 arch/arm/mach-omap2/io.c                       |   44 ++++++++++++++++++++++++
 arch/arm/mach-omap2/iomap.h                    |   27 +++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c               |    2 +-
 arch/arm/mach-omap2/prcm-common.h              |    2 +-
 arch/arm/mach-omap2/prcm.c                     |    2 +-
 arch/arm/plat-omap/include/plat/hardware.h     |    1 +
 arch/arm/plat-omap/include/plat/multi.h        |    9 +++++
 arch/arm/plat-omap/include/plat/omap54xx.h     |   32 +++++++++++++++++
 arch/arm/plat-omap/include/plat/serial.h       |   10 ++++++
 arch/arm/plat-omap/include/plat/uncompress.h   |    6 ++++
 arch/arm/plat-omap/sram.c                      |   11 ++++--
 15 files changed, 198 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap54xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 240f196..085e171 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_AM33XX) += irq.o $(hwmod-common)
+obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o $(hwmod-common) $(secure-common)

 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
@@ -29,8 +30,10 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o

 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
-obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o
-obj-$(CONFIG_ARCH_OMAP4)		+= sleep44xx.o
+omap-4-5-common				=  omap4-common.o omap-wakeupgen.o \
+					   sleep44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common)
+obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common)

 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
@@ -70,6 +73,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= cpuidle34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
+obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
 obj-$(CONFIG_ARCH_OMAP4)		+= cpuidle44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
@@ -85,14 +89,16 @@ endif
 endif

 # PRCM
+omap-prcm-4-5-common			=  prcm.o cminst44xx.o cm44xx.o \
+					   prcm_mpu44xx.o prminst44xx.o \
+					   vc44xx_data.o vp44xx_data.o
 obj-y					+= prm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cminst44xx.o cm44xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= prcm_mpu44xx.o prminst44xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= vc44xx_data.o vp44xx_data.o prm44xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= prcm.o prm33xx.o cm33xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common) prm44xx.o
+obj-$(CONFIG_SOC_OMAP5)			+= $(omap-prcm-4-5-common)

 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
@@ -104,6 +110,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
 obj-$(CONFIG_SOC_AM33XX)                += voltagedomains33xx_data.o
+obj-$(CONFIG_SOC_OMAP5)			+= $(voltagedomain-common)

 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
@@ -121,6 +128,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(powerdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= powerdomain33xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= powerdomains33xx_data.o
+obj-$(CONFIG_SOC_OMAP5)			+= $(powerdomain-common)
+obj-$(CONFIG_SOC_OMAP5)			+= powerdomain44xx.o

 # PRCM clockdomain control
 clockdomain-common			+= clockdomain.o
@@ -139,6 +148,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomain33xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomains33xx_data.o
+obj-$(CONFIG_SOC_OMAP5)			+= $(clockdomain-common)
+obj-$(CONFIG_SOC_OMAP5)			+= clockdomain44xx.o

 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
@@ -157,6 +168,8 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
+obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
+obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o

 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 73d2a0b..069f972 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -178,3 +178,27 @@ void __init omap4_map_io(void)
 }
 #endif

+#if defined(CONFIG_SOC_OMAP5)
+static struct omap_globals omap5_globals = {
+	.class	= OMAP54XX_CLASS,
+	.tap	= OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
+	.ctrl_pad	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
+	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE),
+	.prcm_mpu = OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE),
+};
+
+void __init omap2_set_globals_5xxx(void)
+{
+	omap2_set_globals_tap(&omap5_globals);
+	omap2_set_globals_control(&omap5_globals);
+	omap2_set_globals_prcm(&omap5_globals);
+}
+
+void __init omap5_map_io(void)
+{
+	omap5_map_common_io();
+}
+#endif
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 404f172..399e5bb 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -115,6 +115,14 @@ static inline int omap_mux_late_init(void)
 }
 #endif

+#ifdef CONFIG_SOC_OMAP5
+extern void omap5_map_common_io(void);
+#else
+static inline void omap5_map_common_io(void)
+{
+}
+#endif
+
 extern void omap2_init_common_infrastructure(void);

 extern struct sys_timer omap2_timer;
@@ -134,6 +142,7 @@ void am35xx_init_early(void);
 void ti81xx_init_early(void);
 void am33xx_init_early(void);
 void omap4430_init_early(void);
+void omap5_init_early(void);
 void omap3_init_late(void);	/* Do not use this one */
 void omap4430_init_late(void);
 void omap2420_init_late(void);
@@ -169,6 +178,7 @@ void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
+void omap2_set_globals_5xxx(void);
 void omap2_set_globals_ti81xx(void);
 void omap2_set_globals_am33xx(void);

@@ -188,6 +198,7 @@ void omap243x_map_io(void);
 void omap3_map_io(void);
 void am33xx_map_io(void);
 void omap4_map_io(void);
+void omap5_map_io(void);
 void ti81xx_map_io(void);
 void omap_barriers_init(void);

diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S
b/arch/arm/mach-omap2/include/mach/debug-macro.S
index d7f844a..93d10de 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -60,12 +60,12 @@ omap_uart_lsr:	.word	0
 		beq	23f			@ configure OMAP2UART3
 		cmp	\rp, #OMAP3UART3	@ only on 34xx
 		beq	33f			@ configure OMAP3UART3
-		cmp	\rp, #OMAP4UART3	@ only on 44xx
-		beq	43f			@ configure OMAP4UART3
+		cmp	\rp, #OMAP4UART3	@ only on 44xx/54xx
+		beq	43f			@ configure OMAP4/5UART3
 		cmp	\rp, #OMAP3UART4	@ only on 36xx
 		beq	34f			@ configure OMAP3UART4
-		cmp	\rp, #OMAP4UART4	@ only on 44xx
-		beq	44f			@ configure OMAP4UART4
+		cmp	\rp, #OMAP4UART4	@ only on 44xx/54xx
+		beq	44f			@ configure OMAP4/5UART4
 		cmp	\rp, #TI81XXUART1	@ ti81Xx UART offsets different
 		beq	81f			@ configure UART1
 		cmp	\rp, #TI81XXUART2	@ ti81Xx UART offsets different
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index cb6c11c..8976be9 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -233,6 +233,35 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 };
 #endif

+#ifdef	CONFIG_SOC_OMAP5
+static struct map_desc omap54xx_io_desc[] __initdata = {
+	{
+		.virtual	= L3_54XX_VIRT,
+		.pfn		= __phys_to_pfn(L3_54XX_PHYS),
+		.length		= L3_54XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= L4_54XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_54XX_PHYS),
+		.length		= L4_54XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= L4_WK_54XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_WK_54XX_PHYS),
+		.length		= L4_WK_54XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= L4_PER_54XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_PER_54XX_PHYS),
+		.length		= L4_PER_54XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+#endif
+
 #ifdef CONFIG_SOC_OMAP2420
 void __init omap242x_map_common_io(void)
 {
@@ -278,6 +307,12 @@ void __init omap44xx_map_common_io(void)
 }
 #endif

+#ifdef CONFIG_SOC_OMAP5
+void __init omap5_map_common_io(void)
+{
+	iotable_init(omap54xx_io_desc, ARRAY_SIZE(omap54xx_io_desc));
+}
+#endif
 /*
  * omap2_init_reprogram_sdrc - reprogram SDRC timing parameters
  *
@@ -513,6 +548,15 @@ void __init omap4430_init_late(void)
 }
 #endif

+#ifdef CONFIG_SOC_OMAP5
+void __init omap5_init_early(void)
+{
+	omap2_set_globals_5xxx();
+	omap5xxx_check_revision();
+	omap_common_init_early();
+}
+#endif
+
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
 {
diff --git a/arch/arm/mach-omap2/iomap.h b/arch/arm/mach-omap2/iomap.h
index 80b8892..cce2b65 100644
--- a/arch/arm/mach-omap2/iomap.h
+++ b/arch/arm/mach-omap2/iomap.h
@@ -1,6 +1,14 @@
 /*
  * IO mappings for OMAP2+
  *
+ * IO definitions for TI OMAP processors and boards
+ *
+ * Copied from arch/arm/mach-sa1100/include/mach/io.h
+ * Copyright (C) 1997-1999 Russell King
+ *
+ * Copyright (C) 2009-2012 Texas Instruments
+ * Added OMAP4/5 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2 of the License, or (at your
@@ -166,4 +174,23 @@
 						/* 0x49000000 --> 0xfb000000 */
 #define L4_ABE_44XX_VIRT	(L4_ABE_44XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_ABE_44XX_SIZE	SZ_1M
+/*
+ * ----------------------------------------------------------------------------
+ * Omap5 specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
+#define L3_54XX_PHYS		L3_54XX_BASE	/* 0x44000000 --> 0xf8000000 */
+#define L3_54XX_VIRT		(L3_54XX_PHYS + OMAP4_L3_IO_OFFSET)
+#define L3_54XX_SIZE		SZ_1M
+
+#define L4_54XX_PHYS		L4_54XX_BASE	/* 0x4a000000 --> 0xfc000000 */
+#define L4_54XX_VIRT		(L4_54XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_54XX_SIZE		SZ_4M
+
+#define L4_WK_54XX_PHYS		L4_WK_54XX_BASE	/* 0x4ae00000 --> 0xfce00000 */
+#define L4_WK_54XX_VIRT		(L4_WK_54XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_WK_54XX_SIZE		SZ_2M

+#define L4_PER_54XX_PHYS	L4_PER_54XX_BASE /* 0x48000000 --> 0xfa000000 */
+#define L4_PER_54XX_VIRT	(L4_PER_54XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_PER_54XX_SIZE	SZ_4M
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ff76ef1..2ada364 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3619,7 +3619,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
-	} else if (cpu_is_omap44xx()) {
+	} else if (cpu_is_omap44xx() || soc_is_omap54xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
diff --git a/arch/arm/mach-omap2/prcm-common.h
b/arch/arm/mach-omap2/prcm-common.h
index 6da3ba4..44485a8 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -416,7 +416,7 @@ extern void __iomem *cm_base;
 extern void __iomem *cm2_base;
 extern void __iomem *prcm_mpu_base;

-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_OMAP5)
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 extern void omap_prm_base_init(void);
 extern void omap_cm_base_init(void);
 #else
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 28cbfb2..053e24e 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -160,7 +160,7 @@ void __init omap2_set_globals_prcm(struct
omap_globals *omap2_globals)
 	if (omap2_globals->prcm_mpu)
 		prcm_mpu_base = omap2_globals->prcm_mpu;

-	if (cpu_is_omap44xx()) {
+	if (cpu_is_omap44xx() || soc_is_omap54xx()) {
 		omap_prm_base_init();
 		omap_cm_base_init();
 	}
diff --git a/arch/arm/plat-omap/include/plat/hardware.h
b/arch/arm/plat-omap/include/plat/hardware.h
index e897978..ddbde38 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -288,5 +288,6 @@
 #include <plat/omap44xx.h>
 #include <plat/ti81xx.h>
 #include <plat/am33xx.h>
+#include <plat/omap54xx.h>

 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/plat/multi.h
b/arch/arm/plat-omap/include/plat/multi.h
index 999ffba..045e320 100644
--- a/arch/arm/plat-omap/include/plat/multi.h
+++ b/arch/arm/plat-omap/include/plat/multi.h
@@ -99,4 +99,13 @@
 # endif
 #endif

+#ifdef CONFIG_SOC_OMAP5
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap5
+# endif
+#endif
+
 #endif	/* __PLAT_OMAP_MULTI_H */
diff --git a/arch/arm/plat-omap/include/plat/omap54xx.h
b/arch/arm/plat-omap/include/plat/omap54xx.h
new file mode 100644
index 0000000..a2582bb
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/omap54xx.h
@@ -0,0 +1,32 @@
+/*:
+ * Address mappings and base address for OMAP5 interconnects
+ * and peripherals.
+ *
+ * Copyright (C) 2012 Texas Instruments
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *	Sricharan <r.sricharan@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_SOC_OMAP54XX_H
+#define __ASM_SOC_OMAP54XX_H
+
+/*
+ * Please place only base defines here and put the rest in device
+ * specific headers.
+ */
+#define L4_54XX_BASE			0x4a000000
+#define L4_WK_54XX_BASE			0x4ae00000
+#define L4_PER_54XX_BASE		0x48000000
+#define L3_54XX_BASE			0x44000000
+#define OMAP54XX_32KSYNCT_BASE		0x4ae04000
+#define OMAP54XX_CM_CORE_AON_BASE	0x4a004000
+#define OMAP54XX_CM_CORE_BASE		0x4a008000
+#define OMAP54XX_PRM_BASE		0x4ae06000
+#define OMAP54XX_PRCM_MPU_BASE		0x48243000
+#define OMAP54XX_SCM_BASE		0x4a002000
+#define OMAP54XX_CTRL_BASE		0x4a002800
+
+#endif /* __ASM_SOC_OMAP555554XX_H */
diff --git a/arch/arm/plat-omap/include/plat/serial.h
b/arch/arm/plat-omap/include/plat/serial.h
index 28e2d25..65fce44 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -63,6 +63,14 @@
 /* AM33XX serial port */
 #define AM33XX_UART1_BASE	0x44E09000

+/* OMAP5 serial ports */
+#define OMAP5_UART1_BASE	OMAP2_UART1_BASE
+#define OMAP5_UART2_BASE	OMAP2_UART2_BASE
+#define OMAP5_UART3_BASE	OMAP4_UART3_BASE
+#define OMAP5_UART4_BASE	OMAP4_UART4_BASE
+#define OMAP5_UART5_BASE	0x48066000
+#define OMAP5_UART6_BASE	0x48068000
+
 /* External port on Zoom2/3 */
 #define ZOOM_UART_BASE		0x10000000
 #define ZOOM_UART_VIRT		0xfa400000
@@ -97,6 +105,8 @@
 #define TI81XXUART2		82
 #define TI81XXUART3		83
 #define AM33XXUART1		84
+#define OMAP5UART3		OMAP4UART3
+#define OMAP5UART4		OMAP4UART4
 #define ZOOM_UART		95		/* Only on zoom2/3 */

 /* This is only used by 8250.c for omap1510 */
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h
b/arch/arm/plat-omap/include/plat/uncompress.h
index ac43233..b8d19a1 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -95,6 +95,9 @@ static inline void flush(void)
 	_DEBUG_LL_ENTRY(mach, OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT,	\
 		OMAP4UART##p)

+#define DEBUG_LL_OMAP5(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP5_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP5UART##p)
 /* Zoom2/3 shift is different for UART1 and external port */
 #define DEBUG_LL_ZOOM(mach)						\
 	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
@@ -177,6 +180,9 @@ static inline void __arch_decomp_setup(unsigned
long arch_id)
 		DEBUG_LL_OMAP4(3, omap_4430sdp);
 		DEBUG_LL_OMAP4(3, omap4_panda);

+		/* omap5 based boards using UART3 */
+		DEBUG_LL_OMAP5(3, omap5_sevm);
+
 		/* zoom2/3 external uart */
 		DEBUG_LL_ZOOM(omap_zoom2);
 		DEBUG_LL_ZOOM(omap_zoom3);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 70cf825..766181c 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -6,8 +6,8 @@
  * Copyright (C) 2005 Nokia Corporation
  * Written by Tony Lindgren <tony@atomide.com>
  *
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * Copyright (C) 2009-2012 Texas Instruments
+ * Added OMAP4/5 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -44,6 +44,7 @@
 #else
 #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
 #endif
+#define OMAP5_SRAM_PA		0x40300000

 #if defined(CONFIG_ARCH_OMAP2PLUS)
 #define SRAM_BOOTLOADER_SZ	0x00
@@ -118,6 +119,9 @@ static void __init omap_detect_sram(void)
 			} else if (cpu_is_omap44xx()) {
 				omap_sram_start = OMAP4_SRAM_PUB_PA;
 				omap_sram_size = 0xa000; /* 40K */
+			} else if (soc_is_omap54xx()) {
+				omap_sram_start = OMAP5_SRAM_PA;
+				omap_sram_size = SZ_128K; /* 128KB */
 			} else {
 				omap_sram_start = OMAP2_SRAM_PUB_PA;
 				omap_sram_size = 0x800; /* 2K */
@@ -132,6 +136,9 @@ static void __init omap_detect_sram(void)
 			} else if (cpu_is_omap44xx()) {
 				omap_sram_start = OMAP4_SRAM_PA;
 				omap_sram_size = 0xe000; /* 56K */
+			} else if (soc_is_omap54xx()) {
+				omap_sram_start = OMAP5_SRAM_PA;
+				omap_sram_size = SZ_128K; /* 128KB */
 			} else {
 				omap_sram_start = OMAP2_SRAM_PA;
 				if (cpu_is_omap242x())
-- 
1.7.9.5
