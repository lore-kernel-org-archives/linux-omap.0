From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Vibrations on Droid 4?
Date: Thu, 2 Aug 2018 13:07:01 +0200
Message-ID: <20180802110701.3b4voigegy67h4p5@earth.universe>
References: <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
 <20180716075926.GU99251@atomide.com>
 <20180801185823.GC26087@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xbljm4k4eov3zyn4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180801185823.GC26087@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, narmstrong@baylibre.com, claudiu.beznea@microchip.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--xbljm4k4eov3zyn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 01, 2018 at 08:58:24PM +0200, Pavel Machek wrote:
> > > Yep, so I have two patches that make the device appear, but vibrations
> > > still do not work for me.
> > >=20
> > > a) any ideas how to debug that / get them to work?
> >=20
> > Hmm no new ideas except I wonder if there is also some other
> > regression with the timer pdata not being passed properly now.
>=20
> I checked vibrations work in original Motorola Android; my hardware is
> not broken.

You got it working, but this information might still be interesting
in case of future problems:

The Android "driver" is very different from the one I wrote from
scratch and upstreamed. The mainline driver is less lines of code
(iirc 25%), less complicated (Android vibration support is spread
over multiple drivers/arch code), more efficient (Android drivers
does GPIO bitbanging instead of PWM) and provides more features
(Android driver does not allow all strength settings). Also it uses
normal input device API instead of a custom one.

P.S.: Sorry, I don't have much time to work on D4 at the moment :(

-- Sebastian

--xbljm4k4eov3zyn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlti5dIACgkQ2O7X88g7
+pooEQ/+JRA1BRFyzNPpnTUA8BF8POAbacA7fDvomNAASvrd6MaULPagTcKmVMyk
dEPV4I7ptLyH6mphyGCtd3GKwfRPa4ufbRGTP3syHPxvp5hm+NkXo16oBM9M0gyK
skc/jQ72v0EKKIueSqHcRe1NQXbyDjzSWw46Cju+OJghDFc+pE/2DU+QfIaJSpjD
5KBoig4XQOztHwVT0J/WPxg8h70v4biLVq1pafo2/4SYlyF4pmJCcjzxE0ivULMe
F3XaHomwxdiTbNlhHRHow3Me/xoPQrY2UZdpc4I+xIX1yjCDn1+P/iVFiAcmCUlJ
yviku2W2/h9K6mVDow+PhxorgKviZw98O89jQnlKrdTcB2C3sySC65DOq2DJFiJi
N4MjeU8cIfPnurIQJ0mv6jq/0qiPlnOTBnAuzbXjGUvaGdAmntfFQ67P8/OvWlHc
m1XhWavKj55cJpbKIoDMmUQIxtOi3QtEE+GEZrIReY6qdGD26rPwW3kKM8F6HUR/
qwDR7VWFMdu6/TScRTj7y8Wyjr39zgtSdeL0PxqM3BYQ/POX+fBYBCLxqEQxgOxZ
4dXNJDlavOQx/YA6NfyUlL5ViLCuxwA0fO2NHqPE0psJZj2rS2UL5/9urPNMgZUm
oNu9uR9LOx/WdGS3VV5S3sIKT9cOOny/tRN/WGsyi4iGCC2Ufjo=
=X+hm
-----END PGP SIGNATURE-----

--xbljm4k4eov3zyn4--
