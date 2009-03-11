From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch 2.6.29-rc6+misc] MMC: regulator utilities
Date: Wed, 11 Mar 2009 14:34:28 +0000
Message-ID: <1236782068.6781.159.camel@vega.slimlogic.co.uk>
References: <200902081037.06645.david-b@pacbell.net>
	 <20090308224907.62e9d9d5@mjolnir.ossman.eu>
	 <1236599566.6781.87.camel@vega.slimlogic.co.uk>
	 <200903110430.44198.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755721AbZCKOen@vger.kernel.org>
In-Reply-To: <200903110430.44198.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Pierre Ossman <drzeus-mmc@drzeus.cx>, Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2009-03-11 at 03:30 -0800, David Brownell wrote:
> On Monday 09 March 2009, Liam Girdwood wrote:
> > > > From: David Brownell <dbrownell@users.sourceforge.net>
> > > > 
> > > > Glue between MMC and regulator stacks ... verified with
> > > > some OMAP3 boards using adjustable and configured-as-fixed
> > > > regulators on several MMC controllers.
> > > > 
> > > > ...
> > > 
> > > Acked-by: Pierre Ossman <drzeus@drzeus.cx>
> > > 
> > 
> > Applied.
> 
> ... actually you applied an old version, not the one that
> was verified, with mmc_regulator_set_ocr() fixes and with
> Pierre's ACK.  The comment is in your GIT tree is wrong,
> for starters...
> 
> Please use this one instead.

I've removed the old patch now and applied the correct one. In the
future could you start a new thread or change the thread subject a
little (i.e. patch V2) when a patch changes during discussion. This
should avoid similar confusion in the future.

Thanks

Liam
