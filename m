From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: AM43x: L2 cache support
Date: Fri, 28 Mar 2014 10:50:54 +0000
Message-ID: <20140328105054.GD27282@n2100.arm.linux.org.uk>
References: <5ea7277c21215c7b4aa776d5379dc2d6263228c6.1395994759.git.nsekhar@ti.com> <013dda556020e852a1bc5b875427e68ab9fdf69a.1395994759.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41165 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751977AbaC1KvN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 06:51:13 -0400
Content-Disposition: inline
In-Reply-To: <013dda556020e852a1bc5b875427e68ab9fdf69a.1395994759.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 28, 2014 at 02:05:29PM +0530, Sekhar Nori wrote:
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 8f18460..763a169 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -188,7 +188,7 @@ static int __init omap_l2_cache_init(void)
>  	 * To avoid code running on other OMAPs in
>  	 * multi-omap builds
>  	 */
> -	if (!cpu_is_omap44xx())
> +	if (!cpu_is_omap44xx() && !soc_is_am43xx())
>  		return -ENODEV;
>  
>  	/* Static mapping, never released */
> @@ -200,6 +200,7 @@ static int __init omap_l2_cache_init(void)
>  	 * 16-way associativity, parity disabled
>  	 * Way size - 32KB (es1.0)
>  	 * Way size - 64KB (es2.0 +)
> +	 * Way size - 16KB (am43xx)
>  	 */
>  	aux_ctrl = ((1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
>  			(0x1 << 25) |
> @@ -208,6 +209,11 @@ static int __init omap_l2_cache_init(void)
>  
>  	if (omap_rev() == OMAP4430_REV_ES1_0) {
>  		aux_ctrl |= 0x2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
> +	} else if (soc_is_am43xx()) {
> +		aux_ctrl |= ((0x1 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |

NAK.  This is cargo cult programming.  Again, this code is entirely
removed by my L2 cache series.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
