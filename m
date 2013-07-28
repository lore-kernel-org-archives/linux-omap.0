From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 16:11:29 +0200
Message-ID: <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<51F4F973.8000303@ahsoftware.de>
	<CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
	<51F515A9.9010005@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34220 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab3G1OL3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 10:11:29 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so7251140obc.40
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 07:11:29 -0700 (PDT)
In-Reply-To: <51F515A9.9010005@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Balaji T K <balajitk@ti.com>

On Sun, Jul 28, 2013 at 2:59 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> Am 28.07.2013 13:14, schrieb Linus Walleij:

>> What shall we do with this mess now?
(...)
> Hmm, maybe something which adds a mapping for a IRQ when gpio_to_irq()
> is called would help.

I think this bug is pointing back to my initial remark that
we need to flag, in the DT node for each GPIOchip
that provides "auto-IRQs" exactly which IRQ lines that
will be used as simple IRQ lines. This is what I called
"GPIO hogs" a while back.

If this had been done, gpio_request_one() would
*only* have been called on the GPIOs marked as
being used for IRQs simply. And we wouldn't have
had this bug.

I am leaning towards reverting the whole shebang
right now, and using that as an argument to hammer
in my opinion that we need to do it my way unless
something incredibly clever comes up.

Yours,
Linus Walleij
