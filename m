From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 18:45:12 +0200
Message-ID: <51F54A98.80601@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <51F529D6.8030809@ahsoftware.de> <CACRpkdYKSMcCe+uNiB2Jbc8GbUwvJxyq+7EiLM-xdOevVRK-wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:40086 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab3G1QqK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 12:46:10 -0400
Received: from eiche.ahsoftware (p57B21DD0.dip0.t-ipconnect.de [87.178.29.208])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id BAB80423C1E2
	for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 18:46:07 +0200 (CEST)
In-Reply-To: <CACRpkdYKSMcCe+uNiB2Jbc8GbUwvJxyq+7EiLM-xdOevVRK-wQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Balaji T K <balajitk@ti.com>

Am 28.07.2013 18:25, schrieb Linus Walleij:
> On Sun, Jul 28, 2013 at 4:25 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> 
>> By the way, if someone decides to touch omap_hsmmc, the driver wrongly
>> assumes that 0 is not a valid IRQ number and it doesn't check if
>> gpio_to_irq() returns a negative value. ;)
> 
> Zero *is* *not* a valid IRQ number.

Where is that mentioned?

gpio.txt states:

----
Non-error values returned from gpio_to_irq() can be passed to request_irq()
or free_irq().  They will often be stored into IRQ resources for platform
----

With the new patches gpio_to_irq() returns 0.

Documentation/IRQ-domain.txt:
----
The legacy map should only be used if fixed IRQ mappings must be
supported.  For example, ISA controllers would use the legacy map for
mapping Linux IRQs 0-15 so that existing ISA drivers get the correct IRQ
numbers.
----

You see the 0 too?

And while browsing some other source I had the impression zero might be
a valid irq number too, at least in regard to the IRQ apis. If it's a
valid IRQ nuber on ARM is something else.

Of ourse, I might be wrong, but you just stated that 0 isn't valid, and
I would be happy to find a source for your statement.

Alexander Holler
