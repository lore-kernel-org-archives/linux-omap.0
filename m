From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 03/17] OMAP3: hwmod data: add DSS DISPC RFBI DSI
 VENC
Date: Mon, 10 Jan 2011 15:51:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101101535200.5731@utopia.booyaka.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com> <1294399551-10457-4-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40149 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010Ab1AJWvF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 17:51:05 -0500
In-Reply-To: <1294399551-10457-4-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: tomi.valkeinen@nokia.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hello Sumit, Senthilvadivu,

Here's a first pass of comments based on a preliminary review.

On Fri, 7 Jan 2011, Sumit Semwal wrote:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Hwmod needs database of all IPs in a system. This patch generates the hwmod
> database for Display Sub System applicable for OMAP3430-ES2 onwards and
> OMAP36xx.  DSS is also considered as an IP as DISPC, RFBI and named as dss_dss.
> For all the IP modules in DSS, same clock is needed for enabling. Hwmod sees
> DSS IPs as independent IPs, so same clock has to be repeated for .main_clk in
> each IP.
> 
> OMAP3430ES1 do not have IDLEST bit to poll on for dss IP.  So this hwmod is
> not applicable for 3430ES1.

DSS still exists on the ES1 chips.  So, this means that, after these 
patches, DSS won't be usable on 3430ES1.  Instead, please create separate 
copies of the struct omap_hwmod_ocp_if and omap_hwmod records, labeled 
with "omap3430es1", and label the others as "omap3430es2".  It should be 
possible to share most of the other data.

> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  339 ++++++++++++++++++++++++++++
>  1 files changed, 339 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 8d81813..5f5fbe8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -44,6 +44,11 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod;
>  static struct omap_hwmod omap3xxx_l4_core_hwmod;
>  static struct omap_hwmod omap3xxx_l4_per_hwmod;
>  static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
> +static struct omap_hwmod omap3xxx_dss_dss_hwmod;
> +static struct omap_hwmod omap3xxx_dss_dispc_hwmod;
> +static struct omap_hwmod omap3xxx_dss_dsi1_hwmod;
> +static struct omap_hwmod omap3xxx_dss_rfbi_hwmod;
> +static struct omap_hwmod omap3xxx_dss_venc_hwmod;
>  static struct omap_hwmod omap3xxx_i2c1_hwmod;
>  static struct omap_hwmod omap3xxx_i2c2_hwmod;
>  static struct omap_hwmod omap3xxx_i2c3_hwmod;
> @@ -84,6 +89,13 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_main_slaves[] = {
>  	&omap3xxx_mpu__l3_main,
>  };
>  
> +/* DSS -> l3 */
> +static struct omap_hwmod_ocp_if omap3xxx_dss__l3 = {
> +	.master		= &omap3xxx_dss_dss_hwmod,
> +	.slave		= &omap3xxx_l3_main_hwmod,
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  /* Master interfaces on the L3 interconnect */
>  static struct omap_hwmod_ocp_if *omap3xxx_l3_main_masters[] = {
>  	&omap3xxx_l3_main__l4_core,
> @@ -664,6 +676,326 @@ static struct omap_hwmod_class i2c_class = {
>  	.sysc = &i2c_sysc,
>  };
>  
> +/*
> + * 'dss' class
> + * display sub-system
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap3xxx_dss_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap3xxx_dss_hwmod_class = {
> +	.name = "dss",
> +	.sysc = &omap3xxx_dss_sysc,
> +};
> +
> +/* dss */
> +static struct omap_hwmod_irq_info omap3xxx_dss_irqs[] = {
> +	{ .irq = 25 },
> +};
> +
> +static struct omap_hwmod_dma_info omap3xxx_dss_sdma_chs[] = {
> +	{ .name = "dispc", .dma_req = 5 },
> +	{ .name = "dsi1", .dma_req = 74 },
> +};
> +
> +/* dss */
> +/* dss master ports */
> +static struct omap_hwmod_ocp_if *omap3xxx_dss_masters[] = {
> +	&omap3xxx_dss__l3,
> +};
> +
> +static struct omap_hwmod_addr_space omap3xxx_dss_addrs[] = {
> +	{
> +		.pa_start	= 0x48050000,
> +		.pa_end		= 0x480503FF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> dss */
> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &omap3xxx_dss_dss_hwmod,
> +	.clk		= "dss_ick",
> +	.addr		= omap3xxx_dss_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_addrs),

This struct omap_hwmod_ocp_if record is missing firewall data.
Please add.  See, for example, "omap3_l4_core__i2c1" in
mach-omap2/omap_hwmod_3xxx_data.c, for an example of how to add
this data.  Much of the data that you need can be found in Table
5-113 "Region Allocation for L4-Core Interconnect" of the
OMAP34xx TRM Rev. ZH [SWPU222H].

> +	.user		= OCP_USER_MPU,

Unless there's some reason why the SDMA can't access this module,
the .user field should be set to OCP_USER_MPU | OCP_USER_SDMA.

> +};
> +
> +/* dss slave ports */
> +static struct omap_hwmod_ocp_if *omap3xxx_dss_slaves[] = {
> +	&omap3xxx_l4_core__dss,
> +};
> +
> +static struct omap_hwmod_opt_clk dss_opt_clks[] = {
> +	{ .role = "tv_clk", .clk = "dss_tv_fck" },
> +	{ .role = "dssclk", .clk = "dss_96m_fck" },
> +	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
> +};
> +
> +static struct omap_hwmod omap3xxx_dss_dss_hwmod = {
> +	.name		= "dss_dss",
> +	.class		= &omap3xxx_dss_hwmod_class,
> +	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
> +	.mpu_irqs	= omap3xxx_dss_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dss_irqs),
> +	.sdma_reqs	= omap3xxx_dss_sdma_chs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_dss_sdma_chs),
> +

Please remove this extra blank line.

> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_DSS1_SHIFT,
> +			.module_offs = OMAP3430_DSS_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
> +		},
> +	},
> +	.opt_clks	= dss_opt_clks,
> +	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
> +	.slaves		= omap3xxx_dss_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_slaves),
> +	.masters	= omap3xxx_dss_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap3xxx_dss_masters),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2 |
> +				CHIP_IS_OMAP3630ES1 | CHIP_GE_OMAP3630ES1_1),
> +};
> +
> +/*
> + * 'dispc' class
> + * display controller
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap3xxx_dispc_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> +			   SYSC_HAS_MIDLEMODE | SYSC_HAS_ENAWAKEUP |
> +			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> +			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap3xxx_dispc_hwmod_class = {
> +	.name = "dispc",
> +	.sysc = &omap3xxx_dispc_sysc,
> +};
> +
> +static struct omap_hwmod_addr_space omap3xxx_dss_dispc_addrs[] = {
> +	{
> +		.pa_start	= 0x48050400,
> +		.pa_end		= 0x480507FF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> dss_dispc */
> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dispc = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &omap3xxx_dss_dispc_hwmod,

It appears, from reading Table 5-113 "Region Allocation for L4-Core 
Interconnect" of the OMAP34xx TRM Rev. ZH [SWPU222H], that there is only 
one L4 CORE port for the entire DSS.  However, the struct 
omap_hwmod_ocp_if data here claims that this submodule has its own L4 CORE 
port. Shouldn't this struct omap_hwmod_ocp_if record have 
omap3xxx_dss_dss_hwmod as its .master ?  See also Figure 15-69 "Display 
Subsystem Full Schematic".

> +	.clk		= "dss_ick",
> +	.addr		= omap3xxx_dss_dispc_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_dispc_addrs),

This struct omap_hwmod_ocp_if record is missing firewall data.
Please add.  See, for example, "omap3_l4_core__i2c1" in
mach-omap2/omap_hwmod_3xxx_data.c, for an example of how to add
this data.  Much of the data that you need can be found in Table
5-113 "Region Allocation for L4-Core Interconnect" of the
OMAP34xx TRM Rev. ZH [SWPU222H].

> +	.user		= OCP_USER_MPU,

Unless there's some reason why the SDMA can't access this module,
the .user field should be set to OCP_USER_MPU | OCP_USER_SDMA.

