From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: Charging status for N900/RX-51 with bq27200
Date: Fri, 16 Feb 2018 10:45:45 +0100
Message-ID: <e2b8465c-8ac3-cfac-e138-42773b8f1aa4@wizzup.org>
References: <581dcb51-f469-61c9-e023-62ac535bc41a@wizzup.org>
 <20180215204153.ztdal3qhtmgi7sjo@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="blWnWj9fBjKbJo3mVNwEfLKtrTjNI6Iq3"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20180215204153.ztdal3qhtmgi7sjo@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--blWnWj9fBjKbJo3mVNwEfLKtrTjNI6Iq3
Content-Type: multipart/mixed; boundary="uVixhJJURryiObYmiDBIOcdvvj1RaIrpz";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Message-ID: <e2b8465c-8ac3-cfac-e138-42773b8f1aa4@wizzup.org>
Subject: Re: Charging status for N900/RX-51 with bq27200
References: <581dcb51-f469-61c9-e023-62ac535bc41a@wizzup.org>
 <20180215204153.ztdal3qhtmgi7sjo@earth.universe>
In-Reply-To: <20180215204153.ztdal3qhtmgi7sjo@earth.universe>

--uVixhJJURryiObYmiDBIOcdvvj1RaIrpz
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On 15/02/18 21:41, Sebastian Reichel wrote:

>=20
> "Not charging" is reported, when the battery is neither charged, nor
> dis-charged. It's supposed to be used when a charger is connected
> without charging the battery.

Makes sense.

> Basically the bq27xxx driver assumes, that charger is connected.
> I guess the problem is, that the N900 devicetree does not specify,
> that the bq27xxx is supplied by the charger, so
> power_supply_am_i_supplied returns -ENODEV.
>=20
> This can be fixed by adding the following to the N900 DT:
>=20
> &bq27200 {
>     power-supplies =3D <&bq24150a>;
> };
>=20
> But there is also a bug in the bq27xxx driver, that should cope
> with no charger being specified. The following patch should fix
> the issue. I currently don't have my N900 with me. Could you
> give it a try?

I added the dts change and bq27xxx change on top of my kernel, but now
the bq27xxx-battery does not want to probe:

[   34.947082] power_supply bq27200-0: Not all required supplies found,
defer probe
[   34.958953] bq27xxx-battery 2-0055: failed to register battery

Full boot log here: https://ptpb.pw/UeEV

Thanks,
Cheers,
Merlijn


--uVixhJJURryiObYmiDBIOcdvvj1RaIrpz--

--blWnWj9fBjKbJo3mVNwEfLKtrTjNI6Iq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWoaoSQAKCRAGN09rynK8
WhigAP9YTWgxhnVrEh2WuuSOxTygi4mjyD6Bwy2SEHw+ls1ndQD/W7GvoE51nS7i
MDDsE2AAoJgKsUyf/BGvPWdgdOvsEAY=
=AetO
-----END PGP SIGNATURE-----

--blWnWj9fBjKbJo3mVNwEfLKtrTjNI6Iq3--
