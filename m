From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 13:14:23 +0200
Message-ID: <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<51F4F973.8000303@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:47312 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab3G1LOY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 07:14:24 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so11085156oag.12
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 04:14:23 -0700 (PDT)
In-Reply-To: <51F4F973.8000303@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Balaji T K <balajitk@ti.com>

On Sun, Jul 28, 2013 at 12:58 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> Am 28.06.2013 17:27, schrieb Javier Martinez Canillas:
>
>> When a GPIO is defined as an interrupt line using Device
>> Tree, a call to irq_create_of_mapping() is made that calls
>> irq_create_mapping(). So, is not necessary to do the mapping
>> for all OMAP GPIO lines and explicitly call irq_create_mapping()
>> on the driver probe() when booting with Device Tree.
>>
>> Add a custom IRQ domain .map function handler that will be
>> called by irq_create_mapping() to map the GPIO lines used as IRQ.
>> This also allows to execute needed setup code such as configuring
>> a GPIO as input and enabling the GPIO bank.
>
>
> This patch basically broke every usage of
>
> irq = gpio_to_irq(gpio);
> request[_threaded]_irq(irq, ...);
>
> because request[_threaded]_irq(irq, ...) now fails because of a missing
> irq_domain (no mapping => no domain).

OK and I had ACKs from Santosh and even a Test-by tag from Enric
on that thing.

What shall we do with this mess now?

I was told that these patches really needed to be applied because
they were fixing a regression in v3.11, and now it seems they are
causing another regression.

What I need to know is what is worst: having these three patches
there or reverting them?

Or should I simply revert *all* the TI GPIO stuff merged for v3.11
now that is seems like this is a can of worms? :-/

Tony, Kevin, Santosh, someone? What will make all happy?

Yours,
Linus Walleij
