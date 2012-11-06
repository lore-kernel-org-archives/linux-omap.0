From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
Date: Tue, 6 Nov 2012 14:38:48 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC05561@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
 <5095037A.2020503@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFEA0E@DBDE01.ent.ti.com>
 <5095165E.10403@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFEB57@DBDE01.ent.ti.com>
 <87pq3s7wro.fsf@deeprootsystems.com> <509836BA.5030507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51307 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab2KFOi4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 09:38:56 -0500
In-Reply-To: <509836BA.5030507@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

Hi Santosh,

On Tue, Nov 06, 2012 at 03:29:22, Shilimkar, Santosh wrote:

[...]

> >
> > IMO, assuming that idle will not be useful from the begining is leading
> > down the path to poor design choices that will be much more difficult to
> > fixup down the road in order to add idle support later.  We need to
> > design both idle and suspend at the same time.
> >
> I agree with Kevin. Not supporting CPUIDLE deep states can hit the
> active power numbers dearly. I just don't know why the SOCs don't share
> the standard and must have design choices. But thats another discussion.
> 

Yes, active power numbers are not comparable to OMAP :(

> How about leaving the timer choices as is. PER timer for clock source
> and wakeuptimer for clock event. Anyway in suspend the clock-source
> can be suspended and that is evident from recent discussion. The only
> downside is you won't count time in suspend which is any way the case.
> 
> Vaibhav,
> Do you guys see any implementation bottleneck for above ?
> 

Looking at the timekeeping code I see one more potential reason for making
this change. OMAP registers the 32k sync timer as the persistent clock and
since there's no 32k sync timer in AM33xx it doesn't register a persistent
clock right now. Based on what I understood, we need to have to register
one and DMTimer1 is the only clock that can serve as the persistent clock
in suspend state. When we do so we might as well use it as the clocksource.

A related question that I had was, is there a mechanism to handle the 32k
counter (DMTimer or sync timer) wraparound condition in suspend?

Regards,
Vaibhav