> +};
> +
> +/* dss_dispc slave ports */
> +static struct omap_hwmod_ocp_if *omap3xxx_dss_dispc_slaves[] = {
> +	&omap3xxx_l4_core__dss_dispc,
> +};
> +
> +static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
> +	.name		= "dss_dispc",
> +	.class		= &omap3xxx_dispc_hwmod_class,
> +	.main_clk	= "dss1_alwon_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_DSS1_SHIFT,
> +			.module_offs = OMAP3430_DSS_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
> +		},
> +	},
> +	.slaves		= omap3xxx_dss_dispc_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dispc_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2 |
> +				CHIP_IS_OMAP3630ES1 | CHIP_GE_OMAP3630ES1_1),
> +};
> +
> +/*
> + * 'dsi' class
> + * display serial interface controller
> + */
> +
> +static struct omap_hwmod_class omap3xxx_dsi_hwmod_class = {
> +	.name = "dsi",
> +};
> +
> +/* dss_dsi1 */
> +static struct omap_hwmod_addr_space omap3xxx_dss_dsi1_addrs[] = {
> +	{
> +		.pa_start	= 0x4804FC00,
> +		.pa_end		= 0x4804FFFF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> dss_dsi1 */
> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dsi1 = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &omap3xxx_dss_dsi1_hwmod,

It appears, from reading Table 5-113 "Region Allocation for L4-Core
Interconnect" of the OMAP34xx TRM Rev. ZH [SWPU222H], that there is only
one L4 CORE port for the entire DSS.  However, the struct
omap_hwmod_ocp_if data here claims that this submodule has its own L4 CORE
port. Shouldn't this struct omap_hwmod_ocp_if record have
omap3xxx_dss_dss_hwmod as its .master ?  See also Figure 15-69 "Display
Subsystem Full Schematic".

> +	.addr		= omap3xxx_dss_dsi1_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_dsi1_addrs),
> +	.user		= OCP_USER_MPU,

Unless there's some reason why the SDMA can't access this module,
the .user field should be set to OCP_USER_MPU | OCP_USER_SDMA.

> +};
> +
> +
> +/* dss_dsi1 slave ports */
> +static struct omap_hwmod_ocp_if *omap3xxx_dss_dsi1_slaves[] = {
> +	&omap3xxx_l4_core__dss_dsi1,
> +};
> +
> +static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
> +	.name		= "dss_dsi1",
> +	.class		= &omap3xxx_dsi_hwmod_class,
> +	.main_clk	= "dss1_alwon_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_DSS1_SHIFT,
> +			.module_offs = OMAP3430_DSS_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
> +		},
> +	},
> +	.slaves		= omap3xxx_dss_dsi1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dsi1_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2 |
> +				CHIP_IS_OMAP3630ES1 | CHIP_GE_OMAP3630ES1_1),
> +};
> +/*
> + * 'rfbi' class
> + * remote frame buffer interface
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap3xxx_rfbi_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> +			   SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap3xxx_rfbi_hwmod_class = {
> +	.name = "rfbi",
> +	.sysc = &omap3xxx_rfbi_sysc,
> +};
> +
> +static struct omap_hwmod_addr_space omap3xxx_dss_rfbi_addrs[] = {
> +	{
> +		.pa_start	= 0x48050800,
> +		.pa_end		= 0x48050BFF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> dss_rfbi */
> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_rfbi = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &omap3xxx_dss_rfbi_hwmod,

It appears, from reading Table 5-113 "Region Allocation for L4-Core
Interconnect" of the OMAP34xx TRM Rev. ZH [SWPU222H], that there is only
one L4 CORE port for the entire DSS.  However, the struct
omap_hwmod_ocp_if data here claims that this submodule has its own L4 CORE
port. Shouldn't this struct omap_hwmod_ocp_if record have
omap3xxx_dss_dss_hwmod as its .master ?  See also Figure 15-69 "Display
Subsystem Full Schematic".

> +	.clk		= "dss_ick",
> +	.addr		= omap3xxx_dss_rfbi_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_rfbi_addrs),

This struct omap_hwmod_ocp_if record is missing firewall data.
Please add.  See, for example, "omap3_l4_core__i2c1" in
mach-omap2/omap_hwmod_3xxx_data.c, for an example of how to add
this data.  Much of the data that you need can be found in Table
5-113 "Region Allocation for L4-Core Interconnect" of the
OMAP34xx TRM Rev. ZH [SWPU222H].

