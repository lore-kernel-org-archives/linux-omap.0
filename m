From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap: be more aggressive with pm_runtime
Date: Wed, 8 Feb 2012 15:53:30 +0200
Message-ID: <20120208135329.GJ16334@legolas.emea.dhcp.ti.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1640189532302472782=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1328707614-20146-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linus.walleij@stericsson.com, Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, tarun.kanti@ti.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============1640189532302472782==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Content-Disposition: inline


--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 08, 2012 at 03:26:54PM +0200, Felipe Balbi wrote:
> try to keep gpio block suspended as much as possible.
>=20
> Tested with pandaboard and a sysfs exported gpio.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>=20
> I couldn't see any issues with this patch. I managed to export
> a gpio and change the direction with a while true loop with
> no issues whatsoever.

btw, I also played with gpios 7 and 8 because they have LEDs on them on
pandaboard and everything seems to be fine.

I just want to be sure I can still go to OFF mode and wakeup, but on
vanilla 3.3-rc2 after echo mem > /sys/power/state the systems freezes on
panda, so I can't go any further.

> Any chance someone tells me how to reproduce the original
> wakeup problem we had ?
>=20
> I wrote a simple script to dump gpio states while I had:
>=20
> while true; do echo in > /sys/class/gpio/gpio2/direction; \
> 	echo out > /sys/class/gpio/gpio2/direction; done &
>=20
> running. Here's the ouput:
>=20
> ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status suspended
> runtime_active_time 11945
> runtime_suspended_time 1214578
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1226468
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1226562
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1226578
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1226593
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status suspended
> runtime_active_time 12234
> runtime_suspended_time 1215257
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1227437
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1227531
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1227546
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1227562
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status suspended
> runtime_active_time 12460
> runtime_suspended_time 1215882
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1228289
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1228382
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1228398
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1228414
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status suspended
> runtime_active_time 12734
> runtime_suspended_time 1216453
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1229132
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1229226
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1229242
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1229257
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status active
> runtime_active_time 13007
> runtime_suspended_time 1216960
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1229914
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1230007
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1230023
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1230039
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status suspended
> runtime_active_time 13234
> runtime_suspended_time 1217492
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1230671
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1230765
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1230781
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1230796
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status suspended
> runtime_active_time 13453
> runtime_suspended_time 1218023
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1231421
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1231515
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1231531
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1231546
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status suspended
> runtime_active_time 13703
> runtime_suspended_time 1218539
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1232187
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1232281
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1232296
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1232312
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status active
> runtime_active_time 13890
> runtime_suspended_time 1219125
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1232960
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1233054
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1233070
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1233085
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status suspended
> runtime_active_time 14109
> runtime_suspended_time 1219601
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1233656
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1233750
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1233765
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1233781
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status suspended
> runtime_active_time 14367
> runtime_suspended_time 1220109
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1234421
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1234515
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1234531
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1234546
>=20
> root@legolas:~# ./show_gpios.sh=20
> omap_gpio.0
> control auto
> runtime_status suspended
> runtime_active_time 14531
> runtime_suspended_time 1220648
>=20
> omap_gpio.1
> control auto
> runtime_status suspended
> runtime_active_time 78
> runtime_suspended_time 1235125
>=20
> omap_gpio.2
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1235218
>=20
> omap_gpio.3
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1235234
>=20
> omap_gpio.4
> control auto
> runtime_status suspended
> runtime_active_time 0
> runtime_suspended_time 1235250
>=20
> see that the active time changes for omap_gpio.0 (first gpio bank)
> because I'm constantly changing direction of the exported gpio2, but
> the other banks are kept in suspend state. I even managed to catch
> the gpio bank while it was still in active state. Before suspending
> again.
>=20
>  drivers/gpio/gpio-omap.c |   61 +++++++++++++++++++++++++++++++++-------=
------
>  1 files changed, 44 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 4273401..2dd9ced 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -537,12 +537,7 @@ static int omap_gpio_request(struct gpio_chip *chip,=
 unsigned offset)
