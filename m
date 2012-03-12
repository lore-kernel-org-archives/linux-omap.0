From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Workaround the OCP synchronisation issue with 32K synctimer.
Date: Mon, 12 Mar 2012 09:51:40 -0700
Message-ID: <87399d225f.fsf@ti.com>
References: <1331566388-2397-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56158 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753144Ab2CLQve (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 12:51:34 -0400
Received: by mail-iy0-f179.google.com with SMTP id h37so9072500iak.24
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 09:51:33 -0700 (PDT)
In-Reply-To: <1331566388-2397-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 12 Mar 2012 21:03:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dave.long@linaro.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On OMAP4, recently a synchronisation bug is discovered by hardware
> team, which leads to incorrect timer value read from 32K sync timer
> IP when the IP is comming out of idle.
>
> The issue is due to the synchronization methodology used in the SYNCTIMER IP.
> The value of the counter register in 32kHz domain is synchronized to the OCP
> domain register only at count up event, and if the OCP clock is switched off,
> the OCP register gets out of synch until the first count up event after the
> clock is switched back -at the next falling edge of the 32kHz clock.
>
> Further investigation revealed that it applies to gptimer1 and watchdog timer2
> as well which may run on 32KHz. This patch fixes the issue for all the
> applicable modules.

The changelog describes the problem ver well, but doesn't actually
describe the fix (enable static dep.)  Can you update the changelog do
describe the fix, and why it fixes the problem.

Thanks,

Kevin


> The BUG has not made it yet to the OMAP errata list and it is applicable to
> OMAP1/2/3/4/5. OMAP1/2/3 it is taken care indirectly by autodeps.
>
> Reported-Tested-by: dave.long@linaro.org
> [dave.long@linaro.org: Reported the oprofile time stamp issue with synctimer
> and helped to test this patch]
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/pm44xx.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index c264ef7..974f7ea 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -196,7 +196,7 @@ static void omap_default_idle(void)
>  static int __init omap4_pm_init(void)
>  {
>  	int ret;
> -	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
> +	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm, *l4wkup;
>  	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
>  
>  	if (!cpu_is_omap44xx())
> @@ -220,14 +220,19 @@ static int __init omap4_pm_init(void)
>  	 * MPUSS -> L4_PER/L3_* and DUCATI -> L3_* doesn't work as
>  	 * expected. The hardware recommendation is to enable static
>  	 * dependencies for these to avoid system lock ups or random crashes.
> +	 * The L4 wakeup depedency is added to workaround the OCP sync hardware
> +	 * BUG with 32K synctimer which lead to incorrect timer value read
> +	 * from the 32K counter. The BUG applies for GPTIMER1 and WDT2 which
> +	 * are part of L4 wakeup clockdomain.
>  	 */
>  	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
>  	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
>  	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
>  	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
>  	l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
> +	l4wkup = clkdm_lookup("l4_wkup_clkdm");
>  	ducati_clkdm = clkdm_lookup("ducati_clkdm");
> -	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
> +	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) || (!l4wkup) ||
>  		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
>  		goto err2;
>  
> @@ -235,6 +240,7 @@ static int __init omap4_pm_init(void)
>  	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
>  	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
>  	ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
> +	ret |= clkdm_add_wkdep(mpuss_clkdm, l4wkup);
>  	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
>  	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
>  	if (ret) {
