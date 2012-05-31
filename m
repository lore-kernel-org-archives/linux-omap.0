From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP3: prevent per_clkdm from attempting manual
 domain transitions
Date: Thu, 31 May 2012 18:40:28 -0500
Message-ID: <4FC8016C.9000801@ti.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com> <1338470942-20185-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36974 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758663Ab2EaXkc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 19:40:32 -0400
In-Reply-To: <1338470942-20185-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Hi Tero,

On 05/31/2012 08:29 AM, Tero Kristo wrote:
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
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/clockdomains3xxx_data.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> index 6038adb..0dae4c8 100644
> --- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> @@ -282,7 +282,7 @@ static struct clockdomain usbhost_clkdm = {
>  static struct clockdomain per_clkdm = {
>  	.name		= "per_clkdm",
>  	.pwrdm		= { .name = "per_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP | CLKDM_SKIP_MANUAL_TRANS,
>  	.dep_bit	= OMAP3430_EN_PER_SHIFT,
>  	.wkdep_srcs	= per_wkdeps,
>  	.sleepdep_srcs	= per_sleepdeps,

So this change is just preventing software from clearing the wakeup-deps
and keeping the PER clock domain always in HW_AUTO?

Sorry for the dumb question, but what is the circumstance under which we
want to clear the wakeup-deps when we disable the clock domain? I am
just curious why this is being done in the first place.

Cheers
Jon
