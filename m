From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: mux: correct wrong error messages
Date: Mon, 4 Mar 2013 09:35:30 -0800
Message-ID: <20130304173530.GK11806@atomide.com>
References: <1359850510-32298-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56363 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758085Ab3CDRfc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 12:35:32 -0500
Content-Disposition: inline
In-Reply-To: <1359850510-32298-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ruslan Bilovol <ruslan.bilovol@ti.com> [130202 16:18]:
> This is needed because the omap_mux_get_by_name()
> function calls the _omap_mux_get_by_name subfunction
> for each mux partition until needed mux is not found.
> As a result, we get messages like
> "Could not find signal XXX" for each partition
> where this mux name does not exist.
> 
> This patch fixes wrong error message in
> the _omap_mux_get_by_name() function moving it
> to the omap_mux_get_by_name() one and as result
> reduces noise in the kernel log.
> 
> My kernel log without this patch:
> [...]
> [    0.221801] omap_mux_init: Add partition: #2: wkup, flags: 3
> [    0.222045] _omap_mux_get_by_name: Could not find signal fref_clk0_out.sys_drm_msecure
> [    0.222137] _omap_mux_get_by_name: Could not find signal sys_nirq
> [    0.222167] _omap_mux_get_by_name: Could not find signal sys_nirq
> [    0.225006] _omap_mux_get_by_name: Could not find signal uart1_rx.uart1_rx
> [    0.225006] _omap_mux_get_by_name: Could not find signal uart1_rx.uart1_rx
> [    0.270111] _omap_mux_get_by_name: Could not find signal fref_clk4_out.fref_clk4_out
> [    0.273406] twl: not initialized
> 
> [...]
> 
> My kernel log with this patch:
> [...]
> [    0.221771] omap_mux_init: Add partition: #2: wkup, flags: 3
> [    0.222106] omap_mux_get_by_name: Could not find signal sys_nirq
> [    0.224945] omap_mux_get_by_name: Could not find signal uart1_rx.uart1_rx
> [    0.274536] twl: not initialized
> [...]
> 
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>

Thanks applying into omap-for-v3.9-rc1/fixes.

Regards,

Tony


>  arch/arm/mach-omap2/mux.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 6a217c9..9578ec0 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -211,8 +211,6 @@ static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
>  		return -EINVAL;
>  	}
>  
> -	pr_err("%s: Could not find signal %s\n", __func__, muxname);
> -
>  	return -ENODEV;
>  }
>  
> @@ -234,6 +232,8 @@ int __init omap_mux_get_by_name(const char *muxname,
>  		return mux_mode;
>  	}
>  
> +	pr_err("%s: Could not find signal %s\n", __func__, muxname);
> +
>  	return -ENODEV;
>  }
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
