From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: [PATCH] PM: Prevent direct cpufreq scaling during initialization
Date: Wed, 2 Dec 2009 18:33:38 +0300
Message-ID: <48239d390912020733w2981917ap6312eee193f14263@mail.gmail.com>
References: <1259748759.21203.11.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:19253 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZLBPdc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 10:33:32 -0500
Received: by ey-out-2122.google.com with SMTP id d26so90692eyd.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Dec 2009 07:33:38 -0800 (PST)
In-Reply-To: <1259748759.21203.11.camel@boson>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: romit@ti.com
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org

On Wed, Dec 2, 2009 at 1:12 PM, Romit Dasgupta <romit@ti.com> wrote:
>
> It is seen that the OMAP specific cpufreq initialization code tries to
> scale the MPU frequency to the highest possible without taking care of
> the voltage level. On power on reset the power IC does not provide the
> necessary voltage for the highest available MPU frequency (that would
> satisfy all Si families). This potentially is an window of opportunity
> for things to go wrong.
>
>
> Signed-off-by: Romit Dasgupta <romit@ti.com>
> ---
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index 449b6b6..f94df20 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -149,8 +149,6 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
>                                                        VERY_HI_RATE) / 1000;
>        }
>
> -       clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);
> -
>        policy->min = policy->cpuinfo.min_freq;
>        policy->max = policy->cpuinfo.max_freq;
>        policy->cur = omap_getspeed(0);

This patch leads to hang with current PM branch, SRF and CPU IDLE enabled
on OMAP3525 rev C.
