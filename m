From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v1 1/5] ARM: cache-l2x0: add 'smc' identifier
Date: Tue, 29 Jan 2013 11:33:25 +0000
Message-ID: <20130129113325.GG2637@n2100.arm.linux.org.uk>
References: <20130129101328.GA11878@bnru10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130129101328.GA11878@bnru10>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, avorontsov@mvista.com, gregory.clement@free-electrons.com, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de, shawn.guo@linaro.org, rubini@unipv.it, linus.walleij@linaro.org, linux-omap@vger.kernel.org, tony@atomide.com, horms@verge.net.au, magnus.damm@gmail.com, viresh.linux@gmail.com, shiraz.hashim@st.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 29, 2013 at 03:43:31PM +0530, srinidhi kasagar wrote:
> Add 'smc' (Secure Monitor Call) identifier to differentiates
> the platforms which implements this.

This patch makes no sense.

So, if setting 'smc' in the DT description is supposed to mean that
the platform has a secure monitor then...

> +	is_smc = of_property_read_bool(np, "smc");
> +
> +	if (is_smc) {
> +		/* set the debug interface */
> +		outer_cache.set_debug = pl310_set_debug;
> +	}

Now, let's look at what pl310_set_debug() does:

static void pl310_set_debug(unsigned long val)
{
        writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
}

Can you explain where the secure monitor call is there please, because
I can't see one.  In fact, this is the function used when there _isn't_
a secure monitor.  So this patch just seems totally wrong to me.
