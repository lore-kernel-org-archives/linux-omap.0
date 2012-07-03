From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: temporarily remove data for the
 usb_host_fs and aess IP blocks
Date: Tue, 3 Jul 2012 09:57:00 +0200
Message-ID: <4FF2A5CC.80400@ti.com>
References: <alpine.DEB.2.00.1206292151290.2338@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44690 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756361Ab2GCH5M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jul 2012 03:57:12 -0400
In-Reply-To: <alpine.DEB.2.00.1206292151290.2338@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 06/30/2012 05:53 AM, Paul Walmsley wrote:
>
> The OMAP4 usb_host_fs (OHCI) and AESS IP blocks require some special
> programming for them to enter idle.  Without this programming, they
> will prevent the rest of the chip from entering full chip idle.
>
> To implement the idle programming cleanly, this will take some
> coordination between maintainers.  This is likely to take some time,
> so it is probably best to leave this for 3.6 or 3.7.  So, in the
> meantime, simply remove this data.

I'd rather keep the data and comment the ocp_if entry.
We can even add a disclaimer on top to explain the reason.

It will be less confusing for the driver folks that are currently=20
working on the AESS support.

It will as well minimize the churn.

Regards,
Benoit

> Later, once the appropriate support is available, this patch can be
> reverted.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=EEt Cousson <b-cousson@ti.com>
> ---
> Intended for v3.5-rc.
>
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  178 -----------------=
-----------
>   1 file changed, 178 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index f30e861..95cbfe6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -296,60 +296,6 @@ static struct omap_hwmod omap44xx_ocp_wp_noc_hwm=
od =3D {
>    */
>
>   /*
> - * 'aess' class
> - * audio engine sub system
> - */
> -
> -static struct omap_hwmod_class_sysconfig omap44xx_aess_sysc =3D {
> -	.rev_offs	=3D 0x0000,
> -	.sysc_offs	=3D 0x0010,
> -	.sysc_flags	=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
> -	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART |
> -			   MSTANDBY_SMART_WKUP),
> -	.sysc_fields	=3D &omap_hwmod_sysc_type2,
> -};
> -
> -static struct omap_hwmod_class omap44xx_aess_hwmod_class =3D {
> -	.name	=3D "aess",
> -	.sysc	=3D &omap44xx_aess_sysc,
> -};
> -
> -/* aess */
> -static struct omap_hwmod_irq_info omap44xx_aess_irqs[] =3D {
> -	{ .irq =3D 99 + OMAP44XX_IRQ_GIC_START },
> -	{ .irq =3D -1 }
> -};
> -
> -static struct omap_hwmod_dma_info omap44xx_aess_sdma_reqs[] =3D {
> -	{ .name =3D "fifo0", .dma_req =3D 100 + OMAP44XX_DMA_REQ_START },
> -	{ .name =3D "fifo1", .dma_req =3D 101 + OMAP44XX_DMA_REQ_START },
> -	{ .name =3D "fifo2", .dma_req =3D 102 + OMAP44XX_DMA_REQ_START },
> -	{ .name =3D "fifo3", .dma_req =3D 103 + OMAP44XX_DMA_REQ_START },
> -	{ .name =3D "fifo4", .dma_req =3D 104 + OMAP44XX_DMA_REQ_START },
> -	{ .name =3D "fifo5", .dma_req =3D 105 + OMAP44XX_DMA_REQ_START },
> -	{ .name =3D "fifo6", .dma_req =3D 106 + OMAP44XX_DMA_REQ_START },
> -	{ .name =3D "fifo7", .dma_req =3D 107 + OMAP44XX_DMA_REQ_START },
> -	{ .dma_req =3D -1 }
> -};
> -
> -static struct omap_hwmod omap44xx_aess_hwmod =3D {
> -	.name		=3D "aess",
> -	.class		=3D &omap44xx_aess_hwmod_class,
> -	.clkdm_name	=3D "abe_clkdm",
> -	.mpu_irqs	=3D omap44xx_aess_irqs,
> -	.sdma_reqs	=3D omap44xx_aess_sdma_reqs,
> -	.main_clk	=3D "aess_fck",
> -	.prcm =3D {
> -		.omap4 =3D {
> -			.clkctrl_offs =3D OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
> -			.context_offs =3D OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
> -			.modulemode   =3D MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/*
>    * 'c2c' class
>    * chip 2 chip interface used to plug the ape soc (omap) with an ex=
ternal modem
>    * soc
> @@ -3285,55 +3231,6 @@ static struct omap_hwmod omap44xx_uart4_hwmod =
=3D {
>   };
>
>   /*
> - * 'usb_host_fs' class
> - * full-speed usb host controller
> - */
> -
> -/* The IP is not compliant to type1 / type2 scheme */
> -static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_usb_host_f=
s =3D {
> -	.midle_shift	=3D 4,
> -	.sidle_shift	=3D 2,
> -	.srst_shift	=3D 1,
> -};
> -
> -static struct omap_hwmod_class_sysconfig omap44xx_usb_host_fs_sysc =3D=
 {
> -	.rev_offs	=3D 0x0000,
> -	.sysc_offs	=3D 0x0210,
> -	.sysc_flags	=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
> -			   SYSC_HAS_SOFTRESET),
> -	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			   SIDLE_SMART_WKUP),
> -	.sysc_fields	=3D &omap_hwmod_sysc_type_usb_host_fs,
> -};
> -
> -static struct omap_hwmod_class omap44xx_usb_host_fs_hwmod_class =3D =
{
> -	.name	=3D "usb_host_fs",
> -	.sysc	=3D &omap44xx_usb_host_fs_sysc,
> -};
> -
> -/* usb_host_fs */
> -static struct omap_hwmod_irq_info omap44xx_usb_host_fs_irqs[] =3D {
> -	{ .name =3D "std", .irq =3D 89 + OMAP44XX_IRQ_GIC_START },
> -	{ .name =3D "smi", .irq =3D 90 + OMAP44XX_IRQ_GIC_START },
> -	{ .irq =3D -1 }
> -};
> -
> -static struct omap_hwmod omap44xx_usb_host_fs_hwmod =3D {
> -	.name		=3D "usb_host_fs",
> -	.class		=3D &omap44xx_usb_host_fs_hwmod_class,
> -	.clkdm_name	=3D "l3_init_clkdm",
> -	.mpu_irqs	=3D omap44xx_usb_host_fs_irqs,
> -	.main_clk	=3D "usb_host_fs_fck",
> -	.prcm =3D {
> -		.omap4 =3D {
> -			.clkctrl_offs =3D OMAP4_CM_L3INIT_USB_HOST_FS_CLKCTRL_OFFSET,
> -			.context_offs =3D OMAP4_RM_L3INIT_USB_HOST_FS_CONTEXT_OFFSET,
> -			.modulemode   =3D MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/*
>    * 'usb_host_hs' class
>    * high-speed multi-port usb host controller
>    */
> @@ -3863,14 +3760,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cf=
g__l3_main_2 =3D {
>   	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> -/* usb_host_fs -> l3_main_2 */
> -static struct omap_hwmod_ocp_if omap44xx_usb_host_fs__l3_main_2 =3D =
{
> -	.master		=3D &omap44xx_usb_host_fs_hwmod,
> -	.slave		=3D &omap44xx_l3_main_2_hwmod,
> -	.clk		=3D "l3_div_ck",
> -	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
>   /* usb_host_hs -> l3_main_2 */
>   static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 =3D=
 {
>   	.master		=3D &omap44xx_usb_host_hs_hwmod,
> @@ -3921,14 +3810,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cf=
g__l3_main_3 =3D {
>   	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> -/* aess -> l4_abe */
> -static struct omap_hwmod_ocp_if omap44xx_aess__l4_abe =3D {
> -	.master		=3D &omap44xx_aess_hwmod,
> -	.slave		=3D &omap44xx_l4_abe_hwmod,
> -	.clk		=3D "ocp_abe_iclk",
> -	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
>   /* dsp -> l4_abe */
>   static struct omap_hwmod_ocp_if omap44xx_dsp__l4_abe =3D {
>   	.master		=3D &omap44xx_dsp_hwmod,
> @@ -4003,42 +3884,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cf=
g__ocp_wp_noc =3D {
>   	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> -static struct omap_hwmod_addr_space omap44xx_aess_addrs[] =3D {
> -	{
> -		.pa_start	=3D 0x401f1000,
> -		.pa_end		=3D 0x401f13ff,
> -		.flags		=3D ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -/* l4_abe -> aess */
> -static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess =3D {
> -	.master		=3D &omap44xx_l4_abe_hwmod,
> -	.slave		=3D &omap44xx_aess_hwmod,
> -	.clk		=3D "ocp_abe_iclk",
> -	.addr		=3D omap44xx_aess_addrs,
> -	.user		=3D OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space omap44xx_aess_dma_addrs[] =3D {
> -	{
> -		.pa_start	=3D 0x490f1000,
> -		.pa_end		=3D 0x490f13ff,
> -		.flags		=3D ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -/* l4_abe -> aess (dma) */
> -static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess_dma =3D {
> -	.master		=3D &omap44xx_l4_abe_hwmod,
> -	.slave		=3D &omap44xx_aess_hwmod,
> -	.clk		=3D "ocp_abe_iclk",
> -	.addr		=3D omap44xx_aess_dma_addrs,
> -	.user		=3D OCP_USER_SDMA,
> -};
> -
>   /* l3_main_2 -> c2c */
>   static struct omap_hwmod_ocp_if omap44xx_l3_main_2__c2c =3D {
>   	.master		=3D &omap44xx_l3_main_2_hwmod,
> @@ -5847,24 +5692,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_pe=
r__uart4 =3D {
>   	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> -static struct omap_hwmod_addr_space omap44xx_usb_host_fs_addrs[] =3D=
 {
> -	{
> -		.pa_start	=3D 0x4a0a9000,
> -		.pa_end		=3D 0x4a0a93ff,
> -		.flags		=3D ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -/* l4_cfg -> usb_host_fs */
> -static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_fs =3D {
> -	.master		=3D &omap44xx_l4_cfg_hwmod,
> -	.slave		=3D &omap44xx_usb_host_fs_hwmod,
> -	.clk		=3D "l4_div_ck",
> -	.addr		=3D omap44xx_usb_host_fs_addrs,
> -	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
>   static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] =3D=
 {
>   	{
>   		.name		=3D "uhh",
> @@ -6014,13 +5841,11 @@ static struct omap_hwmod_ocp_if *omap44xx_hwm=
od_ocp_ifs[] __initdata =3D {
>   	&omap44xx_iva__l3_main_2,
>   	&omap44xx_l3_main_1__l3_main_2,
>   	&omap44xx_l4_cfg__l3_main_2,
> -	&omap44xx_usb_host_fs__l3_main_2,
>   	&omap44xx_usb_host_hs__l3_main_2,
>   	&omap44xx_usb_otg_hs__l3_main_2,
>   	&omap44xx_l3_main_1__l3_main_3,
>   	&omap44xx_l3_main_2__l3_main_3,
>   	&omap44xx_l4_cfg__l3_main_3,
> -	&omap44xx_aess__l4_abe,
>   	&omap44xx_dsp__l4_abe,
>   	&omap44xx_l3_main_1__l4_abe,
>   	&omap44xx_mpu__l4_abe,
> @@ -6029,8 +5854,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod=
_ocp_ifs[] __initdata =3D {
>   	&omap44xx_l4_cfg__l4_wkup,
>   	&omap44xx_mpu__mpu_private,
>   	&omap44xx_l4_cfg__ocp_wp_noc,
> -	&omap44xx_l4_abe__aess,
> -	&omap44xx_l4_abe__aess_dma,
>   	&omap44xx_l3_main_2__c2c,
>   	&omap44xx_l4_wkup__counter_32k,
>   	&omap44xx_l4_cfg__ctrl_module_core,
> @@ -6136,7 +5959,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod=
_ocp_ifs[] __initdata =3D {
>   	&omap44xx_l4_per__uart2,
>   	&omap44xx_l4_per__uart3,
>   	&omap44xx_l4_per__uart4,
> -	&omap44xx_l4_cfg__usb_host_fs,
>   	&omap44xx_l4_cfg__usb_host_hs,
>   	&omap44xx_l4_cfg__usb_otg_hs,
>   	&omap44xx_l4_cfg__usb_tll_hs,
>


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
