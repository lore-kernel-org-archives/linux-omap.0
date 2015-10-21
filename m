From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC RFT 2/3] clk: clk_put WARNs if user has not disabled
 clk
Date: Wed, 21 Oct 2015 11:59:32 +0100
Message-ID: <20151021105932.GP32536@n2100.arm.linux.org.uk>
References: <1438974570-20812-1-git-send-email-mturquette@baylibre.com>
 <1438974570-20812-3-git-send-email-mturquette@baylibre.com>
 <CAMuHMdX8Fq3AfxuZMLe4-CYFzrDiQcwnREQhX5fSGXzYNSkKsA@mail.gmail.com>
 <20151020124000.20687.60752@quantum>
 <CAMuHMdWd9LxrSWO5snriW+fb_d8FtMeXUBjp3M-Oeahh+FzJcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWd9LxrSWO5snriW+fb_d8FtMeXUBjp3M-Oeahh+FzJcw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 21, 2015 at 11:50:07AM +0200, Geert Uytterhoeven wrote:
> Hi Mike, Russell,
> 
> On Tue, Oct 20, 2015 at 2:40 PM, Michael Turquette
> <mturquette@baylibre.com> wrote:
> > Why not keep the reference to the struct clk after get'ing it the first
> > time?
> 
> And store it where?

Not my problem :)

Users are supposed to hold on to the reference obtained via clk_get()
while they're making use of the clock: in some implementations, this
increments the module use count if the clock driver is a module, and
may have other effects too.

Dropping that while you're still requiring the clock to be enabled is
unsafe: if it is provided by a module, then removing and reinserting
the module may very well change the enabled state of the clock, it
most certainly will disrupt the enable count.

It's always been this way, right from the outset, and when I've seen
people doing this bollocks, I've always pointed out that it's wrong.
Generally, people will fix it once they become aware of it, so it's
really that people just don't like reading and conforming to published
API requirements.

I think the root cause is that people just don't like reading what
other people write in terms of documentation, and they prefer to go
off and do their own thing, provided it works for them.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
