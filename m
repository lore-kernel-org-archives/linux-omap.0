From: Sebastian Reichel <sre@kernel.org>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 11:31:15 +0200
Message-ID: <20171026093115.4bc6ctxjx72ng7ld@earth>
References: <20171025203459.GA22035@amd>
 <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="grunebutc7modv2j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026091325.GA26929@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, filip.matijevic.pz@gmail.com
List-Id: linux-omap@vger.kernel.org


--grunebutc7modv2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 26, 2017 at 11:13:26AM +0200, Pavel Machek wrote:
> On Wed 2017-10-25 14:28:07, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [171025 13:36]:
> > > Hi!
> > >=20
> > > ...hardware should be identical. 3.5.3-nemo kernel seems to work on
> > > both. 4.13-rc2 with display and clock patches boots on phone "S", but
> > > does not on phone "P"; nothing nothing is received on serial port.
> > >=20
> > > There is some difference in the bootloaders: S's bootloader provides
> > > lots of debug info, P's is silent. R&D settings do _not_ have
> > > influence on bootloader. We know P's serial works, as 3.5.3 kernel
> > > prints "Uncompressing linux...booting" there.
> > >=20
> > > I'll need to return "S" phone and serial cable tommorow. If you have
> > > any ideas, let me know.
> >=20
> > If you get nothing out of the uart, chances are the pins are
> > not muxed for the uart in nolo and maybe kernel dts is missing the
> > pinctrl entries for uart?
> >=20
> > Also try booting with mem=3D512M@0x80000000 or 256M or 768M. Maybe the
> > memory is different size or partially broken?
>=20
> Uhuh. It looks like "P" nokia really wants initrd, otherwise it will
> not boot.
>=20
> I got "uncompressing Linux 4.13" on serial console now, debug LEDs
> blinking, and if I use a flashlight, I see output on the screen, too.
>=20
> (What do I need to do to get the backlight working?)

Glad you got it working :) For backlight you can add this
in drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c:

add the following code at the end of dsicm_probe:

-----------------------------------------------------------
mutex_unlock(&ddata->lock);
mutex_lock(&ddata->lock);
ddata->in->ops.dsi->bus_lock(ddata->in);
r =3D dsicm_wake_up(ddata);
if (!r)
    r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 100);
ddata->in->ops.dsi->bus_unlock(ddata->in);
mutex_unlock(&ddata->lock);
-----------------------------------------------------------

-- Sebastian

--grunebutc7modv2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnxq2EACgkQ2O7X88g7
+poS4RAAh7N3tSIRbT8R9tMVpFRL3vSLHaM+bL2n8XtcUMm6iIpFDv4sZRCpb3pw
aD4+Ali8De392yofoTW8JaHGsbE6a1aNrv7XQMHGhKW5xHLHUwFjGdc0JD1plv9u
/afGUC0X7/E6uy+A35zQhhwyVWXDMoCvtr1AUM+jb6/fRTxRW2cW3O9NyHP8XPY5
b2hWhyFCMMuOffPN2u8+80BDCCz7r926d21tZ5ib6BIyNeIodc1UigE9zmUVMnmT
YvKozou+DnX6x6h5bbNnz1tefqWjtCCv4ri4TefWkL1HpDilpQXXkM49jSmOJ4XB
2Ds+KbjftB78u23HfOlm78D/ylKLw/Hi0x1A7RTCj2gDw3KOqT/Q0/4H3QKJzugf
YuG1xacXnOXmg8al4HGNx7wb6ZTVh6LIPppBxG2AguBp9MVa+zYKlrHG4iEpaet1
iqLGjBbKCR2h/vpZxuVtVbYV9WbuBXa2jj8rAgVA/N0WUp9kvGfJiXxAdhThWEOY
9tLMYGzZ/WR9VxYaaXH3dSNAkiB7xLlCJswMvdyBTYSOrrS8sOr1rJItlGQsJ5Vx
zfUosCvGr1iJfz521Cpt4dwY66bN3IKUtKUNdniyWyS4vqGKbfD7ZRSdl2Kc8Gmc
RPFKDYFmx/ZyQMLtkrXQeLJpc33HA8r7EBAS9AXY3NmRG97vVSA=
=7Tx0
-----END PGP SIGNATURE-----

--grunebutc7modv2j--
