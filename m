From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 00/10] Patches for fixing the lowmem module
Date: Thu, 11 Sep 2008 19:48:09 +0300
Message-ID: <20080911164809.GN16796@gandalf.research.nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com> <20080911161702.GL16796@gandalf.research.nokia.com> <1221152129.10962.12.camel@viktor.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17004 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYIKQsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:48:12 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGm9N8025472
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 11:48:10 -0500
Content-Disposition: inline
In-Reply-To: <1221152129.10962.12.camel@viktor.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Viktor Rosendahl <Viktor.Rosendahl@nokia.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Thu, Sep 11, 2008 at 07:55:29PM +0300, Viktor Rosendahl wrote:
> On Thu, 2008-09-11 at 19:17 +0300, Felipe Balbi wrote:
> > On Thu, Sep 11, 2008 at 07:20:32PM +0300, ext Viktor Rosendahl wrote:
> > > 
> > > Hello,
> > > 
> > > Currently the lowmem module doesn't compile. Here are some patches
> > > that will fix a bug, make some improvements and even make it compile.
> > > 
> > >  security/lowmem.c |  258 ++++++++++++++++++++++++++++++++----------------------
> > >  1 file changed, 154 insertions(+), 104 deletions(-)
> > 
> > This series should be going to LKML, l-o will get it when merging
> > upstream I'd say.
> > 
> 
> The only problem is that currently the lowmem module doesn't exist in
> mainline. My guess is that the lowmem module would need quite a bit of
> more work before it would be accepted in mainline, if at all. 
> 
> It will probably take some time before we get it into mainline, so I
> suggest that these patches are meged into linux-omap now.

Hmm... got it ;-)

It's yet another piece of code that never made its way to mainline :-)

-- 
balbi
