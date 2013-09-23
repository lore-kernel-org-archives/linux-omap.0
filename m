From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 4/4] RX-51: Add platform function and data for bq24150a charger
Date: Mon, 23 Sep 2013 22:06:46 +0200
Message-ID: <201309232206.47391@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com> <201309232116.19161@pali> <20130923200008.GA21808@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8031306.oUTAP5VCoK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130923200008.GA21808@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

--nextPart8031306.oUTAP5VCoK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 23 September 2013 22:00:09 Sebastian Reichel wrote:
> On Mon, Sep 23, 2013 at 09:16:18PM +0200, Pali Roh=C3=A1r wrote:
> > It is not as simple as it looks. This is reason why I
> > submited this patch long time after I submited bq2415x
> > driver.
> >=20
> > Problem is that for rx51 is needed specific function which
> > connect to two drivers (bq2415x and isp1704) plus it call
> > specific rx51 board functions.
> >=20
> > Something which cannot be in DT (unless DT support C/ASM
> > code).
>=20
> mh could isp1704 driver expose the data via the regulator
> framework?

No, isp1704 is power supply driver and export data via power=20
supply (sysfs) interface. It is not regulator but charger driver.

> Then the bq2415x chip can just use the regulator
> framework. This should make converting to DT easy (by giving
> the bq2415x chip the isp1704 as regulator) and uses existing
> standard interfaces.
>=20
> > Patches for modem support are being prepared for upstreaming
> > :-) so after that it is up to you to create "call" script
> > as you want
>=20
> I'm on it. RFC round will be sent out this week. It seems
> hwmod data is already finished, since i didn't get feedback
> for that patch :)
>=20
> -- Sebastian

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart8031306.oUTAP5VCoK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlJAn1cACgkQi/DJPQPkQ1ImuQCdGMp7+nMW7HOEELTTgDbjm5+r
o24AoLqN/0IupCKm9rKUdjkNgtyK31hu
=bGPQ
-----END PGP SIGNATURE-----

--nextPart8031306.oUTAP5VCoK--
