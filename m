From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3] gpio: omap: implement get_direction
Date: Thu, 24 Apr 2014 15:25:16 -0700
Message-ID: <7hppk6nz5f.fsf@paris.lan>
References: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com>
	<CACRpkdZPNGHNQhqovDoaKTXZT3mJfN4pjKSBxW7m6wT5u-XEYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:61693 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbaDXWZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 18:25:19 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so2393767pde.17
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2014 15:25:19 -0700 (PDT)
In-Reply-To: <CACRpkdZPNGHNQhqovDoaKTXZT3mJfN4pjKSBxW7m6wT5u-XEYQ@mail.gmail.com>
	(Linus Walleij's message of "Thu, 24 Apr 2014 15:13:04 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: yegorslists@googlemail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

Linus Walleij <linus.walleij@linaro.org> writes:

> On Thu, Apr 24, 2014 at 8:57 AM,  <yegorslists@googlemail.com> wrote:
>
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> This patch implements gpio_chip's get_direction() routine, that
>> lets other drivers get particular GPIOs direction using
>> struct gpio_desc.
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>> Changes:
>>         v3: get rid of _get_gpio_direction() (Linus Walleij)
>>         v2: rework return value calculation
>
> Looks good to me, Kevin, Santosh?

Reviewed-by: Kevin Hilman <khilman@linaro.org>

> Part of me wants to list Javier as maintainer for this driver.

That's fine with me. 

Kevin
