From: Tony Lindgren <tony@atomide.com>
Subject: Re: Moving board patches from DSS2 to linux-omap
Date: Thu, 11 Feb 2010 10:52:53 -0800
Message-ID: <20100211185253.GG21755@atomide.com>
References: <1265884185.2433.239.camel@tubuntu.research.nokia.com>
 <4B73EF0D.8080904@compulab.co.il>
 <1265889888.2433.245.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50524 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351Ab0BKSwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:52:18 -0500
Content-Disposition: inline
In-Reply-To: <1265889888.2433.245.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Mike Rapoport <mike@compulab.co.il>, "ext Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [100211 03:59]:
> On Thu, 2010-02-11 at 12:50 +0100, ext Mike Rapoport wrote:
> > Tomi Valkeinen wrote:
> > > Hi,
> > > 
> > > As discussed previously, board file changes in DSS2 tree cause conflicts
> > > with linux-omap easily. There are currently three board file patches in
> > > DSS2's for-next branch:
> > > 
> > > 722a97e4594b2041bbf18d95a913ba6dfaca87f2 omap3: cm-t35: add DSS2 display support
> > > 7a56267e775e469c64521179ccc958c8bb661dbf OMAP: AM3517: Enable DSS2 for AM3517EVM board
> > > 40e4e67c6dabcb9897b6823cce2297d6c3e78bbd OMAP: Enable DSS2 for OMAP3EVM board
> > > 
> > > The problem here is of course that DSS2 tree may contain unmerged panel
> > > drivers, and those board file changes try to use these new panel
> > > drivers.

OK, Tomi, can you please set up a banch against mainline -rc7 with
whatever board-*.c dss2 patches you want me to pull? I'll pull them
into omap-for-linus, and rebase omap for-next on those.

In general, omap-for-linus should be static for Linus to pull, while
omap for-next still changes based on the comments.
 
> > Well, the panel drivers are referenced by name in the board files, so merging board
> > file changes through linux-omap tree should not create merge conflicts and compile
> > problems. There just won't be display until DSS2 tree is merged. Or am I missing
> > something?
> 
> Yes, that is correct. This makes adding new boards and panels a bit more
> complicated, but should remove most conflicts that happen between
> linux-omap and dss2 trees.

Sure I'll can pull whatever Tomi thinks is OK. Just please
make sure that before I pull, all the dss2 board-*.c patches have
been reviewed on both linux-omap and linux-arm-kernel lists.

We should probably also start merging Tomi's drivers/video/omap branch
into omap master branch on regular basis for testing.

Regards,

Tony
