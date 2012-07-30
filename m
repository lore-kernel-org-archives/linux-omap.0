From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 1/3] ARM: omap: clk: add clk_prepare and
 clk_unprepare
Date: Mon, 30 Jul 2012 16:31:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com>
References: <1341224669-15231-1-git-send-email-rnayak@ti.com> <1341224669-15231-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33024 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095Ab2G3WbY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 18:31:24 -0400
In-Reply-To: <1341224669-15231-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi

On Mon, 2 Jul 2012, Rajendra Nayak wrote:

> As part of Common Clk Framework (CCF) the clk_enable() operation
> was split into a clk_prepare() which could sleep, and a clk_enable()
> which should never sleep. Similarly the clk_disable() was
> split into clk_disable() and clk_unprepare(). This was
> needed to handle complex cases where in a clk gate/ungate
> would require a slow and a fast part to be implemented.
> None of the clocks below seem to be in the 'complex' clocks
> category and are just simple clocks which are enabled/disabled
> through simple register writes.
> Most of the instances also seem to be called in non-atomic
> context which means its safe to move all of those from
> using a clk_enable() to clk_prepare_enable() and clk_disable() to
> clk_disable_unprepare().
> For a few others where there is a possibility they get called from
> an interrupt or atomic context, there is an additonal clk_prepare()
> done before a clk_enable() and a clk_unprepare()
> after a clk_disable().
> This is in preparation of OMAP moving to CCF.
> 
> Based on initial changes from Mike turquette.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Looking at this one, it seems basically okay except for this part:

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 7731936..f904993 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -608,6 +608,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
>  			   oh->name, oh->main_clk);
>  		return -EINVAL;
>  	}
> +	clk_prepare(oh->_clk);
>  
>  	if (!oh->_clk->clkdm)
>  		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
> @@ -645,6 +646,7 @@ static int _init_interface_clks(struct omap_hwmod *oh)
>  			ret = -EINVAL;
>  		}
>  		os->_clk = c;
> +		clk_prepare(os->_clk);
>  	}
>  
>  	return ret;
> @@ -672,6 +674,7 @@ static int _init_opt_clks(struct omap_hwmod *oh)
>  			ret = -EINVAL;
>  		}
>  		oc->_clk = c;
> +		clk_prepare(oc->_clk);
>  	}
>  
>  	return ret;

Seems to me that the strategy here of calling clk_prepare() right after 
the clk_get() is only going to work as long as clk_prepare() is a no-op. 
Right now this code is called early in the boot before many subsystems are 
available.

So if we make a change like this one, it seems like we would basically 
expect it to break once we start doing anything meaningful with 
clk_prepare(), like using clk_prepare() for voltage scaling or something 
that requires I2C?  We'd also probably want to mark this with some kind of 
"HACK" comment.
 


- Paul
