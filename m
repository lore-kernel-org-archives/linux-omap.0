From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Failure to boot...
Date: Thu, 31 Jan 2013 14:16:35 +0000
Message-ID: <20130131141635.GR2637@n2100.arm.linux.org.uk>
References: <20130131014912.GM2637@n2100.arm.linux.org.uk> <20130131030203.GA8374@quad.lixom.net> <alpine.LFD.2.02.1301302312030.6300@xanadu.home> <20130131092024.GN2637@n2100.arm.linux.org.uk> <20130131104044.GO2637@n2100.arm.linux.org.uk> <510A6877.9080307@ti.com> <20130131130437.GP2637@n2100.arm.linux.org.uk> <510A78E1.8010308@ti.com> <20130131141320.GQ2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60132 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab3AaOQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 09:16:46 -0500
Content-Disposition: inline
In-Reply-To: <20130131141320.GQ2637@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 31, 2013 at 02:13:20PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 31, 2013 at 07:30:01PM +0530, Santosh Shilimkar wrote:
> > Linus' tip(commit: 04c2eee5) + arm-soc for-next boots fine as well.
> > The pull request from Tony [1] fixed the multi-platform boot issue
> > for OMAP.
> >
> > Now trying to merge your for-next and test.
> 
> Well, my tip (which is based on Linus' 6abb7c25) also builds and
> boots fine.
> 
> Hang on... 
> 
> # CONFIG_ARCH_OMAP2PLUS is not set
> CONFIG_ARCH_VEXPRESS=y
> 
> which of course won't boot, and this happens on both oldconfigs because
> of the change to multiplatform support.

And no, the instructions given last time around to add:

# 13 Jan 2013: Update for OMAP moving to multiplatform
CONFIG_ARCH_MULTIPLATFORM=y
CONFIG_ARCH_MULTI_V7=y

don't fix it either, it needs more options defined...
