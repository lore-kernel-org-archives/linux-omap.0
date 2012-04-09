From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 04/17][V2] ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
Date: Mon, 09 Apr 2012 15:38:58 -0700
Message-ID: <87obr0a5tp.fsf@ti.com>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
	<1333570371-1389-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:54029 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757411Ab2DIWiw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 18:38:52 -0400
Received: by dajx4 with SMTP id x4so6869300daj.28
        for <linux-omap@vger.kernel.org>; Mon, 09 Apr 2012 15:38:51 -0700 (PDT)
In-Reply-To: <1333570371-1389-5-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Wed, 4 Apr 2012 22:12:38 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, rob.lee@linaro.org, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Missing changelog.

Kevin

> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index cdd7932..fb0f76e 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -33,7 +33,7 @@ struct omap4_idle_statedata {
>  
>  #define OMAP4_NUM_STATES 3
>  
> -struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
> +static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
>  static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
>  
>  /**
