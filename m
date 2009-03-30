From: Peter Barada <peterb@logicpd.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Mon, 30 Mar 2009 14:18:06 -0400
Message-ID: <1238437086.8002.137.camel@blackhole>
References: <87bprz9zju.fsf@deeprootsystems.com>
	 <1237914611.23022.124.camel@blackhole> <87zlfaztcd.fsf@deeprootsystems.com>
	 <1237925484.23022.133.camel@blackhole>
	 <49C940CA.9070805@deeprootsystems.com>
	 <f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
	 <f9d2a5e10903301044u775edfdo7ac540b3e1bdc597@mail.gmail.com>
	 <878wmm3nbx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:20194 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756841AbZC3SSJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2009 14:18:09 -0400
In-Reply-To: <878wmm3nbx.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russ Dill <russ.dill@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2009-03-30 at 10:57 -0700, Kevin Hilman wrote:
> Russ Dill <russ.dill@gmail.com> writes:
> 
> > On Mon, Mar 30, 2009 at 3:08 AM, Premi, Sanjeev <premi@ti.com> wrote:
> [...]
> 
> >> I had found that two drivers that could prevent clocks_off are
> >> USB and DSS because of the way they use clk_enable().
> >>
> >> Can you try building without theses drivers just for verification?
> >>
> >
> > Building without dss makes things worse:
> >
> > Powerdomain (dss_pwrdm) didn't enter target state 0
> >
> > Maybe by looking at what the dss driver is doing I can get core and
> > per to turn off.
> 
> Peter,
> 
> Have you tried with the debug patch I sent?  If you can test with that
> patch, and send the output, I can tell you what is preventing you from
> hitting RET.

No, not yet.  After comments by Kevin and others regarding my DPLL
setting being wrong from u-boot, I'm currently trying to bring up u-boot
from the Beagle on the LV SOM.  Then I can get the timings for the SDRC
correct, and then work on getting the lates PM rebase (2.6.29) to boot.
When I tried it with my current u-boot (based on 1.1.4 labrador), it
would sporadically hang in rtc_hctosys and other functions that tried to
talk to the twl4030 via i2c...

I'm running into problems with u-boot (cloned the Beagle config) where
I2C to setup power domains fails after the first write (bus gets stuck
busy).

> FWIW, the latest HEAD of the PM branch has that debug patch included.
> 
> After doing the suspend/resume, just
> 
> # cat /debug/pm_debug/registers/1
> 
> and attach the output.
> 
> Kevin
> 
-- 
Peter Barada <peterb@logicpd.com>
