From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 14:59:21 +0200
Message-ID: <51F515A9.9010005@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:40815 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab3G1NA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 09:00:58 -0400
Received: from eiche.ahsoftware (p57B21DD0.dip0.t-ipconnect.de [87.178.29.208])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 693B0423C272
	for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 15:00:56 +0200 (CEST)
In-Reply-To: <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Balaji T K <balajitk@ti.com>

Am 28.07.2013 13:14, schrieb Linus Walleij:
> On Sun, Jul 28, 2013 at 12:58 PM, Alexander Holler <holler@ahsoftware.de> wrote:
>> Am 28.06.2013 17:27, schrieb Javier Martinez Canillas:
>>
>>> When a GPIO is defined as an interrupt line using Device
>>> Tree, a call to irq_create_of_mapping() is made that calls
>>> irq_create_mapping(). So, is not necessary to do the mapping
>>> for all OMAP GPIO lines and explicitly call irq_create_mapping()
>>> on the driver probe() when booting with Device Tree.
>>>
>>> Add a custom IRQ domain .map function handler that will be
>>> called by irq_create_mapping() to map the GPIO lines used as IRQ.
>>> This also allows to execute needed setup code such as configuring
>>> a GPIO as input and enabling the GPIO bank.
>>
>>
>> This patch basically broke every usage of
>>
>> irq = gpio_to_irq(gpio);
>> request[_threaded]_irq(irq, ...);
>>
>> because request[_threaded]_irq(irq, ...) now fails because of a missing
>> irq_domain (no mapping => no domain).
> 
> OK and I had ACKs from Santosh and even a Test-by tag from Enric
> on that thing.
> 
> What shall we do with this mess now?
> 
> I was told that these patches really needed to be applied because
> they were fixing a regression in v3.11, and now it seems they are
> causing another regression.
> 
> What I need to know is what is worst: having these three patches
> there or reverting them?
> 
> Or should I simply revert *all* the TI GPIO stuff merged for v3.11
> now that is seems like this is a can of worms? :-/
> 
> Tony, Kevin, Santosh, someone? What will make all happy?

Hmm, maybe something which adds a mapping for a IRQ when gpio_to_irq()
is called would help.

I've just reverted the 3 patches on that topic because I was to lazy to
find out how to add a mapping for an irq in gpio_to_irq().

And just in case, I've only seen a breakage with that cd-signal for MMC
and nothing else. But I haven't really tested 3.11-rc much and only just
added that cd-gpio to my DT which is the reason I've seen the problem.
And my stripped down kernel doesn't seem to use a gpio-irq somewhere else.

But nevertheless, I assume it is a problem.

Regards,

Alexander Holler
