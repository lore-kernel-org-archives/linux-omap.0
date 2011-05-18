From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 03/11] OMAP3+: PM: VP: fix vstepmax
Date: Wed, 18 May 2011 10:58:06 +0200
Message-ID: <87liy4xu5d.fsf@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
	<1305695854-9638-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:33829 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755396Ab1ERI6j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 04:58:39 -0400
Received: by wwa36 with SMTP id 36so1259624wwa.25
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 01:58:21 -0700 (PDT)
In-Reply-To: <1305695854-9638-4-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 18 May 2011 00:17:26 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Kevin's
> OMAP3+: VP: remove omap_vp_runtime_data
>
> has a typo to fix which causes waittime to be populated for stepmax.
> this is flawed.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Adding to voltdm queue, will fold into original patch.

Thanks for testing/finding/fixing!

Kevin

> ---
>  arch/arm/mach-omap2/vp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 6336ba6..e7d38f6 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -87,7 +87,7 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
>  	voltdm->write(val, vp->vstepmin);
>  
>  	/* VSTEPMAX */
> -	val = (waittime << vp->common->vstepmax_stepmax_shift) |
> +	val = (vstepmax << vp->common->vstepmax_stepmax_shift) |
>  		(waittime << vp->common->vstepmax_smpswaittimemax_shift);
>  	voltdm->write(val, vp->vstepmax);
