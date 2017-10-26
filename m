From: Sebastian Reichel <sre@kernel.org>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 14:01:30 +0200
Message-ID: <20171026120130.dicanunwcdmjntnb@earth>
References: <20171025203459.GA22035@amd>
 <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
 <20171026095734.GA10141@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z5yc34qd3zy7l3z6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026095734.GA10141@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, filip.matijevic.pz@gmail.com
List-Id: linux-omap@vger.kernel.org


--z5yc34qd3zy7l3z6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 26, 2017 at 11:57:34AM +0200, Pavel Machek wrote:
> On Thu 2017-10-26 11:31:15, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Thu, Oct 26, 2017 at 11:13:26AM +0200, Pavel Machek wrote:
> > > On Wed 2017-10-25 14:28:07, Tony Lindgren wrote:
> > > > * Pavel Machek <pavel@ucw.cz> [171025 13:36]:
> > > > > Hi!
> > > > >=20
> > > > > ...hardware should be identical. 3.5.3-nemo kernel seems to work =
on
> > > > > both. 4.13-rc2 with display and clock patches boots on phone "S",=
 but
> > > > > does not on phone "P"; nothing nothing is received on serial port.
> > > > >=20
> > > > > There is some difference in the bootloaders: S's bootloader provi=
des
> > > > > lots of debug info, P's is silent. R&D settings do _not_ have
> > > > > influence on bootloader. We know P's serial works, as 3.5.3 kernel
> > > > > prints "Uncompressing linux...booting" there.
> > > > >=20
> > > > > I'll need to return "S" phone and serial cable tommorow. If you h=
ave
> > > > > any ideas, let me know.
> > > >=20
> > > > If you get nothing out of the uart, chances are the pins are
> > > > not muxed for the uart in nolo and maybe kernel dts is missing the
> > > > pinctrl entries for uart?
> > > >=20
> > > > Also try booting with mem=3D512M@0x80000000 or 256M or 768M. Maybe =
the
> > > > memory is different size or partially broken?
> > >=20
> > > Uhuh. It looks like "P" nokia really wants initrd, otherwise it will
> > > not boot.
> > >=20
> > > I got "uncompressing Linux 4.13" on serial console now, debug LEDs
> > > blinking, and if I use a flashlight, I see output on the screen, too.
> > >=20
> > > (What do I need to do to get the backlight working?)
> >=20
> > Glad you got it working :) For backlight you can add this
> > in drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c:
> >=20
> > add the following code at the end of dsicm_probe:
>=20
> You did not actually include code to paste into panel-dsi-cm, can you
> try a again?

I added it directly below and you quoted it. I guess you mistook it
for a signature or something :)

-- Sebastian

> > -----------------------------------------------------------
> > mutex_unlock(&ddata->lock);
> > mutex_lock(&ddata->lock);
> > ddata->in->ops.dsi->bus_lock(ddata->in);
> > r =3D dsicm_wake_up(ddata);
> > if (!r)
> >     r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 100);
> > ddata->in->ops.dsi->bus_unlock(ddata->in);
> > mutex_unlock(&ddata->lock);
> > -----------------------------------------------------------
> >=20
> > -- Sebastian

--z5yc34qd3zy7l3z6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnxzpcACgkQ2O7X88g7
+pqF4Q/+IgJXxFFK5xJwq9RRJX3bN4qe8mDg1Nvyah8TZl345NJh427YUW2Pzzhn
7+tGM/YuwvKLKnKHuiKa2sZq0DDSeJuJvBSuTMv7Q1UbYoc4tbbXKbJSUClGsRY7
oBWFTG/pUPnX2TuVb5LioMMUWMZ2zoA/w1Um2zEzeRMGZ+Aenzl84XCkm4QUi66G
F9jow4gNRESXxmisTwMpo/rQ9SNFvxSr1kJMDieZ5cRSqeba0xKGf4yeK7s6DRm1
mZTiSwR94Ys7uY5jpj+hmPOy/5kJmNIIDhqrU12asPs68LDI2whIStjAFLcWsoFR
JJjHC3CAdtvlKx8JQMH9nkSK74H/vrf6ViYDMDyT4jZEdHGS+ilIDzq9ExbX6Rzh
zbrcjbNZLagYMIG4X8ta8lhviC5n17gbLKX4UX3DUphDFFOF446UuVNdiy9Yvjdu
IwQBUekcwJoJmB6vxTEo+aewDTzEGjACLPAYorGrQoEJutmcatR5+mtpRXOf0PcZ
HWjtSVIWZZGO944iEou/54wOuVPth2sgWFzN4rS7O8FWZoruowVI08uCIyowthYf
t4y3XDtgBbXdOW0MBDYiEnxh7ouOykrXgx5qBsKMZqMTR5B0AbzbwTP1q6EQ8lyi
/qm4UEVcvSSCa56ortuFXzq9T+ddjgwKJhCDWvIkRez8gFjSSRA=
=mG/4
-----END PGP SIGNATURE-----

--z5yc34qd3zy7l3z6--
