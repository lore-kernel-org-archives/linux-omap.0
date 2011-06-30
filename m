From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP3: Enabling IO Daisy Chain
Date: Thu, 30 Jun 2011 16:33:36 -0700
Message-ID: <87oc1ec2sv.fsf@ti.com>
References: <BANLkTinw1Qz7Q7H0n+d=3WA93Hpzty_g5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39604 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752373Ab1F3Xdp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 19:33:45 -0400
Received: by mail-iy0-f177.google.com with SMTP id 15so2899188iyn.8
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 16:33:40 -0700 (PDT)
In-Reply-To: <BANLkTinw1Qz7Q7H0n+d=3WA93Hpzty_g5w@mail.gmail.com> (Mohan V.'s
	message of "Thu, 30 Jun 2011 12:39:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mohan V <mohanvforum@gmail.com>
Cc: linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

+Tero

Mohan V <mohanvforum@gmail.com> writes:

> Hello all,
>
> I am trying to correct the implementation of the enabling/disabling IO
> daisy chain in omap3. 

Thanks for doing the investigation and proposing a fix!

> I am following the steps as listed in the OMAP36xx TRM Sec. 3.5.7.2.2
> for the same.

Please add the TRM reference in the changelog (preferablly the public
TRM reference, otherwise note it's the NDA TRM.)

> Branch: linux-omap-pm: "pm" branch

Patch should be generated against mainline.  There shouldn't be any
dependencies on my PM branch.

> config: omap2plus_defconfig
>
> Please find the below patch for the same.

In the future, please send patches inline.  Any meta-comments that
should not be in the git history can go after the '---' line in the
changelog.

> ------------------------------------------------------------
>
> From: Mohan <mohanv@ti.com>
> Date: Thu, 30 Jun 2011 12:19:55 +0530
> Subject: [PATCH] omap3: pm: correct enable/disable of daisy io chain
>
> Currently the enabling and disabling of IO Daisy chain is not
> according to the TRM.
> The below steps are followed to enable/disable the IO chain.
>
> Steps to enable IO chain:
> (a) Set PM_WKEN_WKUP.EN_IO bit
> (b) Set the PM_WKEN_WKUP.EN_IO_CHAIN bit
> (c) Poll for PM_WKST_WKUP.ST_IO_CHAIN. When set to 1, clear it.
>
> Steps to disable IO chain:
> [a] Clear PM_WKEN_WKUP.EN_IO_CHAIN bit
> [b] Clear PM_WKEN_WKUP.EN_IO bit
> [c] Clear PM_WKST_WKUP.ST_IO bit by writing 1 to it.

Here, please report what platforms this was tested on.  It should at
least be tested using off-mode on 3430 and 3630.

Also, I think we need to skip step 'c' of both, since that part will be
handled later by the PRCM interrup handler.  If we clear them here, by
the time the PRCM interrupt handler runs, we won't be able to detect
there was a wakeup.

Kevin

> Signed-off-by: Mohan V <mohanv@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index d8c00e4..7f0d371 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -91,7 +91,7 @@ static void omap3_enable_io_chain(void)
>  		/* Do a readback to assure write has been done */
>  		prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>
> -		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
> +		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKST) &
>  			 OMAP3430_ST_IO_CHAIN_MASK)) {
>  			timeout++;
>  			if (timeout > 1000) {
> @@ -99,9 +99,9 @@ static void omap3_enable_io_chain(void)
>  				       "activation failed.\n");
>  				return;
>  			}
> -			prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
> -					     WKUP_MOD, PM_WKEN);
>  		}
> +		prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
> +					     WKUP_MOD, PM_WKST);
>  	}
>  }
>
> @@ -572,6 +572,7 @@ void omap_sram_idle(void)
>  			core_next_state < PWRDM_POWER_ON) {
>  		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
>  		omap3_disable_io_chain();
> +		prm_set_mod_reg_bits(OMAP3430_ST_IO_MASK, WKUP_MOD, PM_WKST);
>  	}
>
>  	pwrdm_post_transition();
