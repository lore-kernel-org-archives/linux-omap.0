From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Thu, 30 Sep 2010 00:58:12 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF2DAF53@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>	<87d3rxblfu.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF48@dbde02.ent.ti.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF49@dbde02.ent.ti.com>
 <87bp7gz7by.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57300 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755350Ab0I2T2l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 15:28:41 -0400
In-Reply-To: <87bp7gz7by.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, September 30, 2010 12:49 AM
> To: Nayak, Rajendra; Raja, Govindraj
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; Varadarajan, Charulatha
> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
> 
> "Nayak, Rajendra" <rnayak@ti.com> writes:
> 
> [...]
> 
> >
> > I forgot to mention, there are similar WARN's that I see on 2430sdp even with UART
> >
> 
> Govidraj, can you look into these UART issues please?
> 
> Looks like you might need to double check the bitfields and the
> module_offs for both of these.

Btw, the WARN's come only for UART3 and the error at hwmod init shows that
maybe _wait_target_ready fails.

[    0.000000] NR_IRQS:402
[    0.000000] Clocking rate (Crystal/DPLL/MPU): 13.0/660/330 MHz
[    0.000000] omap_hwmod: uart3: cannot be enabled (3)

> 
> Thanks,
> 
> Kevin
> 
> > [    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1237 _omap_hwmod_idle+0x28/0xd8()
> > [    0.000000] omap_hwmod: uart3: idle state can only be entered from enabled state
> > [    0.000000] Modules linked in:
> > [    0.000000] [<c0053478>] (unwind_backtrace+0x0/0xe4) from [<c00897f4>]
> (warn_slowpath_common+0x4c/0x64)
> > [    0.000000] [<c00897f4>] (warn_slowpath_common+0x4c/0x64) from [<c008988c>]
> (warn_slowpath_fmt+0x2c/0x3c)
> > [    0.000000] [<c008988c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c005d138>]
> (_omap_hwmod_idle+0x28/0xd8)
> > [    0.000000] [<c005d138>] (_omap_hwmod_idle+0x28/0xd8) from [<c005d210>]
> (omap_hwmod_idle+0x28/0x38)
> > [    0.000000] [<c005d210>] (omap_hwmod_idle+0x28/0x38) from [<c000fd48>]
> (omap_serial_init_port+0x164/0x42c)
> > [    0.000000] [<c000fd48>] (omap_serial_init_port+0x164/0x42c) from [<c0010028>]
> (omap_serial_init+0x18/0x40)
> > [    0.000000] [<c0010028>] (omap_serial_init+0x18/0x40) from [<c0012a44>] (omap_2430sdp_init+0x48/0xcc)
> > [    0.000000] [<c0012a44>] (omap_2430sdp_init+0x48/0xcc) from [<c000b650>]
> (customize_machine+0x18/0x24)
> > [    0.000000] [<c000b650>] (customize_machine+0x18/0x24) from [<c004c578>] (do_one_initcall+0xcc/0x1a4)
> > [    0.000000] [<c004c578>] (do_one_initcall+0xcc/0x1a4) from [<c00085e0>] (kernel_init+0x148/0x210)
> > [    0.000000] [<c00085e0>] (kernel_init+0x148/0x210) from [<c004dcb8>] (kernel_thread_exit+0x0/0x8)
> > [    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1237 _omap_hwmod_idle+0x28/0xd8()
> > [    0.000000] omap_hwmod: uart3: idle state can only be entered from enabled state
> > [    0.000000] Modules linked in:
> > [    0.000000] [<c0053478>] (unwind_backtrace+0x0/0xe4) from [<c00897f4>]
> (warn_slowpath_common+0x4c/0x64)
> > [    0.000000] [<c00897f4>] (warn_slowpath_common+0x4c/0x64) from [<c008988c>]
> (warn_slowpath_fmt+0x2c/0x3c)
> > [    0.000000] [<c008988c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c005d138>]
> (_omap_hwmod_idle+0x28/0xd8)
> > [    0.000000] [<c005d138>] (_omap_hwmod_idle+0x28/0xd8) from [<c0058c48>] (uart_idle_hwmod+0x10/0x18)
> > [    0.000000] [<c0058c48>] (uart_idle_hwmod+0x10/0x18) from [<c006a994>]
> (_omap_device_deactivate+0x58/0x144)
> > [    0.000000] [<c006a994>] (_omap_device_deactivate+0x58/0x144) from [<c006ac44>]
> (omap_device_idle+0x48/0x68)
> > [    0.000000] [<c006ac44>] (omap_device_idle+0x48/0x68) from [<c000ff08>]
> (omap_serial_init_port+0x324/0x42c)
> > [    0.000000] [<c000ff08>] (omap_serial_init_port+0x324/0x42c) from [<c0010028>]
> (omap_serial_init+0x18/0x40)
> > [    0.000000] [<c0010028>] (omap_serial_init+0x18/0x40) from [<c0012a44>] (omap_2430sdp_init+0x48/0xcc)
> > [    0.000000] [<c0012a44>] (omap_2430sdp_init+0x48/0xcc) from [<c000b650>]
> (customize_machine+0x18/0x24)
> > [    0.000000] [<c000b650>] (customize_machine+0x18/0x24) from [<c004c578>] (do_one_initcall+0xcc/0x1a4)
> > [    0.000000] [<c004c578>] (do_one_initcall+0xcc/0x1a4) from [<c00085e0>] (kernel_init+0x148/0x210)
> > [    0.000000] [<c00085e0>] (kernel_init+0x148/0x210) from [<c004dcb8>] (kernel_thread_exit+0x0/0x8)
> > [    0.000000] ---[ end trace 1b75b31a2719ed1d ]---
> >>
> >>
> >> diff --git a/arch/arm/mach-omap2/cm-regbits-24xx.h b/arch/arm/mach-omap2/cm-regbits-24xx.h
> >> index 5986e2b..9a106c0 100644
> >> --- a/arch/arm/mach-omap2/cm-regbits-24xx.h
> >> +++ b/arch/arm/mach-omap2/cm-regbits-24xx.h
> >> @@ -126,12 +126,12 @@
> >>  #define OMAP24XX_ST_HDQ_MASK				(1 << 23)
> >>  #define OMAP2420_ST_I2C2_SHIFT				20
> >>  #define OMAP2420_ST_I2C2_MASK				(1 << 20)
> >> -#define OMAP2430_ST_I2CHS1_SHIFT			20
> >> -#define OMAP2430_ST_I2CHS1_MASK				(1 << 20)
> >> +#define OMAP2430_ST_I2CHS1_SHIFT			19
> >> +#define OMAP2430_ST_I2CHS1_MASK				(1 << 19)
> >>  #define OMAP2420_ST_I2C1_SHIFT				19
> >>  #define OMAP2420_ST_I2C1_MASK				(1 << 19)
> >> -#define OMAP2430_ST_I2CHS2_SHIFT			19
> >> -#define OMAP2430_ST_I2CHS2_MASK				(1 << 19)
> >> +#define OMAP2430_ST_I2CHS2_SHIFT			20
> >> +#define OMAP2430_ST_I2CHS2_MASK				(1 << 20)
> >>  #define OMAP24XX_ST_MCBSP2_SHIFT			16
> >>  #define OMAP24XX_ST_MCBSP2_MASK				(1 << 16)
> >>  #define OMAP24XX_ST_MCBSP1_SHIFT			15
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-
> omap2/omap_hwmod_2420_data.c
> >> index 8bf46c1..ca4edd3 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >> @@ -504,6 +504,7 @@ static struct omap_hwmod omap2420_i2c1_hwmod = {
> >>  	.main_clk	= "i2c1_fck",
> >>  	.prcm		= {
> >>  		.omap2 = {
> >> +			.module_offs = CORE_MOD,
> >>  			.prcm_reg_id = 1,
> >>  			.module_bit = OMAP2420_EN_I2C1_SHIFT,
> >>  			.idlest_reg_id = 1,
> >> @@ -541,6 +542,7 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
> >>  	.main_clk	= "i2c2_fck",
> >>  	.prcm		= {
> >>  		.omap2 = {
> >> +			.module_offs = CORE_MOD,
> >>  			.prcm_reg_id = 1,
> >>  			.module_bit = OMAP2420_EN_I2C2_SHIFT,
> >>  			.idlest_reg_id = 1,
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-
> omap2/omap_hwmod_2430_data.c
> >> index 92f4ec0..9498847 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> >> @@ -502,7 +502,7 @@ static struct omap_hwmod omap2430_i2c1_hwmod = {
> >>  	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
> >>  	.sdma_reqs	= i2c1_sdma_reqs,
> >>  	.sdma_reqs_cnt	= ARRAY_SIZE(i2c1_sdma_reqs),
> >> -	.main_clk	= "i2c1_fck",
> >> +	.main_clk	= "i2chs1_fck",
> >>  	.prcm		= {
> >>  		.omap2 = {
> >>  			/*
> >> @@ -513,6 +513,7 @@ static struct omap_hwmod omap2430_i2c1_hwmod = {
> >>  			 * additonal flags when clk handling is moved
> >>  			 * to hwmod framework.
> >>  			 */
> >> +			.module_offs = CORE_MOD,
> >>  			.prcm_reg_id = 1,
> >>  			.module_bit = OMAP2430_EN_I2CHS1_SHIFT,
> >>  			.idlest_reg_id = 1,
> >> @@ -551,9 +552,10 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
> >>  	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
> >>  	.sdma_reqs	= i2c2_sdma_reqs,
> >>  	.sdma_reqs_cnt	= ARRAY_SIZE(i2c2_sdma_reqs),
> >> -	.main_clk	= "i2c2_fck",
> >> +	.main_clk	= "i2chs2_fck",
> >>  	.prcm		= {
> >>  		.omap2 = {
> >> +			.module_offs = CORE_MOD,
> >>  			.prcm_reg_id = 1,
> >>  			.module_bit = OMAP2430_EN_I2CHS2_SHIFT,
> >>  			.idlest_reg_id = 1,
> >> >
> >> > >
> >> > > >> Note this also depends on a handful of patches from my pm-backports
> >> > > >> branch, most of which you have picked into omap-testing, except for the
> >> > > >> one I just posted to linux-arm-kernel:
> >> > > >>
> >> > > >>    ARM: add cpu_idle_wait() to support CPUidle on SMP systems.
> >> > > >>
> >> > > >> This one is required now that the default config enables SMP.
> >> > > >
> >> > > > I'll apply that into omap-testing branch.
> >> > >
> >> > > Thanks,
> >> > >
> >> > > Kevin
