From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Change hardreset soc_ops for
 AM43XX
Date: Mon, 16 Jun 2014 04:43:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406160441150.26773@utopia.booyaka.com>
References: <1402347553-26029-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34592 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbaFPEnG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 00:43:06 -0400
In-Reply-To: <1402347553-26029-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Dave,

On Mon, 9 Jun 2014, Dave Gerlach wrote:

> am43xx reset register layout is more similar to am33xx than omap4 so
> use the am33xx functions for hwmod hardreset soc_ops rather than the
> currently used omap4 functions. Without this, assert_hardreset and
> deassert_hardreset will not work on am43xx.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 66c60fe..1c0885b 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -4251,9 +4251,9 @@ void __init omap_hwmod_init(void)
>  		soc_ops.enable_module = _omap4_enable_module;
>  		soc_ops.disable_module = _omap4_disable_module;
>  		soc_ops.wait_target_ready = _omap4_wait_target_ready;
> -		soc_ops.assert_hardreset = _omap4_assert_hardreset;
> -		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
> -		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
> +		soc_ops.assert_hardreset = _am33xx_assert_hardreset;
> +		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
> +		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
>  		soc_ops.init_clkdm = _init_clkdm;
>  	} else if (soc_is_am33xx()) {
>  		soc_ops.enable_module = _am33xx_enable_module;

Should AM43XX be using the _am33xx_{enable,disable}_module and 
wait_target_ready functions?  


- Paul
