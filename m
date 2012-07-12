From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP3: prevent per_clkdm from attempting manual
 domain transitions
Date: Thu, 12 Jul 2012 15:11:13 +0530
Message-ID: <4FFE9BB9.7000209@ti.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com> <1338470942-20185-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36146 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757206Ab2GLJlU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 05:41:20 -0400
Received: by obqv19 with SMTP id v19so6701091obq.16
        for <linux-omap@vger.kernel.org>; Thu, 12 Jul 2012 02:41:19 -0700 (PDT)
In-Reply-To: <1338470942-20185-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Thursday 31 May 2012 06:59 PM, Tero Kristo wrote:
> Previously, PER clock domain was always enabled, as the usecounts
> for this domain incorrectly always showed positive value. On HW
> level though, the domain enters idle as it is set in HW supervised
> mode. Now, when the usecounts reflect real values, PER domain will
> attempt to enter software supervised idle, which is not supported by the
> hardware/kernel that well, and causes multiple problems. First of all,
> coming back from idle, PER domain remains idle as the wakedeps have
> been disabled for the domain, and this causes a crash with the GPIO
> code, as the resume code attempts to access domain which is not active.
> Just enabling the interface clocks for the GPIO does not help, as they
> are autoidled and don't bring the domain out of idle. Secondly, there
> are multiple erratas for omap3, which say that the wakedeps should be
> enabled for the PER domain, see e.g. errata i582 for omap3630.

If PER software supervised idle is so *buggy* then shouldn't the flags
just reflect that PER *does not* support software supervised idle?
Using a flag which reflects that the clkdm supports both hardware
and software supervised idle ('CLKDM_CAN_HWSUP_SWSUP') and then using
another one to actually skip putting it in software supervised sounds
a little round about, no?
Does updating the flag to 'CLKDM_CAN_HWSUP' also fix all the issues
for you? without adding the additional 'CLKDM_SKIP_MANUAL_TRANS' flag.

>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/clockdomains3xxx_data.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> index 6038adb..0dae4c8 100644
> --- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> @@ -282,7 +282,7 @@ static struct clockdomain usbhost_clkdm = {
>   static struct clockdomain per_clkdm = {
>   	.name		= "per_clkdm",
>   	.pwrdm		= { .name = "per_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP | CLKDM_SKIP_MANUAL_TRANS,
>   	.dep_bit	= OMAP3430_EN_PER_SHIFT,
>   	.wkdep_srcs	= per_wkdeps,
>   	.sleepdep_srcs	= per_sleepdeps,

