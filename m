From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Tue, 11 Sep 2018 22:05:30 +0200
Message-ID: <20180911200530.GA28290@amd>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911170825.17789-2-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-09-11 12:08:20, Dan Murphy wrote:
> Remove support for the LM3697 LED device
> from the ti-lmu.  The LM3697 will be supported
> via a stand alone LED driver.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

I'd really like to see better explanation here.

We have existing binding, for lm3697 and similar devices. With this
series, different binding is introduced, without documented reason.

That's bad.

Now, maybe you are right and the hardware should be handled by
drivers/leds, not drivers/mfd. But we should have solution for all the
similar chips, and that still does not mean we have to modify the
binding. (But maybe we want to move it to different
directory). Bindings are supposed to describe hardware, not mirror
structure of our drivers.

Unless there's something fatally wrong with the binding... but in such
case we'd like to know what is wrong.

[And yes, I recognize current situation is ... not ideal and I'm
willing to help. But I'm not sure this is step in right direction.]

Thanks,
								Pavel


> ---
>=20
> v7 - New change for the series based on the comments in https://lore.kern=
el.org/patchwork/patch/982550/
>=20
>  .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documenta=
tion/devicetree/bindings/mfd/ti-lmu.txt
> index c885cf89b8ce..920f910be4e9 100644
> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> @@ -9,7 +9,6 @@ TI LMU driver supports lighting devices below.
>    LM3632       Backlight and regulator
>    LM3633       Backlight, LED and fault monitor
>    LM3695       Backlight
> -  LM3697       Backlight and fault monitor
> =20
>  Required properties:
>    - compatible: Should be one of:
> @@ -18,11 +17,10 @@ Required properties:
>                  "ti,lm3632"
>                  "ti,lm3633"
>                  "ti,lm3695"
> -                "ti,lm3697"
>    - reg: I2C slave address.
>           0x11 for LM3632
>           0x29 for LM3631
> -         0x36 for LM3633, LM3697
> +         0x36 for LM3633
>           0x38 for LM3532
>           0x63 for LM3695
> =20
> @@ -38,7 +36,6 @@ Optional nodes:
>      Required properties:
>        - compatible: Should be one of:
>                      "ti,lm3633-fault-monitor"
> -                    "ti,lm3697-fault-monitor"
>    - leds: LED properties for LM3633. Please refer to [2].
>    - regulators: Regulator properties for LM3631 and LM3632.
>                  Please refer to [3].
> @@ -220,24 +217,3 @@ lm3695@63 {
>  		};
>  	};
>  };
> -
> -lm3697@36 {
> -	compatible =3D "ti,lm3697";
> -	reg =3D <0x36>;
> -
> -	enable-gpios =3D <&pioC 2 GPIO_ACTIVE_HIGH>;
> -
> -	backlight {
> -		compatible =3D "ti,lm3697-backlight";
> -
> -		lcd {
> -			led-sources =3D <0 1 2>;
> -			ramp-up-msec =3D <200>;
> -			ramp-down-msec =3D <200>;
> -		};
> -	};
> -
> -	fault-monitor {
> -		compatible =3D "ti,lm3697-fault-monitor";
> -	};
> -};

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluYIAkACgkQMOfwapXb+vI/kwCgklNdw75sHM8TzsqLH+gB/QiO
vy0An0jMgCsNY1QirPhPpG7kVE2eUIdO
=d2K0
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
