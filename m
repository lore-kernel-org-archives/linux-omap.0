From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: pcf875x: Revert "gpio: pcf857x: Propagate wake-up
 setting to parent irq controller"
Date: Tue, 19 May 2015 11:05:37 +0200
Message-ID: <CACRpkdaYv1Uo_b_2wYmj4wthfnqNCb-z4pAhWt2Db73p=q6_VA@mail.gmail.com>
References: <1431353601-21295-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:32892 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbbESJFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2015 05:05:38 -0400
Received: by oica37 with SMTP id a37so5864977oic.0
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2015 02:05:37 -0700 (PDT)
In-Reply-To: <1431353601-21295-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>

On Mon, May 11, 2015 at 4:13 PM, Roger Quadros <rogerq@ti.com> wrote:

> commit b80eef95beb0 ('gpio: pcf857x: Propagate wake-up setting to parent irq controller')
> introduces the following recursive locking warning while suspending dra7-evm.
>
> The issue addressed by that commit has been already resolved by
> commit 10a50f1ab5f0 ('genirq: Set IRQCHIP_SKIP_SET_WAKE flag for dummy_irq_chip')
> and so let's revert commit b80eef95beb0 ('gpio: pcf857x: Propagate wake-up setting to parent irq controller')
>
> At least the recursive locking message no longer appears after the revert.

Geert do you have a better solution to this or should I just
apply the revert?

Yours,
Linus Walleij
