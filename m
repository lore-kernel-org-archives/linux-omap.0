From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
Date: Fri, 3 Oct 2014 08:46:55 -0700
Message-ID: <20141003154655.GC10014@atomide.com>
References: <20140918191615.GN14505@atomide.com>
 <alpine.DEB.2.02.1409191633180.22526@utopia.booyaka.com>
 <alpine.DEB.2.02.1409191726050.22526@utopia.booyaka.com>
 <5422893B.60501@ti.com>
 <20141002163202.GJ3122@atomide.com>
 <20141002195238.GA10014@atomide.com>
 <20141002201753.GM7933@saruman>
 <20141002211908.GB10014@atomide.com>
 <20141002215930.GA628@saruman>
 <20141003144925.GA22626@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16528 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbaJCPru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2014 11:47:50 -0400
Content-Disposition: inline
In-Reply-To: <20141003144925.GA22626@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Felipe Balbi <balbi@ti.com> [141003 07:53]:
> On Thu, Oct 02, 2014 at 04:59:30PM -0500, Felipe Balbi wrote:
> > On Thu, Oct 02, 2014 at 02:19:08PM -0700, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [141002 13:18]:
> > > > On Thu, Oct 02, 2014 at 12:52:38PM -0700, Tony Lindgren wrote:
> > > > > 
> > > > > Hmm here seems to be a link to similar issues from 2011:
> > > > > 
> > > > > http://e2e.ti.com/support/arm/sitara_arm/f/791/p/113593/628790.aspx
> > > > > 
> > > > > Looks like the issue can be potentially reproduced with:
> > > > > 
> > > > > # cyclictest -l100000000 -m -a0 -t1 -n -p99 -i200 -h200 -q
> > > > 
> > > > running here on am335x and am437x. On that same post, on person
> > > > mentions he reproduced on beagle bone.
> > > 
> > > OK I'll run it here too on my am37xx evm. Looks like Stanley was
> > > running both cyclictest and hackbench the same time.
> > 
> > yeah I did that.
> > 
> > BTW, just got the following on BBB, AM437x SK is still running.
> > 
> > [ 3952.432262] Kernel panic - not syncing: Attempted to kill the idle task!752763
> > [ 3952.442403] CPU: 0 PID: 0 Comm: hackbench Not tainted 3.17.0-rc6-00456-gd8da063 #222
> > [ 3952.450517] [<c0017338>] (unwind_backtrace) from [<c0012fdc>] (show_stack+0x20/0x24)
> > [ 3952.458620] [<c0012fdc>] (show_stack) from [<c0647f0c>] (dump_stack+0x8c/0xa4)
> > [ 3952.466168] [<c0647f0c>] (dump_stack) from [<c0644da4>] (panic+0xa4/0x224)
> > [ 3952.473358] [<c0644da4>] (panic) from [<c004b510>] (do_exit+0x924/0x9d8)
> > [ 3952.480358] [<c004b510>] (do_exit) from [<c004c4d8>] (do_group_exit+0x50/0xc0)
> > [ 3952.487903] [<c004c4d8>] (do_group_exit) from [<c004c568>] (__wake_up_parent+0x0/0x30)
> > [ 3952.496179] [<c004c568>] (__wake_up_parent) from [<c000ed40>] (ret_fast_syscall+0x0/0x48)
> > [ 3952.504875] drm_kms_helper: panic occurred, switching back to text console
> > [ 3952.517844] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
> > 
> > 
> > > And I'll also queue the following patch during the -rc cycle to
> > > avoid apps segfaulting occasionally at random on omap3.
> > 
> > and maybe this will fix BBB :-) I'll add that locally. If I survive
> > until tomorrow, I'll add a Tested-by.
> 
> BBB died again with the same behavior as above, but I think it's
> unrelated to this errata. Therefore:
> 
> Tested-by: Felipe Balbi <balbi@ti.com>

BTW, I have revision r3p2:

CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d

And it still seems to need 430973.

Looks like my 37xx evm produced no errors overnight running cyclictest
and hackbench the same time.

Regards,

Tony
