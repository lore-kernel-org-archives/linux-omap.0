From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: TWL6030: Add twl6030 codec
 driver
Date: Wed, 16 Sep 2009 11:17:23 +0100
Message-ID: <20090916101723.GA3589@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90432706@dlee04.ent.ti.com>
 <20090914172135.GA2481@rakim.wolfsonmicro.main>
 <67059DBF19D7214F9C66BB0EA91BA90E907FA65B@dlee04.ent.ti.com>
 <20090915183009.GA4343@sirena.org.uk>
 <67059DBF19D7214F9C66BB0EA91BA90E907FA8DC@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59580 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751045AbZIPKRV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Sep 2009 06:17:21 -0400
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E907FA8DC@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>

On Tue, Sep 15, 2009 at 05:39:09PM -0500, Lopez Cruz, Misael wrote:
> Mark Brown wrote:

> > I'd not expect full interoperability but I'd expect that at least the
> > basic PDM support would interoperate happily.  It wouldn't surprise me
> > if more than one manufacturer came up with the same extension
> > for multi channel PDM.

> If that's the case, then a more appropriate name should be chosen.
> Or is it fine for you _MCPDM?

I'd suggest just plain _PDM.

> >> The codec is turned on/off through an external line (i.e. with a
> >> gpio). Then, codec enable is board-dependent.

> > Might it make more sense to specify a GPIO line instead, at least by
> > default? 

> Not sure, if the GPIO line is in TWL6030 (mfd) as well then probably
> it's fine, which may be the case for now. But isn't it violating
> CODEC independency anyway?

I don't see an abstraction problem - gpiolib can handle this well
enough.

> If you mean to sustitute the codec_enable function by the GPIO
> line, then it opens the possibility to make the CODEC to request and
> operate a GPIO line belonging to a different chip, for example
> to the application processor.

If the CODEC GPIOs are supported via gpiolib that shouldn't be a
problem.  If you specify the GPIO as an int then it'll also be possible
to have invalid values so that cases with the CODEC hard wired to power
up will also be handled.

It just seems easier for boards to have the CODEC do the gpio request
and so on so that it's a simple data value that needs to be set.
