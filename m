From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
Date: Thu, 23 Jun 2016 12:38:07 +0300
Message-ID: <576BADFF.3000802@ti.com>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
 <20160615072404.GB26768@pengutronix.de>
 <CACRpkdYK1C5px+A_O1sF99KTPTob9qTQpipEaRLHnNx5=AokLg@mail.gmail.com>
 <20160619010823.GC26875@pengutronix.de> <20160622161644.GD31817@leverpostej>
 <CACRpkdazjgZX3cY2Q6AoQRmX14x-YU6SQ=Q38tZHt8xX6St24g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdazjgZX3cY2Q6AoQRmX14x-YU6SQ=Q38tZHt8xX6St24g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Kevin Hilman <khilman@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 06/23/2016 12:04 PM, Linus Walleij wrote:
> On Wed, Jun 22, 2016 at 6:16 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> 
>> In general, our use of aliases is rather ill-defined. It would be nicer
>> if we could address devices in a similar manner to disks or partitions,
>> e.g. by path or uuid, but I don't think we have anything sensible we can
>> use there.
>>
>> Given that, I can see the use of an alias to provide a consistent way of
>> referring to a particular gpiochip (and maybe we need to expose the
>> alises information somehow to userspace), but IMO that's independent of
>> any global ID space, probe ordering, etc.
> 
>  From the kernel point of view the way forward to identify and refer to
> a particular gpiochip is using /dev/gpiochipN the character device.
> 
> If complete topology of the bus placement etc is needed, userspace
> can traverse /sys/bus/gpio/*
> 
> This solves the big problem with the current global numbering system
> in /sys/class/gpio/*

Hm. May be i misunderstood samthing (and sry, if my following question
is dummy as I've not followed closely new GPIO ABI development), but..

- from above description it seems that  global numbering system is not really
solved :( instead it's been moved one level up and now the same happens with
gpiocipX devices :( Wouldn't it be reasonable to add possibility to create named/labeled
gpiocipX devices from the very beginning, like: "/dev/gpiocipX[_name|label], or "/dev/gpiocip[_name|label]", or ..

Actually, struct gpio_chip has label field already.

PS. From my experience, the worst case with dev numbering usually happens after 
few insmod/rmmod (or sometimes after suspend/resume) iterations - ttyX ;..(.

> 
> So what this alias should address would be two things:
> 
> - Solve the immediate issue of the global number space for the
>    legacy sysfs ABI, but also:
> 
> - Determine which chip is gpiochip0, gpiochip1, .. etc in the
>    new ABI, so the devices get consistent numbering.
> 
> The latter is lightly frowned upon by the udev people: they think it
> is more proper to traverse /sys to get topological information about
> the devices.
> 
> I would appreciate if a patch to add alias handling would take care
> of both these things if we apply it.
> 

-- 
regards,
-grygorii
