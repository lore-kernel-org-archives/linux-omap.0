From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] Patches to get dm814x-evm booting to NFSroot
Date: Thu, 3 Dec 2015 11:21:27 -0800
Message-ID: <20151203192127.GX23396@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <5660872E.8080603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5660872E.8080603@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [151203 10:18]:
> On 12/02/2015 01:38 AM, Tony Lindgren wrote:
> 
> > Tony Lindgren (10):
> >    ARM: OMAP2+: Fix timer entries for dm814x
> >    clk: ti: Add few dm814x clock aliases
> >    ARM: OMAP2+: Add DPPLS clock manager for dm814x
> >    ARM: OMAP2+: Enable GPIO for dm814x
> >    ARM: OMAP2+: Disable GPIO softreset for dm81xx
> >    ARM: OMAP2+: Remove useless check for legacy booting for dm814x
> >    ARM: dts: Fix dm814x entries for pllss and prcm
> >    ARM: dts: Fix some mux and divider clocks to get dm814x-evm booting
> >    ARM: dts: Fix dm8148 control modules ranges
> >    ARM: dts: Fix dm814x pinctrl address and mask
> 
> I'm worry a bit, if you will apply this series in its current order
> - it will break git bisect.
> Patch one "ARM: OMAP2+: Fix timer entries for dm814x" will use timerX_fck, but those
> clocks will be added by patches 2 "clk: ti: Add few dm814x clock aliases"
> and 8 "ARM: dts: Fix some mux and divider clocks to get dm814x-evm booting"

Yeah you have a point there. I was hoping to separate them to dts and soc
related patches but clearly that's not possible.

We can keep t410 limping along just fine with this order:

ARM: dts: Fix dm814x entries for pllss and prcm
clk: ti: Add few dm814x clock aliases
ARM: OMAP2+: Add DPPLS clock manager for dm814x
ARM: dts: Fix some mux and divider clocks to get dm814x-evm booting
ARM: OMAP2+: Fix timer entries for dm814x
ARM: dts: Fix dm8148 control modules ranges
ARM: dts: Fix dm814x pinctrl address and mask
ARM: OMAP2+: Enable GPIO for dm814x
ARM: OMAP2+: Remove useless check for legacy booting for dm814x

Regards,

Tony
