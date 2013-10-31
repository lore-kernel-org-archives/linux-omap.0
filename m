From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 4/4] ASoC: RX-51: Add DT support to sound driver
Date: Thu, 31 Oct 2013 07:44:22 -0700
Message-ID: <CACRpkdb1dAiDCeZkOiZ6inbDruaUwLgk3joWwuQmSRNZ9WkDGw@mail.gmail.com>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
	<1382909086-10493-5-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37049 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab3JaOoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Oct 2013 10:44:23 -0400
Received: by mail-oa0-f46.google.com with SMTP id g12so3174558oah.33
        for <linux-omap@vger.kernel.org>; Thu, 31 Oct 2013 07:44:22 -0700 (PDT)
In-Reply-To: <1382909086-10493-5-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.>

On Sun, Oct 27, 2013 at 2:24 PM, Sebastian Reichel <sre@debian.org> wrote:

> +- eci-sw-gpio: GPIO for ECI SW
> +- speaker-amp-gpio: GPIO for Speaker Amp

Can you please spell out the acronyms? ECI? SW? Amp?

I guess SW=switch, Amp=amplifier, but ECI beats me.

Yours,
Linus Walleij
