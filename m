From: Paul Walmsley <pwalmsley@nvidia.com>
Subject: Re: regression: Clock changes in next-20141205 break at least
 omap4
Date: Tue, 16 Dec 2014 20:45:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412162034420.3102@utopia.booyaka.com>
References: <5481F79D.4010504@codeaurora.org> <20141205183849.GB30437@atomide.com> <20141212194238.20398.33333@quantum> <alpine.DEB.2.02.1412122310570.29716@utopia.booyaka.com> <20141215220224.20398.98259@quantum> <548F7B02.1090009@nvidia.com>
 <20141216003834.GC23854@atomide.com> <548F8B70.2060803@nvidia.com> <5490816E.7060706@codeaurora.org> <54908F8D.2020202@nvidia.com> <20141216202301.GF11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33732 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbaLPUp0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2014 15:45:26 -0500
In-Reply-To: <20141216202301.GF11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <pwalmsley@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Tony Lindgren <tony@atomide.com>, t-kristo@ti.com, Nishanth Menon <nm@ti.com>, khilman@linaro.org, Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 16 Dec 2014, Russell King - ARM Linux wrote:

> On Tue, Dec 16, 2014 at 01:01:17PM -0700, Paul Walmsley wrote:
> > So the reference clock and functional clock are (usually) required by the
> > PLL to operate, and should therefore be required by the PLL clock driver
> > code in the kernel; but one could claim that they aren't technically parent
> > clocks of the PLL in a clock tree sense, since the downstream output clock
> > isn't directly derived from either of those clocks.
> 
> The reference clock is the parent clock for a PLL, and the output clock 
> is a derivative of the reference clock. The PLL maths show that very 
> clearly.

The PLL's internal oscillator is the electrical source of the PLL's output 
clock.  The reference clock is just used to discipline that internal 
oscillator.  Even that's not necessary - the reference clock can be 
optional on some clock source implementations, which can run the internal 
oscillator in open-loop mode.

The question of what the appropriate "parent" clock(s) should be is really 
a question of how the software chooses to model it, and has more to do 
with use-counts, constraints, etc.  I don't believe we have documented a 
precise definition for what a "parent clock" is, in the Linux clock 
framework context.


- Paul
