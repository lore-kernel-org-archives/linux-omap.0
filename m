From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can: c_can: Add d_can raminit support
Date: Wed, 21 Nov 2012 11:12:53 +0100
Message-ID: <50ACA925.60900@pengutronix.de>
References: <1353490282-10853-1-git-send-email-mkl@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA77E29@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2C1F286584D44A07F647C6D6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32936 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab2KUKNH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 05:13:07 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA77E29@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C1F286584D44A07F647C6D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/21/2012 11:07 AM, AnilKumar, Chimata wrote:
> On Wed, Nov 21, 2012 at 15:01:22, Marc Kleine-Budde wrote:
>> From: AnilKumar Ch <anilkumar@ti.com>
>>
>> Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
>> which holds all the message objects during transmission or
>> receiving of data. This initialization/de-initialization should
>> be done in synchronous with D_CAN clock.
>>
>> In case of AM335X-EVM (current user of D_CAN driver) message RAM is
>> controlled through control module register for both instances. So
>> control module register details is required to initialization or
>> de-initialization of message RAM according to instance number.
>>
>> Control module memory resource is obtained from D_CAN dt node and
>> instance number obtained from device tree aliases node.
>>
>> This patch was tested on AM335x-EVM along with pinctrl data addition
>> patch, d_can dt aliases addition and control module data addition.
>> pinctrl data addition is not added to am335x-evm.dts (only supports
>> CPLD profile#0) because d_can1 is supported under CPLD profile#1.
>>
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> [mkl: fix instance for non DT in probe, cleaned up raminit]
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello,
>>
>> compile time tested only - please test on real HW.
>=20
> Hi Marc,
>=20
> I tested this patch, its working.

Tnx, pushed to linux-can-next/master

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2C1F286584D44A07F647C6D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCsqSkACgkQjTAFq1RaXHNHuACfa4rtwoY7jJZHeQKq8bsxpgpp
9FgAnjmvjIvugxGqW4DvaJJbIgwuoiiH
=XFKw
-----END PGP SIGNATURE-----

--------------enig2C1F286584D44A07F647C6D6--