>  	struct gpio_bank *bank =3D container_of(chip, struct gpio_bank, chip);
>  	unsigned long flags;
> =20
> -	/*
> -	 * If this is the first gpio_request for the bank,
> -	 * enable the bank module.
> -	 */
> -	if (!bank->mod_usage)
> -		pm_runtime_get_sync(bank->dev);
> +	pm_runtime_get_sync(bank->dev);
> =20
>  	spin_lock_irqsave(&bank->lock, flags);
>  	/* Set trigger to none. You need to enable the desired trigger with
> @@ -572,6 +567,8 @@ static int omap_gpio_request(struct gpio_chip *chip, =
unsigned offset)
> =20
>  	spin_unlock_irqrestore(&bank->lock, flags);
> =20
> +	pm_runtime_put(bank->dev);
> +
>  	return 0;
>  }
> =20
> @@ -581,6 +578,8 @@ static void omap_gpio_free(struct gpio_chip *chip, un=
signed offset)
>  	void __iomem *base =3D bank->base;
>  	unsigned long flags;
> =20
> +	pm_runtime_get_sync(bank->dev);
> +
>  	spin_lock_irqsave(&bank->lock, flags);
> =20
>  	if (bank->regs->wkup_en) {
> @@ -606,12 +605,7 @@ static void omap_gpio_free(struct gpio_chip *chip, u=
nsigned offset)
>  	_reset_gpio(bank, bank->chip.base + offset);
>  	spin_unlock_irqrestore(&bank->lock, flags);
> =20
> -	/*
> -	 * If this is the last gpio to be freed in the bank,
> -	 * disable the bank module.
> -	 */
> -	if (!bank->mod_usage)
> -		pm_runtime_put(bank->dev);
> +	pm_runtime_put(bank->dev);
>  }
> =20
>  /*
> @@ -707,9 +701,11 @@ static void gpio_irq_shutdown(struct irq_data *d)
>  	struct gpio_bank *bank =3D irq_data_get_irq_chip_data(d);
>  	unsigned long flags;
> =20
> +	pm_runtime_get_sync(bank->dev);
>  	spin_lock_irqsave(&bank->lock, flags);
>  	_reset_gpio(bank, gpio);
>  	spin_unlock_irqrestore(&bank->lock, flags);
> +	pm_runtime_put(bank->dev);
>  }
> =20
>  static void gpio_ack_irq(struct irq_data *d)
> @@ -717,7 +713,9 @@ static void gpio_ack_irq(struct irq_data *d)
>  	unsigned int gpio =3D d->irq - IH_GPIO_BASE;
>  	struct gpio_bank *bank =3D irq_data_get_irq_chip_data(d);
> =20
> +	pm_runtime_get_sync(bank->dev);
>  	_clear_gpio_irqstatus(bank, gpio);
> +	pm_runtime_put(bank->dev);
>  }
> =20
>  static void gpio_mask_irq(struct irq_data *d)
> @@ -726,10 +724,12 @@ static void gpio_mask_irq(struct irq_data *d)
>  	struct gpio_bank *bank =3D irq_data_get_irq_chip_data(d);
>  	unsigned long flags;
> =20
> +	pm_runtime_get_sync(bank->dev);
>  	spin_lock_irqsave(&bank->lock, flags);
>  	_set_gpio_irqenable(bank, gpio, 0);
>  	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
>  	spin_unlock_irqrestore(&bank->lock, flags);
> +	pm_runtime_put(bank->dev);
>  }
> =20
>  static void gpio_unmask_irq(struct irq_data *d)
> @@ -740,6 +740,7 @@ static void gpio_unmask_irq(struct irq_data *d)
>  	u32 trigger =3D irqd_get_trigger_type(d);
>  	unsigned long flags;
> =20
> +	pm_runtime_get_sync(bank->dev);
>  	spin_lock_irqsave(&bank->lock, flags);
>  	if (trigger)
>  		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
> @@ -753,6 +754,7 @@ static void gpio_unmask_irq(struct irq_data *d)
> =20
>  	_set_gpio_irqenable(bank, gpio, 1);
>  	spin_unlock_irqrestore(&bank->lock, flags);
> +	pm_runtime_put(bank->dev);
>  }
> =20
>  static struct irq_chip gpio_irq_chip =3D {
> @@ -836,17 +838,26 @@ static int gpio_input(struct gpio_chip *chip, unsig=
ned offset)
>  	unsigned long flags;
> =20
>  	bank =3D container_of(chip, struct gpio_bank, chip);
> +	pm_runtime_get_sync(bank->dev);
> +
>  	spin_lock_irqsave(&bank->lock, flags);
>  	_set_gpio_direction(bank, offset, 1);
>  	spin_unlock_irqrestore(&bank->lock, flags);
> +	pm_runtime_put(bank->dev);
> +
>  	return 0;
>  }
> =20
>  static int gpio_is_input(struct gpio_bank *bank, int mask)
>  {
>  	void __iomem *reg =3D bank->base + bank->regs->direction;
> +	u32 val;
> =20
> -	return __raw_readl(reg) & mask;
> +	pm_runtime_get_sync(bank->dev);
> +	val =3D __raw_readl(reg) & mask;
> +	pm_runtime_put(bank->dev);
> +
> +	return val;
>  }
> =20
>  static int gpio_get(struct gpio_chip *chip, unsigned offset)
> @@ -856,15 +867,20 @@ static int gpio_get(struct gpio_chip *chip, unsigne=
d offset)
>  	int gpio;
>  	u32 mask;
> =20
> +	int val;
>  	gpio =3D chip->base + offset;
>  	bank =3D container_of(chip, struct gpio_bank, chip);
>  	reg =3D bank->base;
>  	mask =3D GPIO_BIT(bank, gpio);
> =20
> +	pm_runtime_get_sync(bank->dev);
>  	if (gpio_is_input(bank, mask))
> -		return _get_gpio_datain(bank, gpio);
> +		val =3D _get_gpio_datain(bank, gpio);
>  	else
> -		return _get_gpio_dataout(bank, gpio);
> +		val =3D _get_gpio_dataout(bank, gpio);
> +	pm_runtime_put(bank->dev);
> +
> +	return val;
>  }
> =20
>  static int gpio_output(struct gpio_chip *chip, unsigned offset, int valu=
e)
> @@ -873,10 +889,14 @@ static int gpio_output(struct gpio_chip *chip, unsi=
gned offset, int value)
>  	unsigned long flags;
> =20
>  	bank =3D container_of(chip, struct gpio_bank, chip);
> +
> +	pm_runtime_get_sync(bank->dev);
>  	spin_lock_irqsave(&bank->lock, flags);
>  	bank->set_dataout(bank, offset, value);
>  	_set_gpio_direction(bank, offset, 0);
>  	spin_unlock_irqrestore(&bank->lock, flags);
> +	pm_runtime_put(bank->dev);
> +
>  	return 0;
>  }
> =20
> @@ -894,9 +914,11 @@ static int gpio_debounce(struct gpio_chip *chip, uns=
igned offset,
>  			dev_err(bank->dev, "Could not get gpio dbck\n");
>  	}
> =20
> +	pm_runtime_get_sync(bank->dev);
>  	spin_lock_irqsave(&bank->lock, flags);
>  	_set_gpio_debounce(bank, offset, debounce);
>  	spin_unlock_irqrestore(&bank->lock, flags);
> +	pm_runtime_put(bank->dev);
> =20
>  	return 0;
>  }
> @@ -907,9 +929,12 @@ static void gpio_set(struct gpio_chip *chip, unsigne=
d offset, int value)
>  	unsigned long flags;
> =20
>  	bank =3D container_of(chip, struct gpio_bank, chip);
> +
> +	pm_runtime_get_sync(bank->dev);
>  	spin_lock_irqsave(&bank->lock, flags);
>  	bank->set_dataout(bank, offset, value);
>  	spin_unlock_irqrestore(&bank->lock, flags);
> +	pm_runtime_put(bank->dev);
>  }
> =20
>  static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
> @@ -1330,7 +1355,8 @@ void omap2_gpio_prepare_for_idle(int pwr_mode)
> =20
>  		bank->power_mode =3D pwr_mode;
> =20
> -		pm_runtime_put_sync_suspend(bank->dev);
> +		if (!pm_runtime_suspended(bank->dev))
> +			pm_runtime_suspend(bank->dev);
>  	}
>  }
> =20
> @@ -1342,7 +1368,8 @@ void omap2_gpio_resume_after_idle(void)
>  		if (!bank->mod_usage || !bank->loses_context)
>  			continue;
> =20
> -		pm_runtime_get_sync(bank->dev);
> +		if (pm_runtime_suspended(bank->dev))
> +			pm_runtime_resume(bank->dev);
>  	}
>  }
> =20
> --=20
> 1.7.9
>=20

--=20
balbi

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMn5ZAAoJEIaOsuA1yqRE3MIP/3sWBN8lyuV7UzdaGj3AtF2q
UBEm1IML5GodNPk/xvdEUJLTjSAACMZgR5/W94cdO6Fun4yGanoW2v+E9RiQE5y7
ng/XMUWhmpGLkoA2m0all4yQUviE722H8QEX0lQTgVCAixQz1qF0PUqArckCl/Zs
hkRloKRBGqDmCtGOCmj6y2ap+IUNd6+Orkc5GhUnLva65ht46vu5oDK5SimOTQyx
heLoySQ7pi6uE2GJ6dBEAJYc1c4AWHf9dJ/4mBhZ0CEl9eLvc1CcseFV7fbolDVN
M1N0xfauKKX0l5xsYBPUhzkl8hpAj57q3UV/OwZkZsAjRFPIdl1ezEBSgMY3vAd8
OoJHP0Km13uMfIq1ppV3Va/uzaOWqJ6lwKE2YFZz9M1TSDrXvl2OANFWNVIPOKsX
uXV49gERNvBVgniFOtU4DOyVWZP2ZikArz2QufNSlSyKzHhrty0KOvFNEYLkrMmN
nrHb5dj00QypoKimHbsIrf4m6gJFHQZ9GlPpzOIBYfkIXIMgaimInKV3KPXKmcia
hHjZJt4GEUtfVG/6zfPdy7tC0+Epc0R4aD2gzbpV0sdNpX+T605qTWRo3QYn9y06
SwqkeqK0tpTKWsyOmXbB9mIxToUKkT+C2JBr6IV25eLk/+qqEchNlMZeWbk0cAGM
tgZ3aR9i6roJqTNvy/S8
=r42l
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--


--===============1640189532302472782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1640189532302472782==--
