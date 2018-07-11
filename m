From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 02/14] thermal: ti-soc-thermal: fix comment in
 omap5xxx-bandgap.h
Date: Wed, 11 Jul 2018 07:51:06 +0530
Message-ID: <65f3e868-976d-7568-f452-e28af691df17@ti.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180514114308epcas2p3bba580c5500889f22d50549994b227db@epcas2p3.samsung.com>
 <1526298141-14045-3-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526298141-14045-3-git-send-email-b.zolnierkie@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> The comment for OMAP5430.CORE register offsets is incorrect. Fix it.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> index 9096403..dcbf903 100644
> --- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> @@ -55,7 +55,7 @@
>   #define OMAP5430_BGAP_DTEMP_MPU_1_OFFSET		0x1E4
>   #define OMAP5430_BGAP_DTEMP_MPU_2_OFFSET		0x1E8
>   
> -/* OMAP5430.MPU register offsets */
> +/* OMAP5430.CORE register offsets */
>   #define OMAP5430_FUSE_OPP_BGAP_CORE			0x8
>   #define OMAP5430_TEMP_SENSOR_CORE_OFFSET		0x154
>   #define OMAP5430_BGAP_THRESHOLD_CORE_OFFSET		0x1AC
> 
