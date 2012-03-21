From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC][PATCH 4/7] ARM: OMAP4: cpuidle - fix static omap4_idle_data
 declaration
Date: Wed, 21 Mar 2012 15:21:50 +0530
Message-ID: <4F69A4B6.7030305@ti.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org> <1332322070-24577-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:42729 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757764Ab2CUJv4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 05:51:56 -0400
Received: by yhjj56 with SMTP id j56so809095yhj.20
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 02:51:54 -0700 (PDT)
In-Reply-To: <1332322070-24577-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index 0455858..254f97b 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -33,7 +33,7 @@ struct omap4_idle_statedata {
>  
>  #define OMAP4_NUM_STATES 3
>  
> -struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
> +static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
OK

Regards
santosh
