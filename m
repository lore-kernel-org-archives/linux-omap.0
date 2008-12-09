From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Bug in linux omap clock framework?
Date: Tue, 9 Dec 2008 16:14:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812091612240.5902@utopia.booyaka.com>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>  <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>  <1228726770.8668.66.camel@tubuntu>  <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>
 <1228831086.31061.9.camel@tubuntu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39777 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741AbYLIXOs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Dec 2008 18:14:48 -0500
In-Reply-To: <1228831086.31061.9.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Tomi,

On Tue, 9 Dec 2008, Tomi Valkeinen wrote:

> I don't know much about power and clock domains, but I believe I found
> the reason and fix for this. At least this should point to the right
> direction.
> 
> It looks to me that when I do clk_enable() to a clock which is inside a
> turned off powerdomain, clk_enable() function will return before the
> powerdomain is fully turned on. Reading PM_PWSTST_DSS shows that the
> powerdomain is still in transition state.
> 
> The following change waits until the powerdomain has finished the
> transition. At least it fixed the problem for me, and other things seem
> to be still working =).

Nice work - this makes sense.  Tested your patch here also. 

Care to put together a patch with something similar to the description 
above and your Signed-off-by, and send it to the list?  This should go 
into l-o.


- Paul


> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index fa62f14..f713d0b 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -567,6 +567,8 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
>         else
>                 omap2_clkdm_wakeup(clkdm);
>  
> +       pwrdm_wait_transition(clkdm->pwrdm.ptr);
> +
>         return 0;
>  }
> 
> 

