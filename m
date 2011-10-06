From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP3: hwmod: fix variant registration and remove
	SmartReflex from common list
Date: Thu, 6 Oct 2011 23:35:45 +0100
Message-ID: <20111006223545.GB27281@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1110061433540.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48265 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1JFWfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 18:35:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1110061433540.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Abhilash K V <abhilash.kv@ti.com>, Chase Maupin <chase.maupin@ti.com>

On Thu, Oct 06, 2011 at 02:39:28PM -0600, Paul Walmsley wrote:
> @@ -3240,7 +3240,7 @@ int __init omap3xxx_hwmod_init(void)
>  
>  	/* Register hwmods common to all OMAP3 */
>  	r = omap_hwmod_register(omap3xxx_hwmods);
> -	if (!r)
> +	if (IS_ERR_VALUE(r))
>  		return r;
>  
>  	rev = omap_rev();
> @@ -3265,7 +3265,7 @@ int __init omap3xxx_hwmod_init(void)
>  	};
>  
>  	r = omap_hwmod_register(h);
> -	if (!r)
> +	if (IS_ERR_VALUE(r))
>  		return r;

What _really_ is the return value meaning of omap_hwmod_register() ?

If it's zero for success, negative for error codes, then don't be
clever and try to use IS_ERR_VALUE() for that - just use a standard
< 0 test instead.

You only need to use IS_ERR_VALUE() for stuff that may return negative
errno values _and_ which may return valid addresses which may be
misinterpreted as negative numbers.
