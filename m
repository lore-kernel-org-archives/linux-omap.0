From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
Date: Mon, 29 Jul 2013 11:01:17 +0200
Message-ID: <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:53641 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab3G2JBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 05:01:18 -0400
Received: by mail-oa0-f51.google.com with SMTP id h2so250827oag.10
        for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 02:01:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linux-OMAP <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>

Hi Paul,

On Mon, Jul 29, 2013 at 9:52 AM, Paul Walmsley <paul@pwsan.com> wrote:

> your commit 0e970cec05635adbe7b686063e2548a8e4afb8f4 ("gpio/omap: don't
> create an IRQ mapping for every GPIO on DT") breaks the boot on the
> OMAP5912 OSK:

I'm contemplating just reverting this whole series, as I didn't like
the approach from the beginning and it has exploded in exactly
the way I thought it would.

If we revert these three patches:

commit 949eb1a4d29dc75e0b5b16b03747886b52ecf854
"gpio/omap: fix build error when OF_GPIO is not defined."
commit b4419e1a15905191661ffe75ba2f9e649f5d565e
"gpio/omap: auto request GPIO as input if used as IRQ via DT"
commit 0e970cec05635adbe7b686063e2548a8e4afb8f4
"gpio/omap: don't create an IRQ mapping for every GPIO on DT"

Does the OMAP1 boot again after this?

I think it's a way better idea to proceed with input-hogs on the gpiochip
DT node and use that to get auto-request on the GPIO lines that
will be used as IRQs only.

Yours,
Linus Walleij
