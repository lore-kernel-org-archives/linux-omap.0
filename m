From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Thu, 15 Apr 2010 19:04:11 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DA67699@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
 <i2x5d5443651004140034mdd11969cg72d4306c77f2bd0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <i2x5d5443651004140034mdd11969cg72d4306c77f2bd0f@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


Hi Trilok!

> > =A0- matrix_keypac.c logic
> > =A0- hwmod framework
>=20
> Do we have hwmod framework mainlined in the kernel?

Not yet but wanted to gather initial comments to be ready once framewor=
k is pushed

>=20
> >
> > +config KEYBOARD_OMAP4
> > + =A0 =A0 =A0 =A0tristate "TI OMAP4 keypad support"
> > + =A0 =A0 =A0 =A0depends on (ARCH_OMAP4)
>=20
> No need of brackets.

Removed

>=20
> Could you please provide "default y/n" option too?

Added

>=20
> > + * linux/drivers/input/keyboard/omap4-keypad.c
>=20
> Better not to include file paths.

Removed path... only filename

>=20
> > +
> > +struct omap_device_pm_latency omap_keyboard_latency[] =3D {
>=20
> static?

Not sure... I'll check

<snip>

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(inpu=
t, keypad_data->keycodes[code],
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 key_state[col] & (1 << row));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
>=20
> where is input_sync(..)?

Added

>=20
> > +
> > + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(struct matrix_keypad_platfor=
m_data),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_K=
ERNEL);
>=20
> Please check error return here, because kzalloc can fail.

Added

<snip>

> > +
> > + =A0 =A0 =A0 /* keymap data */
> > + =A0 =A0 =A0 keymap_data =3D pdata->keymap_data;
> > + =A0 =A0 =A0 if (!keymap_data) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no keymap data d=
efined\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(keymap_data);
>=20
> not freeing kfree(pdata)? Please check error return path again in thi=
s driver.

I'll check error return in all code

<snip>

> > +
> > +failed_free_device:
> > + =A0 =A0 =A0 input_unregister_device(keypad_data->input);
>=20
> add keypad_data->input =3D NULL.

Added

Best Regards
Abraham
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
