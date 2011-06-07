From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [pm-wip/cpufreq][PATCH 3/3] OMAP2+: cpufreq: do lateinit
Date: Tue, 07 Jun 2011 13:45:24 +0530
Message-ID: <4DEDDE1C.3050506@ti.com>
References: <1307412330-25798-1-git-send-email-nm@ti.com> <1307412330-25798-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:48893 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751499Ab1FGIPb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 04:15:31 -0400
Received: by mail-yi0-f43.google.com with SMTP id 19so924224yie.2
        for <linux-omap@vger.kernel.org>; Tue, 07 Jun 2011 01:15:30 -0700 (PDT)
In-Reply-To: <1307412330-25798-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, kevin <khilman@ti.com>

On 6/7/2011 7:35 AM, Nishanth Menon wrote:
> Since we do module_init, cpufreq initializes before power late_init
> where many of the required data structures are registered. Move
> cpufreq init to late_initcall instead. Further CONFIG_CPU_FREQ
> on which the build depends is bool and does'nt support modules yet.
>
You might want to fix sequence instead of this change
considering we want to make OMAP CPUFReq as a loadable module.


> Signed-off-by: Nishanth Menon<nm@ti.com>
> ---
>   arch/arm/mach-omap2/omap2plus-cpufreq.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 2177381..07c2ab9 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -273,5 +273,5 @@ static void __exit omap_cpufreq_exit(void)
>
>   MODULE_DESCRIPTION("cpufreq driver for OMAP2PLUS SOCs");
>   MODULE_LICENSE("GPL");
> -module_init(omap_cpufreq_init);
> +late_initcall(omap_cpufreq_init);
>   module_exit(omap_cpufreq_exit);

