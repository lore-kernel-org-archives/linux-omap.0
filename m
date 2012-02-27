From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: OMAP gpio handling
Date: Mon, 27 Feb 2012 12:41:17 +0530
Message-ID: <CAC83ZvL7w5tL7q1zqaPWk3df2XXVGEpm+_TH5_OFD4pNDxXpZQ@mail.gmail.com>
References: <20120225130444.GJ22675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46677 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838Ab2B0HLS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 02:11:18 -0500
Received: by mail-qw0-f53.google.com with SMTP id c11so227321qad.5
        for <linux-omap@vger.kernel.org>; Sun, 26 Feb 2012 23:11:17 -0800 (PST)
In-Reply-To: <20120225130444.GJ22675@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

On Sat, Feb 25, 2012 at 6:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Can someone explain to me this:
>
> #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
> #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
>
> static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
> {
> =A0 =A0 =A0 =A0void __iomem *reg =3D bank->base + bank->regs->datain;
>
> =A0 =A0 =A0 =A0return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) !=3D =
0;
> }
>
> static int gpio_get(struct gpio_chip *chip, unsigned offset)
> {
> =A0 =A0 =A0 =A0struct gpio_bank *bank =3D container_of(chip, struct g=
pio_bank, chip);
> =A0 =A0 =A0 =A0void __iomem *reg =3D bank->base;
> =A0 =A0 =A0 =A0int gpio =3D chip->base + offset;
> =A0 =A0 =A0 =A0u32 mask =3D GPIO_BIT(bank, gpio);
>
> =A0 =A0 =A0 =A0if (gpio_is_input(bank, mask))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return _get_gpio_datain(bank, gpio);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return _get_gpio_dataout(bank, gpio);
> }
>
> Given that bank->width on OMAP is either 32 or 16, and GPIO numbers f=
or
> any GPIO chip are always aligned to 32 or 16, why does this code both=
er
> adding the chips base gpio number and then modulo the width?
As far as I understand we could very well use offset directly.
The macro is used to derive the same offset value in this case.
Therefore, _get_gpio_datain(bank, gpio) and _get_gpio_dataout(bank, gpi=
o)
can be passed offset instead of (bank->base + offset) as suggested by y=
ou below.
And of course, offset can be used to derive mask both here and in the
called functions.

>
> Surely this means if - for argument sake - you registered a GPIO chip
> with 8 lines followed by one with 16 lines, GPIO0..7 would be chip 0
> bit 0..7, GPIO8..15 would be chip 1 bit 8..15, GPIO16..23 would be
> chip 1 bit 0..7.
>
> However, if you registered a GPIO chip with 16 lines first, it would
> mean GPIO0..15 would be chip 0 bit 0..15, and GPIO16..31 would be
> chip 1 bit 0..15.
>
> Surely this kind of behaviour is not intended?
>
> Is there a reason why the bitmask can't just be (1 << offset) where
> offset is passed into these functions as GPIO number - chip->base ?
Yes, I have made the following changes and tested on OMAP4 and OMAP1(bo=
otup).

[PATCH] gpio/omap: remove redundant decoding of gpio offset
---
 drivers/gpio/gpio-omap.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 5953ece..2196747 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -133,18 +133,18 @@ static void _set_gpio_dataout_mask(struct
gpio_bank *bank, int gpio, int enable)
        bank->context.dataout =3D l;
 }

-static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
+static int _get_gpio_datain(struct gpio_bank *bank, int offset)
 {
        void __iomem *reg =3D bank->base + bank->regs->datain;

-       return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) !=3D 0;
+       return (__raw_readl(reg) & (1 << offset)) !=3D 0;
 }

-static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
+static int _get_gpio_dataout(struct gpio_bank *bank, int offset)
 {
        void __iomem *reg =3D bank->base + bank->regs->dataout;

-       return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) !=3D 0;
+       return (__raw_readl(reg) & (1 << offset)) !=3D 0;
 }

 static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bo=
ol set)
@@ -849,19 +849,15 @@ static int gpio_is_input(struct gpio_bank *bank, =
int mask)
 static int gpio_get(struct gpio_chip *chip, unsigned offset)
 {
        struct gpio_bank *bank;
-       void __iomem *reg;
-       int gpio;
        u32 mask;

-       gpio =3D chip->base + offset;
        bank =3D container_of(chip, struct gpio_bank, chip);
-       reg =3D bank->base;
-       mask =3D GPIO_BIT(bank, gpio);
+       mask =3D (1 << offset);

        if (gpio_is_input(bank, mask))
-               return _get_gpio_datain(bank, gpio);
+               return _get_gpio_datain(bank, offset);
        else
-               return _get_gpio_dataout(bank, gpio);
+               return _get_gpio_dataout(bank, offset);
 }

 static int gpio_output(struct gpio_chip *chip, unsigned offset, int va=
lue)
--
1.7.0.4

--
Tarun

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
