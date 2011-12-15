From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] ARM: OMAP2+: mux: add wakeup-capable hwmod mux
 entries to dynamic list
Date: Thu, 15 Dec 2011 13:41:09 -0800
Message-ID: <20111215214109.GX32251@atomide.com>
References: <20111215213358.26632.44165.stgit@dusk>
 <20111215213609.26632.43406.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35263 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756549Ab1LOVlL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:41:11 -0500
Content-Disposition: inline
In-Reply-To: <20111215213609.26632.43406.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Govindraj R <govindraj.raja@ti.com>

* Paul Walmsley <paul@pwsan.com> [111215 13:05]:
> omap_hwmod_mux() currently only iterates through the dynamic pad list.
> This list currently only consists of pads with the
> OMAP_DEVICE_MUX_REMUX flag set.
> 
> Subsequent patches in this series will cause hwmod mux entries with
> the OMAP_DEVICE_MUX_WAKEUP flag set to be changed dynamically, to
> control hwmod I/O ring wakeup.  For this to work correctly, hwmod mux
> entries with the OMAP_DEVICE_MUX_WAKEUP flag set must also be added to
> the dynamic pad list.  So this patch modifies omap_hwmod_mux_init() to
> do so.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Govindraj R <govindraj.raja@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/mux.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 655e948..a474c81 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -306,7 +306,8 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
>  		pad->idle = bpad->idle;
>  		pad->off = bpad->off;
>  
> -		if (pad->flags & OMAP_DEVICE_PAD_REMUX)
> +		if (pad->flags &
> +		    (OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP))
>  			nr_pads_dynamic++;
>  
>  		pr_debug("%s: Initialized %s\n", __func__, pad->name);
> @@ -331,7 +332,8 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
>  	for (i = 0; i < hmux->nr_pads; i++) {
>  		struct omap_device_pad *pad = &hmux->pads[i];
>  
> -		if (pad->flags & OMAP_DEVICE_PAD_REMUX) {
> +		if (pad->flags &
> +		    (OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP)) {
>  			pr_debug("%s: pad %s tagged dynamic\n",
>  					__func__, pad->name);
>  			hmux->pads_dynamic[nr_pads_dynamic] = pad;
> 
> 
