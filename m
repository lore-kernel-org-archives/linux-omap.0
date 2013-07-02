From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 1/1] gpio/omap: fix build error when OF_GPIO is not defined.
Date: Tue, 02 Jul 2013 13:48:49 -0700
Message-ID: <87d2r0lmby.fsf@linaro.org>
References: <1372794390-9512-1-git-send-email-javier.martinez@collabora.co.uk>
	<CACRpkdb3n6BKswq=ODXdByRJL3y+ezYF3ZS=nG2K=7Tn=amM9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41443 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab3GBUsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 16:48:55 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so3935353pde.32
        for <linux-omap@vger.kernel.org>; Tue, 02 Jul 2013 13:48:54 -0700 (PDT)
In-Reply-To: <CACRpkdb3n6BKswq=ODXdByRJL3y+ezYF3ZS=nG2K=7Tn=amM9w@mail.gmail.com>
	(Linus Walleij's message of "Tue, 2 Jul 2013 22:15:37 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>

Linus Walleij <linus.walleij@linaro.org> writes:

> On Tue, Jul 2, 2013 at 9:46 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>
>> The OMAP GPIO driver check if the chip has an associated
>> Device Tree node using the struct gpio_chip of_node member.
>>
>> But this is only build if CONFIG_OF_GPIO is defined which
>> leads to the following error when using omap1_defconfig:
>>
>> linux/drivers/gpio/gpio-omap.c: In function 'omap_gpio_chip_init':
>> linux/drivers/gpio/gpio-omap.c:1080:17: error: 'struct gpio_chip' has no member named 'of_node'
>> linux/drivers/gpio/gpio-omap.c: In function 'omap_gpio_irq_map':
>> linux/drivers/gpio/gpio-omap.c:1116:16: error: 'struct gpio_chip' has no member named 'of_node'
>>
>> Reported-by: Kevin Hilman <khilman@linaro.org>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>
>> Hi Linus,
>>
>> Sorry for not spoting this issue before. In a previous version of the patch-set:
>>
>> [PATCH v3 0/2]: auto request GPIO as input if used as IRQ via DT
>>
>> of_have_populated_dt() was used instead of struct gpio_chip of_node member to
>> check wether legacy or DT boot was used. I did a build test on every OMAP platform
>> but later I was asked to use .of_node instead of_have_populated_dt() and forget
>> to do a built test for OMAP1.
>
> Such things happen ...
>
>> I hope this patch can go as a fix for the v3.11-rc cycle.
>
> Yeah I queued it on top of the others. Good thing I didn't rush the
> other two out :-)

I can confirm this makes the build work again for omap1_defconfig.

Javier, thanks for the quick fix!     

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
