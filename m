From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 2/3] OMAP4: Update Voltage Rail Values for MPU/IVA
Date: Tue, 08 Mar 2011 07:36:54 +0530
Message-ID: <4D758F3E.4020209@ti.com>
References: <1299318713-21389-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51159 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756826Ab1CHCHM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 21:07:12 -0500
Received: by mail-vw0-f53.google.com with SMTP id 8so4579403vws.26
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 18:07:11 -0800 (PST)
In-Reply-To: <1299318713-21389-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shweta Gulati wrote, on 03/05/2011 03:21 PM:
> Update MPU/IVA voltage Rail values obtained from
> OMAP4430 Data Manual Operating Condition Addendum_v0.3.
>
> Tested on OMAP4430 SDP Board.
>
> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   arch/arm/mach-omap2/opp4xxx_data.c |   14 +++++++-------
>   1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
> index 93b9744..36a4517 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -31,10 +31,10 @@
>    * voltage dependent data for each VDD.
>    */
>
> -#define OMAP4430_VDD_MPU_OPP50_UV		930000
> -#define OMAP4430_VDD_MPU_OPP100_UV		1100000
> -#define OMAP4430_VDD_MPU_OPPTURBO_UV		1260000
> -#define OMAP4430_VDD_MPU_OPPNITRO_UV		1350000
> +#define OMAP4430_VDD_MPU_OPP50_UV		1025000
> +#define OMAP4430_VDD_MPU_OPP100_UV		1200000
> +#define OMAP4430_VDD_MPU_OPPTURBO_UV		1313000
> +#define OMAP4430_VDD_MPU_OPPNITRO_UV		1375000
>
>   struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
>   	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPP50_UV, OMAP44XX_CONTROL_FUSE_MPU_OPP50, 0xf4, 0x0c),
> @@ -44,9 +44,9 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
>   	VOLT_DATA_DEFINE(0, 0, 0, 0),
>   };
>
> -#define OMAP4430_VDD_IVA_OPP50_UV		930000
> -#define OMAP4430_VDD_IVA_OPP100_UV		1100000
> -#define OMAP4430_VDD_IVA_OPPTURBO_UV		1260000
> +#define OMAP4430_VDD_IVA_OPP50_UV		1013000
> +#define OMAP4430_VDD_IVA_OPP100_UV		1188000
> +#define OMAP4430_VDD_IVA_OPPTURBO_UV		1300000
>
>   struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
>   	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPP50_UV, OMAP44XX_CONTROL_FUSE_IVA_OPP50, 0xf4, 0x0c),
Acked-by: Nishanth Menon <nm@ti.com>


Side note: unrelated to this patch: PMICs have discrete step sizes of 
10mV, 12.5, 25mV etc.. which makes something lik 1.118V probably not 
exactly possible on a PMIC with 25mV step. We need to next probably 
create a framework to round_up the voltages to the PMIC step size once 
the PMIC voltage layer changes are in.

-- 
Regards,
Nishanth Menon
