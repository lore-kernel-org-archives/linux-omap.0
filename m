From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v7 01/11] OMAP: GPIO: prepare for platform driver
Date: Fri, 26 Nov 2010 10:33:33 +0530
Message-ID: <AANLkTi=9RpAw4gi92M_7JLkS+VHPUp_YPdwRRin0u8Jx@mail.gmail.com>
References: <1290524213-395-1-git-send-email-charu@ti.com> <1290524213-395-2-git-send-email-charu@ti.com>
 <20101126043829.GB6598@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48709 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750751Ab0KZFEO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Nov 2010 00:04:14 -0500
Received: by mail-iw0-f182.google.com with SMTP id 39so1903280iwn.13
        for <linux-omap@vger.kernel.org>; Thu, 25 Nov 2010 21:04:14 -0800 (PST)
In-Reply-To: <20101126043829.GB6598@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com, tony@atomide.com

Olof Johansson,

On Fri, Nov 26, 2010 at 10:08, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Tue, Nov 23, 2010 at 08:26:43PM +0530, Varadarajan, Charulatha wro=
te:
>> +static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
>> +{
>> + =A0 =A0 if (cpu_class_is_omap2()) {
>
> Why check class when you're checking for all possible variants anyway=
?

This is only a movement of code as I mentioned in the patch description
and I am not trying to modify anything newly. All these would be remove=
d while
doing GPIO driver cleanup (please see below).

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, b=
ank->base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP4_GPIO_IRQSTATUSCLR0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0x00000000, b=
ank->base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0OMAP4_GPIO_DEBOUNCENABLE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Initialize interface cl=
k ungated, module enabled */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, bank->base=
 + OMAP4_GPIO_CTRL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (cpu_is_omap34xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0x00000000, b=
ank->base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP24XX_GPIO_IRQENABLE1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, b=
ank->base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP24XX_GPIO_IRQSTATUS1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0x00000000, b=
ank->base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP24XX_GPIO_DEBOUNCE_EN);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Initialize interface cl=
k ungated, module enabled */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, bank->base=
 + OMAP24XX_GPIO_CTRL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (cpu_is_omap24xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 static const u32 non_wakeu=
p_gpios[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xe203ffc0=
, 0x08700040
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (id < ARRAY_SIZE(non_wa=
keup_gpios))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->non_=
wakeup_gpios =3D non_wakeup_gpios[id];
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else if (cpu_class_is_omap1()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bank_is_mpuio(bank))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writew(0xffff, bank-=
>base
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP_MPUIO_GPIO_MASKIT);
>
> Above is using else if, this is using if. I don't see how you can eve=
r
> hit more than one of these anyway.
>
> Besides, why check for both cpu and method? When do they ever
> diverge? (same goes for other places)
>
> The plat-omap/gpio.c driver is pretty hard to read because of all the
> ifdeffing and tests for platforms. It would make sense to abstract ou=
t
> some of the operations into separate functions and use function point=
ers
> for them, IMHO. (Not an issue for this patch, just a reflection).

Yes. I also wondered why to have cpu_is checks, methods and #ifdefs and
it is quite confusing too.

This patch series is intended only for platform driver implementation o=
f hwmod
and mainly using hwmod for OMAP2+. If I include cleaning up of GPIO dri=
ver
also in this patch series, it would become too huge. This was discussed=
 long ago
and it was agreed to have GPIO driver cleanup as a separate series.
Hence this is
mentioned in the TODOs (please see patch 10 description for the list of=
 TODOs as
that is main patch where the actual platform driver implementation is
being done for
GPIO)

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
