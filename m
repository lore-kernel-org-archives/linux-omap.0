From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: RE: [PATCH 1/1] OMAP: I2C: Add mpu wake up latency constraint
	in	i2c
Date: Fri, 9 Oct 2009 07:50:32 +0300
Message-ID: <1255063832.22468.340.camel@ubuntu>
References: <1253204923-21916-1-git-send-email-kalle.jokiniemi@digia.com>
	 <1253204923-21916-2-git-send-email-kalle.jokiniemi@digia.com>
	 <87bpkso0dj.fsf@deeprootsystems.com> <1254383040.22468.130.camel@ubuntu>
	 <4AC49578.9090906@nokia.com> <1254481161.22468.179.camel@ubuntu>
	 <13B9B4C6EF24D648824FF11BE8967162039B0BD781@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:48439 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbZJIEuT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Oct 2009 00:50:19 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B0BD781@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2009-10-07 at 21:52 +0300, Woodruff, Richard wrote:
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Kalle Jokiniemi
> > Sent: Friday, October 02, 2009 5:59 AM
> 
> 
> > Yes, this is a good idea in theory, but the reality of wake-up latencies
> > kind-a kill this one. Wake-up from even C1 (MPU INA, CORE ON) takes
> > ~130us on fastest OPP. And when you add 70us of sleep transition into
> > that, you get 200us at minimum.
> 
> These values feel a bit on the high side.  Have you measured since tweaking your DPLL M/N values?
> 
> Are you measuring just across WFI or adding in some part of the idle code path?

For the numbers I mentioned, the path from start of omap_sram_idle to
end of omap_sram_idle was included. And one can't really not include it,
since it is run with interrupts disabled.

> 
> > For us, the 500us constraint seems to work quite nicely. It removes the
> > problems we had with i2c transfers timing out with off mode, and
> > restores average transfer times (from clk_enable to clk_disable) to few
> > hundred us (that were observed with retention).
> 
> Some of the historic I2C timeout issues were from the wakeup sources
> not being programmed properly.

There could be such issues, I have not investigated for other reasons
causing the time-outs. 


> 
> Your constraint in my understanding is more about saving power.  

True.

> Today cpuidle doesn't predict interrupt events very well.  As such the
> huge timeout used with i2c will never gate an off mode attempt.  You
> will loose in context save and restore with out constraint.

True, that is why the constraint is needed on latency basis.

- Kalle

> 
> I floated some idea a while back on pm list to try and do something
> really simple with irqs.  ... take a timestamp on last irq, when
> cpuilde goes to sleep if current time since last irq is too near then
> choose safe sleep state.  Comments I got at that time was some didn't
> like extra overhead on irq path.  However, I don't know I agree with
> that.
> 
> Regards,
> Richard W.

