From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] regulator core: fix double-free in
	regulator_register() error path
Date: Tue, 28 Apr 2009 12:00:52 +0100
Message-ID: <20090428110052.GH14626@sirena.org.uk>
References: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com> <200904272008.50268.david-b@pacbell.net> <20090428081646.GC20027@rakim.wolfsonmicro.main> <200904280232.56329.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52962 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757150AbZD1LAz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 07:00:55 -0400
Content-Disposition: inline
In-Reply-To: <200904280232.56329.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, linux-kernel@vger.kernel.org

On Tue, Apr 28, 2009 at 02:32:56AM -0700, David Brownell wrote:
> On Tuesday 28 April 2009, Mark Brown wrote:

> > It's not VAUX3 that it's saying has incomplete constraints, it's the
> > board as a whole - if the constraints for the board were fully specified

> No; driver support != constraint.  Only one of the
> issues is packaged as a "constraint".

Driver support isn't particularly relevant here.  If there are devices
that don't have drivers or don't have drivers with regulator support but
need a regulator enabling then the board should mark the regulator as
always_on when setting full constraints; the always_on flag can be
removed when the required consumers are added.

> > > Mark and/or Liam ... you might want to fix that diagnostic, to
> > > avoid leading more developers astray!

> > Probably shove a "board has" in there or something I guess.

> How about:  "VAUX3 board support is incomplete".
> That's accurate.

No.  The constraints being complete is a property of the board as a
whole and not the particular regulator.
