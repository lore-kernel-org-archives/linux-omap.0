From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 18:25:07 +0200
Message-ID: <CACRpkdYKSMcCe+uNiB2Jbc8GbUwvJxyq+7EiLM-xdOevVRK-wQ@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<51F4F973.8000303@ahsoftware.de>
	<51F529D6.8030809@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:39029 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab3G1QZI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 12:25:08 -0400
Received: by mail-oa0-f49.google.com with SMTP id n12so10967173oag.8
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 09:25:08 -0700 (PDT)
In-Reply-To: <51F529D6.8030809@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Balaji T K <balajitk@ti.com>

On Sun, Jul 28, 2013 at 4:25 PM, Alexander Holler <holler@ahsoftware.de> wrote:

> By the way, if someone decides to touch omap_hsmmc, the driver wrongly
> assumes that 0 is not a valid IRQ number and it doesn't check if
> gpio_to_irq() returns a negative value. ;)

Zero *is* *not* a valid IRQ number.

But the latter should be checked.

Yours,
Linus Walleij
