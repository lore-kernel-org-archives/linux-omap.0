From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SMP local timers and their CPUfreq notifiers setup on OMAP3
Date: Tue, 21 Feb 2012 09:11:24 +0000
Message-ID: <20120221091124.GB22675@n2100.arm.linux.org.uk>
References: <8739aahc0n.fsf@ti.com> <4F3E0655.2040702@ti.com> <0401fed02a58f7bc48cc274050adbac7@localhost> <CAMQu2gwW6ES14jB8E6snE4pQRKg1q2ZF0pBedBtuPxeYV+7cow@mail.gmail.com> <4F3E34A3.4000307@arm.com> <4F3E47F2.2090400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48473 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab2BUJLr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 04:11:47 -0500
Content-Disposition: inline
In-Reply-To: <4F3E47F2.2090400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Feb 17, 2012 at 05:58:34PM +0530, Santosh Shilimkar wrote:
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 4285daa..9834851 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb = {
> 
>  static int twd_cpufreq_init(void)
>  {
> -	if (!IS_ERR(twd_clk))
> +	 if (twd_evt && *__this_cpu_ptr(twd_evt) && !IS_ERR(twd_clk))

You seem to have an additional space before 'if'.
