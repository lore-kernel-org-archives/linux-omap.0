From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 04/14] thermal: ti-soc-thermal: cleanup COUNTER feature
 handling for OMAP5
Date: Wed, 11 Jul 2018 09:08:29 +0530
Message-ID: <51799355-1a39-7f2f-6a20-a1718b9e0a64@ti.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180514114319epcas1p1921a83c1baaaf1e6f94283f462022dc5@epcas1p1.samsung.com>
 <1526298141-14045-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526298141-14045-5-git-send-email-b.zolnierkie@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> OMAP5 sensors don't claim COUNTER feature support (they use
> COUNTER_DELAY feature instead) so there is no need to set fields
> of struct temp_sensor_registers which are only used for COUNTER
> feature.
> 
> There should be no functional changes caused by this patch.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/thermal/ti-soc-thermal/omap5-thermal-data.c | 9 ---------
>   drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h   | 3 ---
>   2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
> index 8191bae..e384be1 100644
> --- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
> +++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
> @@ -41,9 +41,6 @@
>   	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
>   	.mask_freeze_mask = OMAP5430_MASK_FREEZE_MPU_MASK,
>   
> -	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
> -	.counter_mask = OMAP5430_COUNTER_MASK,
> -
>   	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_MPU_OFFSET,
>   	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
>   	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
> @@ -77,9 +74,6 @@
>   	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
>   	.mask_freeze_mask = OMAP5430_MASK_FREEZE_GPU_MASK,
>   
> -	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
> -	.counter_mask = OMAP5430_COUNTER_MASK,
> -
>   	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_GPU_OFFSET,
>   	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
>   	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
> @@ -114,9 +108,6 @@
>   	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
>   	.mask_freeze_mask = OMAP5430_MASK_FREEZE_CORE_MASK,
>   
> -	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
> -	.counter_mask = OMAP5430_COUNTER_MASK,
> -
>   	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_CORE_OFFSET,
>   	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
>   	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
> diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> index dcbf903..223c7a8 100644
> --- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> @@ -93,9 +93,6 @@
>   #define OMAP5430_MASK_HOT_MPU_MASK			BIT(1)
>   #define OMAP5430_MASK_COLD_MPU_MASK			BIT(0)
>   
> -/* OMAP5430.BANDGAP_COUNTER */
> -#define OMAP5430_COUNTER_MASK				(0xffffff << 0)
> -
>   /* OMAP5430.BANDGAP_THRESHOLD */
>   #define OMAP5430_T_HOT_MASK				(0x3ff << 16)
>   #define OMAP5430_T_COLD_MASK				(0x3ff << 0)
> 
