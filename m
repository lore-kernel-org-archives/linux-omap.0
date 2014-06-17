From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
Date: Tue, 17 Jun 2014 12:25:04 +0300
Message-ID: <53A00970.3090902@ti.com>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com> <20140617085846.GO17845@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="99SNfjjuriiLBhpcT8PQJGApnsWCUeDtb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35320 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932263AbaFQJZb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 05:25:31 -0400
In-Reply-To: <20140617085846.GO17845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, Sathya Prakash M R <sathyap@ti.com>

--99SNfjjuriiLBhpcT8PQJGApnsWCUeDtb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/06/14 11:58, Tony Lindgren wrote:

>> +/* rfbi */
>=20
> I think we're still missing am43x_rfbi_sysc entry though?
>=20
>> +static struct omap_hwmod am43xx_dss_rfbi_hwmod =3D {
>> +	.name		=3D "dss_rfbi",
>> +	.class		=3D &omap2_rfbi_hwmod_class,
>> +	.clkdm_name	=3D "dss_clkdm",
>> +	.main_clk	=3D "disp_clk",
>> +	.prcm =3D {
>> +		.omap4 =3D {
>> +			.clkctrl_offs =3D AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
>> +		},
>> +	},
>> +};

That should come from omap2/3 hwmod data, as the above references
omap2_rfbi_hwmod_class. The bits there looked correct for AM43xx to me.

 Tomi



--99SNfjjuriiLBhpcT8PQJGApnsWCUeDtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToAlwAAoJEPo9qoy8lh71jxoP/id0sfMyTOX9g2bwyyCIWTt+
AWVTFRER0Oa5WviBioIglP6tYYGstHJPa/OIfW74tJpn4Z32RYB+cMpQquj8DmGW
heST+28idekmwjgS54M+2HHbxP3ALMcVGHhRKuHYqVqfk2IWjCYpNZkMdaKvRbQj
KUxHDRIEOGtlKf0JVZ8a6bm4XsuF+Tf7PxZHlUBJfti43xmdTNa5EodgB091B7dm
MzOQ3CwGb62Qh3M04ejHWHMjcMxxoU/LzOJvGlR7luEwsBeAAkkM3txmSxpqemaa
q+r0q8yVBPHR3mBJJS/Piz3I/BVDQahIZqZxwfgW1HWJhrFFCrzLEz9dDs/H655i
iq+FFfcxs3L5gCM0+qDgxmQ7CxdRpJbAuDklHJ95Q4Rib2xg9+Sew9jlWfuw75T0
awk6FJx7oau5Ugnj61CAccmKE9kpU86w83lSUSq8jBKCkrTQlos1ePr2tb+F+0gH
hmCrtAbPBfe32oUxtd7ial21PTOx81Lp1MhS9L/AtvfJP6ED6vg+SEJY0OyB9lFU
R3teYc9CPpkbQmqTeY6lG9NtzAaFqrEVLMshB7+FUZMP9QzW0QJFPeu6EFdZZYOx
3TLeBbJ2OvRvKncWrusuf5n9vXpKKKlycV42lWjLF3ki7bdC17gVzRHmed6geJ1C
ZIWRr5oGBqezl5rdg2IS
=LMAq
-----END PGP SIGNATURE-----

--99SNfjjuriiLBhpcT8PQJGApnsWCUeDtb--
