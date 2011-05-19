From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 10/13] OMAP3: PM: export the v7_flush_dcache_all API to
 modules
Date: Thu, 19 May 2011 13:34:33 +0530
Message-ID: <4DD4CF11.5010701@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com> <1305739950-11695-11-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51601 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754521Ab1ESIEn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 04:04:43 -0400
Received: by mail-gy0-f177.google.com with SMTP id 20so1015138gyh.8
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 01:04:38 -0700 (PDT)
In-Reply-To: <1305739950-11695-11-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org

On 5/18/2011 11:02 PM, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> Provide the the assembly function v7_flush_dcache_all to the
> OMAP3 PM module, under CONFIG_CPU_V7.
> v7_flush_dcache_all is used by the low level sleep code.
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/pm.c |    4 ++++
>   arch/arm/mach-omap2/pm.h |    4 ++++
>   2 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 2e43fd6..ab69c5a 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -325,6 +325,10 @@ unsigned long omap_pm_tick_nohz_get_sleep_length_us(void)
>   EXPORT_SYMBOL(omap_pm_tick_nohz_get_sleep_length_us);
>   #endif
>
> +#ifdef CONFIG_CPU_V7
> +EXPORT_SYMBOL(v7_flush_dcache_all);
> +#endif
> +
You have already mentioned, this export is wrong and indeed it
is wrong. You can use "flush_cache_all()" instead here which will
pick the right asm function. The downside is it will invalidate
I cache as well but that's ok because it's get invalidated anyways
in wakeup path.

Regards
Santosh
