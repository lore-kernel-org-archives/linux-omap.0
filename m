From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 2/3] OMAP4: Update Voltage Rail Values for MPU, IVA
 and CORE
Date: Fri, 11 Mar 2011 08:37:05 +0530
Message-ID: <4D7991D9.3010003@ti.com>
References: <1299732829-3376-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:43844 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752149Ab1CKDHN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 22:07:13 -0500
Received: by mail-vw0-f54.google.com with SMTP id 18so291318vws.13
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 19:07:12 -0800 (PST)
In-Reply-To: <1299732829-3376-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shweta Gulati wrote, on 03/10/2011 10:23 AM:
> Update MPU, IVA and CORE voltage Rail values obtained from
> OMAP4430 Data Manual Operating Condition Addendum_v0.4.
>
> Tested on OMAP4430 SDP Board.
>
> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
Thanks for pro-actively keeping this updated.
Acked-by: Nishanth Menon <nm@ti.com>

> ---
> V3:
> Update CORE Voltages as well
> in sync with V0.4 of OMAP4 Data Manual.
>
> V2:
> Fixed Comments from Nishanth Menon.
>
>   arch/arm/mach-omap2/opp4xxx_data.c |   18 +++++++++---------
>   1 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
> index ed0efdb..aa624d1 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -30,10 +30,10 @@
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
> @@ -43,9 +43,9 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
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
> @@ -54,8 +54,8 @@ struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
>   	VOLT_DATA_DEFINE(0, 0, 0, 0),
>   };
>
> -#define OMAP4430_VDD_CORE_OPP50_UV		930000
> -#define OMAP4430_VDD_CORE_OPP100_UV		1100000
> +#define OMAP4430_VDD_CORE_OPP50_UV		1025000
> +#define OMAP4430_VDD_CORE_OPP100_UV		1200000
>
>   struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
>   	VOLT_DATA_DEFINE(OMAP4430_VDD_CORE_OPP50_UV, OMAP44XX_CONTROL_FUSE_CORE_OPP50, 0xf4, 0x0c),


-- 
Regards,
Nishanth Menon
