From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Fri, 13 Jun 2014 19:53:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406131924571.340@utopia.booyaka.com>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com> <5370B839.3050108@ti.com> <5370BAFF.9070501@ti.com> <20140515060834.3084.5199@quantum> <5374B241.9010201@ti.com> <20140531000207.10062.55946@quantum> <alpine.DEB.2.02.1406031907210.14238@utopia.booyaka.com>
 <538EBBF1.7040804@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53943 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbaFMTxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2014 15:53:07 -0400
In-Reply-To: <538EBBF1.7040804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, 4 Jun 2014, Tomi Valkeinen wrote:

> On 03/06/14 22:35, Paul Walmsley wrote:
> 
> > What's really needed is better control over rounding in the clock code.  
> 
> Well, if you ask me, what's really needed _now_ is to fix the bug that
> makes am3xxx (and am4xxx when it's merged) display not to work. I don't
> need a fix that solves all the clock set_rate/round issues once and for
> all, I just want to get the display working.

Yep, I understand; it's not a great situation.

> > Both the driver API should be improved; and, to the extent that clock 
> > sources share the same underlying code implementation, probably some clock 
> > source configuration data enhancement is needed (DT or whatever).
> > 
> > Furthermore, clk_set_rate() should never silently round a requested rate - 
> > it should just return an error if it can't satisfy the requested rate 
> > precisely.  Silently rounding a rate is racy, and, if we care about 
> > drivers behaving consistently across different integration environments, 
> > prone to behavior that the driver may not expect.
> > 
> > Frankly, a DT "ti,round-rate" property is risible.  I certainly understand 
> > why you don't like it and I don't know why that specific property was 
> > proposed.  The issue has never been whether clk_round_rate() should round 
> 
> I created the property for the v2 because (if I recall right) you were
> worried that fixing the rounding bug unconditionally could break some
> drivers, and suggested that it should be used only for DSS.

Here's the summary from my perspective: I don't want to merge a patch that 
results in a behavior change for all PLLs just to fix one user of one 
single PLL.  That's why I haven't merged your v1 patches.

So that's why I asked you for patches that limit the impact of the change 
to the PLL that you're trying to change.  You (graciously) respun those 
patches, but with a DT flag that doesn't really make sense, and those 
patches were NACK'ed by others.  So that's why the v2 patches haven't gone 
anywhere.

> > But all this won't happen in -rc8; this is 3.16 material..
> > 
> > 
> >> We can always see how it goes and fix it up afterwards when everything 
> >> explodes.
> > 
> > No thanks... that's what leads to these kinds of messes :-( 
> 
> I don't understand how this fix would lead to a mess.
> 
> 1. AM3xxx/AM4xxx display is broken
> 2. The PLL round function is broken, it doesn't round
> 3. The fix to omap2_dpll_round_rate has been in TI's kernel for a long
> time, no problems observed
> 4. We've ran test runs with linux-next + the fix, no problems observed

Whatever we do to the (common, not DSS-specific) clock code to fix this 
issue, it has to make sense independently of your specific DSS needs.  
This is why I asked you for a DSS-specific change, since it would 
effectively avoid this basic principle.  

Right now, in my view, it does not make sense to have a PLL clk_set_rate() 
function that unconditionally rounds to the "closest" rate for all users.  
As I've written before, callers could end up with a clock rate that is 
different than what's needed for a synchronous I/O user that expects an 
exact rate.  I am concerned about both rounding to a lower rate and 
rounding to a higher rate in this case, although the higher rate is 
marginally more of a concern to me since the resulting rate may be higher 
than the device is characterized for at a given voltage.

Furthermore, as a general interface principle, allowing clk_set_rate() to 
silently round rates could lead to unexpected behavior, since the set of 
rates that clk_set_rate() can round to may change between the call to 
clk_round_rate() and the call to clk_set_rate().

So again I think that the right way to deal with this is to:

1. avoid silently rounding rates in clk_set_rate() and to return an error 
if calling clk_set_rate() would result in a rate other than the one 
desired; and to

2. modify clk_round_rate() such that it returns the closest 
lowest-or-equal rate match to the target rate requested.


- Paul
