From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+ hwmod: Allow modules to disable HW_AUTO
Date: Tue, 14 Mar 2017 08:48:44 -0700
Message-ID: <20170314154843.GD20572@atomide.com>
References: <1489405996-10718-1-git-send-email-rogerq@ti.com>
 <1489405996-10718-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489405996-10718-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: paul@pwsan.com, bcousson@baylibre.com, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [170313 04:55]:

> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2149,7 +2149,7 @@ static int _idle(struct omap_hwmod *oh)
>  		_idle_sysc(oh);
>  	_del_initiator_dep(oh, mpu_oh);
>  
> -	if (oh->clkdm)
> +	if (oh->clkdm && !(oh->flags & HWMOD_CLKDM_NOAUTO))
>  		clkdm_deny_idle(oh->clkdm);
>  
>  	if (oh->flags & HWMOD_BLOCK_WFI)

Is this change to _idle() really needed? It seems that the
clkdm_deny_idle() there is paired with the clkdm_allow_idle()
later on in the same function?

Regards,

Tony
