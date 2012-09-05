From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 0/4] can: c_can: Add suspend/resume and pinctrl support
Date: Wed, 05 Sep 2012 15:55:00 +0200
Message-ID: <504759B4.6060203@pengutronix.de>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com> <50473D92.9000500@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDFD22B900FE27AE33105E039"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40798 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab2IENzH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 09:55:07 -0400
In-Reply-To: <50473D92.9000500@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, tony@atomide.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDFD22B900FE27AE33105E039
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/05/2012 01:54 PM, Marc Kleine-Budde wrote:
> On 09/05/2012 01:12 PM, AnilKumar Ch wrote:
>> Adds suspend/resume functionality of d_can driver along with d_can
>> raminit support which is required to initialize RAM while data
>> transmission.
>>
>> This patch series also adds pinctrl support to c_can driver. These
>> patches were tested on AM335x-EVM.
>>
>> This patch-series is based ontop of runtimePM patch submitted
>> earlier - https://patchwork.kernel.org/patch/1348081/
>=20
> Looks good, I'll apply the series after Tony acks the patch 3
> ([PATCH RESEND 3/4] ARM: AM33XX: board-generic: Add of_dev_auxdata to
> pass d_can raminit).

I've pushed all patches to can-next/master [1]. When Tony gives his Ack,
I'll send David a pull request (of a tree including that Ack).

Marc

[1] https://gitorious.org/linux-can/linux-can-next

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigDFD22B900FE27AE33105E039
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBHWbUACgkQjTAFq1RaXHPQGACfQFC5GsK7kjLw+sDzqlmuKD1V
O9AAnRduWne5Vk2PBfkSvgmH7HfpBdWW
=tr3m
-----END PGP SIGNATURE-----

--------------enigDFD22B900FE27AE33105E039--
