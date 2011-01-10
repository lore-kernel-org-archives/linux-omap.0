From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 01/17] OMAP2420: hwmod data: add DSS DISPC RFBI VENC
Date: Mon, 10 Jan 2011 16:21:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101101555150.5731@utopia.booyaka.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com> <1294399551-10457-2-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34570 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab1AJXVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 18:21:16 -0500
In-Reply-To: <1294399551-10457-2-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: tomi.valkeinen@nokia.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hello Sumit, Senthilvadivu,

here are some initial comments based on a preliminary review.

On Fri, 7 Jan 2011, Sumit Semwal wrote:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Hwmod needs database of all IPs in a system. This patch generates the hwmod
> database for OMAP2420 Display Sub System,. Since DSS is also considered as an
> IP as DISPC, RFBI, name it as dss_dss.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  283 ++++++++++++++++++++++++++++
>  1 files changed, 283 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index b85c630..14ae4a8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -38,6 +38,10 @@ static struct omap_hwmod omap2420_mpu_hwmod;
>  static struct omap_hwmod omap2420_iva_hwmod;
>  static struct omap_hwmod omap2420_l3_main_hwmod;
>  static struct omap_hwmod omap2420_l4_core_hwmod;
> +static struct omap_hwmod omap2420_dss_dss_hwmod;
> +static struct omap_hwmod omap2420_dss_dispc_hwmod;
> +static struct omap_hwmod omap2420_dss_rfbi_hwmod;
> +static struct omap_hwmod omap2420_dss_venc_hwmod;
>  static struct omap_hwmod omap2420_wd_timer2_hwmod;
>  static struct omap_hwmod omap2420_gpio1_hwmod;
>  static struct omap_hwmod omap2420_gpio2_hwmod;
> @@ -64,6 +68,13 @@ static struct omap_hwmod_ocp_if *omap2420_l3_main_slaves[] = {
>  	&omap2420_mpu__l3_main,
>  };
>  
> +/* DSS -> l3 */
> +static struct omap_hwmod_ocp_if omap2420_dss__l3 = {
> +	.master		= &omap2420_dss_dss_hwmod,
> +	.slave		= &omap2420_l3_main_hwmod,
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  /* Master interfaces on the L3 interconnect */
>  static struct omap_hwmod_ocp_if *omap2420_l3_main_masters[] = {
>  	&omap2420_l3_main__l4_core,
> @@ -470,6 +481,272 @@ static struct omap_hwmod omap2420_uart3_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
>  };
>  
> +/*
> + * 'dss' class
> + * display sub-system
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap2420_dss_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap2420_dss_hwmod_class = {
> +	.name = "dss",
> +	.sysc = &omap2420_dss_sysc,
> +};
> +
> +/* dss */
> +static struct omap_hwmod_irq_info omap2420_dss_irqs[] = {
> +	{ .irq = 25 },
> +};
> +
> +static struct omap_hwmod_dma_info omap2420_dss_sdma_chs[] = {
> +	{ .name = "dispc", .dma_req = 5 },
> +};
> +
> +/* dss */
> +/* dss master ports */
> +static struct omap_hwmod_ocp_if *omap2420_dss_masters[] = {
> +	&omap2420_dss__l3,
> +};
> +
> +static struct omap_hwmod_addr_space omap2420_dss_addrs[] = {
> +	{
> +		.pa_start	= 0x48050000,
> +		.pa_end		= 0x480503FF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> dss */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__dss = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_dss_dss_hwmod,
> +	.clk		= "dss_ick",
> +	.addr		= omap2420_dss_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_dss_addrs),

This struct omap_hwmod_ocp_if record is missing firewall data.
Please add.  See, for example, "omap3_l4_core__i2c1" in
mach-omap2/omap_hwmod_3xxx_data.c, for an example of how to add
this data.  Much of the data that you need can be found in Table
6-194 "L4 Interconnect Detailed Memory Mapping" of the OMAP242x TRM Rev. X
[SWPU064X].

> +	.user		= OCP_USER_MPU,

Unless there's some reason why the SDMA can't access this module,
the .user field should be set to OCP_USER_MPU | OCP_USER_SDMA.

> +};
> +
> +/* dss slave ports */
> +static struct omap_hwmod_ocp_if *omap2420_dss_slaves[] = {
> +	&omap2420_l4_core__dss,
> +};
> +
> +static struct omap_hwmod_opt_clk dss_opt_clks[] = {
> +	{ .role = "tv_clk", .clk = "dss_54m_fck" },
> +	{ .role = "sys_clk", .clk = "dss2_fck" },
> +};
> +
> +static struct omap_hwmod omap2420_dss_dss_hwmod = {
> +	.name		= "dss_dss",
> +	.class		= &omap2420_dss_hwmod_class,
> +	.main_clk	= "dss1_fck", /* instead of dss_fck */
> +	.mpu_irqs	= omap2420_dss_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_dss_irqs),
> +	.sdma_reqs	= omap2420_dss_sdma_chs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_dss_sdma_chs),
> +

