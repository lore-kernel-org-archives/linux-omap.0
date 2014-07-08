From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] gpio: omap: Remove unnecessary lockdep class
Date: Tue, 8 Jul 2014 09:54:25 +0200
Message-ID: <CACRpkdYpUJSXFUqJ76r9kQdBCAs4ZUSuNXDUEWOk6kZH0xmOLQ@mail.gmail.com>
References: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
	<1403900258-20717-2-git-send-email-jmartinez@softcrates.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:33994 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbaGHHyZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 03:54:25 -0400
Received: by mail-oa0-f44.google.com with SMTP id i7so5946108oag.3
        for <linux-omap@vger.kernel.org>; Tue, 08 Jul 2014 00:54:25 -0700 (PDT)
In-Reply-To: <1403900258-20717-2-git-send-email-jmartinez@softcrates.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Javier Martinez Canillas <jmartinez@softcrates.net>

On Fri, Jun 27, 2014 at 10:17 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:

> GPIO irqchips assign to the cascaded IRQs their own lock class
> in order to avoid warnings about lockdep recursions since that
> allow the lockdep core to keep track of things.
>
> Since commit e45d1c80 ("gpio: put GPIO IRQs into their own lock class")
> there is no need to do this in a driver if it's using the GPIO
> irqchip helpers since gpiolib already assigns a lockdep class.
>
> Signed-off-by: Javier Martinez Canillas <jmartinez@softcrates.net>

That's right. Patch applied.

Yours,
Linus Walleij
