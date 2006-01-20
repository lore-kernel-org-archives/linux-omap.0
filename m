From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Convert touchscreen to input_allocate_device
Date: Fri, 20 Jan 2006 15:07:29 -0800
Message-ID: <20060120230729.GD6683@atomide.com>
References: <20060118112155.GA16067@two.research.nokia.com>
	<20060118163932.15056.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060118163932.15056.qmail@web32901.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: Mikko.Soikkala@tietoenator.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060118 08:47]:
> --- Juha Yrj=F6l=E4 <juha.yrjola@nokia.com> wrote:
>=20
> >=20
> > Not quite yet. =3D) If you allocate the input device earlier, you als=
o
> > have to
> > take care in deallocating it in the error paths after it.
>=20
> Ok. Please check the attached patch. Build for OSK.=20
>=20
> Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
>=20
>=20
> ---Komal Shah
> http://komalshah.blogspot.com/
>=20
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around=20
> http://mail.yahoo.com=20
Content-Description: 1479429603-tsfix.patch
> diff --git a/drivers/input/touchscreen/corgi_ts.c b/drivers/input/touch=
screen/corgi_ts.c
> diff --git a/drivers/input/touchscreen/omap/omap_ts.c b/drivers/input/t=
ouchscreen/omap/omap_ts.c
> index 5916245..f55ea05 100644
> --- a/drivers/input/touchscreen/omap/omap_ts.c
> +++ b/drivers/input/touchscreen/omap/omap_ts.c
> @@ -133,6 +133,12 @@ static int __init omap_ts_probe(struct p
>  	int status =3D -ENODEV;
> =20
>  	memset(&ts_omap, 0, sizeof(ts_omap));
> +=09
> +	ts_omap.inputdevice =3D input_allocate_device();
> +	if (!ts_omap.inputdevice) {
> +		return -ENOMEM;
> +	}
> +
>  	spin_lock_init(&ts_omap.lock);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(ts_devs); i++) {
> @@ -145,8 +151,10 @@ static int __init omap_ts_probe(struct p
>  		}
>  	}
> =20
> -	if (status !=3D 0)
> +	if (status !=3D 0) {
> +	    	input_free_device(ts_omap.inputdevice);
>  		return status;
> +	}
> =20
>  	// Init acquisition timer function
>  	init_timer(&ts_omap.ts_timer);
> @@ -159,15 +167,18 @@ static int __init omap_ts_probe(struct p
>  			printk(KERN_ERR
>  	  "omap_ts.c: Could not allocate touchscreen IRQ!\n");
>  			ts_omap.irq =3D -1;
> +			ts_omap.dev->remove();
> +			input_free_device(ts_omap.inputdevice);
>  			return -EINVAL;
>  		}
>  		ts_omap.irq_enabled =3D 1;
>  	} else {
>  		printk(KERN_ERR "omap_ts.c: No touchscreen IRQ assigned!\n");
> +		ts_omap.dev->remove();
> +		input_free_device(ts_omap.inputdevice);
>  		return -EINVAL;
>  	}
> =20
> -	ts_omap.inputdevice =3D input_allocate_device();
>  	ts_omap.inputdevice->name =3D OMAP_TS_NAME;
>  	ts_omap.inputdevice->dev =3D &pdev->dev;
>  	ts_omap.inputdevice->evbit[0] =3D BIT(EV_KEY) | BIT(EV_ABS);

Pushing today.

Tony
