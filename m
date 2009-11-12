From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/19] OMAP: DSS2 v5 intro
Date: Thu, 12 Nov 2009 10:08:12 -0800
Message-ID: <20091112180812.GW24837@atomide.com>
References: <1257767126-12059-1-git-send-email-tomi.valkeinen@nokia.com>
 <1257856848.21596.753.camel@localhost>
 <1257929140.20378.51.camel@tubuntu.research.nokia.com>
 <1257932641.20378.77.camel@tubuntu.research.nokia.com>
 <20091111184208.GC24837@atomide.com>
 <1258002222.21596.1129.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56699 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbZKLSIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 13:08:14 -0500
Content-Disposition: inline
In-Reply-To: <1258002222.21596.1129.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

* Artem Bityutskiy <dedekind1@gmail.com> [091111 21:05]:
> On Wed, 2009-11-11 at 10:42 -0800, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@nokia.com> [091111 01:43]:
> > > On Wed, 2009-11-11 at 09:45 +0100, Valkeinen Tomi (Nokia-D/Helsinki)
> > > wrote:
> > > > On Tue, 2009-11-10 at 13:40 +0100, Artem Bityutskiy wrote:
> > > > > Tomi,
> > > > > 
> > > > > could you please kindly ask Stephen (CCed) to include the DSS2 tree into
> > > > > linux-next, because you are going to merge it the next merge window, and
> > > > > there does not seem to be any blocker for this.
> > > > > 
> > > > > Being in linux-next for a while is really important.
> > > > 
> > > > Stephen, would this be possible? DSS2 driver is rather big piece of
> > > > code, even if it's quite isolated, so it would be nice to have it in
> > > > linux-next.
> > > > 
> > > > What does it require from me? A git tree, obviously, but what should it
> > > > be based on?
> > > 
> > > Ah, I just realized that DSS2 patches depend on patches from Tony's
> > > tree. I guess I should base my tree on top of some Tony's tree that is
> > > going to linux-next?
> > 
> > Or I can merge them into my for-next if that's OK with everybody. This
> > merge cycle is a pain for omap as we've moved all the common headers from
> > include/mach to include/plat.
> 
> I thought everything stable which you are going to merge next merge
> window should be in the next branch by default. Especially these massive
> re-names which potentially may break many things, right?

Yes, the renames are already there.

Tony
