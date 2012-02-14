From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Move the barrier memboclk_steal() as
	part of reserve callback
Date: Tue, 14 Feb 2012 11:13:05 +0000
Message-ID: <20120214111305.GF15338@n2100.arm.linux.org.uk>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com> <1328191435-18652-3-git-send-email-santosh.shilimkar@ti.com> <20120210191926.GV1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39949 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab2BNLNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 06:13:15 -0500
Content-Disposition: inline
In-Reply-To: <20120210191926.GV1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 10, 2012 at 11:19:26AM -0800, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [120202 05:33]:
> > arm_memblock_steal() is not suppose to be used outside ->reserve callback.
> > OMAP barrier errata code was using it outside reserve callback and hence
> > it was broken.
> > 
> > Move the allocation as part of ->reserve callback to fix the it.
> 
> Please update this to mention again commit that changed things
> around for arm_memblock_steal() so it's clear why this is needed
> as a fix.

It's more the case that this whole errata fix was broken right from the
start, and the change to arm_memblock_steal() just enforced correct usage
of the APIs.

So, really the arm_memblock_steal() change has nothing to do with this.
