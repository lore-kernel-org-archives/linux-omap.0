From: Felipe Balbi <balbi@ti.com>
Subject: Re: Kconfig help descriptions
Date: Thu, 21 Jul 2011 12:37:19 +0300
Message-ID: <20110721093718.GM23253@legolas.emea.dhcp.ti.com>
References: <20110721092221.GA28942@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gw4vLALk08fVJy3V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:57772 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751717Ab1GUJhY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 05:37:24 -0400
Received: by ewy10 with SMTP id 10so1061258ewy.9
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 02:37:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110721092221.GA28942@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org


--gw4vLALk08fVJy3V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2011 at 10:22:21AM +0100, Russell King - ARM Linux wrote:
> Some of the Kconfig help descriptions aren't very useful - for example:
>=20
> | CONFIG_TWL4030_MADC:
> |=20
> | This driver provides support for triton TWL4030-MADC. The
> | driver supports both RT and SW conversion methods.
> |=20
> | This driver can be built as a module. If so it will be
> | named twl4030-madc
>=20
> What is madc?  What does it do?  Do I enable it for the OMAP 4430SDP ?

Monitoring ADC.

--=20
balbi

--gw4vLALk08fVJy3V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOJ/NOAAoJEAv8Txj19kN1J78H/jKDWb6g5FvDLFCFeOEvZZgc
KV+iZbbZ3xMtOTSJqlKlLFlY2QkVrF0krgGIv685DDegQQaUm5IJBzs6A+0EgEPC
FGsIhCbFPL0EyxG8hN0Gr8i64RrQQT7YniIbmXMXNZEmNOUs1a/N0/6v08MljRA/
7BrH99ZcJi2eCuba8md/Nj3S1TlwXQ5jxZVlScbxMrnyY/KsZAmVtI3RK/C5Dmja
mSsof+PP8YExxLmDGFTtZWSBcU0Aoi/nCJcqWQ907gwP9DN1DZlvSL/ER6EFPoKW
7N9Jfb2RX6dBYBE+E9i2VaqaDS4G7a6ZEwb8vpIxlLJWG7KIDq3Gi8isw3mr77U=
=4xRo
-----END PGP SIGNATURE-----

--gw4vLALk08fVJy3V--
