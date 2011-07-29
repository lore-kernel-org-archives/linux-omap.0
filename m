From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP4: I2C: Enable the wakeup in I2C_WE
Date: Fri, 29 Jul 2011 15:37:17 +0300
Message-ID: <20110729123716.GN31013@legolas.emea.dhcp.ti.com>
References: <1311940122-10681-1-git-send-email-shubhrajyoti@ti.com>
 <20110729120711.GL31013@legolas.emea.dhcp.ti.com>
 <4E32A75C.5060400@warmcat.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eGLW8NzjjVmDHwQh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4E32A75C.5060400-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--eGLW8NzjjVmDHwQh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 29, 2011 at 01:28:12PM +0100, "Andy Green (=E6=9E=97=E5=AE=89=
=E5=BB=B8)" wrote:
> On 07/29/2011 01:07 PM, Somebody in the thread at some point said:
>=20
> Hi -
>=20
> >-                       omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->we=
state);
> >+                       if (dev->rev<  OMAP_I2C_REV_ON_3530_4430)
> >+                               omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> >+                                                               dev->wes=
tate);
>=20
> >Andy, can you clarify why you added the revision check which didn't
> >exist before ?
> >
> >[1] http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.gi=
t;a=3Dcommitdiff;h=3Da3a7acbcc3df4e9ecc12aa1fc435534d74ebbdf4
> >
>=20
> At the time I wrote the patches back in March, the code there was
> different: there was a pre-extant test avoiding that line on 4430,
> and the patch is simply converting it to the new scheme.  You can see
> it here:
>=20
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/54940
>=20
> @@ -379,7 +379,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			 * REVISIT: Some wkup sources might not be needed.
>  			 */
>  			dev->westate =3D OMAP_I2C_WE_ALL;
> -			if (dev->rev < OMAP_I2C_REV_ON_4430)
> +			if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
>  				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
>  								dev->westate);
>  		}
>=20
> I guess since March and before this got committed for 3.1, someone
> got a patch in first removing the test, so when my patchset was
> uplevelled for commit against 3.1-rc this conflict was dealt with by
> re-introducing the test.
>=20
> Long story short, it's there from me as a mechanical 1:1 renaming
> action as part of the fix that 3530 and 4430 (different) IPs return
> the same rev number.  Despite how it now looks I didn't add it, so if
> Shubhrajyoti has reasons to think it should be gone again I have
> nothing against that at all.

yeah, looks like a bad conflict resolution. Shubhrajyoti, care to respin
the patch and update commit log stating that it is fixing a bad conflict
resolution or something ?

--=20
balbi

--eGLW8NzjjVmDHwQh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMql8AAoJEAv8Txj19kN1asAH/17I6yVoZV6x/mG4TXt7C5l8
3kMjs+njEGKDFovHJGi3Y6z/dw+3rEsyHCM1FWMdVVgjcKysoWotboneMiv8mRrU
PbIixqQDDH0g54zoperlGnQWjvZ1Czp4YkrUFsBUwh5kkVoxmdGirzIq+HO3H+8D
jpJEPwIm78OF3ncpfgjwD5PGv/liRtfmplJPV6KyNAAihZh88Wtnyi+X+OhDV/jX
LmuZhScE6zvJoFKrcJT1z5tpMzoktVX1riaKx5kuNqMXZn8tpJtlI50yxb2jcL63
72HIeaMB+Ibn6cTMDkacc+pHRA9jH2xfV0tCV62G9YyKAxtFSpoPxBqQsODYeQw=
=A2O5
-----END PGP SIGNATURE-----

--eGLW8NzjjVmDHwQh--
