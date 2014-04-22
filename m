From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/11] pinctrl: single: Clear pin interrupts enabled by bootloader
Date: Tue, 22 Apr 2014 13:54:52 +0200
Message-ID: <CACRpkdYu2Obo8kuA2D9a33K_KCF-LPza=+reEpFnq8JFK6jOCg@mail.gmail.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
	<1397173639-29587-12-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:40155 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932422AbaDVLyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 07:54:53 -0400
Received: by mail-oa0-f42.google.com with SMTP id i4so5562897oah.29
        for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 04:54:53 -0700 (PDT)
In-Reply-To: <1397173639-29587-12-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>

On Fri, Apr 11, 2014 at 1:47 AM, Tony Lindgren <tony@atomide.com> wrote:

> Since we set up device wake-up interrupts as pinctrl-single
> interrupts, we now must use the standard request_irq and
> related functions to manage them.
>
> If the pin interrupts are enabled for some pins at boot,
> the wake-up events can show up as constantly pending
> at least on omaps and will hang the system unless the related
> device driver clears the event at the device.
>
> To fix this, let's clear the interrupt flags during init,
> and print out a warning so the board maintainers can update
> their drivers to do proper request_irq for the driver specific
> wake-up events.
>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Looks clean.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Shall I apply this patch or will you funnel it through ARM SoC
due to deps?

Yours,
Linus Walleij
