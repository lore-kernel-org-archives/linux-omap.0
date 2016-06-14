From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
Date: Tue, 14 Jun 2016 18:10:56 +0300
Message-ID: <57601E80.1060003@ti.com>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <575FE7F0.6090200@ti.com> <20160614120152.GW26768@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160614120152.GW26768@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On 06/14/2016 03:01 PM, Uwe Kleine-K=F6nig wrote:
> Hello Grygorii,
>=20
> On Tue, Jun 14, 2016 at 02:18:08PM +0300, Grygorii Strashko wrote:
>> On 06/14/2016 01:03 PM, Uwe Kleine-K=F6nig wrote:
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index b98ede78c9d8..6814245a54aa 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -1034,6 +1034,7 @@ static int omap_gpio_chip_init(struct gpio_ba=
nk *bank, struct irq_chip *irqc)
>>>    	static int gpio;
>>>    	int irq_base =3D 0;
>>>    	int ret;
>>> +	int gpio_alias_id;
>>>   =20
>>>    	/*
>>>    	 * REVISIT eventually switch from OMAP-specific gpio structs
>>> @@ -1056,6 +1057,17 @@ static int omap_gpio_chip_init(struct gpio_b=
ank *bank, struct irq_chip *irqc)
>>>    		bank->chip.label =3D "gpio";
>>>    		bank->chip.base =3D gpio;
>>
>> I think, the gpio base correction should be done here
>=20
> What is the upside of doing it here? It has the downside that it need=
s
> one more indention level. The only difference I see is that it doesn'=
t
> apply for mpuio devices then and wonder if that is relevant.

Personally, I prefer not ti touch mpuio code unless really required.

>  =20
>>>    	}
>>> +
>>> +	/*
>>> +	 * Traditionally the base is given out in first-come-first-serve =
order.
>>> +	 * This might shuffle the numbering of gpios if the probe order c=
hanges.
>>> +	 * So make the base deterministical if the device tree specifies =
alias
>>> +	 * ids.
>>> +	 */
>>> +	gpio_alias_id =3D of_alias_get_id(bank->chip.of_node, "gpio");
>>> +	if (gpio_alias_id >=3D 0)
>>> +		bank->chip.base =3D bank->width * gpio_alias_id;
>>> +
>>
>> Unfortunately, this driver is still used by non-DT platforms, so abo=
ve code will
>>   break build if !OF && !OF_GPIO
>=20
> Without CONFIG_OF of_alias_get_id still exists and returns -ENOSYS wh=
ich
> should make the added code a nop. Does your compiler agree with you t=
hat
> my patch breaks building the driver?

make ARCH=3Darm omap1_defconfig
make ARCH=3Darm ./drivers/gpio/gpio-omap.o


drivers/gpio/gpio-omap.c: In function 'omap_gpio_chip_init':
drivers/gpio/gpio-omap.c:1066:44: error: 'struct gpio_chip' has no memb=
er named 'of_node'
  gpio_alias_id =3D of_alias_get_id(bank->chip.of_node, "gpio");
                                            ^
make[1]: *** [drivers/gpio/gpio-omap.o] Error 1
make: *** [drivers/gpio/gpio-omap.o] Error 2


--=20
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
