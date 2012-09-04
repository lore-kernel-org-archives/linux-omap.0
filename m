From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] gpio-twl4030: new dt properties for BeagleBoard and omap3-EVM
Date: Tue, 4 Sep 2012 09:30:57 +0200
Message-ID: <CACRpkdYkYeykE6j_CZG_WdPoewFGMBFKgA02yW9JmeckgUB4WA@mail.gmail.com>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
	<1346680491-4211-3-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55127 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756256Ab2IDHa7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 03:30:59 -0400
Received: by wgbdr13 with SMTP id dr13so5322998wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 00:30:58 -0700 (PDT)
In-Reply-To: <1346680491-4211-3-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

On Mon, Sep 3, 2012 at 3:54 PM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:

> Add device tree properties for twl4030/gpio, according to the
> platform data of corresponding boards. This enables the led
> connected to LEDB output for both boards, as well as
> pullups/pulldowns on GPIO for the BeagleBoard.
>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
