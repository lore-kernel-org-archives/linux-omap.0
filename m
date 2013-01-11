From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH v4 4/4] ARM: OMAP2+: omap2plus_defconfig: Enable RTC support
Date: Fri, 11 Jan 2013 00:08:31 -0800
Message-ID: <CA+Bv8XacG1eQ=pZ52Tt5UoHEbOF4WTy8tDTi7BK=b9XcyZt6=g@mail.gmail.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
	<1355464997-19367-5-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:34969 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab3AKIId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 03:08:33 -0500
Received: by mail-qa0-f50.google.com with SMTP id cr7so1292967qab.9
        for <linux-omap@vger.kernel.org>; Fri, 11 Jan 2013 00:08:31 -0800 (PST)
In-Reply-To: <1355464997-19367-5-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: a.zummo@towertech.it, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Herring <rob.herring@calxeda.com>, rtc-linux@googlegroups.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>

On Thu, Dec 13, 2012 at 10:03 PM, AnilKumar Ch <anilkumar@ti.com> wrote:
> AM33XX family of devices use RTC module, one has to manually enable
> this support to use RTC features. So this patch enable RTC driver in
> omap2plus_defconfig.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Looks good

Reviewed-by: Russ Dill <russ.dill@ti.com>
Acked-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 0ce6771..e58afc5 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -216,6 +216,7 @@ CONFIG_LEDS_TRIGGER_CPU=y
>  CONFIG_LEDS_TRIGGER_GPIO=y
>  CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>  CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_OMAP=y
>  CONFIG_RTC_DRV_TWL92330=y
>  CONFIG_RTC_DRV_TWL4030=y
>  CONFIG_DMADEVICES=y
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
