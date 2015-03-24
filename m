From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [rtc-linux] [PATCH] rtc: OMAP: Add external 32k clock feature
Date: Tue, 24 Mar 2015 15:59:16 -0700
Message-ID: <20150324155916.cfd1b7ab442271466160283f@linux-foundation.org>
References: <1425375722-13412-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425375722-13412-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 3 Mar 2015 15:12:02 +0530 Keerthy <j-keerthy@ti.com> wrote:

> Add external 32k clock feature. The internal clock will be gated during suspend.
> Hence make use of the external 32k clock so that rtc is functional accross
> suspend/resume.
> 
> ...
>
> @@ -446,6 +449,7 @@ static const struct omap_rtc_device_type omap_rtc_default_type = {
>  
>  static const struct omap_rtc_device_type omap_rtc_am3352_type = {
>  	.has_32kclk_en	= true,
> +	.has_osc_ext_32k = true,
>  	.has_kicker	= true,
>  	.has_irqwakeen	= true,
>  	.has_pmic_mode	= true,
> @@ -543,7 +547,16 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  	if (rtc->type->has_32kclk_en) {
>  		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
>  		rtc_writel(rtc, OMAP_RTC_OSC_REG,
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
>  	}

How do we know that all systems have this external clock and that it
works OK?