Please remove this extra blank line.

> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
> +			.module_offs = CORE_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_DSS_SHIFT,

This should be .idlest_stdby_bit; see below.

> +		},
> +	},
> +	.opt_clks	= dss_opt_clks,
> +	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
> +	.slaves		= omap2420_dss_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_slaves),
> +	.masters	= omap2420_dss_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap2420_dss_masters),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +	.flags		= HWMOD_NO_IDLEST,

No hwmod should define .idlest_idle_bit and set HWMOD_NO_IDLEST; they are 
mutually exclusive.  In this case, looking at the definition of ST_DSS in 
the TRM, it is defined as the module's standby status, so it is 
appropriate to leave HWMOD_NO_IDLEST set here, but the assignment of 
.idlest_idle_bit above is incorrect.

> +};
> +
> +/*
> + * 'dispc' class
> + * display controller
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap2420_dispc_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
> +			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> +			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap2420_dispc_hwmod_class = {
> +	.name = "dispc",
> +	.sysc = &omap2420_dispc_sysc,
> +};
> +
> +static struct omap_hwmod_addr_space omap2420_dss_dispc_addrs[] = {
> +	{
> +		.pa_start	= 0x48050400,
> +		.pa_end		= 0x480507FF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> dss_dispc */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__dss_dispc = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_dss_dispc_hwmod,

It appears, from reading Table 6-194 "L4 Interconnect Detailed
Memory Mapping" of the OMAP242x TRM Rev. X [SWPU064X], that there
is only one L4 CORE port for the entire DSS.  However, the struct
omap_hwmod_ocp_if data here claims that this submodule has its
own L4 CORE port. Shouldn't this struct omap_hwmod_ocp_if record
have omap2420_dss_dss_hwmod as its .master ?  See also Figure
17-2 "Display Subsystem Schematic".

> +	.clk		= "dss_ick",
> +	.addr		= omap2420_dss_dispc_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_dss_dispc_addrs),

This struct omap_hwmod_ocp_if record is missing firewall data.
Please add.  See, for example, "omap3_l4_core__i2c1" in
mach-omap2/omap_hwmod_3xxx_data.c, for an example of how to add
this data.  Much of the data that you need can be found in Table
6-194 "L4 Interconnect Detailed Memory Mapping" of the OMAP242x TRM Rev. X
[SWPU064X].

> +	.user		= OCP_USER_MPU,

Unless there's some reason why the SDMA can't access this module,
the .user field should be set to OCP_USER_MPU | OCP_USER_SDMA.

> +};
> +
> +/* dss_dispc slave ports */
> +static struct omap_hwmod_ocp_if *omap2420_dss_dispc_slaves[] = {
> +	&omap2420_l4_core__dss_dispc,
> +};
> +
> +static struct omap_hwmod omap2420_dss_dispc_hwmod = {
> +	.name		= "dss_dispc",
> +	.class		= &omap2420_dispc_hwmod_class,
> +	.main_clk	= "dss1_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
> +			.module_offs = CORE_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_DSS_SHIFT,

This should be .idlest_stdby_bit; see below.

> +		},
> +	},
> +	.slaves		= omap2420_dss_dispc_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_dispc_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +	.flags		= HWMOD_NO_IDLEST,

No hwmod should define .idlest_idle_bit and set HWMOD_NO_IDLEST; they are
mutually exclusive.  In this case, looking at the definition of ST_DSS in
the TRM, it is defined as the module's standby status, so it is
appropriate to leave HWMOD_NO_IDLEST set here, but the assignment of
.idlest_idle_bit above is incorrect.

> +};
> +
> +/*
> + * 'rfbi' class
> + * remote frame buffer interface
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap2420_rfbi_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> +			   SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap2420_rfbi_hwmod_class = {
> +	.name = "rfbi",
> +	.sysc = &omap2420_rfbi_sysc,
> +};
> +
> +static struct omap_hwmod_addr_space omap2420_dss_rfbi_addrs[] = {
> +	{
> +		.pa_start	= 0x48050800,
> +		.pa_end		= 0x48050BFF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> dss_rfbi */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__dss_rfbi = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_dss_rfbi_hwmod,

It appears, from reading Table 6-194 "L4 Interconnect Detailed
Memory Mapping" of the OMAP242x TRM Rev. X [SWPU064X], that there
is only one L4 CORE port for the entire DSS.  However, the struct
omap_hwmod_ocp_if data here claims that this submodule has its
own L4 CORE port. Shouldn't this struct omap_hwmod_ocp_if record
have omap2420_dss_dss_hwmod as its .master ?  See also Figure
17-2 "Display Subsystem Schematic".

> +	.clk		= "dss_ick",
> +	.addr		= omap2420_dss_rfbi_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_dss_rfbi_addrs),

