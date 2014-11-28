From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/8] usb: musb: Pass fifo_mode in platform data
Date: Fri, 28 Nov 2014 14:40:14 +0100
Message-ID: <CACRpkdYnZ2vRa8j7qqorvyUGH00YJ_yLb+xKKnn3K5YwiKnAxA@mail.gmail.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
	<1416855906-13931-7-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:60528 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaK1NkP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2014 08:40:15 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so9923705igd.8
        for <linux-omap@vger.kernel.org>; Fri, 28 Nov 2014 05:40:14 -0800 (PST)
In-Reply-To: <1416855906-13931-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Fabio Baltieri <fabio.baltieri@linaro.org>, Lee Jones <lee.jones@linaro.org>, Apelete Seketeli <apelete@seketeli.net>, Lars-Peter Clausen <lars@metafoo.de>

On Mon, Nov 24, 2014 at 8:05 PM, Tony Lindgren <tony@atomide.com> wrote:

> This allows setting the correct fifo_mode when multiple
> MUSB glue layers are built-in.
>
> Cc: Fabio Baltieri <fabio.baltieri@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Apelete Seketeli <apelete@seketeli.net>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
