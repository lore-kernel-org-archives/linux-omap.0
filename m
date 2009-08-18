From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH][PM] ARM: OMAP34xx: Fix compilation warning
Date: Tue, 18 Aug 2009 11:13:43 +0200
Message-ID: <87vdkljxh4.fsf@deeprootsystems.com>
References: <A24693684029E5489D1D202277BE89444A81FBB9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:40056 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbZHRJNr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 05:13:47 -0400
Received: by pxi34 with SMTP id 34so1695458pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2009 02:13:48 -0700 (PDT)
In-Reply-To: <A24693684029E5489D1D202277BE89444A81FBB9@dlee02.ent.ti.com> (Aguirre Rodriguez's message of "Mon\, 17 Aug 2009 09\:46\:17 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

"Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com> writes:

> From: Sergio Aguirre <saaguirre@ti.com>
>
> This fixes the following compilation warnings:
>
> In file included from arch/arm/mach-omap2/resource34xx.c:26:
> arch/arm/mach-omap2/resource34xx.h:32: warning: function declaration isn't a prototype
> arch/arm/mach-omap2/resource34xx.h:33: warning: function declaration isn't a prototype
>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>

Thanks, will pull into PM branch and fold into original patch which
introduced these functions.

Kevin

> ---
>  arch/arm/mach-omap2/resource34xx.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resource34xx.h
> index 5b5618a..3c70eef 100644
> --- a/arch/arm/mach-omap2/resource34xx.h
> +++ b/arch/arm/mach-omap2/resource34xx.h
> @@ -29,8 +29,8 @@
>  #include <mach/omap34xx.h>
>  
>  extern int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
> -extern void lock_scratchpad_sem();
> -extern void unlock_scratchpad_sem();
> +extern void lock_scratchpad_sem(void);
> +extern void unlock_scratchpad_sem(void);
>  
>  /*
>   * mpu_latency/core_latency are used to control the cpuidle C state.
> -- 
> 1.6.3.2
