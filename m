From: Tony Lindgren <tony@atomide.com>
Subject: Re: problem with "undefined instruction"
Date: Mon, 27 Jun 2011 05:12:47 -0700
Message-ID: <20110627121246.GO23145@atomide.com>
References: <20110430162357.GA14287@earth.universe>
 <20110606125600.GB20909@earth.universe>
 <20110607115331.GZ8696@atomide.com>
 <20110623195353.GA16800@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10355 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757085Ab1F0MMt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 08:12:49 -0400
Content-Disposition: inline
In-Reply-To: <20110623195353.GA16800@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [110623 12:49]:
> On Tue, Jun 07, 2011 at 02:53:31PM +0300, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@debian.org> [110606 15:51]:
> > > On Sat, Apr 30, 2011 at 06:23:57PM +0200, Sebastian Reichel wrote:
> > > > I'm currently trying to get a mainline based kernel running on my pandaboard.
> > > > The problem is, that it's crashing very early during the init phase because of
> > > > "undefined instruction" exceptions:
> > > > 
> > > > [    1.867980] udevd (56): undefined instruction: pc=401e6ed4
> > > > [    1.874603] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> > > > [    1.977752] modprobe (69): undefined instruction: pc=400c6ed4
> > > > [    1.977783] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> > > > [    1.978240] init (1): undefined instruction: pc=40149ed4
> > > > [    1.978240] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> > > > [    2.005706] Kernel panic - not syncing: Attempted to kill init!
> > > >
> > > > Exactly the same userland boots fine with the original 2.6.35 kernel, so it's
> > > > probably not the userland's fault.
> > > 
> > > I found the source of this problem. VFPv3 support is not working
> > > correctly when OMAP2 (and thus CPU_V6) is enabled in the kernel
> > > config.
> > > 
> > > I guess this should be mentioned in the kernel config (or fixed if
> > > possible).
> > 
> > This should be easy to fix now. Do you have a minimal test program that
> > triggers this?
> 
> Sorry for the delay, here is a minimal test binary, that triggers
> the bug: http://elektranox.org/omap-kernel/test

Heh that's pretty minimal :) I'll take a look why it fails.

Tony
