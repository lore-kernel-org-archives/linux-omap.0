From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] gpio-twl4030: get platform data from device tree
Date: Tue, 4 Sep 2012 09:30:32 +0200
Message-ID: <CACRpkdY7AtvGRabo6A9Go=g1=nJY08YXGm3r5oL+Q9RKjW=Ncw@mail.gmail.com>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
	<1346680491-4211-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34154 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab2IDHad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 03:30:33 -0400
Received: by wicr5 with SMTP id r5so4931920wic.1
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 00:30:32 -0700 (PDT)
In-Reply-To: <1346680491-4211-2-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org

On Mon, Sep 3, 2012 at 3:54 PM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:

> Adds a number of missing properties to the device tree of
> twl4030/gpio:
> - "ti,use-leds"  -> .use_leds
> - "ti,debounce"  -> .debounce
> - "ti,mmc-cd"    -> .mmc_cd
> - "ti,pullups"   -> .pullups
> - "ti,pulldowns" -> .pulldowns
>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Tony will you carry this in the OMAP tree?

Yours,
Linus Walleij
