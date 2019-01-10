From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] serial: 8250_omap: Drop check for of_node
Date: Thu, 10 Jan 2019 13:07:58 +0100
Message-ID: <20190110120758.bz63neey5ztepw4m@earth.universe>
References: <20190109091206.25759-1-vigneshr@ti.com>
 <20190109091206.25759-2-vigneshr@ti.com>
 <20190109214403.GW5544@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5tx4nodvh2iwfgy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109214403.GW5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vignesh R <vigneshr@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--u5tx4nodvh2iwfgy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 09, 2019 at 01:44:03PM -0800, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [190109 09:11]:
> > 8250_omap is DT only driver so dev->of_node always exists. Drop check
> > for existence of valid dev->of_node to simplify omap8250_probe().
>=20
> That part seems safe to me now.
>=20
> > --- a/drivers/tty/serial/8250/8250_omap.c
> > +++ b/drivers/tty/serial/8250/8250_omap.c
> ...
> > -		const struct of_device_id *id;
> > -
> > -		ret =3D of_alias_get_id(pdev->dev.of_node, "serial");
> > -
> > -		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> > -				     &up.port.uartclk);
> > -		priv->wakeirq =3D irq_of_parse_and_map(pdev->dev.of_node, 1);
> > -
> > -		id =3D of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
> > -		if (id && id->data)
> > -			priv->habit |=3D *(u8 *)id->data;
>=20
> But this part it seems we still need to keep around
> as we still have lots of clock-frequency references
> in the *.dtsi files. Or am I missing something?

It's re-added a couple of lines later. Only the indent was removed.

-- Sebastian

--u5tx4nodvh2iwfgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlw3NZsACgkQ2O7X88g7
+pr5IBAAhmNLhHoG54gdNETgXhIRD+prbisTAvMlT5EQjZRR0o0X//uoTI8Hw+Z6
Yh46FgkTU7rj++fpvAHfSbSOsMLklT7dsU6r8OQqc/4szPAoJPa+Fp2eDi3QOQKo
f12NEqD42+i2R4Ah789ctstIek5z0YIBL4dK92ubKbEHSqMp0/u214+JHGnVM7Jx
Zw5r+ibBYPjMEU8xVKe3993mEU5MyTQhOlRSSMBwiDcxqyckle+IUZugr91lr0dG
Mluv1LK7wupwbk/a/YD7gagiZN2kuyXRzwxE6J/hRHl1wchj4ald2SRvmxYUpEW/
6BtldqSPd3HDsxRwxYhfztg9JIJZy1zDYILTRT93bKH3SHQTUcBP+JNva69zVik6
BeV6kLfXo47dSv2GGK4HcGD4Ryggh6P7UyrP3seFg7FM5LS7a9fSPPEONoWyt5ew
1WUNusbG0/VK9XMpo3lWBL3xEg0mSUO0Ov+9sKCHQcNQhZIAqJb9i4SSbe9dCoOa
rJ5pRG54NHOZQAX2JcWSur54kDNGAVcHT4tyApGmrtqAbIOe6cAFopKPJ7mzD8uj
Od5/QGcmSPg1YDaT+NPniXTc95dwK0JIOy4C5mXR7mUE0L30tvj8MwXyBYJZXj2b
4qLnkr0hJRKkOblwysOSqeCPCMcO6sF+0qPiQg9uBesI3FvPUWg=
=kRf9
-----END PGP SIGNATURE-----

--u5tx4nodvh2iwfgy--
