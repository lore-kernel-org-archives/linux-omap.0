From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHV3] OMAP3630: Clock: Workaround for DPLL HS divider
 limitation
Date: Tue, 9 Feb 2010 23:25:05 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002092323260.28188@utopia.booyaka.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B7E82B7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33845 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab0BJGZF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 01:25:05 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B7E82B7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Turquette, Mike" <mturquette@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hello Vijayakumar,

On Wed, 10 Feb 2010, G.N, Vijayakumar wrote:

> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > 
> > Shouldn't there also be a:
> > 
> > dummy_v &= clk->parent->clksel_mask;
> > 
> > here to avoid writing to reserved bits?
> 
> XOR with "0x00" will always retains the original values, hence I don't see any requirement of mask.
> 
> Example:
> For CM_CLKSEL1_PLL
>  
> clksel_mask:
> #define OMAP3430_DIV_DPLL3_MASK				(0x1f << 16)
>  
> clksel_shift = __ffs(clk->parent->clksel_mask); becomes 16
>  
> (1 << clksel_shift) will become (1 << 16)
> 
> XOR operator will only change the Divisor's LSB 1st bit to it's negated value.
>  
> Hence we will be always changing the Divisor's LSB 1's bit and hence 
>  the value written will be different one from the existing value and won't be touching any reserved fileds.

OK, thanks, looks like I misread the code.  Queued for 2.6.34.


- Paul
