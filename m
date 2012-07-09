From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH v2 0/2] Watchdog: OMAP: bootstatus fix for omap3 and changes
 for the current watchdog framework
Date: Mon, 9 Jul 2012 11:32:03 +0530
Message-ID: <4FFA73DB.1020009@ti.com>
References: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57480 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043Ab2GIGCb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jul 2012 02:02:31 -0400
In-Reply-To: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@windriver.com>
Cc: shubhrajyoti@ti.com, wim@iguana.be, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul.gortmaker@windriver.com



On 7/9/2012 10:09 AM, Zumeng Chen wrote:
> Hello,
> 
> The following patches based on the 3.5-rc6 from Wim, which
> are based on:
> 
> 1 ) bootstatus fix for omap3,
> 
> 2 ) omap-wdt framework update cater for the current framework
>     as Shubhrajyoti comments mentioned.
> 
> Regards,
> Zumeng
> 
>   Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)
> 
> Zumeng Chen (3):
>       Watchdog: Omap: Changes for the new watchdog framework
>       Watchdog: Omap: select watchdog core for framework change
>       Watchdog: Omap: get the bootstatus for OMAP2Plus
> 

It looks like you have manually created your cover letter, cover-letter
says [0/2] but actually you have 3 patches in series.


You should use following command to create cover letter,

git format-patch --cover-letter <no of patches OR commits for patches>


Thanks,
Vaibhav

>  arch/arm/mach-omap2/prcm.c  |    5 +-
>  drivers/watchdog/Kconfig    |    1 +
>  drivers/watchdog/omap_wdt.c |  338 ++++++++++++++++---------------------------
>  drivers/watchdog/omap_wdt.h |    5 +
>  4 files changed, 133 insertions(+), 216 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

