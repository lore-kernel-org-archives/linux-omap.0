From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH RFC RFT 2/3] clk: clk_put WARNs if user has not disabled
 clk
Date: Thu, 22 Oct 2015 02:57:01 -0700
Message-ID: <20151022095701.20687.92456@quantum>
References: <1438974570-20812-1-git-send-email-mturquette@baylibre.com>
 <1438974570-20812-3-git-send-email-mturquette@baylibre.com>
 <CAMuHMdX8Fq3AfxuZMLe4-CYFzrDiQcwnREQhX5fSGXzYNSkKsA@mail.gmail.com>
 <20151020124000.20687.60752@quantum>
 <CAMuHMdWd9LxrSWO5snriW+fb_d8FtMeXUBjp3M-Oeahh+FzJcw@mail.gmail.com>
 <20151021105932.GP32536@n2100.arm.linux.org.uk>
 <20151021155057.20687.14055@quantum>
 <CAMuHMdWgf8DOhaDLcQ=qJx0r7G0zK_yfWRpVOPBV--SW2Rw1kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdWgf8DOhaDLcQ=qJx0r7G0zK_yfWRpVOPBV--SW2Rw1kA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Quoting Geert Uytterhoeven (2015-10-21 09:46:35)
> Hi Mike,
> 
> On Wed, Oct 21, 2015 at 5:50 PM, Michael Turquette
> <mturquette@baylibre.com> wrote:
> > Quoting Russell King - ARM Linux (2015-10-21 03:59:32)
> >> On Wed, Oct 21, 2015 at 11:50:07AM +0200, Geert Uytterhoeven wrote:
> >> > On Tue, Oct 20, 2015 at 2:40 PM, Michael Turquette
> >> > <mturquette@baylibre.com> wrote:
> >> > > Why not keep the reference to the struct clk after get'ing it the first
> >> > > time?
> >> >
> >> > And store it where?
> >>
> >> Not my problem :)
> >>
> >> Users are supposed to hold on to the reference obtained via clk_get()
> >> while they're making use of the clock: in some implementations, this
> >> increments the module use count if the clock driver is a module, and
> >> may have other effects too.
> >>
> >> Dropping that while you're still requiring the clock to be enabled is
> >> unsafe: if it is provided by a module, then removing and reinserting
> >> the module may very well change the enabled state of the clock, it
> >> most certainly will disrupt the enable count.
> >>
> >> It's always been this way, right from the outset, and when I've seen
> >> people doing this bollocks, I've always pointed out that it's wrong.
> >> Generally, people will fix it once they become aware of it, so it's
> >> really that people just don't like reading and conforming to published
> >> API requirements.
> >>
> >> I think the root cause is that people just don't like reading what
> >> other people write in terms of documentation, and they prefer to go
> >> off and do their own thing, provided it works for them.
> >
> > Right, so in other words this problem must be solved by the caller of
> > clk_get, as it should be. I have never much looked at the pm clk code in
> > question, but I gave it a quick look and came up with some example code
> > that does not compile, in an effort to be as helpful as possible.
> >
> > Basically I added a flex array to struct pm_clk_notifier_block, so that
> > now there are two flex arrays which is stupid. But I am too lazy to
> > replace the nbclk->clks thing with a malloc after walking all of the
> > clk_id's to figure out the number of clocks. Or we could just add
> > .num_clk to the struct, fix up all 4 users of it and drop the NULL
> > sentinel used the .clk_id's... Hmm that would have been better.
> 
> Thanks for trying.
> 
> > index 25266c6..45e58fe 100644
> > --- a/include/linux/pm_clock.h
> > +++ b/include/linux/pm_clock.h
> > @@ -16,6 +16,7 @@ struct pm_clk_notifier_block {
> >         struct notifier_block nb;
> >         struct dev_pm_domain *pm_domain;
> >         char *con_ids[];
> > +       struct clk *clks[];
> >  };
> >
> >  struct clk;
> 
> Unfortunately that won't work: while the .con_ids[] array is per-platform,
> the .clks[] array should be per-device. I.e. it should be tied to the struct
> device, not to the struct pm_clk_notifier_block.

Well you're right about that. But the problem needs to be solved at some
point. There is no good technical reason for this violation to occur
other than, "it's been this way for a while now, so let's keep it".
Essentially it's blocking the per-user imbalance checks that I'd like to
merge.

Or we could accept lots of noisy warns for the CONFIG_PM=n case.

Regards,
Mike

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
