From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH V2 2/2] power: twl4030_charger: attempt to power off in
 case of critical events
Date: Wed, 4 Jun 2014 13:04:06 +0300
Message-ID: <CANOLnOPb1xbqb5WXaK5-kdCezVuDhNxTtE5VV_MbCi4WTd2=oA@mail.gmail.com>
References: <1401313610-14252-1-git-send-email-nm@ti.com>
	<1401313610-14252-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401313610-14252-3-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: dbaryshkov@gmail.com, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, dwmw2@infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 29, 2014 at 12:46 AM, Nishanth Menon <nm@ti.com> wrote:
> Attempt to power off in case of critical events such as battery remov=
al,
> over voltage events.
>
> There is no guarentee that we'd be in a safe scenario here, but the v=
ery
> least we can try to do is to power off the device to prevent damage t=
o
> the system instead of just printing a message and hoping for the best=
=2E

At least "battery temperature out of range" does seem to happen quite
often while charging on hot summer day. I'd prefer my pandora to not
shutdown in such case, it could just stop charging instead.

>
> NOTE: twl4030 should attempt some form of recovery, but just dependin=
g
> on that is never a safe alternative.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> new patch. original attempt was: https://patchwork.kernel.org/patch/4=
002371/
>
> NOTE: we dont have poweroff support yet enabled on LDP, but it just n=
eeds
> relevant dts entry.
>
>  drivers/power/twl4030_charger.c |   26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_=
charger.c
> index 2598c58..ed0dbd2 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -22,6 +22,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/notifier.h>
>  #include <linux/usb/otg.h>
> +#include <linux/reboot.h>
>  #include <linux/regulator/machine.h>
>
>  #define TWL4030_BCIMSTATEC     0x02
> @@ -332,6 +333,7 @@ static irqreturn_t twl4030_bci_interrupt(int irq,=
 void *arg)
>         struct twl4030_bci *bci =3D arg;
>         u8 irqs1, irqs2;
>         int ret;
> +       bool power_off =3D false;
>
>         ret =3D twl_i2c_read_u8(TWL4030_MODULE_INTERRUPTS, &irqs1,
>                               TWL4030_INTERRUPTS_BCIISR1A);
> @@ -352,20 +354,34 @@ static irqreturn_t twl4030_bci_interrupt(int ir=
q, void *arg)
>         }
>
>         /* various monitoring events, for now we just log them here *=
/
> -       if (irqs1 & (TWL4030_TBATOR2 | TWL4030_TBATOR1))
> +       if (irqs1 & (TWL4030_TBATOR2 | TWL4030_TBATOR1)) {
>                 dev_warn(bci->dev, "battery temperature out of range\=
n");
> +               power_off =3D true;
> +       }
>
> -       if (irqs1 & TWL4030_BATSTS)
> +       if (irqs1 & TWL4030_BATSTS) {
>                 dev_crit(bci->dev, "battery disconnected\n");
> +               power_off =3D true;
> +       }
>
> -       if (irqs2 & TWL4030_VBATOV)
> +       if (irqs2 & TWL4030_VBATOV) {
>                 dev_crit(bci->dev, "VBAT overvoltage\n");
> +               power_off =3D true;
> +       }
>
> -       if (irqs2 & TWL4030_VBUSOV)
> +       if (irqs2 & TWL4030_VBUSOV) {
>                 dev_crit(bci->dev, "VBUS overvoltage\n");
> +               power_off =3D true;
> +       }
>
> -       if (irqs2 & TWL4030_ACCHGOV)
> +       if (irqs2 & TWL4030_ACCHGOV) {
>                 dev_crit(bci->dev, "Ac charger overvoltage\n");
> +               power_off =3D true;
> +       }
> +
> +       /* Try to shutdown the system */
> +       if (power_off)
> +               orderly_poweroff(true);
>
>         return IRQ_HANDLED;
>  }
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--=20
Gra=C5=BEvydas
