From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1 compilation problem
Date: Thu, 25 Nov 2010 10:45:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011251043400.20215@utopia.booyaka.com>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl> <20101124235342.GC31536@atomide.com> <20101125090201.256972a4.jhnikula@gmail.com> <201011251347.44912.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37273 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab0KYRpU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 12:45:20 -0500
In-Reply-To: <201011251347.44912.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 25 Nov 2010, Janusz Krzysztofik wrote:

> Thursday 25 November 2010 08:02:01 Jarkko Nikula wrote:
> > On Wed, 24 Nov 2010 15:53:42 -0800
> >
> > Tony Lindgren <tony@atomide.com> wrote:
> > > * Tony Lindgren <tony@atomide.com> [101124 15:25]:
> > > > Anyways, Paul's patch should be merged during the -rc cycle
> > > > because it is currently blocking Amstrad delta being built:
> > > >
> > > > http://armlinux.simtec.co.uk/kautobuild/
> > >
> > > Turns out I'm several hours behind.. The build is
> > > working with Janusz commit 233538501f707b0176f09af7039fec1e3fcac6e7
> > > now in mainline.
> > >
> > > I guess no need to merge Paul's fix then?
> >
> > Not necessary I think if compilers are happy with Janusz's fix. If not,
> > then very strong reasong to start looking for platform data solution
> > as soon as possible :-)
> 
> Fine with me if you prefere reverting my changes and using Paul's fix as a 
> better short term solution instead.

And I'm fine with Janusz's patch.  My patch was written in response to 
Mark's comments about compilers...


- Paul
