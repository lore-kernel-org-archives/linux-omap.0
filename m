From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Sat, 27 Sep 2008 16:45:20 -0700
Message-ID: <200809271645.20782.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <20080927222900.GC8468@frodo> <20080927230902.GD8468@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:46624 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753611AbYI0Xqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Sep 2008 19:46:37 -0400
In-Reply-To: <20080927230902.GD8468@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>

On Saturday 27 September 2008, Felipe Balbi wrote:
> We need something like the patch below (I can't find a substitute
> to twl4030_set_gpio_edge_ctrl and twl4030_set_gpio_debounce):

Something like that, yes.  I have other patches queued up though.

And meanwhile, your build seems goofed ... fix that first.

=46or the moment I'm waiting until HSMMC works again in the OMAP
tree before I submit patches for any of those issues ... and
some of them imply updates from upstream.  Like these two:

  http://marc.info/?l=3Dlinux-kernel&m=3D122239480403730&w=3D2
  http://marc.info/?l=3Dlinux-kernel&m=3D122239472903349&w=3D2

=46or the "edge control" thing, I have a patch pushing that into
the standard IRQF_TRIGGER_{RISING,FALLING} and set_irq_type()
calls ... there was never a need for a twl-specific call here.

=46or debouncing, see this LKML RFC:

  http://marc.info/?l=3Dlinux-kernel&m=3D122228602206108&w=3D2

I have a twl4030 patch using that mechanism, and that patch
covers four processor families.  (OMAP2, OMAP3, AT91, AVR32.)
The OMAP1 MPUIO lines have debouncing too, but it's ganged
(all sixteen MPUIO lines get debounced, or none do).  I know
of a few more chips with built-in debouncing... so the RFC is
IMO more "are there blocking problems doing it this way" than
"should it be done at all".

- Dave



> =3D=3D=3D=3D patch 1 (desired) =3D=3D=3D=3D
>=20
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.=
c
> index 32b517b..3ca43aa 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -16,6 +16,7 @@
> =A0#include <linux/interrupt.h>
> =A0#include <linux/delay.h>
> =A0#include <linux/i2c/twl4030.h>
> +#include <linux/gpio.h>
> =A0#include <mach/hardware.h>
> =A0#include <mach/mmc.h>
> =A0#include <mach/board.h>
> @@ -48,7 +49,7 @@
> =A0
> =A0static int hsmmc_card_detect(int irq)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0return twl4030_get_gpio_datain(irq - TWL4030_GP=
IO_IRQ_BASE);
> +=A0=A0=A0=A0=A0=A0=A0return gpio_get_value(irq - TWL4030_GPIO_IRQ_BA=
SE);

That's a non-portable version of irq_to_gpio() ... and one
which should use gpio_get_value_cansleep().  My patches use
a simpler scheme, which among other things lets other GPIOs
be used for card detect.

(I understand that not all OMAP3 customers want to use twl4030
for their power management ... and in any case, having this kind
of needless dependency between drivers is a Bad Thing.)


> =A0}
> =A0
> =A0/*
> @@ -61,7 +62,7 @@ static int hsmmc_late_init(struct device *dev)
> =A0=A0=A0=A0=A0=A0=A0=A0/*
> =A0=A0=A0=A0=A0=A0=A0=A0 * Configure TWL4030 GPIO parameters for MMC =
hotplug irq
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> -=A0=A0=A0=A0=A0=A0=A0ret =3D twl4030_request_gpio(MMC1_CD_IRQ);
> +=A0=A0=A0=A0=A0=A0=A0ret =3D gpio_request(MMC1_CD_IRQ, "mmc_card_det=
ect");

Another inappropriate dependency, removed in my patches.

Note also that the TWL call currently does stuff gpio_request()
can't ... so this would be incorrect right now.  (It's the right
direction obviously, but fixing that needs my other patches.)

> =A0=A0=A0=A0=A0=A0=A0=A0if (ret)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err;
> =A0
> @@ -88,11 +89,7 @@ err:
> =A0
> =A0static void hsmmc_cleanup(struct device *dev)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0int ret =3D 0;
> -
> -=A0=A0=A0=A0=A0=A0=A0ret =3D twl4030_free_gpio(MMC1_CD_IRQ);
> -=A0=A0=A0=A0=A0=A0=A0if (ret)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_err(dev, "Failed to=
 configure TWL4030 GPIO IRQ\n");
> +=A0=A0=A0=A0=A0=A0=A0gpio_free(MMC1_CD_IRQ);

(That's the same inappropriate dependency.)


> =A0}
> =A0
> =A0#ifdef CONFIG_PM
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
