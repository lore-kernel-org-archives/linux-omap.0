From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Add dm816x hwmod support
Date: Fri, 23 Jan 2015 10:28:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501230918390.5450@utopia.booyaka.com>
References: <1421191355-12835-1-git-send-email-tony@atomide.com> <1421191355-12835-3-git-send-email-tony@atomide.com> <20150114194301.GR2419@atomide.com> <20150117163144.GQ18552@atomide.com> <20150121043436.GP7718@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34170 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbbAWK2o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2015 05:28:44 -0500
In-Reply-To: <20150121043436.GP7718@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aida Mynzhasova <aida.mynzhasova@skitlab.ru>, Brian Hutchinson <b.hutchman@gmail.com>

Hi Tony

just a few brief comments

On Tue, 20 Jan 2015, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [150117 08:38]:
> > 
> > And the sysc and syss offsets for mcspi1 need 0x100 added to them for
> > it to work, like on am33xx. Updated patch below.
> 
> Here's this one updated with the alwon_l3s_clkdm naming changes
> Paul commented in the related clockdomain patch.
> 
> Regards,
> 
> Tony
> 
> 8< --------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 20 Jan 2015 18:24:47 -0800
> Subject: [PATCH] ARM: OMAP2+: Add dm816x hwmod support
> 
> Add minimal hwmod support that works at least on dm8168. This
> is based on the code in the earlier TI CDP tree, and an earlier
> patch by Aida Mynzhasova <aida.mynzhasova@skitlab.ru>.
> 
> I've set up things to work pretty much the same way as for
> am33xx. We are basically using cm33xx.c with a different set
> of clocks and clockdomains.
> 
> This code is based on the TI81XX-LINUX-PSP-04.04.00.02 patches
> published at:
> 
> http://downloads.ti.com/dsps/dsps_public_sw/psp/LinuxPSP/TI81XX_04_04/04_04_00_02/index_FDS.html
> 
> Cc: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -121,6 +121,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common)
>  obj-$(CONFIG_SOC_OMAP5)			+= $(omap-prcm-4-5-common)
>  obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-prcm-4-5-common)
>  am33xx-43xx-prcm-common			+= prm33xx.o cm33xx.o
> +obj-$(CONFIG_SOC_TI81XX)		+= $(am33xx-43xx-prcm-common)
>  obj-$(CONFIG_SOC_AM33XX)		+= $(am33xx-43xx-prcm-common)
>  obj-$(CONFIG_SOC_AM43XX)		+= $(omap-prcm-4-5-common) \
>  					   $(am33xx-43xx-prcm-common)
> @@ -225,6 +226,7 @@ obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_43xx_ipblock_data.o
>  obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_43xx_data.o
>  obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_33xx_43xx_interconnect_data.o
>  obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_33xx_43xx_ipblock_data.o
> +obj-$(CONFIG_SOC_TI81XX)		+= omap_hwmod_81xx_data.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
>  obj-$(CONFIG_SOC_OMAP5)			+= omap_hwmod_54xx_data.o
>  obj-$(CONFIG_SOC_DRA7XX)		+= omap_hwmod_7xx_data.o
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index ed3e6e8f..e60780f 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -545,10 +545,12 @@ void __init ti814x_init_early(void)
>  	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
>  	omap3xxx_check_revision();
>  	ti81xx_check_features();
> +	am33xx_prm_init();
> +	am33xx_cm_init();
>  	omap3xxx_voltagedomains_init();
>  	omap3xxx_powerdomains_init();
>  	ti81xx_clockdomains_init();
> -	omap3xxx_hwmod_init();
> +	ti81xx_hwmod_init();
>  	omap_hwmod_init_postsetup();
>  	if (of_have_populated_dt())
>  		omap_clk_soc_init = ti81xx_dt_clk_init;
> @@ -564,10 +566,12 @@ void __init ti816x_init_early(void)
>  	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
>  	omap3xxx_check_revision();
>  	ti81xx_check_features();
> +	am33xx_prm_init();
> +	am33xx_cm_init();
>  	omap3xxx_voltagedomains_init();
>  	omap3xxx_powerdomains_init();
>  	ti81xx_clockdomains_init();
> -	omap3xxx_hwmod_init();
> +	ti81xx_hwmod_init();
>  	omap_hwmod_init_postsetup();
>  	if (of_have_populated_dt())
>  		omap_clk_soc_init = ti81xx_dt_clk_init;
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 1c0cb48..be50454 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -3916,7 +3916,7 @@ void __init omap_hwmod_init(void)
>  		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
>  		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
>  		soc_ops.init_clkdm = _init_clkdm;
> -	} else if (soc_is_am33xx()) {
> +	} else if (cpu_is_ti816x() || soc_is_am33xx()) {
>  		soc_ops.enable_module = _omap4_enable_module;
>  		soc_ops.disable_module = _omap4_disable_module;
>  		soc_ops.wait_target_ready = _omap4_wait_target_ready;
> --- a/arch/arm/mach-omap2/omap_hwmod.h
> +++ b/arch/arm/mach-omap2/omap_hwmod.h
> @@ -748,6 +748,7 @@ extern int omap3xxx_hwmod_init(void);
>  extern int omap44xx_hwmod_init(void);
>  extern int omap54xx_hwmod_init(void);
>  extern int am33xx_hwmod_init(void);
> +extern int ti81xx_hwmod_init(void);
>  extern int dra7xx_hwmod_init(void);
>  int am43xx_hwmod_init(void);
>  
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> @@ -0,0 +1,1025 @@
> +/*
> + * DM81xx hwmod data.
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
> + * Copyright (C) 2013 SKTB SKiT, http://www.skitlab.ru/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/platform_data/gpio-omap.h>
> +#include <linux/platform_data/hsmmc-omap.h>
> +#include <linux/platform_data/spi-omap2-mcspi.h>
> +#include <plat/dmtimer.h>
> +
> +#include "omap_hwmod_common_data.h"
> +#include "cm81xx.h"
> +#include "ti81xx.h"
> +#include "wd_timer.h"
> +
> +/*
> + * DM816X hardware modules integration data
> + *
> + * Note: This is incomplete and at present, not generated from h/w database.
> + *
> + * The .clkctrl_offs field is offset from the CM_ALWON, so basically the
> + * TRM 18.7.17 CM_ALWON device register values minus 0x1400.
> + */
> +
> +/* L3 Interconnect entries */
> +static struct omap_hwmod dm816x_l3_s_hwmod = {
> +	.name		= "l3_s",

Would suggest naming this l3_slow

> +	.clkdm_name	= "alwon_l3s_clkdm",
> +	.class		= &l3_hwmod_class,
> +	.flags		= HWMOD_NO_IDLEST,
> +};
> +
> +static struct omap_hwmod __used dm816x_l3_med_hwmod = {

Hmm, why __used for this -- maybe just add it to the hwmod list at the 
bottom?

> +	.name		= "l3_med",
> +	.clkdm_name	= "alwon_l3_med_clkdm",
> +	.class		= &l3_hwmod_class,
> +	.flags		= HWMOD_NO_IDLEST,
> +};
> +
> +static struct omap_hwmod __used dm816x_l3_fast_hwmod = {

Same __used comment as above.

> +	.name		= "l3_fast",
> +	.clkdm_name	= "alwon_l3_fast_clkdm",
> +	.class		= &l3_hwmod_class,
> +	.flags		= HWMOD_NO_IDLEST,
> +};
> +
> +/*
> + * L4 standard peripherals, see TRM table 1-12 for devices using this.
> + * Devices using this have 125MHz SYSCLK5 clock.
> + */
> +static struct omap_hwmod dm816x_l4_ls_hwmod = {
> +	.name		= "l4_ls",
> +	.clkdm_name	= "alwon_l3s_clkdm",
> +	.class		= &l4_hwmod_class,
> +	.flags		= HWMOD_NO_IDLEST,

Section 18.7.17.46 "CM_ALWON_L3_CLKCTRL Register" lists an IDLEST bitfield 
for this.

> +};
> +
> +/*
> + * L4 high-speed peripherals. For devices using this, please see the TRM
> + * "Table 1-13. L4 High-Speed Peripheral Memory Map". On dm816x, only
> + * EMAC, MDIO and SATA use this.
> + */
> +static struct omap_hwmod dm816x_l4_hs_hwmod = {
> +	.name		= "l4_hs",
> +	.clkdm_name	= "alwon_l3_med_clkdm",
> +	.class		= &l4_hwmod_class,
> +	.flags		= HWMOD_NO_IDLEST,

Section 18.7.17.47 "CM_ALWON_L4HS_CLKCTRL Register" lists an IDLEST 
bitfield for this.

> +};
> +
> +/* L3 SLOW -> L4 ls peripheral interface */
> +static struct omap_hwmod_ocp_if dm816x_l3_s__l4_ls = {
> +	.master	= &dm816x_l3_s_hwmod,
> +	.slave	= &dm816x_l4_ls_hwmod,
> +	.user	= OCP_USER_MPU,
> +};
> +
> +/* MPU */
> +static struct omap_hwmod dm816x_mpu_hwmod = {
> +	.name		= "mpu",
> +	.clkdm_name	= "alwon_mpu_clkdm",
> +	.class		= &mpu_hwmod_class,
> +	.flags		= HWMOD_INIT_NO_IDLE,
> +	.main_clk	= "mpu_ck",
> +	.prcm		= {
> +		.omap4 = {
> +			.clkctrl_offs = 0x1dc,

In the other hwmod data files, we've used macros here - easier to review. 
I'm not going to try to doublecheck these numeric constants here...

> +			.modulemode = MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if dm816x_mpu__l3_slow = {
> +	.master		= &dm816x_mpu_hwmod,
> +	.slave		= &dm816x_l3_s_hwmod,
> +	.user		= OCP_USER_MPU,
> +};

The 816x TRM is pretty crappy when it comes to integration documentation, 
so it's not so easy to figure out what IP blocks are connected to which 
initiators.  (Maybe it doesn't even matter that much in the long run; I 
doubt anyone is going to spend much time on PM or DMA path hacking for 
these DM816x chips.)  Anyway, I think it's pretty safe to assume that any 
IP block with a 128-bit or 64-bit initiator port onto the interconnect 
probably isn't connected to the L3 Slow interconnect.  So looking at 
Figure 1-75 "L3 Interconnect Block Diagram" and Section 1.11.2.2 "L3 Port 
Mapping" this includes the MPU L3 port, HDVICP2-{0,1,2} initiator ports, 
IOMMU, DSP, TPTC, TPCC, VPSS M0/M1 ports, SGX, Media Controller, expansion 
slot 0 initiator, EMIF0/1, and PCIe.    Similarly I'd assume that anything 
with a 128-bit target port off of the interconnect is on the L3 Fast: DMM 
T0/T1, HDVICP-{0,1,2} target ports, DSP SDMA, expansion slot 0 target.


One should be able to cross-check these in two ways: first, by clocking, 
by looking at Table 1-73 "System Clock Domains" and Figure 1-68 "Detailed 
Clock Architecture".  The L3 Fast is driven by SYSCLK4, so anything with 
an interface clock of SYSCLK4 is probably hanging off the L3 Fast.  A 
SYSCLK5 interface clock probably means either L3 Medium or L4 HS.  
SYSCLK6 interface clocks likely mean either L3 Slow or L4 LS.

The other way to cross-check these is by the address ranges in Section 1.5 
"Memory Map".   This looks primarily useful for L4 HS/L4 LS...

Glancing at Table 1-73, it looks to me like a reasonable rule of thumb 
would be that anything with a 128-bit interconnect port is probably on L3 
Fast, anything with a 64-bit interconnect port is probably on L3 Medium, 
and anything with a 32-bit port on the L3 is probably on L3 Slow.

> +
> +/* UART common */
> +static struct omap_hwmod_class_sysconfig uart_sysc = {
> +	.rev_offs	= 0x50,
> +	.sysc_offs	= 0x54,
> +	.syss_offs	= 0x58,
> +	.sysc_flags	= SYSC_HAS_SIDLEMODE |
> +				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> +				 SYSC_HAS_AUTOIDLE,

Also SYSS_HAS_RESET_STATUS should be set, according to Table 23-44 "System 
Status Register (SYSS) Field Descriptions"

> +	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,

Also SIDLE_SMART_WKUP is supported, according to Table 23-43 "System 
Configuration Register (SYSC) Field Descriptions"

> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class uart_class = {
> +	.name = "uart",
> +	.sysc = &uart_sysc,
> +};
> +
> +static struct omap_hwmod dm816x_uart1_hwmod = {
> +	.name		= "uart1",
> +	.clkdm_name	= "alwon_l3s_clkdm",
> +	.main_clk	= "sysclk10_ck",
> +	.prcm		= {
> +		.omap4 = {
> +			.clkctrl_offs = 0x150,
> +			.modulemode = MODULEMODE_SWCTRL,
> +		},
> +	},
> +	.class		= &uart_class,
> +	.flags		= DEBUG_TI81XXUART1_FLAGS,
> +};
> +
> +static struct omap_hwmod_ocp_if dm816x_l4_ls__uart1 = {
> +	.master		= &dm816x_l4_ls_hwmod,
> +	.slave		= &dm816x_uart1_hwmod,
> +	.clk		= "sysclk6_ck",
> +	.user		= OCP_USER_MPU,

Probably OCP_USER_SDMA should be set here too (although I don't think 
we're using this flag at present, and we may not even be doing DMA to/from 
the serial ports)

...

Am not going to go through the rest at the moment, but you might want
to check the above issues with the rest of the file also.


- Paul
