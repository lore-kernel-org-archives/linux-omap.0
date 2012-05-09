From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCH 2/2] Add LCD support for the LogicPD OMAP3530 DevKits
Date: Wed, 09 May 2012 18:52:17 +0300
Message-ID: <1336578737.3962.67.camel@deskari>
References: <1336418480-32635-1-git-send-email-ashwin.bihari@logicpd.com>
	 <1336418480-32635-3-git-send-email-ashwin.bihari@logicpd.com>
	 <1336547775.2724.7.camel@deskari>
	 <0520A3FE5EDCF24F88B3F1451CFC64AE04A34D4C8E@edprex01>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-z+KsRMF2nOUmJmQoioRo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:46994 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760023Ab2EIPwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 11:52:23 -0400
Received: by lahc1 with SMTP id c1so134439lah.4
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 08:52:20 -0700 (PDT)
In-Reply-To: <0520A3FE5EDCF24F88B3F1451CFC64AE04A34D4C8E@edprex01>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <ashwin.bihari@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>


--=-z+KsRMF2nOUmJmQoioRo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 10:38 -0500, Ashwin Bihari wrote:
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@ti.com]
> > Sent: Wednesday, May 09, 2012 3:16 AM
> > To: Ashwin Bihari
> > Cc: linux-omap; Tony Lindgren
> > Subject: Re: [PATCH 2/2] Add LCD support for the LogicPD OMAP3530 DevKi=
ts
>=20
> <snip>
> =20
> > > +static int omap3logic_panel_enable_lcd(struct omap_dss_device
> > > +*dssdev) {
> > > +	gpio_set_value(LCD_PANEL_PWR, 1);
> > > +	if (machine_is_omap3530_lv_som())
> > > +		gpio_set_value(OMAP3530_LV_SOM_BACKLIGHT_PWR, 1);
> > > +	else if (machine_is_omap3_torpedo()) {
> > > +		gpio_set_value(OMAP3530_TORPEDO_BACKLIGHT_PWR, 1);
> > > +
> > > +		gpio_set_value(OMAP3530_TORPEDO_MDISP, 1);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int omap3logic_panel_disable_lcd(struct omap_dss_device
> > > +*dssdev) {
> > > +	gpio_set_value(LCD_PANEL_PWR, 0);
> > > +	if (machine_is_omap3530_lv_som())
> > > +		gpio_set_value(OMAP3530_LV_SOM_BACKLIGHT_PWR, 0);
> > > +	else if (machine_is_omap3_torpedo()) {
> > > +		gpio_set_value(OMAP3530_TORPEDO_BACKLIGHT_PWR, 0);
> > > +
> > > +		gpio_set_value(OMAP3530_TORPEDO_MDISP, 0);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> >=20
> > This doesn't play well with device-tree. We can't do such callbacks whe=
n we
> > move to DT.
> >=20
> > I know we have similar code for other boards, and this can't be properl=
y fixed
> > right now, but I'm still a bit hesitant to add more such code because I=
'm the
> > one that has to clean it up later for DT =3D).
> >=20
> > I can handle the LCD_PANEL_PWR gpio, but the backlight is something tha=
t
> > should be removed from the panel enable callbacks. You could look at
> > drivers/video/backlight/ and see if there's something there that could =
be
> > used for your board. Or implement a new BL driver, if nothing fits.
> >=20
> >  Tomi
>=20
> Tomi,
>=20
> Let me take a look at your linux-omap-dss2 tree and learn a bit more abou=
t DT and figure out how to modify the LCD support so it better aligns with =
your work and I'll re-submit that patch again..

I haven't published any DT stuff yet. But there's the DT cleanup series
I have posted, which tries to re-structure stuff for some displays to be
more DT compatible.

The basic idea is that with DT there are no board files, and all device
specific configuration values are in the DT data. So GPIO numbers etc.
are defined in the DT data, and the device driver will read them and use
them.

But DT support is not working yet, and we anyway need to support both DT
and the old way for some time, so the board files should be changed to
this direction. What this means for dss is that the panel specific GPIOs
etc. need to be defined in a device specific struct, which is passed to
the panel driver.

For example, see my cleanup series, and
include/video/omap-panel-tfp410.h,
drivers/video/omap2/displays/panel-tfp410.c and the board files using
that.

All this is still a bit alive and changing, so you could also choose to
wait a bit until things stabilize =3D).

 Tomi


--=-z+KsRMF2nOUmJmQoioRo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqpKxAAoJEPo9qoy8lh71CEQP/2PTXes14JViBIIFRwJsmcLH
u73JnEPZQbU59HoWlia0m/6a4vimN3S+iPtlEXqPpftRbRnJFD4xXKf8JVPRwEIQ
kwdfy3LjJ6VKojW9ZteZOBfvJM89fMD6LP7eWOxYdnUHKr/y6lOLscHmo6unjuQk
7GYSLm0B79erzsv6Be2B6b1XnwGjHGS6HqmDtynwV4JKODTiplIQEmccPIw+l0eb
9zbZNlLYcaB8MDSPupnQyvuGh8y8hJU+jIwuSqOWPVuL363BCvP2cbCJZBu2VeyC
mAzeqkd2iHsCWB3gq3jlzA/0VcZS8u24DiJnU//uATSP4Fm4OUerD3RZfP8dAzai
Ch4nKuw4mfI/FovRjrhJXYryhi/Nv8y6VDn17Vx2CO2c5A0MV9Z97PwMqFM7vWst
2L7KA/LSifNkYBawLm5i0g6Ti7/rereC2vqlPmJJ8+fbjIrOzUXk6lCiFFbpTTJA
EhQSNndyqRs7bAj9mkGOH8ZWhFKVSB0CQnVDq1mgStxfgaOLzDYRmciPP8KtOi4G
01mLUAOXZObOnUiRc6MwbsTENoyvfyW1KfONWg3wj7PUcQHhE2ul8k2Cr2u0d7Vg
QSrRSbGXROwiKLSmynKEjNuYJDc61BcqqpQmj7urlqTM/n6JBMZXySWZGEDvyewA
gAl5Ow/KSd5uPoRGsUux
=ESmW
-----END PGP SIGNATURE-----

--=-z+KsRMF2nOUmJmQoioRo--

