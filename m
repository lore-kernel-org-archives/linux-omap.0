From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] gpio: omap: Remove unneeded include
Date: Tue, 8 Jul 2014 09:55:18 +0200
Message-ID: <CACRpkdYoA=MzSrujQi=4N76-ROYwrG9t4jHmC3seQMgT_VtvdQ@mail.gmail.com>
References: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
	<1403900258-20717-3-git-send-email-jmartinez@softcrates.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:51520 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbaGHHzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 03:55:18 -0400
Received: by mail-oa0-f47.google.com with SMTP id n16so5957992oag.6
        for <linux-omap@vger.kernel.org>; Tue, 08 Jul 2014 00:55:18 -0700 (PDT)
In-Reply-To: <1403900258-20717-3-git-send-email-jmartinez@softcrates.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Javier Martinez Canillas <jmartinez@softcrates.net>

On Fri, Jun 27, 2014 at 10:17 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:

> The <linux/irqchip/chained_irq.h> header is already included
> when selecting GPIOLIB_IRQCHIP so there is no need to do it
> in the driver. This is a left over from commit fb655f5
> ("gpio: omap: convert driver to use gpiolib irqchip").
>
> Signed-off-by: Javier Martinez Canillas <jmartinez@softcrates.net>

Patch applied.

Yours,
Linus Walleij
