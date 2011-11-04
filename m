From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 07/11] omap3+: vp: use new vp_params for calculating vddmin and vddmax
Date: Fri, 04 Nov 2011 14:13:00 -0700
Message-ID: <87sjm37fs3.fsf@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
	<1317835031-8201-8-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:60437 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752952Ab1KDVNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 17:13:04 -0400
Received: by mail-iy0-f171.google.com with SMTP id n33so4086253iae.2
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 14:13:02 -0700 (PDT)
In-Reply-To: <1317835031-8201-8-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 5 Oct 2011 20:17:07 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> Now we select the vddmin and vddmax values based on both pmic and
> voltage processor data, this allows usage of different power ICs.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/vp.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 16cb6d4..fd3f43c 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -53,8 +53,12 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
>  	sys_clk_rate = voltdm->sys_clk.rate / 1000;
>  
>  	timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
> -	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmin);
> -	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmax);
> +	vddmin = voltdm->vp_param->vddmin > voltdm->pmic->vp_vddmin ?
> +		voltdm->vp_param->vddmin : voltdm->pmic->vp_vddmin;
> +	vddmax = voltdm->vp_param->vddmax < voltdm->pmic->vp_vddmax ?
> +		voltdm->vp_param->vddmax : voltdm->pmic->vp_vddmax;

For better readability, please use the min() and max() macros here.

Kevin

> +	vddmin = voltdm->pmic->uv_to_vsel(vddmin);
> +	vddmax = voltdm->pmic->uv_to_vsel(vddmax);
>  
>  	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
>  		    sys_clk_rate) / 1000;
