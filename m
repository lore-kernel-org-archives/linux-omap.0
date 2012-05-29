From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: VC: fix I2C timing
Date: Tue, 29 May 2012 14:30:34 -0700
Message-ID: <877gvuekud.fsf@ti.com>
References: <1336139842-845-1-git-send-email-t-kristo@ti.com>
	<1336139842-845-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:54136 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755875Ab2E2Vag (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 17:30:36 -0400
Received: by dadz8 with SMTP id z8so7628377dad.35
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 14:30:35 -0700 (PDT)
In-Reply-To: <1336139842-845-2-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Fri, 4 May 2012 16:57:20 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> Current I2C timing parameters do not work with Panda board at least.
> Parameters updated based on TI recommendation.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Let's fix this correctly by deriving/calculating them from the proper
source clocks.

Otherwise, this is going to work for Panda and break for something else.

Kevin

> ---
>  arch/arm/mach-omap2/vc.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 1fd976e..a731400 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -585,7 +585,9 @@ static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
>  	omap4_set_timings(voltdm, true);
>  
>  	/* XXX These are magic numbers and do not belong! */
> -	vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430_SCLH_SHIFT);
> +	vc_val = (0x28 << OMAP4430_SCLL_SHIFT | 0x2c << OMAP4430_SCLH_SHIFT);
> +	vc_val |= (0x0b << OMAP4430_HSSCLL_SHIFT);
> +	vc_val |= (0x0 << OMAP4430_HSSCLH_SHIFT);
>  	voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
>  }
