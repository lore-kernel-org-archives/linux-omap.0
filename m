From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] Patches for fixing the lowmem module
Date: Fri, 12 Sep 2008 11:14:46 -0700
Message-ID: <20080912181444.GE10675@atomide.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com> <20080911161702.GL16796@gandalf.research.nokia.com> <1221152129.10962.12.camel@viktor.research.nokia.com> <20080911164809.GN16796@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56882 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbYILSOs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 14:14:48 -0400
Content-Disposition: inline
In-Reply-To: <20080911164809.GN16796@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Viktor Rosendahl <Viktor.Rosendahl@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080911 09:48]:
> On Thu, Sep 11, 2008 at 07:55:29PM +0300, Viktor Rosendahl wrote:
> > On Thu, 2008-09-11 at 19:17 +0300, Felipe Balbi wrote:
> > > On Thu, Sep 11, 2008 at 07:20:32PM +0300, ext Viktor Rosendahl wrote:
> > > > 
> > > > Hello,
> > > > 
> > > > Currently the lowmem module doesn't compile. Here are some patches
> > > > that will fix a bug, make some improvements and even make it compile.
> > > > 
> > > >  security/lowmem.c |  258 ++++++++++++++++++++++++++++++++----------------------
> > > >  1 file changed, 154 insertions(+), 104 deletions(-)
> > > 
> > > This series should be going to LKML, l-o will get it when merging
> > > upstream I'd say.
> > > 
> > 
> > The only problem is that currently the lowmem module doesn't exist in
> > mainline. My guess is that the lowmem module would need quite a bit of
> > more work before it would be accepted in mainline, if at all. 
> > 
> > It will probably take some time before we get it into mainline, so I
> > suggest that these patches are meged into linux-omap now.
> 
> Hmm... got it ;-)
> 
> It's yet another piece of code that never made its way to mainline :-)

Still, how about posting it to LKML? Other people may be interested in
it too. And you'll find out what would have to be fixed to get it
integrated.

Anyways, pushing to l-o tree today.

Tony
