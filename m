From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/10] OMAP: SCM/McBSP/clock: branch integration patches
 for 2.6.37
Date: Wed, 6 Oct 2010 12:57:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010061255260.13816@utopia.booyaka.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>  <20101005155242.20900538.jhnikula@gmail.com>  <20101005184017.GP3117@atomide.com>  <201010060842.21260.peter.ujfalusi@nokia.com>  <20101006144807.GB2913@atomide.com>
 <1286377687.5662.24.camel@odin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34997 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759806Ab0JFS57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 14:57:59 -0400
In-Reply-To: <1286377687.5662.24.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi, 
On Wed, 6 Oct 2010, Liam Girdwood wrote:

> On Wed, 2010-10-06 at 07:48 -0700, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@nokia.com> [101005 22:33]:
> > > On Tuesday 05 October 2010 21:40:17 ext Tony Lindgren wrote:
> > > 
> > > ...
> > > 
> > > > > For patches 6-7 you could have my ack.
> > > > > Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> > > > > 
> > > > > As they are touching also sound/soc/omap/omap-mcbsp.c, an ack from Mark
> > > > > and Liam are needed. Links to patches 6 and 7 below and my fixes on top
> > > > > of them [1].
> > > > > 
> > > > > http://marc.info/?l=linux-omap&m=128596931117788&w=2
> > > > > http://marc.info/?l=linux-omap&m=128596931417805&w=2
> > > > 
> > > > Sorry, I've already merged them as they fixed code that did not compile.
> > > > 
> > > > Let me know if you guys want me to rebuild those parts of omap-for-linus
> > > > to add the acks.
> > > 
> > > If you decide to rebuild, than you can add my (for patch 6-7):
> > > Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com> 
> > 
> > OK, let's do that then we should still have some time left before the
> > merge window.
> > 
> > Mark & Liam, care to ack as well?
> > 
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Okay, acks from Liam, Mark, Peter, and Jarkko have been added to patches 6 
and 7.  Also, acks from Peter have been added to Jarkko's three patches.  
Jarkko's three patches have been added on to the original ten.  Will send 
out an updated pull request shortly.


- Paul