> +	.user		= OCP_USER_MPU,

Unless there's some reason why the SDMA can't access this module,
the .user field should be set to OCP_USER_MPU | OCP_USER_SDMA.

> +};
> +
> +/* dss_rfbi slave ports */
> +static struct omap_hwmod_ocp_if *omap3xxx_dss_rfbi_slaves[] = {
> +	&omap3xxx_l4_core__dss_rfbi,
> +};
> +
> +static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
> +	.name		= "dss_rfbi",
> +	.class		= &omap3xxx_rfbi_hwmod_class,
> +	.main_clk	= "dss1_alwon_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_DSS1_SHIFT,
> +			.module_offs = OMAP3430_DSS_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
> +		},
> +	},
> +	.slaves		= omap3xxx_dss_rfbi_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_rfbi_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2 |
> +				CHIP_IS_OMAP3630ES1 | CHIP_GE_OMAP3630ES1_1),
> +};
> +
> +/*
> + * 'venc' class
> + * video encoder
> + */
> +
> +static struct omap_hwmod_class omap3xxx_venc_hwmod_class = {
> +	.name = "venc",
> +};
> +
> +/* dss_venc */
> +static struct omap_hwmod_addr_space omap3xxx_dss_venc_addrs[] = {
> +	{
> +		.pa_start	= 0x48050C00,
> +		.pa_end		= 0x48050FFF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> dss_venc */
> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_venc = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &omap3xxx_dss_venc_hwmod,

It appears, from reading Table 5-113 "Region Allocation for L4-Core
Interconnect" of the OMAP34xx TRM Rev. ZH [SWPU222H], that there is only
one L4 CORE port for the entire DSS.  However, the struct
omap_hwmod_ocp_if data here claims that this submodule has its own L4 CORE
port. Shouldn't this struct omap_hwmod_ocp_if record have
omap3xxx_dss_dss_hwmod as its .master ?  See also Figure 15-69 "Display
Subsystem Full Schematic".

> +	.clk		= "dss_tv_fck",
> +	.addr		= omap3xxx_dss_venc_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_venc_addrs),

This struct omap_hwmod_ocp_if record is missing firewall data.
Please add.  See, for example, "omap3_l4_core__i2c1" in
mach-omap2/omap_hwmod_3xxx_data.c, for an example of how to add
this data.  Much of the data that you need can be found in Table
5-113 "Region Allocation for L4-Core Interconnect" of the
OMAP34xx TRM Rev. ZH [SWPU222H].

> +	.user		= OCP_USER_MPU,

Unless there's some reason why the SDMA can't access this module,
the .user field should be set to OCP_USER_MPU | OCP_USER_SDMA.

> +};
> +
> +/* dss_venc slave ports */
> +static struct omap_hwmod_ocp_if *omap3xxx_dss_venc_slaves[] = {
> +	&omap3xxx_l4_core__dss_venc,
> +};
> +
> +static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
> +	.name		= "dss_venc",
> +	.class		= &omap3xxx_venc_hwmod_class,
> +	.main_clk	= "dss1_alwon_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_DSS1_SHIFT,
> +			.module_offs = OMAP3430_DSS_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
> +		},
> +	},
> +	.slaves		= omap3xxx_dss_venc_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_venc_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2 |
> +				CHIP_IS_OMAP3630ES1 | CHIP_GE_OMAP3630ES1_1),
> +};
> +
>  /* I2C1 */
>  
>  static struct omap_i2c_dev_attr i2c1_dev_attr = {
> @@ -1368,6 +1700,13 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>  	&omap3xxx_uart2_hwmod,
>  	&omap3xxx_uart3_hwmod,
>  	&omap3xxx_uart4_hwmod,
> +	/* dss class */
> +	&omap3xxx_dss_dss_hwmod,
> +	&omap3xxx_dss_dispc_hwmod,
> +	&omap3xxx_dss_dsi1_hwmod,
> +	&omap3xxx_dss_rfbi_hwmod,
> +	&omap3xxx_dss_venc_hwmod,
> +	/* i2c class */
>  	&omap3xxx_i2c1_hwmod,
>  	&omap3xxx_i2c2_hwmod,
>  	&omap3xxx_i2c3_hwmod,
> -- 
> 1.7.0.4


- Paul
