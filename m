From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [RFC] io.c for OMAP3430
Date: Wed, 30 May 2007 22:38:17 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701062ED3@dlee13.ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701062E30@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701062E30@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all:

>
>>		if (cpu_is_omap242x()) {
>>			iotable_init(omap242x_io_desc,
>>ARRAY_SIZE(omap242x_io_desc));
>>		} else if (cpu_is_omap243x()) {
>>			iotable_init(omap243x_io_desc,
>>ARRAY_SIZE(omap243x_io_desc));
>>		}
>We cannot put this kind of check in common_io function. I was trying to
>validate 2420 / 2430 platforms and I found that "cpu_is_" function =
calls
>returning "0" (when "1" was expected).

Please let me know your views on the following approach for io.c.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

/*
 * linux/arch/arm/mach-omap2/io.c
 *
 * OMAP2 I/O mapping code
 *
 * Copyright (C) 2005 Nokia Corporation
 * Copyright (C) 2007 Texas Instruments
 *
 * Author:
 *	Juha Yrjola <juha.yrjola@nokia.com>
 *	Syed Khasim <x0khasim@ti.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

#include <asm/tlb.h>
#include <asm/io.h>

#include <asm/mach/map.h>

#include <asm/arch/mux.h>
#include <asm/arch/omapfb.h>

extern void omap_sram_init(void);
extern int omap2_clk_init(void);
extern void omap2_check_revision(void);
extern void omap2_init_memory(void);
extern void gpmc_init(void);
extern void omapfb_reserve_sdram(void);

/*
 * The machine specific code may provide the extra mapping besides the
 * default mapping provided here.
 */

#ifdef CONFIG_ARCH_OMAP24XX
static struct map_desc omap24xx_io_desc[] __initdata =3D {
	{
		.virtual	=3D L3_24XX_VIRT,
		.pfn		=3D __phys_to_pfn(L3_24XX_PHYS),
		.length		=3D L3_24XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D L4_24XX_VIRT,
		.pfn		=3D __phys_to_pfn(L4_24XX_PHYS),
		.length		=3D L4_24XX_SIZE,
		.type		=3D MT_DEVICE
	},
};

#ifdef CONFIG_ARCH_OMAP2420
static struct map_desc omap242x_io_desc[] __initdata =3D {
	{
		.virtual	=3D DSP_MEM_24XX_VIRT,
		.pfn		=3D __phys_to_pfn(DSP_MEM_24XX_PHYS),
		.length		=3D DSP_MEM_24XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D DSP_IPI_24XX_VIRT,
		.pfn		=3D __phys_to_pfn(DSP_IPI_24XX_PHYS),
		.length		=3D DSP_IPI_24XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D DSP_MMU_24XX_VIRT,
		.pfn		=3D __phys_to_pfn(DSP_MMU_24XX_PHYS),
		.length		=3D DSP_MMU_24XX_SIZE,
		.type		=3D MT_DEVICE
	},
};

#endif

#ifdef CONFIG_ARCH_OMAP2430
static struct map_desc omap243x_io_desc[] __initdata =3D {
	{
		.virtual	=3D L4_WK_243X_VIRT,
		.pfn		=3D __phys_to_pfn(L4_WK_243X_PHYS),
		.length		=3D L4_WK_243X_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP243X_GPMC_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP243X_GPMC_PHYS),
		.length		=3D OMAP243X_GPMC_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP243X_SDRC_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP243X_SDRC_PHYS),
		.length		=3D OMAP243X_SDRC_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP243X_SMS_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP243X_SMS_PHYS),
		.length		=3D OMAP243X_SMS_SIZE,
		.type		=3D MT_DEVICE
	},
};
#endif
#endif

#ifdef	CONFIG_ARCH_OMAP34XX
static struct map_desc omap34xx_io_desc[] __initdata =3D {
	{
		.virtual	=3D L3_34XX_VIRT,
		.pfn		=3D __phys_to_pfn(L3_34XX_PHYS),
		.length		=3D L3_34XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D L4_34XX_VIRT,
		.pfn		=3D __phys_to_pfn(L4_34XX_PHYS),
		.length		=3D L4_34XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D L4_WK_34XX_VIRT,
		.pfn		=3D __phys_to_pfn(L4_WK_34XX_PHYS),
		.length		=3D L4_WK_34XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP34XX_GPMC_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP34XX_GPMC_PHYS),
		.length		=3D OMAP34XX_GPMC_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP343X_SMS_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP343X_SMS_PHYS),
		.length		=3D OMAP343X_SMS_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP343X_SDRC_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP343X_SDRC_PHYS),
		.length		=3D OMAP343X_SDRC_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D L4_PER_34XX_VIRT,
		.pfn		=3D __phys_to_pfn(L4_PER_34XX_PHYS),
		.length		=3D L4_PER_34XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D L4_EMU_34XX_VIRT,
		.pfn		=3D __phys_to_pfn(L4_EMU_34XX_PHYS),
		.length		=3D L4_EMU_34XX_SIZE,
		.type		=3D MT_DEVICE
	},
};
#endif

void __init omap2_map_common_io(void)
{
#if defined(CONFIG_ARCH_OMAP2420)
	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
#elif defined(CONFIG_ARCH_OMAP2430)
	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
#elif defined(CONFIG_ARCH_OMAP34XX)
	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
#endif
	/* Normally devicemaps_init() would flush caches and tlb after
	 * mdesc->map_io(), but we must also do it here because of the CPU
	 * revision check below.
	 */
	local_flush_tlb_all();
	flush_cache_all();

	omap2_check_revision();
	omap_sram_init();
	omapfb_reserve_sdram();
}

void __init omap2_init_common_hw(void)
{
	omap2_mux_init();
	omap2_clk_init();
	omap2_init_memory();
	gpmc_init();
}
