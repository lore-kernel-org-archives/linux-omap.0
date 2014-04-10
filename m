From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Thu, 10 Apr 2014 14:40:28 +0100
Message-ID: <20140410134028.GL27282@n2100.arm.linux.org.uk>
References: <cover.1396605300.git.nsekhar@ti.com> <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com> <20140404101808.GG27282@n2100.arm.linux.org.uk> <53440D73.6060504@ti.com> <20140409162327.GH27282@n2100.arm.linux.org.uk> <534686DF.7070207@ti.com> <20140410120348.GK27282@n2100.arm.linux.org.uk> <53468B8E.9040604@ti.com> <53469C29.8050906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:57195 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030915AbaDJNlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Apr 2014 09:41:07 -0400
Content-Disposition: inline
In-Reply-To: <53469C29.8050906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 10, 2014 at 06:57:05PM +0530, Sekhar Nori wrote:
> On Thursday 10 April 2014 05:46 PM, Sekhar Nori wrote:
> > This will work. NS_LOCKDOWN is required for L2C-220 as well and so I was
> > thinking about adding a new l2c220_enable() which will set the
> > NS_LOCKDOWN and then call l2c_enable()
> 
> Here is a patch for what I was saying above.
> 
> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> index c47ac8f..dc9e03b 100644
> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> @@ -105,6 +105,8 @@
>  #define L2X0_AUX_CTRL_DIRTY_LATENCY_MASK	(7 << 9)
>  #define L2X0_AUX_CTRL_ASSOC_SHIFT		13
>  #define L2X0_AUX_CTRL_ASSOC_MASK		(15 << 13)
> +/* L2C-220/310 common bits */
> +#define L2C_AUX_CTRL_NS_LOCKDOWN		BIT(26)
>  /* L2C-210 specific bits */
>  #define L210_AUX_CTRL_WRAP_DISABLE		BIT(12)
>  #define L210_AUX_CTRL_WA_OVERRIDE		BIT(23)
> @@ -113,7 +115,6 @@
>  #define L220_AUX_CTRL_EXCLUSIVE_CACHE		BIT(12)
>  #define L220_AUX_CTRL_FWA_SHIFT			23
>  #define L220_AUX_CTRL_FWA_MASK			(3 << 23)
> -#define L220_AUX_CTRL_NS_LOCKDOWN		BIT(26)
>  #define L220_AUX_CTRL_NS_INT_CTRL		BIT(27)
>  /* L2C-310 specific bits */
>  #define L310_AUX_CTRL_FULL_LINE_ZERO		BIT(0)	/* R2P0+ */
> @@ -122,7 +123,6 @@
>  #define L310_AUX_CTRL_EXCLUSIVE_CACHE		BIT(12)
>  #define L310_AUX_CTRL_ASSOCIATIVITY_16		BIT(16)
>  #define L310_AUX_CTRL_CACHE_REPLACE_RR		BIT(25)	/* R2P0+ */
> -#define L310_AUX_CTRL_NS_LOCKDOWN		BIT(26)

NAK.  The reason for this split is because the NS lockdown bit is *not*
on L2C-210, and so it does not deserve to be a "common" bit - because it
isn't common to all variants.

> @@ -764,7 +776,7 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
>  			power_ctrl & L310_STNDBY_MODE_EN ? "en" : "dis");
>  	}
>  
> -	l2c_enable(base, aux, num_lock);
> +	l2c220_enable(base, aux, num_lock);

My first reaction to this is to say NAK again - I don't want to create
a multi-layered maze of X calls Y calls Z.  Who's to say that The 220
won't need to do something different from 310 in the future?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
