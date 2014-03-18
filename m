From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: DTS: AM43x: Add sii9022 dt information
Date: Tue, 18 Mar 2014 13:03:26 +0200
Message-ID: <532827FE.30203@ti.com>
References: <1395137278-5065-1-git-send-email-sathyap@ti.com> <1395137278-5065-3-git-send-email-sathyap@ti.com> <53282082.1000208@ti.com> <5328268C.1030306@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hQQuqVRWLgS3qvNEqLd4cxSdFMgHskO09"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59576 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755277AbaCRLDg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 07:03:36 -0400
In-Reply-To: <5328268C.1030306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash <a0393677@ti.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, pawel.moll@arm.com, paul@pwsan.com

--hQQuqVRWLgS3qvNEqLd4cxSdFMgHskO09
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18/03/14 12:57, Sathya Prakash wrote:

>> You add the same label, "dpi_out" to both endpoints. Does this even
>> compile?
>>
>> As there's just one port, you can leave out the 'ports' node.
> Will check. the ports was added as per documentation in
> video-interfaces.txt

It mentions that the 'ports' is optional.

> Can you suggest how to add the 2 dpi_out endpoints?

Didn't try, but:

port {
	#address-cells =3D <1>;
	#size-cells =3D <0>;

	dpi_lcd_out: endpoint@0 {
		reg =3D <0>;
		remote-endpoint =3D <&lcd_in>;
		data-lines =3D <24>;
	};

	dpi_sii_out: endpoint@1 {
		reg =3D <1>;
		remote-endpoint =3D <&sii9022_in>;
		data-lines =3D <24>;
	};
};

However, we still need to handle the GPIO which is used to select the
LCD or HDMI. So, maybe the above works, but we should try the
encoder-gpio-switch to handle the GPIO, which we discussed about earlier.=


 Tomi



--hQQuqVRWLgS3qvNEqLd4cxSdFMgHskO09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTKCf+AAoJEPo9qoy8lh711P4QAK9RGbbstK+L5eQM8q3H6+5g
Xqnop0Uycg0zFob6X9pHuppbJhnCLS8+Zk88Yn4TEZjlXBNvgz9G+N/OOiCMCPFl
hYCd9GQr9TIOiYhd9YklZfXkS4ZkTNlabVT3CePx03iaXPwpAsAiyq0rExaEtzb0
v1pVYHYm9/SeiJPDrvpQwT3J3FtxaF1cNmev06pjEtMNAt8h8OqJNM2vJ5uh0m5s
0WgQ4+YTuG5zbB0RRdyCUrrvU1QzJ5jXvZe+FHqEjUKn5hLlIEBIfpVKrx6rKXuY
CHGxqMkrJNiKdw1FA3eeAJABo1LUIZnPULBRWcHdOxFVNSkKcbPintIERsxOI4X3
viF/S8pID3vp7HjVIK99ny0mahOiwNUSHEpg95mRpdqrCJLViRcZficOq+srT8w2
56aZaQrSvf3g2ScQUNRnKxQ3KhonUHcgZJe6aUJOS8a4bLzurqq0/DDlG5BuUPSj
FDnoLBvEh/vM38O/6k7dS5HQhrOOOE6gIUoDAfFJh/AADBZp1amxKXUcJta9Ee9L
S/H9QzujM4ybeUVSt2LsSETb9aju+bUePGCziHNIxRLILk3Ve5UOo9s1UTgBK8oG
tn9Ztk/Egb3GargIzMSNfUFthzyPUNhkXQRnOnUiOQNsmV0wtghOJORCPaiypjtr
1jqas7IX1fJWAWZn2IK5
=2aKR
-----END PGP SIGNATURE-----

--hQQuqVRWLgS3qvNEqLd4cxSdFMgHskO09--
