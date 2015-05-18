From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
Date: Mon, 18 May 2015 08:21:08 -0700
Message-ID: <20150518152108.GE10274@atomide.com>
References: <1431525001-5747-1-git-send-email-robertcnelson@gmail.com>
 <20150513141658.GB6605@localhost>
 <20150513144846.GC6605@localhost>
 <CAALWOA-hkgrMi+OeNrmwaVpdEfNadFn0R-QbpXi9LU-4sbakJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51828 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654AbbERPVL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 May 2015 11:21:11 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA-hkgrMi+OeNrmwaVpdEfNadFn0R-QbpXi9LU-4sbakJQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150515 19:50]:
> On 13 May 2015 at 16:48, Johan Hovold <johan@kernel.org> wrote:
> > By the way, perhaps you should add a comment in the tps node explaining
> > why ti,pmic-shutdown-controller must not be disabled (on what revisions
> > of hardware) as well?
> 
> There are actually three separate obstacles for RTC-only sleep (only
> one of which actually BeagleBone-specific), so the "why" is a bit of a
> long story. The end result can however be stated briefly:
> 
> Only BBBs prior to rev A6 properly support RTC-only mode. The rare BBW
> with a 2.x processor also supports it, provided nothing is connected
> to its expansion ports that leaks significant current from 3v3exp to
> processor I/Os while in reset.
> 
> Any BeagleBone with an AM335x 2.x can be patched to properly support
> RTC-only mode. (Though reconnecting vdds to LDO3 is really no fun, and
> not a patch I could have done myself.)
> 
> 
> 
> For reference, the details on the three problems:
> 
> 
> 1. Most BeagleBone Whites use AM335x 1.0 which freezes the RTC when
> vdd_core is gone or power-on reset is asserted, rendering RTC-only
> sleep mostly useless.  The BeagleBone Black, and a few BBWs, use
> AM335x 2.x which fixed this.
> 
> Of all problems this is the most benign one since it merely results in
> loss of functionality. The other two risk hardware damage.

If some of these depend on the SoC revision and cannot be detected
based on the RTC driver revision register, that information should
be be passed to the RTC driver in platform data. This can be done
with the rev == AM35XX_REV_ES* comparison that can be added to the
mach-omap2/pdata-quirks.c for am335x to initialize platform_data
for the RTC driver.
 
> 2. TI issued a notice that the AM335x "vdds" supply must be among the
> first to come up, and changed the official connection diagram for the
> TPS65217C/D (used for boards with DDR3/3L memory) by moving vdds from
> LDO3 to LDO1, and the BBB implemented this change in rev A6A.
> 
> This change is incompatible with RTC-only sleep (a fact mentioned by
> TI), so this rules out RTC-only sleep for any AM335x board with
> DDR3/3L memory unless it predates (or ignored) TI's advice or uses a
> different power supply scheme altogether. Boards with DDR2 memory
> (TPS65217A/B) such as the BBW are not affected.
> 
> Curiously, based on preliminary measurements, I have not observed any
> leakage to vdds when it is powered up "late" (LDO3). In contrast,
> during shutdown vdds begins to leak heavily (far in excess of rated
> max current) to other rails once they drop low enough, and moving vdds
> to LDO1 only makes this situation persist even longer (and
> indefinitely in RTC-only sleep). I've asked TI support for some
> clarification on this, but not yet received any response.

This information should be passed based on the board revision in
platform_data to the RTC driver assuming we can detect the board
revision during the early boot.. Otherwise we should have revision
specific dts files.

> 3. All BeagleBones have a mismanaged external regulator for the
> "3v3exp" (BBW) / "3v3b" (BBB) rail, which remains enabled longer than
> the AM335x's 3.3V supplies ("3v3a").
> 
> On the BBW, external hardware may end up sourcing current into
> processor I/Os, which feeds the 3v3a through protection diodes. Since
> the 3v3a is used as enable-signal for the regulator, if non-negligible
> current is leaked via this path, 3v3a remains "logic high" and the
> situation will persist indefinitely. If the currents remain modest
> this won't necessarily violate any absolute maximum ratings, but I'd
> still worry about the processor's long-term health.
> 
> On BBB rev A6 and later the situation is the same, but without
> dependency on external hardware: the current from on-board pull-up
> resistors already suffices (3v3a remains at ~1.4V), and since rev A6A
> the leakage from vdds would also get the job done. Worse still, since
> the buffer for the console port is powered by the 3v3b, having a
> serial cable attached causes a dangerous amount of current to be
> driven into UART0_RXD (~45 mA) and I captured an event which I fear
> may have been a brief latch-up.
> 
> On BBBs prior to rev A6 the regulator is enabled by LDO2 (whose only
> other use is the power led), which prevents it from staying on
> indefinitely. It is however enabled 1ms before and disabled 1ms after
> the processor's 3.3V supplies, so external hardware must still avoid
> driving much current into I/O pins during those windows, e.g. by
> keeping drivers disabled while reset is asserted. As mentioned above,
> the console port buffer violates this rule.
> 
> Technically this problem is also present when performing a full
> shutdown ("OFF-mode"), but then the main supply is cut at the start of
> the power-down sequence, which proceeds while running off rapidly
> draining capacitors. Heavy current draw from 3v3b will drain them even
> faster, thus making the issue self-limiting. (This however does not
> apply when running on battery power, in which case even a full
> shutdown is hazardous on an unpatched BBB rev A6 or later.)

Sounds like this should be configured based on the board revision
too.

Regards,

Tony
 
