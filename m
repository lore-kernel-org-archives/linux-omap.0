From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] OMAP: SCM/McBSP/clock: branch integration
 patches for 2.6.37
Date: Wed, 6 Oct 2010 07:48:07 -0700
Message-ID: <20101006144807.GB2913@atomide.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
 <20101005155242.20900538.jhnikula@gmail.com>
 <20101005184017.GP3117@atomide.com>
 <201010060842.21260.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53337 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490Ab0JFOsP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 10:48:15 -0400
Content-Disposition: inline
In-Reply-To: <201010060842.21260.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [101005 22:33]:
> On Tuesday 05 October 2010 21:40:17 ext Tony Lindgren wrote:
> 
> ...
> 
> > > For patches 6-7 you could have my ack.
> > > Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> > > 
> > > As they are touching also sound/soc/omap/omap-mcbsp.c, an ack from Mark
> > > and Liam are needed. Links to patches 6 and 7 below and my fixes on top
> > > of them [1].
> > > 
> > > http://marc.info/?l=linux-omap&m=128596931117788&w=2
> > > http://marc.info/?l=linux-omap&m=128596931417805&w=2
> > 
> > Sorry, I've already merged them as they fixed code that did not compile.
> > 
> > Let me know if you guys want me to rebuild those parts of omap-for-linus
> > to add the acks.
> 
> If you decide to rebuild, than you can add my (for patch 6-7):
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com> 

OK, let's do that then we should still have some time left before the
merge window.

Mark & Liam, care to ack as well?

Regards,

Tony
