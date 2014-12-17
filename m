From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 17 Dec 2014 18:51:55 +0000
Message-ID: <20141217185155.GI11502@n2100.arm.linux.org.uk>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:36533 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751352AbaLQSwH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Dec 2014 13:52:07 -0500
Content-Disposition: inline
In-Reply-To: <20141217172333.GE23854@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joel Fernandes <joelf@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Nishanth Menon <nm@ti.com>

On Wed, Dec 17, 2014 at 09:23:33AM -0800, Tony Lindgren wrote:
> Hi,
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [141217 01:55]:
> > Tony,
> > 
> > As the IOMMU stuff was merged last night, which removed a really quite
> > horrid conflict resolution, I updated my nightly build tree from its
> > previous state last Thursday.
> > 
> > Now, SDP4430 seems to be really quite broken.
> 
> Sigh, things are just break left and right every merge window :(

Some of these things were present before the merge window, so they're
less of a concern.  The biggest problem though is the ABE ASoC stuff
exploding, which prevents my test system getting anywhere near mounting
its rootfs.

It's fine in the "combined" case, because we end up totally dead as
far as serial console goes, but the "omap4430" kernel boot test never
ends because the kernel doesn't stop spewing "rcu_sched stall" messages.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
