From: Igor Mazanov <i.mazanov@gmail.com>
Subject: Re: [PATCH v3 5/5] ARM: OMAP2+: omap2plus_defconfig: Enable RTC support
Date: Fri, 23 Nov 2012 20:55:07 +0400
Message-ID: <50AFAA6B.9020706@gmail.com>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com> <1353404927-14412-6-git-send-email-anilkumar@ti.com>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48851 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab2KWQyY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 11:54:24 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so4339706lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Nov 2012 08:54:23 -0800 (PST)
In-Reply-To: <1353404927-14412-6-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: anilkumar@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

AnilKumar Ch wrote:
> AM33XX family of devices uses RTC module, one has to manually enable
> this support to use RTC features. So this patch enable RTC driver in
> omap2plus_defconfig.
> 
> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index a4b330e..8839ac9 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -194,6 +194,7 @@ CONFIG_SDIO_UART=y
>  CONFIG_MMC_OMAP=y
>  CONFIG_MMC_OMAP_HS=y
>  CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_OMAP=y
>  CONFIG_RTC_DRV_TWL92330=y
>  CONFIG_RTC_DRV_TWL4030=y
>  CONFIG_DMADEVICES=y

Hello,

But this is not enough, we need to change drivers/rtc/Kconfig too. This change 
was offered in this thread

http://marc.info/?l=linux-arm-kernel&m=135057569913027&w=2

But, may be all this previous rtc-related changes accounted already in some 
development branch. I just doesn't see it in the current master. In this case, 
when could we get RTC support in the current kernel?

Regards,
Igor.
