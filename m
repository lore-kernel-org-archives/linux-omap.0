From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: RT and omap-gpio irqchip with DeviceTree
Date: Tue, 2 Jul 2013 14:15:46 +0200
Message-ID: <CAAwP0s2KUCowe5scWJtiZ8hZb-5EMbmef_WO_03cY3H7DqxSOQ@mail.gmail.com>
References: <20130702114452.GA13763@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:61554 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab3GBMQG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 08:16:06 -0400
In-Reply-To: <20130702114452.GA13763@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Torben Hohn <torbenh@linutronix.de>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: tglx@linutronix.de, bigeasy@linutronix.de, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org

+ Grant, Linus W and Jean-Christophe.

On Tue, Jul 2, 2013 at 1:44 PM, Torben Hohn <torbenh@linutronix.de> wro=
te:
>
> Hi..
>
> I am running into Problems with a network adapter IRQ connected to an
> omap-gpio pin.
>
> omap-gpio expects gpio-request() to be called before i can use the pi=
n.
> But this is abstracted via the DeviceTree bindings.
>
> I see 8d4c277e185c31359cf70573d8b0351fb7dd0dfe in mainline.
> This one just puts a warning into the exact place, i am dealing with.
> But i need to make this work, instead of bailing out.
>

This has been discussed extensively on the linux-omap mailing list and
the agreement is that it has to be handled by the IRQ core. So when a
GPIO line is mapped in the IRQ domain with irq_create_of_mapping(),
the core has to take care to request the GPIO and configure it as
input.

 But until we have this general solution we have to do it on a per irq
chip driver basis and the less hack-ish solution is to have a custom
=2Emap function handler that request the GPIO used as IRQ.

There is already a patch [1] queued in Linus Walleij linux-gpio tree
[2] for-next branch that implements this for OMAP GPIO. It would be
great if you can test it and give feedback.

> I have this fix in place, instead:
> ---------------------------------------------------------------------=
------------------
> commit 4ca17be8e7e24863cb98f440992fd89034aa34f5
> Author: Torben Hohn <torbenh@linutronix.de>
> Date:   Fri Jun 21 17:34:24 2013 +0200
>
>     gpio omap: Fix for DT calling into gpio_irq_type without request_=
gpio()
>
>     gpio_irq_type() requires that the GPIO is requested, do that.
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index f1fbedb2..57d956c 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -87,6 +87,8 @@ struct gpio_bank {
>  #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
>  #define GPIO_MOD_CTRL_BIT      BIT(0)
>
> +static int omap_gpio_request(struct gpio_chip *chip, unsigned offset=
);
> +
>  static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq=
)
>  {
>         return gpio_irq - bank->irq_base + bank->chip.base;
> @@ -429,6 +431,9 @@ static int gpio_irq_type(struct irq_data *d, unsi=
gned type)
>         if (!gpio)
>                 gpio =3D irq_to_gpio(bank, d->irq);
>
> +       if (!bank->mod_usage)
> +               omap_gpio_request( &bank->chip, gpio );
> +
>         if (type & ~IRQ_TYPE_SENSE_MASK)
>                 return -EINVAL;
>
>
> ---------------------------------------------------------------------=
--------------------
>
>
> But now with RT i am running into a Problem, because gpio_irq_type() =
is called
> under a raw_spinlock() But its calling pm_runtime_suspend() which car=
ries a normal spinlock.
>
>
> ---------------------------------------------------------------------=
--------------------
> /**
>  *      irq_set_type - set the irq trigger type for an irq
>  *      @irq:   irq number
>  *      @type:  IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq=
=2Eh
>  */
> int irq_set_irq_type(unsigned int irq, unsigned int type)
> {
>         unsigned long flags;
>         struct irq_desc *desc =3D irq_get_desc_buslock(irq, &flags, I=
RQ_GET_DESC_CHECK_GLOBAL);
>         int ret =3D 0;
>
>         if (!desc)
>                 return -EINVAL;
>
>         type &=3D IRQ_TYPE_SENSE_MASK;
>         ret =3D __irq_set_trigger(desc, irq, type);
>         irq_put_desc_busunlock(desc, flags);
>         return ret;
> }
> ---------------------------------------------------------------------=
--------------------
>
> I think, i need a normal hook in the irq_chip, which "prepares" the i=
rq, but i dont see one.
>
>
> --
> Mit freundlichen Gr=C3=BC=C3=9Fen
> Torben Hohn
>
> Linutronix GmbH
>
> Standort: Bremen
>
> Phone: +49 421 5650 2310 ; Fax.: +49 7556 919 886
> mailto: torbenh@linutronix.de
> Firmensitz / Registered Office: D-88690 Uhldingen, Auf dem Berg 3
> Registergericht / Local District Court: Freiburg i. Br., HRB Nr. / Tr=
ade
> register no.: 700 806;
>
> Gesch=C3=A4ftsf=C3=BChrer / Managing Directors: Heinz Egger, Thomas G=
leixner

Thanks a lot and best regards,
Javier

[1]: https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git=
/commit/?h=3Dfor-next&id=3D570c4bb53366157fa076922d0fc7e7adfd81cf42
[2]: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.gi=
t
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
