From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 15/15] OMAP2+: cpuidle only influences the MPU state
Date: Tue, 16 Aug 2011 19:46:46 +0530
Message-ID: <4E4A7BCE.8010701@ti.com>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com> <1313502198-9298-16-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:55196 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752155Ab1HPOQz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 10:16:55 -0400
Received: by mail-yi0-f49.google.com with SMTP id 13so5084435yic.22
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 07:16:54 -0700 (PDT)
In-Reply-To: <1313502198-9298-16-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Jean,

On Tuesday 16 August 2011 07:13 PM, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> Since cpuidle is a CPU centric framework it decides the MPU
> next power state based on the MPU exit_latency and target_residency
> figures.
>
> The rest of the power domains get their next power state programmed
> from the devices PM QoS framework, via the devices wake-up latency
> constraints.
>
> Note: the exit_latency and target_residency figures of the MPU
> include the MPU itself and the peripherals needed for the MPU to
> execute instructions (e.g. main memory, caches, IRQ controller,
> MMU etc). Some of those peripherals can belong to other power domains
> than the MPU subsystem and so the corresponding latencies must be
> included in this figure.
>
> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
> on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/cpuidle34xx.c |   42 +++++++++++-------------------------
>   arch/arm/mach-omap2/pm.h          |   17 +++++++++++++-
>   2 files changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 4bf6e6e..b43d1d2 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -37,26 +37,26 @@
>   #ifdef CONFIG_CPU_IDLE
>

[....]

> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 4e166ad..aca3b6c 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -43,9 +43,22 @@ static inline int omap4_opp_init(void)
>    * omap3_pm_init_cpuidle
>    */
>   struct cpuidle_params {
> -	u32 exit_latency;	/* exit_latency = sleep + wake-up latencies */
> +	/*
> +	 * exit_latency = sleep + wake-up latencies of the MPU,
> +	 * which include the MPU itself and the peripherals needed
> +	 * for the MPU to execute instructions (e.g. main memory,
> +	 * caches, IRQ controller, MMU etc). Some of those peripherals
> +	 * can belong to other power domains than the MPU subsystem and so
> +	 * the corresponding latencies must be included in this figure.
> +	 */
This is exactly was my point in the last comment on this patch.
If you are adding up those numbers then it's no long MPU PD
latency but the system C-state latency.

And I say again, the latency numbers above are not for MPU alone
as you have done in this hunk. So be clear here. Either you provide
way to dynamically add the latency numbers to MPU latency which
is fixed for a OPP or call this as system latency etc.

 >   /*
 > - * The latencies/thresholds for various C states have
 > + * The MPU latencies/thresholds for various C states have
 >    * to be configured from the respective board files.
 >    * These are some default values (which might not provide
 >    * the best power savings) used on boards which do not
 >    * pass these details from the board file.
 >    */
 >   static struct cpuidle_params cpuidle_params_table[] = {
 > -	/* C1 */
 > +	/* C1 . MPU WFI + Core active */
 >   	{2 + 2, 5, 1},
 > -	/* C2 */
 > +	/* C2 . MPU WFI + Core inactive */
 >   	{10 + 10, 30, 1},

Regards
Santosh
