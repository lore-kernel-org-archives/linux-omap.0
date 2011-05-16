From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCHv2 2/2] [RFC] OMAP4: clock data: shrink more clock data.
Date: Mon, 16 May 2011 12:23:01 +0530
Message-ID: <20110516065301.GA12703@avinash-laptop>
References: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
 <1305495958-2236-3-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44028 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751739Ab1EPGxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 02:53:17 -0400
Received: by mail-gx0-f178.google.com with SMTP id 8so1740109gxk.37
        for <linux-omap@vger.kernel.org>; Sun, 15 May 2011 23:53:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305495958-2236-3-git-send-email-vzapolskiy@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, May 16, 2011 at 12:45:58AM +0300, Vladimir Zapolskiy wrote:
> This mass change continues the reduction of homogeneous data chunks
> along clock definitions. No semantical difference is added in the
> change.
> 
> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> ---

[ ... ]

> +DEFINE_CLOCK_DM(gpu_fck, dpll_core_m7x2_ck, l3_gfx_clkdm,
> +		CLOCK_OPS_DFLT_SW(CM_GFX_GFX),
> +		CLOCK_CLKSEL0(sgx_clk_mux_sel,
> +			      CM_GFX_GFX_CLKCTRL, CLKSEL_SGX_FCLK));
>  

Hi Vladimir ,

With this the rate wouldn't get initialised and it throws a warning at
boot.

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/mach-omap2/clkt_clksel.c:194 omap2_clksel_recalc+0xd4/0xe4()
[    0.000000] clock: Could not find fieldval 1 for clock gpu_fck parent dpll_core_m7x2_ck
[    0.000000] Modules linked in:
[    0.000000] [<c005fd5c>] (unwind_backtrace+0x0/0xe4) from [<c00921b4>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c00921b4>] (warn_slowpath_common+0x4c/0x64) from [<c009224c>] (warn_slowpath_fmt+0x2c/0x3c)
[    0.000000] [<c009224c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0072594>] (omap2_clksel_recalc+0xd4/0xe4)
[    0.000000] [<c0072594>] (omap2_clksel_recalc+0xd4/0xe4) from [<c007712c>] (propagate_rate+0x24/0x50)
[    0.000000] [<c007712c>] (propagate_rate+0x24/0x50) from [<c0077138>] (propagate_rate+0x30/0x50)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---

Will be fixed with this change below :

-		CLOCK_CLKSEL0(sgx_clk_mux_sel,
+		CLOCK_CLKSEL_INIT(sgx_clk_mux_sel,

May be CLOCK_CLKSEL0 is not required altogether. I see it used only to
initialise gpu_fck. May be can remove this.

I boot tested it on 4430 sdp. FWIW , you can add 
Tested-by: Avinash.H.M. <avinashhm@ti.com>

thanks,

- Avinash
 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
