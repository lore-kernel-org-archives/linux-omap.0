From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP4: I2C: Enable the wakeup in I2C_WE
Date: Fri, 29 Jul 2011 17:09:26 +0300
Message-ID: <20110729140925.GW31013@legolas.emea.dhcp.ti.com>
References: <1311940122-10681-1-git-send-email-shubhrajyoti@ti.com>
 <20110729120711.GL31013@legolas.emea.dhcp.ti.com>
 <4E32A75C.5060400@warmcat.com>
 <20110729123716.GN31013@legolas.emea.dhcp.ti.com>
 <4E32B88E.6030508@ti.com>
 <CANQgH-YVzcvST=ofs4DYw5e4e_Qb1xO-=T46O6ioxMRDf2mpFg@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L+ytD9kXoSFEJYhc"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANQgH-YVzcvST=ofs4DYw5e4e_Qb1xO-=T46O6ioxMRDf2mpFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Andy Green =?utf-8?B?KOael+WuieW7uCk=?= <andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--L+ytD9kXoSFEJYhc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 29, 2011 at 07:33:39PM +0530, Datta, Shubhrajyoti wrote:
>    On Fri, Jul 29, 2011 at 7:11 PM, Shubhrajyoti <[1]shubhrajyoti-l0cyMroinI0@public.gmane.org>
>    wrote:
>=20
>      On Friday 29 July 2011 06:07 PM, Felipe Balbi wrote:
>=20
>        Hi,
>=20
>        On Fri, Jul 29, 2011 at 01:28:12PM +0100, "Andy Green (=E6=9E=97=
=E5=AE=89=E5=BB=B8)" wrote:
>=20
>          On 07/29/2011 01:07 PM, Somebody in the thread at some point sai=
d:
>=20
>          Hi -
>=20
>            - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
>            dev->westate);
>            + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (dev->rev< =C2=A0 OMAP_I2C_REV_ON_3530_4430)
>            + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_i2c_write_reg(dev,
>            OMAP_I2C_WE_REG,
>            + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
>            dev->westate);
>            Andy, can you clarify why you added the revision check which
>            didn't
>            exist before ?
>=20
>            [1]
>            [2]http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-o=
map-pm.git;a=3Dcommitdiff;h=3Da3a7acbcc3df4e9ecc12aa1fc435534d74ebbdf4
>=20
>          At the time I wrote the patches back in March, the code there was
>          different: there was a pre-extant test avoiding that line on 443=
0,
>          and the patch is simply converting it to the new scheme. =C2=A0Y=
ou can
>          see
>          it here:
>=20
>          [3]http://permalink.gmane.org/gmane.linux.ports.arm.omap/54940
>=20
>          @@ -379,7 +379,7 @@ static int omap_i2c_init(struct omap_i2c_dev
>          *dev)
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 * REVISIT: Some wkup sources might not be
>          needed.
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 */
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0dev->westate =3D OMAP_I2C_WE_ALL;
>          - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (dev->rev< =C2=A0OMAP_I2C_REV_ON_4430)
>          + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (dev->rev< =C2=A0OMAP_I2C_REV_ON_3530_4430)
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_i2c_write_reg(dev,
>          OMAP_I2C_WE_REG,
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
>          =C2=A0dev->westate);
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=20
>          I guess since March and before this got committed for 3.1, someo=
ne
>          got a patch in first removing the test, so when my patchset was
>          uplevelled for commit against 3.1-rc this conflict was dealt wit=
h by
>          re-introducing the test.
>=20
>          Long story short, it's there from me as a mechanical 1:1 renaming
>          action as part of the fix that 3530 and 4430 (different) IPs ret=
urn
>          the same rev number. =C2=A0Despite how it now looks I didn't add=
 it, so
>          if
>          Shubhrajyoti has reasons to think it should be gone again I have
>          nothing against that at all.
>=20
>        yeah, looks like a bad conflict resolution. Shubhrajyoti, care to
>        respin
>        the patch and update commit log stating that it is fixing a bad
>        conflict
>        resolution or something ?
>=20
>      I wasn't aware of the conflict resolution part. Actually came across
>      this
>      piece of code as per the discussion on the reset implementation patch
>      will update
>      the changelogs.
>      How about,
>=20
>    Earlier mail got corrupted resending

this is much worse. What mail client are you using ? Maybe there are
some tips on Documentation/email-clients.txt

--=20
balbi

--L+ytD9kXoSFEJYhc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMr8VAAoJEAv8Txj19kN1DfwH/23pu7CMA8a6O0DLzH5VRWyX
WN73p2r8/npQpqacpBtn+fv/k79rNBqTmcxXgsPNYU37iWiVQkANGUW88Yvm22Up
HH/tfTFqGohnCOBqy1paXEI4CgV0zEPlxIuANopaNFmqxtpwAh0vORYkm6i2jCKe
MPWDQAQRRPwr0aiPakeNLO5WX4jDoxkq1cX86odnJCOPrRF6ci9SI/fLvX6OM6xP
Cmdwdiw7grqU+hRec+0TLX1KBAKrQ4YH/t6oa5ThqGKvDyQZfrCoioipmGngL3Vd
CSUB/0YXZsQ887kEQxnnAzkyIx448THVmV+N9mUWVQO9f2oz80NGkVS2IeLdwSo=
=yJoY
-----END PGP SIGNATURE-----

--L+ytD9kXoSFEJYhc--
