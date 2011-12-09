From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 10/15] omap: beagle: set oscillator startup time to 10ms for rev c4
Date: Fri, 09 Dec 2011 11:11:38 -0800
Message-ID: <878vmlftlh.fsf@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	<1322236188-19456-11-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46321 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153Ab1LITL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 14:11:56 -0500
Received: by yenm12 with SMTP id m12so2923617yen.20
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 11:11:41 -0800 (PST)
In-Reply-To: <1322236188-19456-11-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Fri, 25 Nov 2011 17:49:43 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

Tero Kristo <t-kristo@ti.com> writes:

> Based on the oscillator datasheet for this device.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index a7c3d60..5e3f575 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -516,6 +516,9 @@ static void __init beagle_opp_init(void)
>  			opp_disable(mpu_dev, 720000000);
>  			opp_disable(iva_dev, 520000000);
>  		}
> +
> +		/* Setup oscillator startup time to 10ms */
> +		omap_pm_setup_oscillator(10000, 0);
>  	}

...but shutdown time is probably not zero. :)

This should probably be -1, or ULONG_MAX.

Yes, I see that tshut isn't even used on OMAP3, so it doesn't matter,
but it does help readability IMO.

Kevin
