From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
Date: Thu, 23 Jun 2016 14:08:33 +0200
Message-ID: <CACRpkdaAcsikDgdbchKkx4i0Pk12qp7gTDUQJvj+kmCOtiRiqA@mail.gmail.com>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
 <20160615072404.GB26768@pengutronix.de> <CACRpkdYK1C5px+A_O1sF99KTPTob9qTQpipEaRLHnNx5=AokLg@mail.gmail.com>
 <20160619010823.GC26875@pengutronix.de> <20160622161644.GD31817@leverpostej>
 <CACRpkdazjgZX3cY2Q6AoQRmX14x-YU6SQ=Q38tZHt8xX6St24g@mail.gmail.com> <576BADFF.3000802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <576BADFF.3000802@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Kevin Hilman <khilman@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 23, 2016 at 11:38 AM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

>> This solves the big problem with the current global numbering system
>> in /sys/class/gpio/*
>
> Hm. May be i misunderstood samthing (and sry, if my following question
> is dummy as I've not followed closely new GPIO ABI development), but..
>
> - from above description it seems that  global numbering system is not really
> solved :( instead it's been moved one level up and now the same happens with
> gpiocipX devices :(

Yes that is true, but also the discovery mechanism is changed so it should
not be a problem: by traversing /sys/bus/gpio/* you know from the topology
information which GPIO chip is which. This is the same method that e.g. USB,
IIO or disks use: you have to complement the device name with bus information
from sysfs.

/sys/class/gpio/* on the other hand has no such information: it is flat.

But as I wrote in the other mail in response to Mark Rutland: if it is desired
to have predictable numbering of the GPIO chips the exact same alias
method can be used for that, and a patch utilizing aliases should fix also
this for the character device usecase.

My own position on these aliases is "eating popcorn", I'm happy with it,
happy without it, the people who care need to argue for it with the DT
maintainers.

> Wouldn't it be reasonable to add possibility to create named/labeled
> gpiocipX devices from the very beginning, like: "/dev/gpiocipX[_name|label], or "/dev/gpiocip[_name|label]", or ..
>
> Actually, struct gpio_chip has label field already.

I don't think that would be nice. There is an ioctl() to get that information
(amongst other stuff) from the device. Check tools/gpio/lsgpio.c

> PS. From my experience, the worst case with dev numbering usually happens after
> few insmod/rmmod (or sometimes after suspend/resume) iterations - ttyX ;..(.

In the GPIO case I think the numbers will be reused as we're using
<linux/idr.h> infrastructure (same method as IIO).

Yours,
Linus Walleij
