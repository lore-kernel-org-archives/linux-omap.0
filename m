From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/6] ARM: OMAP4 PM: Add IO Daisychain support
Date: Fri, 24 Feb 2012 12:20:08 +0530
Message-ID: <4F473320.7000901@ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com> <1330003320-17400-3-git-send-email-t-kristo@ti.com> <5672BD13E82B844A93BB4597F293F19A0B3F41AF@DNCE02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:42647 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751266Ab2BXGuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 01:50:21 -0500
Received: by yenr1 with SMTP id r1so1180063yen.4
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 22:50:19 -0800 (PST)
In-Reply-To: <5672BD13E82B844A93BB4597F293F19A0B3F41AF@DNCE02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Elaidi, Djamil" <d-elaidi@ti.com>
Cc: "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Djamil,

On Thursday 23 February 2012 09:28 PM, Elaidi, Djamil wrote:
> Hi Kristo,
>
> I think you must also add a omap_test_timeout() check after the Trigg=
er WUCLKIN disable, to verify WUCLK_STATUS has come back to 0.
> This is needed because the IO daisy chain will not be ready until the=
 WUCLKIN falling edge has propagated.

You are right, this was missed and needs to be added.
Thanks for the review.

regards,
Rajendra

>
> +	/* Trigger WUCLKIN disable */
> +	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
> +			OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
> +	return;
> +	omap_test_timeout(
> +		(((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
> +			OMAP4_PRM_IO_PMCTRL_OFFSET)&
> +			OMAP4430_WUCLK_STATUS_MASK)>>
> +			OMAP4430_WUCLK_STATUS_SHIFT) =3D=3D 0),
> +		MAX_IOPAD_LATCH_TIME, i);
>
>
> Best regards
> Djamil ELA=CFDI
> +33 4 97 27 50 97
> Software Systems Engineer
> OMAP Platform Business Unit - PSI Modem Integration
> Texas Instruments
>
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.=
kernel.org] On Behalf Of Kristo, Tero
> Sent: jeudi 23 f=E9vrier 2012 14:22
> To: linux-omap@vger.kernel.org; Hilman, Kevin
> Cc: linux-arm-kernel@lists.infradead.org; Nayak, Rajendra; Sripathy, =
Vishwanath
> Subject: [PATCH 2/6] ARM: OMAP4 PM: Add IO Daisychain support
>
> From: Rajendra Nayak<rnayak@ti.com>
>
> patch adds IO Daisychain support for OMAP4 as per section 3.9.4 in OM=
AP4430
> Public TRM.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/prm44xx.c |   32 ++++++++++++++++++++++++++++++=
++
>   arch/arm/mach-omap2/prm44xx.h |    1 +
>   2 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm4=
4xx.c
> index 33dd655..1557647 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -230,6 +230,41 @@ void omap44xx_prm_restore_irqen(u32 *saved_mask)
>   				 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
>   }
>
> +/**
> + * Maximum time(us) it takes to output the signal WUCLKOUT of the la=
st pad of
> + * the I/O ring after asserting WUCLKIN high
> + */
> +#define MAX_IOPAD_LATCH_TIME 1000
> +
> +/* OMAP4 IO Daisychain trigger sequence */
> +void omap4_trigger_wuclk_ctrl(void)
> +{
> +	int i =3D 0;
> +
> +	/* Enable GLOBAL_WUEN */
> +	if (!(omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
> +		OMAP4_PRM_IO_PMCTRL_OFFSET)&  OMAP4430_GLOBAL_WUEN_MASK))
> +		omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
> +			OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_DEVICE_INST,
> +			OMAP4_PRM_IO_PMCTRL_OFFSET);
> +
> +	/* Trigger WUCLKIN enable */
> +	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK,
> +			OMAP4430_WUCLK_CTRL_MASK, OMAP4430_PRM_DEVICE_INST,
> +			OMAP4_PRM_IO_PMCTRL_OFFSET);
> +	omap_test_timeout(
> +		(((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
> +			OMAP4_PRM_IO_PMCTRL_OFFSET)&
> +			OMAP4430_WUCLK_STATUS_MASK)>>
> +			OMAP4430_WUCLK_STATUS_SHIFT) =3D=3D 1),
> +		MAX_IOPAD_LATCH_TIME, i);
> +
> +	/* Trigger WUCLKIN disable */
> +	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
> +			OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
> +	return;
> +}
> +
>   static int __init omap4xxx_prcm_init(void)
>   {
>   	if (cpu_is_omap44xx())
> diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm4=
4xx.h
> index 7978092..a840f0f 100644
> --- a/arch/arm/mach-omap2/prm44xx.h
> +++ b/arch/arm/mach-omap2/prm44xx.h
> @@ -762,6 +762,7 @@ void omap4_prm_vp_clear_txdone(u8 vp_id);
>   extern u32 omap4_prm_vcvp_read(u8 offset);
>   extern void omap4_prm_vcvp_write(u32 val, u8 offset);
>   extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
> +extern void omap4_trigger_wuclk_ctrl(void);
>
>   /* PRM interrupt-related functions */
>   extern void omap44xx_prm_read_pending_irqs(unsigned long *events);

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
