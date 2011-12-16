From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH v2 1/8] omap4: introduce fdif(face detect module)
 hwmod
Date: Fri, 16 Dec 2011 15:54:52 +0100
Message-ID: <4EEB5BBC.7050807@ti.com>
References: <1323871214-25435-1-git-send-email-ming.lei@canonical.com> <1323871214-25435-2-git-send-email-ming.lei@canonical.com> <alpine.DEB.2.00.1112152252260.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33796 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab1LPOzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 09:55:13 -0500
In-Reply-To: <alpine.DEB.2.00.1112152252260.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ming Lei <ming.lei@canonical.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Sylwester Nawrocki <snjw23@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org

Hi Paul,

On 12/16/2011 6:53 AM, Paul Walmsley wrote:
> Hi Beno=EEt
>
> On Wed, 14 Dec 2011, Ming Lei wrote:
>
>> Signed-off-by: Ming Lei<ming.lei@canonical.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   81 ++++++++++++++++=
++++++++++++
>>   1 files changed, 81 insertions(+), 0 deletions(-)
>
> any comments on this patch?  I'd like to queue it if it looks good to=
 you.

It looks good to me. The only minor comment is about fdif location in=20
the list that should be sorted and thus cannot be after wd_timer2.

Regards,
Benoit

>
> - Paul
>
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_44xx_data.c
>> index 6cf21ee..30db754 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -53,6 +53,7 @@ static struct omap_hwmod omap44xx_dmm_hwmod;
>>   static struct omap_hwmod omap44xx_dsp_hwmod;
>>   static struct omap_hwmod omap44xx_dss_hwmod;
>>   static struct omap_hwmod omap44xx_emif_fw_hwmod;
>> +static struct omap_hwmod omap44xx_fdif_hwmod;
>>   static struct omap_hwmod omap44xx_hsi_hwmod;
>>   static struct omap_hwmod omap44xx_ipu_hwmod;
>>   static struct omap_hwmod omap44xx_iss_hwmod;
>> @@ -354,6 +355,14 @@ static struct omap_hwmod_ocp_if omap44xx_dma_sy=
stem__l3_main_2 =3D {
>>   	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>>   };
>>
>> +/* fdif ->  l3_main_2 */
>> +static struct omap_hwmod_ocp_if omap44xx_fdif__l3_main_2 =3D {
>> +	.master		=3D&omap44xx_fdif_hwmod,
>> +	.slave		=3D&omap44xx_l3_main_2_hwmod,
>> +	.clk		=3D "l3_div_ck",
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>>   /* hsi ->  l3_main_2 */
>>   static struct omap_hwmod_ocp_if omap44xx_hsi__l3_main_2 =3D {
>>   	.master		=3D&omap44xx_hsi_hwmod,
>> @@ -5444,6 +5453,75 @@ static struct omap_hwmod omap44xx_wd_timer3_h=
wmod =3D {
>>   	.slaves_cnt	=3D ARRAY_SIZE(omap44xx_wd_timer3_slaves),
>>   };
>>
>> +/* 'fdif' class */
>> +static struct omap_hwmod_class_sysconfig omap44xx_fdif_sysc =3D {
>> +	.rev_offs	=3D 0x0000,
>> +	.sysc_offs	=3D 0x0010,
>> +	.sysc_flags	=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_RESET_STATUS |
>> +			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
>> +	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>> +			   MSTANDBY_FORCE | MSTANDBY_NO |
>> +			   MSTANDBY_SMART),
>> +	.sysc_fields	=3D&omap_hwmod_sysc_type2,
>> +};
>> +
>> +static struct omap_hwmod_class omap44xx_fdif_hwmod_class =3D {
>> +	.name	=3D "fdif",
>> +	.sysc	=3D&omap44xx_fdif_sysc,
>> +};
>> +
>> +/*fdif*/
>> +static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] =3D {
>> +	{
>> +		.pa_start	=3D 0x4a10a000,
>> +		.pa_end		=3D 0x4a10afff,
>> +		.flags		=3D ADDR_TYPE_RT
>> +	},
>> +	{ }
>> +};
>> +
>> +/* l4_cfg ->  fdif */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__fdif =3D {
>> +	.master		=3D&omap44xx_l4_cfg_hwmod,
>> +	.slave		=3D&omap44xx_fdif_hwmod,
>> +	.clk		=3D "l4_div_ck",
>> +	.addr		=3D omap44xx_fdif_addrs,
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>> +/* fdif slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_fdif_slaves[] =3D {
>> +	&omap44xx_l4_cfg__fdif,
>> +};
>> +static struct omap_hwmod_irq_info omap44xx_fdif_irqs[] =3D {
>> +	{ .irq =3D 69 + OMAP44XX_IRQ_GIC_START },
>> +	{ .irq =3D -1 }
>> +};
>> +
>> +/* fdif master ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_fdif_masters[] =3D {
>> +	&omap44xx_fdif__l3_main_2,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_fdif_hwmod =3D {
>> +	.name		=3D "fdif",
>> +	.class		=3D&omap44xx_fdif_hwmod_class,
>> +	.clkdm_name	=3D "iss_clkdm",
>> +	.mpu_irqs	=3D omap44xx_fdif_irqs,
>> +	.main_clk	=3D "fdif_fck",
>> +	.prcm =3D {
>> +		.omap4 =3D {
>> +			.clkctrl_offs =3D OMAP4_CM_CAM_FDIF_CLKCTRL_OFFSET,
>> +			.context_offs =3D OMAP4_RM_CAM_FDIF_CONTEXT_OFFSET,
>> +			.modulemode   =3D MODULEMODE_SWCTRL,
>> +		},
>> +	},
>> +	.slaves		=3D omap44xx_fdif_slaves,
>> +	.slaves_cnt	=3D ARRAY_SIZE(omap44xx_fdif_slaves),
>> +	.masters	=3D omap44xx_fdif_masters,
>> +	.masters_cnt	=3D ARRAY_SIZE(omap44xx_fdif_masters),
>> +};
>> +
>>   static __initdata struct omap_hwmod *omap44xx_hwmods[] =3D {
>>
>>   	/* dmm class */
>> @@ -5593,6 +5671,9 @@ static __initdata struct omap_hwmod *omap44xx_=
hwmods[] =3D {
>>   	&omap44xx_wd_timer2_hwmod,
>>   	&omap44xx_wd_timer3_hwmod,
>>
>> +	/* fdif class */
>> +	&omap44xx_fdif_hwmod,
>> +
>>   	NULL,
>>   };
>>
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> - Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
