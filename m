From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Fix DEBUG_LL code for p2v changes (Re: Fwd: [RFC
 4/5] ARM: P2V: introduce phys_to_virt/virt_to_phys runtime patching)
Date: Mon, 7 Feb 2011 07:51:23 -0800
Message-ID: <20110207155123.GC20795@atomide.com>
References: <20110118183252.GJ16980@n2100.arm.linux.org.uk>
 <20110118203706.GR4957@atomide.com>
 <20110204011538.GN3322@atomide.com>
 <20110204234620.GB8821@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34416 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab1BGPwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 10:52:04 -0500
Content-Disposition: inline
In-Reply-To: <20110204234620.GB8821@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110204 15:45]:
> On Thu, Feb 03, 2011 at 05:15:39PM -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [110118 12:36]:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110118 10:32]:
> > > > A warning for OMAP.
> > > > 
> > > > Your use of the __virt_to_phys() in assembly code for the debug stuff
> > > > will break with this patch... please ensure that it is resolved by the
> > > > next merge window.
> > > 
> > > Sure thanks. I'm aware of this series, will take care of it.
> > 
> > Here's a minimal fix for your p2v branch. Will send more DEBUG_LL
> > related patches in a separate series.
> 
> Could you please provide some acks/tested bys for the p2v stuff?

Sorry was out of town for the weekend, will reply with acks.

Tony
