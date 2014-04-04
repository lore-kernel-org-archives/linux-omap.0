From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Fri, 4 Apr 2014 11:18:08 +0100
Message-ID: <20140404101808.GG27282@n2100.arm.linux.org.uk>
References: <cover.1396605300.git.nsekhar@ti.com> <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50160 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752444AbaDDKSg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2014 06:18:36 -0400
Content-Disposition: inline
In-Reply-To: <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 04, 2014 at 03:40:29PM +0530, Sekhar Nori wrote:
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index f8b8dac..6b2a056 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -224,6 +224,14 @@ int __init omap4_l2_cache_init(void)
>  
>  	return omap_l2_cache_init(aux_ctrl, 0xc19fffff);
>  }
> +
> +int __init am43xx_l2_cache_init(void)
> +{
> +	u32 aux_ctrl = L310_AUX_CTRL_DATA_PREFETCH |
> +		       L310_AUX_CTRL_INSTR_PREFETCH;

It would be good to documenting the difference between this and OMAP4,
and why you have chosen different values.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
