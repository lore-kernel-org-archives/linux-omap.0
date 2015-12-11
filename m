From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] clk: ti: Add support for dm814x ADPLL
Date: Fri, 11 Dec 2015 13:52:37 +0000
Message-ID: <20151211135237.GG30871@n2100.arm.linux.org.uk>
References: <1449800792-5551-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449800792-5551-1-git-send-email-tony@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Philipp Rosenberger <ilu@linutronix.de>, Brian Hutchinson <b.hutchman@gmail.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 10, 2015 at 06:26:32PM -0800, Tony Lindgren wrote:
> +	/* Released with kfree() by clkdev_drop() */
> +	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
> +	if (!cl)
> +		return -ENOMEM;
> +
> +	/* Use clkdev_add, clk_register_clkdev limits length to MAX_CON_ID */
> +	cl->con_id = name;
> +	cl->clk = clock;
> +	cl->clk_hw = __clk_get_hw(clock);
> +	clkdev_add(cl);
> +	d->clocks[index].cl = cl;

NAK.  I've no idea why you're open-coding the clkdev internals (which
seems to have been a historical habbit in OMAP code.)  Please stop
doing this.

You are provided with clkdev_alloc() which will allocate the structure
and initialise it for you, and clkdev_add() which will add the allocated
and initialised struct to the list of lookups.  Everything you're doing
above can be done with clkdev_alloc() + clkdev_add() which have been
there for a _very_ long time.  They're even documented (thanks for
providing me with more proof that documentation is nothing but a waste
of time. :))

Even better is clkdev_create() which eliminates the two step clkdev_alloc()
and clkdev_add() process.

So, the whole of the above can be reduced down to:

	cl = clkdev_create(clock, name, NULL);
	if (!cl)
		return -ENOMEM;

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
