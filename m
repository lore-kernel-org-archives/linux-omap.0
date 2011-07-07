From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v3 03/13] OMAP4: hwmod: Replace CLKCTRL absolute
 address with offset macros
Date: Thu, 7 Jul 2011 11:27:58 -0700
Message-ID: <20110707182758.GA32199@google.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
 <1309554558-19819-4-git-send-email-b-cousson@ti.com>
 <alpine.DEB.2.00.1107070223340.30028@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:62323 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab1GGS2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 14:28:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107070223340.30028@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jul 07, 2011 at 02:25:23AM -0600, Paul Walmsley wrote:
> On Fri, 1 Jul 2011, Benoit Cousson wrote:
> 
> > The CLKCTRL register was accessed using an absolute address.
> > The usage of hardcoded macros to calculate virtual address from physical
> > one should be avoided as much as possible.
> > The usage of a offset will allow future improvement like migration from
> > the current architecture code toward a module driver.
> > 
> > Update cm_xxx accessor, move definition to the proper header file and
> > update copyrights.
> > 
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> 
> This patch was updated to use '_cminst_' in the function names that are in 
> the cminst44xx.c file, rather than '_cm_', to preserve consistency with 
> the rest of the file.  Updated patch below.
> 
...
> -int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg)
> +int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
>  {
>  	int i = 0;
>  
> -	if (!clkctrl_reg)
> +	if (!clkctrl_offs)
>  		return 0;
>  
>  	omap_test_timeout((
> -		((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) == 0) ||
> -		 (((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) >>
> -		  OMAP4430_IDLEST_SHIFT) == 0x2)),
> +		_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) == 0 ||
> +		_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) == 0x2),
>  		MAX_MODULE_READY_TIME, i);

Suggest adding symbols for the constant IDLEST values, next to the 0x3
value added for "[PATCH v2 04/13] OMAP: hwmod: Wait the idle status to
be disabled".

Would be nice to call _clkctrl_idlest() once.

Similar vague questioning of the API names as for the above-mentioned
patch: this waits for the module slave to be ready, don't know if
anything similar is needed for module masters or if it's important to
keep this distinction.


Todd
