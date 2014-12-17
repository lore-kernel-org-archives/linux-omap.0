From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 17 Dec 2014 11:09:05 -0800
Message-ID: <20141217190904.GF23854@atomide.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
 <20141217185155.GI11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54438 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaLQTMB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2014 14:12:01 -0500
Content-Disposition: inline
In-Reply-To: <20141217185155.GI11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joel Fernandes <joelf@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Nishanth Menon <nm@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [141217 10:54]:
> On Wed, Dec 17, 2014 at 09:23:33AM -0800, Tony Lindgren wrote:
> > Hi,
> > 
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [141217 01:55]:
> > > Tony,
> > > 
> > > As the IOMMU stuff was merged last night, which removed a really quite
> > > horrid conflict resolution, I updated my nightly build tree from its
> > > previous state last Thursday.
> > > 
> > > Now, SDP4430 seems to be really quite broken.
> > 
> > Sigh, things are just break left and right every merge window :(
> 
> Some of these things were present before the merge window, so they're
> less of a concern.  The biggest problem though is the ABE ASoC stuff
> exploding, which prevents my test system getting anywhere near mounting
> its rootfs.

Right.
 
> It's fine in the "combined" case, because we end up totally dead as
> far as serial console goes, but the "omap4430" kernel boot test never
> ends because the kernel doesn't stop spewing "rcu_sched stall" messages.

Yeah and there are some new clock issues for sure like I posted.

Also, in your 3430-LDP logs, the DMA setup_irq related "In-band Error"
is a mystery. I'm not seeing that with omap2plus_defconfig, but can
reproduce it here with your LDP .config file. Got any ideas on that one?

Regards,

Tony
