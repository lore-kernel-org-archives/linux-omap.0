From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 13:48:28 +0200
Message-ID: <CACRpkdZPh0SQ=eGa7f7GTBqEoceUaxrvAoq_Gr9Te57bnR+X_g@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<51F4F973.8000303@ahsoftware.de>
	<CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
	<51F515A9.9010005@ahsoftware.de>
	<CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com>
	<448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com>
	<CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com>
	<CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com>
	<CACRpkdYEmzh-Viq+vj6-99yz8=Ghn=e3Xe5_UYvsSkTr0g8JyQ@mail.gmail.com>
	<CAAwP0s2ETdSwmFjh=QJP+LwU+hsBR_KQ0mYGX94BYYfjx3+QVA@mail.gmail.com>
	<51F60E81.7090103@ahsoftware.de>
	<CAAwP0s2ZF8_qwkHYTn4RBbMFjzL3otMNcmswsDFC9vXPmnpjwg@mail.gmail.com>
	<51F64397.2090107@ahsoftware.de>
	<2AF86F5A-DEF4-47BD-A08D-7292753A51EC@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:36287 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3G2Ls2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 07:48:28 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so9998oah.37
        for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 04:48:28 -0700 (PDT)
In-Reply-To: <2AF86F5A-DEF4-47BD-A08D-7292753A51EC@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Alexander Holler <holler@ahsoftware.de>, Javier Martinez Canillas <martinez.javier@gmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

On Mon, Jul 29, 2013 at 1:11 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> A different "GPIO hogs" approach will be used to pre-define which GPIO
> are going to be used as IRQ so the core can request them and setup as input.
>
> I expect you will have the same issue with this new approach though since
> the omap hsmmc driver will try to call gpio_request() on a previously
> requested GPIO.

This should not happen.

I've realized that GPIO interrupt hogs will just redefine information
that already exist in the device tree.

The right way is to traverse the tree, find all references to the GPIO
based interrupt-controller, and request each of these lines as
GPIO (i.e. hog them) in the gpiolib OF core.

Yours,
Linus Walleij
