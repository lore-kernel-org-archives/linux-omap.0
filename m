From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] gpio-twl4030: get platform data from device tree
Date: Thu, 6 Sep 2012 13:47:44 -0700
Message-ID: <20120906204744.GK1303@atomide.com>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
 <1346680491-4211-2-git-send-email-florian.vaussard@epfl.ch>
 <CACRpkdY7AtvGRabo6A9Go=g1=nJY08YXGm3r5oL+Q9RKjW=Ncw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:33649 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759865Ab2IFUru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:47:50 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdY7AtvGRabo6A9Go=g1=nJY08YXGm3r5oL+Q9RKjW=Ncw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [120904 00:31]:
> On Mon, Sep 3, 2012 at 3:54 PM, Florian Vaussard
> <florian.vaussard@epfl.ch> wrote:
> 
> > Adds a number of missing properties to the device tree of
> > twl4030/gpio:
> > - "ti,use-leds"  -> .use_leds
> > - "ti,debounce"  -> .debounce
> > - "ti,mmc-cd"    -> .mmc_cd
> > - "ti,pullups"   -> .pullups
> > - "ti,pulldowns" -> .pulldowns
> >
> > Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Tony will you carry this in the OMAP tree?

Yes thanks I can queue this once the acks are there,
I guess Benoit is planning to test the series first.

Regards,

Tony
