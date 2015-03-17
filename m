From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH] rtc: OMAP: Add external 32k clock feature
Date: Tue, 17 Mar 2015 09:45:09 +0530
Message-ID: <5507AA4D.3060209@ti.com>
References: <1425375722-13412-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55138 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbbCQEQW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 00:16:22 -0400
In-Reply-To: <1425375722-13412-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it
Cc: Keerthy <j-keerthy@ti.com>, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org



On Tuesday 03 March 2015 03:12 PM, Keerthy wrote:
> Add external 32k clock feature. The internal clock will be gated during suspend.
> Hence make use of the external 32k clock so that rtc is functional accross
> suspend/resume.

A gentle ping on this.

>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>
> Tested on DRA7-EVM.
>
>   drivers/rtc/rtc-omap.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 8e5851a..4f803ca 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -107,6 +107,8 @@
>
>   /* OMAP_RTC_OSC_REG bit fields: */
>   #define OMAP_RTC_OSC_32KCLK_EN		BIT(6)
> +#define OMAP_RTC_OSC_OSC32K_GZ		BIT(4)
> +#define OMAP_RTC_OSC_EXT_32K		BIT(3)
>
>   /* OMAP_RTC_IRQWAKEEN bit fields: */
>   #define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN	BIT(1)
> @@ -120,6 +122,7 @@
>
>   struct omap_rtc_device_type {
>   	bool has_32kclk_en;
> +	bool has_osc_ext_32k;
>   	bool has_kicker;
>   	bool has_irqwakeen;
>   	bool has_pmic_mode;
> @@ -446,6 +449,7 @@ static const struct omap_rtc_device_type omap_rtc_default_type = {
>
>   static const struct omap_rtc_device_type omap_rtc_am3352_type = {
>   	.has_32kclk_en	= true,
> +	.has_osc_ext_32k = true,
>   	.has_kicker	= true,
>   	.has_irqwakeen	= true,
>   	.has_pmic_mode	= true,
> @@ -543,7 +547,16 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>   	if (rtc->type->has_32kclk_en) {
>   		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
>   		rtc_writel(rtc, OMAP_RTC_OSC_REG,
> -				reg | OMAP_RTC_OSC_32KCLK_EN);
> +			   reg | OMAP_RTC_OSC_32KCLK_EN);
> +	}
> +
> +	/* Enable External clock as the source */
> +
> +	if (rtc->type->has_osc_ext_32k) {
> +		rtc_writel(rtc, OMAP_RTC_OSC_REG,
> +			   (OMAP_RTC_OSC_EXT_32K |
> +			   rtc_read(rtc, OMAP_RTC_OSC_REG)) &
> +			   (~OMAP_RTC_OSC_OSC32K_GZ));
>   	}
>
>   	/* clear old status */
>
