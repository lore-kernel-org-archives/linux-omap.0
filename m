From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] omap: Fix DEBUG_LL code for p2v changes (Re: Fwd: [RFC
	4/5] ARM: P2V: introduce phys_to_virt/virt_to_phys runtime patching)
Date: Fri, 4 Feb 2011 23:46:20 +0000
Message-ID: <20110204234620.GB8821@n2100.arm.linux.org.uk>
References: <20110118183252.GJ16980@n2100.arm.linux.org.uk> <20110118203706.GR4957@atomide.com> <20110204011538.GN3322@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48488 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992Ab1BDXq1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 18:46:27 -0500
Content-Disposition: inline
In-Reply-To: <20110204011538.GN3322@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Feb 03, 2011 at 05:15:39PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [110118 12:36]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110118 10:32]:
> > > A warning for OMAP.
> > > 
> > > Your use of the __virt_to_phys() in assembly code for the debug stuff
> > > will break with this patch... please ensure that it is resolved by the
> > > next merge window.
> > 
> > Sure thanks. I'm aware of this series, will take care of it.
> 
> Here's a minimal fix for your p2v branch. Will send more DEBUG_LL
> related patches in a separate series.

Could you please provide some acks/tested bys for the p2v stuff?

Thanks.
