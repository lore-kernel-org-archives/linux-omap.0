From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 20:10:28 +0200
Message-ID: <CACRpkdbADV25OZCehZu79FSiXTMu8vLg3daFAfKO6fSa_ixaUg@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<51F4F973.8000303@ahsoftware.de>
	<CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
	<51F515A9.9010005@ahsoftware.de>
	<CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com>
	<448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com>
	<CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com>
	<51F5512D.1070105@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:46206 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab3G1SK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 14:10:29 -0400
Received: by mail-ob0-f169.google.com with SMTP id wc20so1430400obb.14
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 11:10:28 -0700 (PDT)
In-Reply-To: <51F5512D.1070105@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

On Sun, Jul 28, 2013 at 7:13 PM, Alexander Holler <holler@ahsoftware.de> wrote:

> Having a quick look git grep gpio_to_irq, I've quickly spotted e.g. this
> in drivers/input/keyboard/gpio_keys.c:
>
>                 irq = gpio_to_irq(button->gpio);
>                 if (irq < 0) {
>
> (again <0 not <=0)

Hm I think this should atleast be augmented to spit a warning if
IRQ 0 is returned.

> Besides that, I feel free to ignore me. I don't know what the new
> patches do fix and I don't really have a need for a solution.

No one shall be ignored because I expect the OMAP GPIO
maintainers to have very clear answers to how they want to
proceed with this, and the issue with gpio_to_irq() *is* complex
so we shall indeed discuss it. Better to have the discussion
now and not when it gets deployed in a million systems.

Yours,
Linus Walleij
