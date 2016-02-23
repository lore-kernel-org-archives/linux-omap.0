From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 2/2] clk: ti: Add support for dm814x ADPLL
Date: Tue, 23 Feb 2016 14:47:31 +0100
Message-ID: <CAALWOA-dA1r5Ac-y7d3yLhDR1fNM5WJvOmQ3YvvNM+6NP84VLw@mail.gmail.com>
References: <1455312009-808-1-git-send-email-tony@atomide.com>
 <1455312009-808-3-git-send-email-tony@atomide.com> <20160217011930.2278.38316@quark.deferred.io>
 <20160217173949.GB21202@atomide.com> <20160217205257.2278.11639@quark.deferred.io>
 <20160217212045.GE21202@atomide.com> <20160217230253.2278.80903@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160217230253.2278.80903@quark.deferred.io>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On 17 February 2016 at 22:20, Tony Lindgren <tony@atomide.com> wrote:
>* Michael Turquette <mturquette@baylibre.com> [160217 12:53]:
>> Do you think you will ever have a driver that wants to gate these
>> clocks? Probably not for MPU/DDR, but the HAND_OFF flag is a better fit
>> if you do. It's the same as CRITICAL but transfers the prepare/enable
>> reference counting to the consumer driver after that driver calls
>> clk_get() and clk_prepare_enable() on the HAND_OFF clk.
>
> OK I'll use CLK_ENABLE_HAND_OFF then. Who knows maybe somebody
> somewhere has code running on one of the coprocessors in SRAM that
> actually allows gating these :)

An arrangement somewhat similar to the one the am335x has should
indeed be doable, but note that it would be the coprocessor that would
gate and ungate the clocks, not linux. The L3 clock is actually even
more essential and can never be gated at all.

In the absence of help from a coprocessor linux could still put the L3
and MPU PLLs into bypass for power saving, and DDR can be gated if
it's first put into self-refresh and helper code in on-chip SRAM is
used to manage the transitions.

On 18 February 2016 at 00:02, Michael Turquette <mturquette@baylibre.com> wrote:
> Low power mp3 decoder executing out of ARM icache with DDR clock cut ;-)

L1 cache is rather tricky since you can't lock it. You can however
lock 448 KB of the 512 KB L2 cache, which should be plenty of space.
There's also quite a bit of SRAM on chip usable for buffering data.

The C674x DSP would probably also be a good candidate for such an application.

Matthijs
