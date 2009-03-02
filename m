From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [patch 2.6.29-rc6+misc] MMC: regulator utilities
Date: Mon, 2 Mar 2009 22:40:40 +0100
Message-ID: <20090302224040.5e7ab0b2@mjolnir.ossman.eu>
References: <200902081037.06645.david-b@pacbell.net>
	<200902261348.30617.david-b@pacbell.net>
	<20090302215956.3f355eee@mjolnir.ossman.eu>
	<200903021327.14285.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:41924 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbZCBVko (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Mar 2009 16:40:44 -0500
In-Reply-To: <200903021327.14285.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Mon, 2 Mar 2009 13:27:13 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Monday 02 March 2009, Pierre Ossman wrote:
> > On Thu, 26 Feb 2009 13:48:30 -0800
> > David Brownell <david-b@pacbell.net> wrote:
> > 
> > > + */
> > > +int mmc_regulator_set_ocr(struct mmc_host *host, struct regulator *supply)
> > > +{
> > 
> > Why not pass the vdd directly? Saves a few dereferences if nothing else.
> 
> This call syntax is simpler, which is usually a win.
> Passing a third parameter would create fault paths
> of the "pass *wrong* parameter" flavor.
> 
> In terms of object code, when I've looked at such things
> the dereferences generally cost the same as a ref to a
> parameter, but passing an extra parameter isn't free.
> 

I couldn't see host being used in there, so I was thinking more of a
replacement, not an addition.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
