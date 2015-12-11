From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] clk: ti: Add support for dm814x ADPLL
Date: Fri, 11 Dec 2015 07:48:54 -0800
Message-ID: <20151211154854.GK23396@atomide.com>
References: <1449800792-5551-1-git-send-email-tony@atomide.com>
 <20151211135237.GG30871@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151211135237.GG30871@n2100.arm.linux.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Philipp Rosenberger <ilu@linutronix.de>, Brian Hutchinson <b.hutchman@gmail.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [151211 05:53]:
> On Thu, Dec 10, 2015 at 06:26:32PM -0800, Tony Lindgren wrote:
> > +	/* Released with kfree() by clkdev_drop() */
> > +	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
> > +	if (!cl)
> > +		return -ENOMEM;
> > +
> > +	/* Use clkdev_add, clk_register_clkdev limits length to MAX_CON_ID */
> > +	cl->con_id = name;
> > +	cl->clk = clock;
> > +	cl->clk_hw = __clk_get_hw(clock);
> > +	clkdev_add(cl);
> > +	d->clocks[index].cl = cl;
> 
> NAK.  I've no idea why you're open-coding the clkdev internals (which
> seems to have been a historical habbit in OMAP code.)  Please stop
> doing this.
>
> You are provided with clkdev_alloc() which will allocate the structure
> and initialise it for you, and clkdev_add() which will add the allocated
> and initialised struct to the list of lookups.  Everything you're doing
> above can be done with clkdev_alloc() + clkdev_add() which have been
> there for a _very_ long time.  They're even documented (thanks for
> providing me with more proof that documentation is nothing but a waste
> of time. :))

I tried, but I was seeing mysterious silent failures for some clocks.

> Even better is clkdev_create() which eliminates the two step clkdev_alloc()
> and clkdev_add() process.
> 
> So, the whole of the above can be reduced down to:
> 
> 	cl = clkdev_create(clock, name, NULL);
> 	if (!cl)
> 		return -ENOMEM;
> 

There's a problem with MAX_CON_ID 16 hardcoded allocated name length.

In this case I have 13 instances of plls with 3 - 4 outputs each and I'd
like to use "481c5040.adpll.clkout" style naming starting with the instance
address. Also "adpll5.clkdcoldo" style naming would work,

Below is a patch we should probably apply as a band aid to produce a proper
warning.

Naturally we don't want to allocate longer names for all the clocks.. And
we already do have some const names coming from device tree we could use.

What if we optionally allow passing a name to clkdev and add some flag
that tells clkdev code not to attempt to free it? Or do you have better
ideas in mind to fix the issue?

Regards,

Tony

8< ----------------
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 11 Dec 2015 07:28:36 -0800
Subject: [PATCH] clkdev: Make silent failures of clk_get() produce a proper
 warning

Otherwise we can see mysterious failures with some clocks where
the name is longer than MAX_CON_ID 16. This can easily happen with
clock names coming from device tree for example in the form of
"481c5040.adpll.clkout" or "adpll1.clkdcoldo".

Let's make things a bit easier to debug by adding a warning for
the clock name. Note that we don't want to error out here as the
string matching still probably does the right thing for most
clocks.

Also note that we should also remove the hardcoded name allocation
in clkdev by adding functions that allow passing a name to clkdev
optionally.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -256,6 +256,10 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 {
 	struct clk_lookup_alloc *cla;
 
+	if (strlen(con_id) > MAX_CON_ID)
+		pr_warn("%s length of %s > %i, clock lookup can fail\n",
+			__func__, con_id, MAX_CON_ID);
+
 	cla = __clkdev_alloc(sizeof(*cla));
 	if (!cla)
 		return NULL;
