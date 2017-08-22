From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: device tree bindings for lp5523 leds on N950?
Date: Tue, 22 Aug 2017 12:22:14 +0200
Message-ID: <20170822102214.pmag4k2dxz4fdvq5@earth>
References: <20170814133816.GA24493@amd>
 <20170815131518.jt4xff6qv4whebul@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aple5tjnxhbfaxtn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170815131518.jt4xff6qv4whebul@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--aple5tjnxhbfaxtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 15, 2017 at 09:15:28AM -0400, Sebastian Reichel wrote:
> Hi Pavel,
>=20
> On Mon, Aug 14, 2017 at 03:38:16PM +0200, Pavel Machek wrote:
> > I'm (still) trying to debug "N950 not booting" situation. I'm stuck
> > with black screen, so I thought it would be cool to use RGB led for
> > debugging...
> >=20
> > Unfortunately, I don't see required dts bindings in the mainline.
> >=20
> > Does anyone have that working?
>=20
> I have some N950 DTS patches lying around, I think RGB led was one
> of them. I'm currently in Canda for a company event without my N950,
> but I should be able to send something tested before the weekend.

Below is a DTS snippet for N950, that has been tested by me
on top of 4.13-rc6. The left and right keyboard LEDs are
also debug LEDs for cpu idle modes, so they will be lit
without being enabled in lp5523. The status LED of N950 is
not RGB, but just white. Also you need this to get the driver
loading. Otherwise detection after reset fails even after
quite increases waiting times. Looks like the lp5523 reset
(which is not properly Ack'd by the device) breaks the omap-i2c
state horribly.

-- Sebastian

--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -413,7 +413,7 @@ int lp55xx_init_device(struct lp55xx_chip *chip)
                usleep_range(1000, 2000); /* 500us abs min. */
        }
=20
-       lp55xx_reset_device(chip);
+       //lp55xx_reset_device(chip); // FIXME: breaks omap-i2c
=20
        /*
         * Exact value is not available. 10 - 20ms

----------

&i2c2 {
       rgb-led@32 {
               compatible =3D "national,lp5523";
               reg =3D <0x32>;

               enable-gpio =3D <&gpio2 9 GPIO_ACTIVE_HIGH>; /* 41 */
               clock-mode =3D /bits/ 8 <2>; /* external */

               chan0 {
                       chan-name =3D "lp5523:kb5"; /* Keyboard ooooox */
                       led-cur =3D /bits/ 8 <50>;
                       max-cur =3D /bits/ 8 <130>;
               };

               chan1 {
                       chan-name =3D "lp5523:kb4"; /* Keyboard ooooxo */
                       led-cur =3D /bits/ 8 <50>;
                       max-cur =3D /bits/ 8 <130>;
               };

               chan2 {
                       chan-name =3D "lp5523:kb3"; /* Keyboard oooxoo */
                       led-cur =3D /bits/ 8 <50>;
                       max-cur =3D /bits/ 8 <130>;
               };

               chan3 {
                       chan-name =3D "lp5523:kb2"; /* Keyboard ooxooo */
                       led-cur =3D /bits/ 8 <50>;
                       max-cur =3D /bits/ 8 <130>;
               };

               chan4 {
                       chan-name =3D "lp5523:kb1"; /* Keyboard oxoooo */
                       led-cur =3D /bits/ 8 <50>;
                       max-cur =3D /bits/ 8 <130>;
               };

               chan5 {
                       chan-name =3D "lp5523:kb0"; /* Keyboard xooooo */
                       led-cur =3D /bits/ 8 <50>;
                       max-cur =3D /bits/ 8 <130>;
               };

               chan6 {
                       led-cur =3D /bits/ 8 <0>;
                       max-cur =3D /bits/ 8 <0>;
               };

               chan7 {
                       led-cur =3D /bits/ 8 <0>;
                       max-cur =3D /bits/ 8 <0>;
               };

               chan8 {
                       chan-name =3D "lp5523:status-led";
                       led-cur =3D /bits/ 8 <50>;
                       max-cur =3D /bits/ 8 <130>;
               };
       };
};

--aple5tjnxhbfaxtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmcBdQACgkQ2O7X88g7
+ppWmBAAlq0NQnWiKfnVShfgtKVUtBmtVbgWtz2MEGwo/kECxPmOv6i7hbN08neN
2OfQqbJW1tHxy7VoASqehKEj7hPzAZXZw/F0ZPgWFj4uAyfXBuyI32bNNYNK40Mv
PhRN9F13qyuJ65Ajc0Li5J1t+yj6TkjaiZVfJkDojM5JAP2Dm09Bxo0zoJY1cQao
NtJjdFwLPdAkoBkgsJn0wptcaLnBuLQPloBBnOCxNZH1Wbdkd3UQZiwKStej/Np7
cCg9YYOPa6ZUQIqfMolQ7G7fsIAsegFql9QOwzZUj2YHBIXrpznqAjI6FJ89lw3J
nrd69F4ZTdi6qiNMiQ+omEbFx5v2pjFWikHWdXc012g4S+9lyEiLZ1h10zHEG3+W
GwjBjKEKYl23PVWPUtUiqzJrHozEc+bjgGfxNv+XiyjkduxMWKQLt8WApOT8pcks
oZvYEK4i+/cfZfA9x1WuJ83i9X4yNQiupGc1SNE1gebIQxfE1oUBHf0bWEP8ztog
i0Z9m7YlK8yLMmu6i2MDIyE6sYcy+kpUk6NXNvak6tuuICq2Fmtxsez8vX16pg1W
isCNvCdlXzh8MHcHoJNAornr5KHdSIm2eymRZ7iFLitHWtHihhu101TwNeT+n6uh
HqRWshkJLuX+iSo2hp+OnZSdXq8To+8FLMVhyYiI+FyHP3vTEzs=
=/ghp
-----END PGP SIGNATURE-----

--aple5tjnxhbfaxtn--
