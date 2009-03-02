From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc6+misc] MMC: regulator utilities
Date: Mon, 2 Mar 2009 14:00:49 -0800
Message-ID: <200903021400.50201.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200903021327.14285.david-b@pacbell.net> <20090302224040.5e7ab0b2@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n28.bullet.mail.mud.yahoo.com ([68.142.206.223]:28643 "HELO
	n28.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754420AbZCBWAy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 17:00:54 -0500
In-Reply-To: <20090302224040.5e7ab0b2@mjolnir.ossman.eu>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Monday 02 March 2009, Pierre Ossman wrote:
> > > > +int mmc_regulator_set_ocr(struct mmc_host *host, struct regulator *supply)
> > > > +{
> > > 
> > > Why not pass the vdd directly? Saves a few dereferences if nothing else.
> > 
> > This call syntax is simpler, which is usually a win.
> > Passing a third parameter would create fault paths
> > of the "pass *wrong* parameter" flavor.
> > 
> > In terms of object code, when I've looked at such things
> > the dereferences generally cost the same as a ref to a
> > parameter, but passing an extra parameter isn't free.
> > 
> 
> I couldn't see host being used in there, so I was thinking more of a
> replacement, not an addition.

Oh, I see.  That'd make sense.  Just pass host->ios.vdd.



