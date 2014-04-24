From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] gpio: omap: implement get_direction
Date: Thu, 24 Apr 2014 15:35:14 +0200
Message-ID: <CACRpkdZJ_HejR0n47WCrF0fA4Mxr0atR+C6XSfR+HnAba+tq1g@mail.gmail.com>
References: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:59420 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848AbaDXNfP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 09:35:15 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so2650606obc.15
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2014 06:35:14 -0700 (PDT)
In-Reply-To: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegorslists@googlemail.com
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

On Thu, Apr 24, 2014 at 8:57 AM,  <yegorslists@googlemail.com> wrote:

> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> This patch implements gpio_chip's get_direction() routine, that
> lets other drivers get particular GPIOs direction using
> struct gpio_desc.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
> Changes:
>         v3: get rid of _get_gpio_direction() (Linus Walleij)
>         v2: rework return value calculation

This v3 version applied with Santosh's ACK.

Yours,
Linus Walleij
