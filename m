From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3 0/2]: auto request GPIO as input if used as IRQ via DT
Date: Tue, 2 Jul 2013 09:10:02 -0700
Message-ID: <CAGa+x87OnYmnCQjLzyc5CFJE_n8GXaka2iPjCUdGj=yx1uqd4Q@mail.gmail.com>
References: <1372276203-21755-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:50873 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab3GBQKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 12:10:03 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj3so4344600wib.4
        for <linux-omap@vger.kernel.org>; Tue, 02 Jul 2013 09:10:02 -0700 (PDT)
In-Reply-To: <1372276203-21755-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-omap <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, aaro.koskinen@iki.fi

On Wed, Jun 26, 2013 at 12:50 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

[...]

> Aaro, could you please test if these changes break any of your OMAP1 boards?
> Although it shouldn't do it as far as I can tell.

This doesn't build for omap1_defconfig (at least in next-20130702):

/work/kernel/next/drivers/gpio/gpio-omap.c: In function 'omap_gpio_chip_init':
/work/kernel/next/drivers/gpio/gpio-omap.c:1080:17: error: 'struct
gpio_chip' has no member named 'of_node'
/work/kernel/next/drivers/gpio/gpio-omap.c: In function 'omap_gpio_irq_map':
/work/kernel/next/drivers/gpio/gpio-omap.c:1116:16: error: 'struct
gpio_chip' has no member named 'of_node'

Probably because OMAP1 is non-DT?

Kevin
