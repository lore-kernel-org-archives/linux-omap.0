From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Wed, 20 Jan 2016 19:29:47 +0200
Message-ID: <569FC40B.5030902@ti.com>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 01/20/2016 02:29 PM, Lothar Wa=C3=9Fmann wrote:
> On the AM335x SoC rev. <=3D 1.0 the "Input Function of the EXTINTn
> Terminal is Inverted", for which the only remedy is to "Use an active
> high interrupt source or use an external inverter to change the
> polarity of any active low interrupt source."
>=20
> This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
> electronics TX48 module. Make the IRQ optional in the driver and use =
a
> polling routine instead if no IRQ is specified in DT.
> Otherwise the driver will continuously generate interrupts and make
> the system unusable.
>=20
> Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> ---
>   drivers/regulator/ltc3589.c | 49 ++++++++++++++++++++++++++++++++++=
+++++++----
>   1 file changed, 45 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.=
c

[...]

>   }
> @@ -519,6 +539,16 @@ static int ltc3589_probe(struct i2c_client *clie=
nt,
>   			return ret;
>   		}
>   	}
> +	if (client->irq <=3D 0) {
> +		dev_warn(dev,
> +			"No interrupt configured; poll for thermal shutdown and undervolt=
age events\n");
> +
> +		INIT_DELAYED_WORK(&ltc3589->poll_timer, ltc3589_poll_func);
> +		schedule_delayed_work(&ltc3589->poll_timer,
> +				msecs_to_jiffies(POLL_PERIOD));
> +
> +		return 0;
> +	}
>  =20
>   	ret =3D devm_request_threaded_irq(dev, client->irq, NULL, ltc3589_=
isr,
>   					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
					^^^^^^^^^^^^^^^^

I assume you have issue with IRQ because of the above hard-coded flag.
if yes - Over all approach for such kind of issues - do not hard-code I=
RQ triggering=20
flags in code in case of DT boot. DT core will configure it properly.



[...]

--=20
regards,
-grygorii
