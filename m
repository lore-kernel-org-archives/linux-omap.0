From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH A 09/10] OMAP2/3: Remove OMAP_PRM_REGADDR, OMAP_CM_REGADDR
Date: Tue, 3 Mar 2009 08:28:37 +0000
Message-ID: <20090303082837.GJ25699@n2100.arm.linux.org.uk>
References: <20090128020447.7244.80496.stgit@localhost.localdomain> <20090128021312.7244.2415.stgit@localhost.localdomain> <20090128232831.GL23301@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0901290021360.32081@utopia.booyaka.com> <87zlg372rm.fsf@deeprootsystems.com> <alpine.DEB.2.00.0903021945060.30037@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40761 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbZCCI25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 03:28:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0903021945060.30037@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.arm.linux.org.uk, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, Mar 02, 2009 at 07:48:07PM -0700, Paul Walmsley wrote:
> Hi Kevin,
> 
> On Mon, 2 Mar 2009, Kevin Hilman wrote:
> 
> > What about the rest of the *_PRM_REGADDR() accessor macro changes in
> > this patch?
> > 
> > The rest of the PM core code uses these and so does not build on top
> > of the Russell's omap-clks3 branch.
> 
> yes, all of the *_{PRM,CM}_REGADDR() work should be kept.

Well, in case it wasn't clear from my previous mail, I'm not merging this.
