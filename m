From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Fri, 7 Sep 2012 23:59:23 +0200
Message-ID: <CACRpkdZbyUFvYuou015ge+k8zroNtL9s9HFKsVC5OJV8NHEorg@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
	<CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
	<331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
	<20120907110251.GA7968@glitch>
	<331ABD5ECB02734CA317220B2BBEABC13EA29BF3@DBDE01.ent.ti.com>
	<20120907160025.GB14330@glitch>
	<20120907163542.GU1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55419 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab2IGV7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 17:59:24 -0400
Received: by wibhi8 with SMTP id hi8so247545wib.1
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 14:59:23 -0700 (PDT)
In-Reply-To: <20120907163542.GU1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.com>, Grant Likely <grant.likely@secretlab.ca>

On Fri, Sep 7, 2012 at 6:35 PM, Tony Lindgren <tony@atomide.com> wrote:

> In the pure GPIO pins only case it could be all done in the GPIO controller,
> but it's probably best to have the pins muxed by the drivers using them.

Yes, that's an easier way to say the long unreadable thing I just
posted ...

> Some drivers doing runtime PM may need to dynamically toggle the pins
> for idle mode to stop leakage, enable wakeup events for rx pins etc.
> Probably no need for that in the gpio leds case, but it would be confusing
> to have some pins claimed by the GPIO driver and some by the drivers
> using the pins.

True. drivers/tty/serial/amba-pl011.c provides a simple example.

Yours,
Linus Walleij
