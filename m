From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 11:05:13 +0200
Message-ID: <CACRpkda3vN1SQR-25358B20Gye3kgVOBTQqYT+reYhjQoZ2rbA@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<51F4F973.8000303@ahsoftware.de>
	<51F529D6.8030809@ahsoftware.de>
	<CACRpkdYKSMcCe+uNiB2Jbc8GbUwvJxyq+7EiLM-xdOevVRK-wQ@mail.gmail.com>
	<51F54A98.80601@ahsoftware.de>
	<CACRpkdYb7jBpZofLn5VLL7pcMdh5P227ZpwYfV2HJAszFwUEig@mail.gmail.com>
	<CAAwP0s0q6U6MDYBHiA=u3N_3bJ7CXTPKX_A_wwTrWrqj17mH0w@mail.gmail.com>
	<51F5FC8E.9010007@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51427 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3G2JFO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 05:05:14 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so5602839obb.33
        for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 02:05:13 -0700 (PDT)
In-Reply-To: <51F5FC8E.9010007@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Balaji T K <balajitk@ti.com>

On Mon, Jul 29, 2013 at 7:24 AM, Alexander Holler <holler@ahsoftware.de> wrote:

> Maybe it might be worth to suggest using/returning NO_IRQ in (new) patches
> instead of zero. That would make it very clear that the value 0 isn't to be
> used later.

Using NO_IRQ is also discouraged, and this is because we should
use the if (!irq) design pattern and not if (irq == NO_IRQ).

Yours,
Linus Walleij
