From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: tfp410 and i2c_bus_num (was: Re: [PATCH] OMAP: board-files: fix
 i2c_bus for tfp410)
Date: Fri, 16 Nov 2012 20:21:46 +0200
Message-ID: <20121116182146.GC20496@arwen.pp.htv.fi>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
 <20121116135155.GE18527@arwen.pp.htv.fi>
 <50A64D35.9050109@ti.com>
 <20121116151959.GA19411@arwen.pp.htv.fi>
 <50A65E40.9040208@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50A65E40.9040208-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2012 at 05:39:44PM +0200, Tomi Valkeinen wrote:
> >>> To be fair, the whole i2c_bus_num looks like a big hackery introduced=
 by
> >>> the way panel drivers are written for OMAP DSS.
> >>>
> >>> TFP410 is an I2C client, not an OMAPDSS client. After a quick look at
> >>> the driver, there's is no such thing as a DSS bus, so looks like you
> >>> should have an I2C driver for TFP410 and the whole DSS stuff should be
> >>> just a list of clients, but not a struct bus at all.
> >>>
> >>> The fact that you have to pass the I2C bus number down to the panel
> >>> driver is already a big indication of how wrong this is, IMHO.
> >>
> >> Without going deeper in the dss device model problems, I would agree
> >> with you if this was about i2c panel, but this is not quite like that.
> >>
> >> A panel controlled via i2c would be an i2c device. But TFP410 is not
> >> controlled via i2c. It's not really controlled at all except via
> >> power-down gpio. TFP410 doesn't need the i2c to be functional at all.
> >=20
> > then why does it need the i2c adapter ? What is this power-down gpio ?
> > Should that be hidden under gpiolib instead ?
>=20
> For the i2c, see below. Power-down GPIO is used to power down and up the
> tfp410 chip.

that much I guessed ;-) Should it be hidden under gpiolib ?

> >> The i2c lines do not even touch TFP410 chip, so to be precise, the i2c
> >> lines should not be TFP410's concern. The i2c lines come from the
> >> monitor and go to OMAP's i2c pins. But TFP410 driver is a convenient
> >> place to manage them.
> >=20
> > fair enough... but who's actually using those i2c lines ? OMAP is the
> > I2C master, who's the slave ? It's something in the monitor, I assume...
> >=20
> > IIUC, this I2C bus goes over the HDMI wire ?
>=20
> Yes, the i2c goes over HDMI wire. OMAP is the master, monitor is the
> slave. You can see some more info from
> http://en.wikipedia.org/wiki/Display_Data_Channel under DDC2 section.
>=20
> It is used to read the EDID
> (http://en.wikipedia.org/wiki/Extended_display_identification_data)
> information from the monitor, which tells things like supported video
> timings etc.
>=20
> As for why the tfp410 driver handles the i2c... We don't have a better
> place. There's no driver for the monitor. Although in the future with

than that's wrong :-) If TFP410 isn't really using I2C it shouldn't need
the whole i2c_bus_num logic. I'm far from fully understanding dss
architecture but it looks like what you want is a generic 'i2c-edid.c'
which just reads the edid structure during probe and caches the values
and exposes them via sysfs ?!? (perhaps you also need a kernel API to
read those values... I don't know; but that's also doable).

If you have a generic i2c-edid.c simple driver, I guess X could be
changes to read those values from sysfs and take actions based on those.

Looks like even drm_edid.c should change, btw.

> common panel framework perhaps we will.

ok, good ;-)

--=20
balbi

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpoQ6AAoJEIaOsuA1yqREEREP/3GvOFlGDal8oFud/bVkkbvY
pQiX/fLWpDe6gsznEvADM//K/rFziUvaYlVPC12IWBAQTPzZkd/m4nSRY6bRlzHi
e4OOjE4cjUsa8k+La/HOonJT0lXcRP272bYGNOi2AWaTGuWC3YbBqMMZNS8XuVcj
pjQrlRgXKl7lTQf78WOaKx8BJUszGKj0NSrDZF/Pupo6HVhnGbkKoD9Pp/HWshM8
3cXrL+lSL5FIONs8nzowVQRllLm0dSDux8fLerWNexJP9NqVvBvSPKwsMhpWd2AC
K36W3nHWkM+GtahaVkXlFhmY2TJpJaAg8KU/Xupioxptd0gqyvKyQKmQO/PdMAZ8
YwOCecImCsHuArePgpHVRDxfAc6cnIrAZ+OJSYtZORynEGl4grA/MQxsELJHyGwv
NK5bW18nfy5UsL3/WO+XX8212EWtdV+gSZ/2gkt4Mv3dYW8cCaIaBUuX7D+8ARRZ
f/0TZpdXyLwRAl5TcDd5kPD23y78tGvgdGgy2xBUz5fNgGNTGvMPpPPcwpzGZ9Hf
3qMjsHjv/vVuLe/XmV4dpm2ECG0it/4mYNs9Oj6N7UyKUxfJgDLvdd61JTw8WiTL
7ICrx4AYdaGSn3D++L3qSIcu1cgv+ObdBdUPjnTFW8XRw+BRkzMajqih4agR4cl+
JIvmDqXSzlaZEZmRhw9h
=wsMJ
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
