From: Paul Walmsley <pwalmsley@nvidia.com>
Subject: Re: regression: Clock changes in next-20141205 break at least omap4
Date: Tue, 16 Dec 2014 13:01:17 -0700
Message-ID: <54908F8D.2020202@nvidia.com>
References: <20141205165539.GA30437@atomide.com>
 <5481F79D.4010504@codeaurora.org> <20141205183849.GB30437@atomide.com>
 <20141212194238.20398.33333@quantum>
 <alpine.DEB.2.02.1412122310570.29716@utopia.booyaka.com>
 <20141215220224.20398.98259@quantum> <548F7B02.1090009@nvidia.com>
 <20141216003834.GC23854@atomide.com> <548F8B70.2060803@nvidia.com>
 <5490816E.7060706@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8505 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaLPUBT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2014 15:01:19 -0500
In-Reply-To: <5490816E.7060706@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Tony Lindgren <tony@atomide.com>, t-kristo@ti.com
Cc: Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, khilman@linaro.org, paul@pwsan.com

+ Tero

On 12/16/2014 12:01 PM, Stephen Boyd wrote:
> On 12/15/2014 05:31 PM, Paul Walmsley wrote:
>> I just took a quick glance at Tero's second patch, and it looks like a
>> hack to me.  Better to fix the problem in the core CCF code if
>> possible.  I don't think there's any reason why a PLL couldn't have
>> just one parent clock.  But I'm fine with merging it as a short-term
>> fix if fixing the core code is difficult or risky.
> Can you describe what's wrong?

Took a closer look at it, at your prompting.

The first observation is that the issue seems to be limited to 
TI-specific clock code in drivers/clk/ti.  So nothing to worry about in 
terms of the CCF core, it looks.

The second observation is that this appears to only be a problem due to 
the current DT data in arch/arm/boot/dts/omap3xxx-clocks.dtsi:

     dpll3_ck: dpll3_ck {
         #clock-cells = <0>;
         compatible = "ti,omap3-dpll-core-clock";
         clocks = <&sys_ck>, <&sys_ck>;
         reg = <0x0d00>, <0x0d20>, <0x0d40>, <0x0d30>;
     };


It lists two entries for the "clocks" node for some reason. 
of_ti_dpll_setup() only seems to require one.

So unless there's some good reason to list two of them in the DTS file, 
the right fix would probably have been to fix the DT data.

> Does the PLL have a mux with two inputs that map to the same clock?
>

I don't think so.

...

Generally speaking, I suspect the way we model PLLs isn't quite right 
(although it's been a while since I've looked at that particular code).  
This was probably my fault, in the final analysis, for taking a shortcut 
here a long time ago.

Unless one wishes to implement support for multiple clock parents, it's 
probably not quite right to state that a PLL's reference clock is a 
"parent" in a clock tree sense.  When a PLL is active, the output clock 
originates from a VCO of some kind that is internal to the PLL.  The 
reference clock is just used by the PLL internal logic to close the 
control loop.  Some PLL-like clock sources use a third clock that is 
used to clock some of the PLL's internal logic (let's call this a 
"functional clock.")

So the reference clock and functional clock are (usually) required by 
the PLL to operate, and should therefore be required by the PLL clock 
driver code in the kernel; but one could claim that they aren't 
technically parent clocks of the PLL in a clock tree sense, since the 
downstream output clock isn't directly derived from either of those clocks.

Otherwise if we want to represent those clocks accurately in the Linux 
clock tree, we probably need to state that clocks can have multiple 
"parents" that often need to be active simultaneously, and we should 
propagate usecount changes accordingly up all of the parent paths.

...

Anyway, thanks for following up on this,

- Paul
