From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] gpio: omap: be more aggressive with pm_runtime
Date: Thu, 9 Feb 2012 14:03:56 +0200
Message-ID: <CANOLnONWuEyp9pCPs-tJgyOd_-RdTNAz1axQHJ0d_0Rq37b3=A@mail.gmail.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
	<877gzwyivt.fsf@ti.com>
	<20120209060939.GB1121@legolas.emea.dhcp.ti.com>
	<20120209111142.GZ1121@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62626 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab2BIMD5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 07:03:57 -0500
Received: by iacb35 with SMTP id b35so2495429iac.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 04:03:56 -0800 (PST)
In-Reply-To: <20120209111142.GZ1121@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, linus.walleij@stericsson.com, tarun.kanti@ti.com

On Thu, Feb 9, 2012 at 1:11 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi again,
>
> On Thu, Feb 09, 2012 at 08:09:40AM +0200, Felipe Balbi wrote:
>> On Wed, Feb 08, 2012 at 04:01:42PM -0800, Kevin Hilman wrote:
>> > Felipe Balbi <balbi@ti.com> writes:
>> >
>> > > try to keep gpio block suspended as much as possible.
>> > >
>> > > Tested with pandaboard and a sysfs exported gpio.
>> > >
>> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > > ---
>> >
>> > Looks like you need a few more get/puts around other places where
>> > registers are accessed. =C2=A0It currently causes a boot crash on =
OMAP3 in
>> > _set_gpio_triggering().
>>
>> it was a missing get/put on gpio_irq_set_type(). Fixed.
>>
>> > Did you test GPIO wakeups? =C2=A0both IO ring wakeups and GPIO mod=
ule-level
>> > wakeups?
>>
>> how can I test that easily with panda ?
>
> Ok, I have added gpio-keys to panda's boardfile:
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index 30ad40d..0a38282 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -23,6 +23,7 @@
> =C2=A0#include <linux/io.h>
> =C2=A0#include <linux/leds.h>
> =C2=A0#include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
> =C2=A0#include <linux/usb/otg.h>
> =C2=A0#include <linux/i2c/twl.h>
> =C2=A0#include <linux/regulator/machine.h>
> @@ -90,7 +91,30 @@ static struct platform_device leds_gpio =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> +static struct gpio_keys_button gpio_buttons[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .code =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D BTN_EXTRA,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 121,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .desc =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "user",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wakeup =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 1,

While at it, could you also test GPIO module wakeups with debounce
feature enabled? Kevin says it should work but it doesn't for me. Just
add:
    .debounce_interval =3D 10,


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