This struct omap_hwmod_ocp_if record is missing firewall data.
Please add.  See, for example, "omap3_l4_core__i2c1" in
mach-omap2/omap_hwmod_3xxx_data.c, for an example of how to add
this data.  Much of the data that you need can be found in Table
6-194 "L4 Interconnect Detailed Memory Mapping" of the OMAP242x TRM Rev. X
[SWPU064X].

> +	.user		= OCP_USER_MPU,

Unless there's some reason why the SDMA can't access this module,
the .user field should be set to OCP_USER_MPU | OCP_USER_SDMA.

> +};
> +
> +/* dss_rfbi slave ports */
> +static struct omap_hwmod_ocp_if *omap2420_dss_rfbi_slaves[] = {
> +	&omap2420_l4_core__dss_rfbi,
> +};
> +
> +static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
> +	.name		= "dss_rfbi",
> +	.class		= &omap2420_rfbi_hwmod_class,
> +	.main_clk	= "dss1_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
> +			.module_offs = CORE_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_DSS_SHIFT,

I don't think this module should have .idlest_idle_bit, .idlest_stdby_bit, 
or .idlest_reg_id set.  From my reading of the OMAP242x TRM Rev. X 
[SWPU064X], particularly Figure 17-2 "Display Subsystem Schematic", it 
appears that the L3 initiator interface is only connected to the DISPC 
module and possibly the main DSS module.

> +		},
> +	},
> +	.slaves		= omap2420_dss_rfbi_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_rfbi_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +	.flags		= HWMOD_NO_IDLEST,
> +};
> +
> +/*
> + * 'venc' class
> + * video encoder
> + */
> +
> +static struct omap_hwmod_class omap2420_venc_hwmod_class = {
> +	.name = "venc",
> +};
> +
> +/* dss_venc */
> +static struct omap_hwmod_addr_space omap2420_dss_venc_addrs[] = {
> +	{
> +		.pa_start	= 0x48050C00,
> +		.pa_end		= 0x48050FFF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> dss_venc */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__dss_venc = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_dss_venc_hwmod,

It appears, from reading Table 6-194 "L4 Interconnect Detailed
Memory Mapping" of the OMAP242x TRM Rev. X [SWPU064X], that there
is only one L4 CORE port for the entire DSS.  However, the struct
omap_hwmod_ocp_if data here claims that this submodule has its
own L4 CORE port. Shouldn't this struct omap_hwmod_ocp_if record
have omap2420_dss_dss_hwmod as its .master ?  See also Figure
17-2 "Display Subsystem Schematic".

> +	.clk		= "dss_54m_fck",
> +	.addr		= omap2420_dss_venc_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_dss_venc_addrs),

This struct omap_hwmod_ocp_if record is missing firewall data. Please add.  
See, for example, "omap3_l4_core__i2c1" in 
mach-omap2/omap_hwmod_3xxx_data.c, for an example of how to add this data.  
Much of the data that you need can be found in Table 6-194 "L4 
Interconnect Detailed Memory Mapping" of the OMAP242x TRM Rev. X 
[SWPU064X].

> +	.user		= OCP_USER_MPU,

Unless there's some reason why the SDMA can't access this module,
the .user field should be set to OCP_USER_MPU | OCP_USER_SDMA.

> +};
> +
> +/* dss_venc slave ports */
> +static struct omap_hwmod_ocp_if *omap2420_dss_venc_slaves[] = {
> +	&omap2420_l4_core__dss_venc,
> +};
> +
> +static struct omap_hwmod omap2420_dss_venc_hwmod = {
> +	.name		= "dss_venc",
> +	.class		= &omap2420_venc_hwmod_class,
> +	.main_clk	= "dss1_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
> +			.module_offs = CORE_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_DSS_SHIFT,

I don't think this module should have .idlest_idle_bit, .idlest_stdby_bit,
or .idlest_reg_id set.  From my reading of the OMAP242x TRM Rev. X
[SWPU064X], particularly Figure 17-2 "Display Subsystem Schematic", it
appears that the L3 initiator interface is only connected to the DISPC
module and possibly the main DSS module.

> +		},
> +	},
> +	.slaves		= omap2420_dss_venc_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_venc_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +	.flags		= HWMOD_NO_IDLEST,
> +};
> +
>  /* I2C common */
>  static struct omap_hwmod_class_sysconfig i2c_sysc = {
>  	.rev_offs	= 0x00,
> @@ -874,6 +1151,12 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
>  	&omap2420_uart1_hwmod,
>  	&omap2420_uart2_hwmod,
>  	&omap2420_uart3_hwmod,
> +	/* dss class */
> +	&omap2420_dss_dss_hwmod,
> +	&omap2420_dss_dispc_hwmod,
> +	&omap2420_dss_rfbi_hwmod,
> +	&omap2420_dss_venc_hwmod,
> +	/* i2c class */
>  	&omap2420_i2c1_hwmod,
>  	&omap2420_i2c2_hwmod,
>  
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
