From: Tony Lindgren <tony@atomide.com>
Subject: Re: Moving board patches from DSS2 to linux-omap
Date: Fri, 12 Feb 2010 12:42:18 -0800
Message-ID: <20100212204218.GT21755@atomide.com>
References: <1265884185.2433.239.camel@tubuntu.research.nokia.com>
 <4B73EF0D.8080904@compulab.co.il>
 <1265889888.2433.245.camel@tubuntu.research.nokia.com>
 <20100211185253.GG21755@atomide.com>
 <1265971459.2433.285.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49590 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab0BLUlm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 15:41:42 -0500
Content-Disposition: inline
In-Reply-To: <1265971459.2433.285.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Mike Rapoport <mike@compulab.co.il>, "ext Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [100212 02:38]:
> On Thu, 2010-02-11 at 19:52 +0100, ext Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@nokia.com> [100211 03:59]:
> > > On Thu, 2010-02-11 at 12:50 +0100, ext Mike Rapoport wrote:
> > > > Tomi Valkeinen wrote:
> > > > > Hi,
> > > > > 
> > > > > As discussed previously, board file changes in DSS2 tree cause conflicts
> > > > > with linux-omap easily. There are currently three board file patches in
> > > > > DSS2's for-next branch:
> > > > > 
> > > > > 722a97e4594b2041bbf18d95a913ba6dfaca87f2 omap3: cm-t35: add DSS2 display support
> > > > > 7a56267e775e469c64521179ccc958c8bb661dbf OMAP: AM3517: Enable DSS2 for AM3517EVM board
> > > > > 40e4e67c6dabcb9897b6823cce2297d6c3e78bbd OMAP: Enable DSS2 for OMAP3EVM board
> > > > > 
> > > > > The problem here is of course that DSS2 tree may contain unmerged panel
> > > > > drivers, and those board file changes try to use these new panel
> > > > > drivers.
> > 
> > OK, Tomi, can you please set up a banch against mainline -rc7 with
> > whatever board-*.c dss2 patches you want me to pull? I'll pull them
> > into omap-for-linus, and rebase omap for-next on those.
> 
> Here:
> 
> git://gitorious.org/linux-omap-dss2/linux.git for-tony
> 
> I removed the defconfig changes from the patches, and compile tested.
> I'll add the defconfig changes as separate patches in my tree, and I'll
> push them to Linus only after the board changes from Tony's tree have
> gone through.

Great, thanks, I've pulled it into omap-for-linus branch. Note that we
need to wait for Russell to merge the arm changes first and then I
need merge with that before I can send a pull request because of the
addruart changes that affect most of our multi-omap patches.

So you may want to send the defconfig changes as a separate fix later on
if that allows you to keep your dss2 mergeable without having to worry
about the merging of arm and omap trees.

Regards,

Tony
