From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Tue, 24 Feb 2015 18:18:00 -0800
Message-ID: <20150225021800.421.95142@quantum>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <54D3C803.30706@samsung.com> <54D3CD6A.1010209@codeaurora.org>
 <54D3EB29.4090007@codeaurora.org>
 <20150206004210.GB8670@n2100.arm.linux.org.uk>
 <54D41A60.8040702@codeaurora.org>
 <20150206133920.GC8670@n2100.arm.linux.org.uk>
 <54D5164A.30503@codeaurora.org> <20150219213233.421.11915@quantum>
 <20150224140808.GG8670@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150224140808.GG8670@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Russell King - ARM Linux (2015-02-24 06:08:08)
> On Thu, Feb 19, 2015 at 01:32:33PM -0800, Mike Turquette wrote:
> > Quoting Stephen Boyd (2015-02-06 11:30:18)
> > > On 02/06/15 05:39, Russell King - ARM Linux wrote:
> > > > On Thu, Feb 05, 2015 at 05:35:28PM -0800, Stephen Boyd wrote:
> > > >
> > > >> From what I can tell this code is
> > > >> now broken because we made all clk getting functions (there's quite a
> > > >> few...) return unique pointers every time they're called. It seems that
> > > >> the driver wants to know if extclk and clk are the same so it can do
> > > >> something differently in kirkwood_set_rate(). Do we need some sort of
> > > >> clk_equal(struct clk *a, struct clk *b) function for drivers like this?
> > > > Well, the clocks in question are the SoC internal clock (which is more or
> > > > less fixed, but has a programmable divider) and an externally supplied
> > > > clock, and the IP has a multiplexer on its input which allows us to select
> > > > between those two sources.
> > > >
> > > > If it were possible to bind both to the same clock, it wouldn't be a
> > > > useful configuration - nothing would be gained from doing so in terms of
> > > > available rates.
> > > >
> > > > What the comparison is there for is to catch the case with legacy lookups
> > > > where a clkdev lookup entry with a NULL connection ID results in matching
> > > > any connection ID passed to clk_get().  If the patch changes this, then
> > > > we will have a regression - and this is something which needs fixing
> > > > _before_ we do this "return unique clocks".
> > > >
> > > 
> > > Ok. It seems that we might need a clk_equal() or similar API after all.
> > > My understanding is that this driver is calling clk_get() twice with
> > > NULL for the con_id and then "extclk" in attempts to get the SoC
> > > internal clock and the externally supplied clock. If we're using legacy
> > > lookups then both clk_get() calls may map to the same clk_lookup entry
> > > and before Tomeu's patch that returns unique clocks the driver could
> > > detect this case and know that there isn't an external clock. Looking at
> > > arch/arm/mach-dove/common.c it seems that there is only one lookup per
> > > device and it has a wildcard NULL for con_id so both clk_get() calls
> > > here are going to find the same lookup and get a unique struct clk pointer.
> > > 
> > > Why don't we make the legacy lookup more specific and actually indicate
> > > "internal" for the con_id? Then the external clock would fail to be
> > > found, but we can detect that case and figure out that it's not due to
> > > probe defer, but instead due to the fact that there really isn't any
> > > mapping. It looks like the code is already prepared for this anyway.
> > > 
> > > ----8<----
> > > 
> > > From: Stephen Boyd <sboyd@codeaurora.org>
> > > Subject: [PATCH] ARM: dove: Remove wildcard from mvebu-audio device clk lookup
> > > 
> > > This i2s driver is using the wildcard nature of clkdev lookups to
> > > figure out if there's an external clock or not. It does this by
> > > calling clk_get() twice with NULL for the con_id first and then
> > > "external" for the con_id the second time around and then
> > > compares the two pointers. With DT the wildcard feature of
> > > clk_get() is gone and so the driver has to handle an error from
> > > the second clk_get() call as meaning "no external clock
> > > specified". Let's use that logic even with clk lookups to
> > > simplify the code and remove the struct clk pointer comparisons
> > > which may not work in the future when clk_get() returns unique
> > > pointers.
> > > 
> > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > Russell et al,
> > 
> > I'm happy to take this patch through the clock tree (where the problem
> > shows up) with an ack.
> 
> It's not up to me - I don't maintain this driver.  I'm just an interested
> party.

Sure.

> 
> Note that much more than just this has now broken.  The iMX6 code has
> broken as well, and it's not going to take such a simple fix there to
> fix it either.
> 
> Please either revert the patches creating this breakage (and have another
> attempt at the next merge window) or supply fixes for these places.

Let's try the latter. Stephen used coccinelle to find similar instances
of clk pointer comparisons[0]. As a stop-gap solution we can introduce a
clk_is_match(struct clk *a, struct clk *b) function and sub it for the
handful of drivers that do this behavior and use CCF.

[0] http://lkml.kernel.org/r/<54E3BA20.3080205@codeaurora.org>

Regards,
Mike

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
