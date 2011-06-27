From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 05/16] OMAP4: clock data: Remove usb_host_fs clkdev with
 NULL dev
Date: Mon, 27 Jun 2011 11:03:17 +0300
Message-ID: <20110627080316.GC2508@legolas.emea.dhcp.ti.com>
References: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
 <1308851025-26313-6-git-send-email-b-cousson@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:39130 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755791Ab1F0IDW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 04:03:22 -0400
Received: by mail-bw0-f50.google.com with SMTP id 11so1539671bwb.23
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 01:03:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308851025-26313-6-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2011 at 07:43:34PM +0200, Benoit Cousson wrote:
> usb_host_fs_fck does have a clkdev mapping with "usbhs-omap.0"
> and "fs_fck" alias used by the driver.
> The entry with NULL dev is thus not needed anymore.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Felipe Balbi <balbi@ti.com>

looks good to me. That was duplicated anyway:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOCDlEAAoJEAv8Txj19kN1BtYIAIc21K28hKarza3SqLPpUHsT
zlHNMVHYr6DeKL9lM2fJjK7gQNO4Gd3hrXZW+XCCZTtoID8GfOTKL0HyWEuSwvlk
ZZtbmYsgtN2Z8Y0ek0D95VmTnuZ3DBItGB1XCZeZXwbCRduNX8ViA/vB+XC4/DFJ
aFtqGfNPtciLngAeylphZ00YlXgKM8OtB2rwvzmaCTMS1fLydN8WApQ3znYoQH42
Zc5iZmK+tuZWLGbZ3sSNiGG1ErTUQwDF/wYheiuQkdPglu9KM60D0kPgIakRBCIK
CQbBR9xlGPmsYzkVpaiXsyNQXFE5EJBhuXXjmy3JKDVLOSds/zzUtST/22VLQK0=
=onMI
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
