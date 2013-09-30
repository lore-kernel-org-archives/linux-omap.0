From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Mon, 30 Sep 2013 10:56:12 +0300
Message-ID: <52492E9C.4000901@ti.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com> <522F0F9B.9050705@ti.com> <522F1346.3020206@ti.com> <522F1BF9.5050006@ti.com> <523019EE.5000508@ti.com> <5232C413.8010207@gmail.com> <5232F85E.7050502@ti.com> <524544B5.9050402@ti.com> <52456B0B.9040502@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="BKm7noMCe4ah95CwMIp7LggECJKesvWFG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41123 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011Ab3I3H4R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Sep 2013 03:56:17 -0400
In-Reply-To: <52456B0B.9040502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Stefan Roese <stefan.roese@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

--BKm7noMCe4ah95CwMIp7LggECJKesvWFG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27/09/13 14:24, Tero Kristo wrote:

>> Tero, can you queue this patch? Or who should handle this?
>=20
> I can't queue anything as I don't have maintainership on any of this
> stuff. Paul / Tony should go with this.

Well, I mainly meant preparing a patch with proper description and
sending to relevant maintainers.

For some reason I can't reproduce the issue with 3.12-rc1. I guess some
other driver enables the clock now, which wasn't there in 3.11. So as
far as DSS is concerned, things look fine now without the patch. But if
the clock code is wrong, as I understood, maybe it's still good to have
the patch applied.

 Tomi



--BKm7noMCe4ah95CwMIp7LggECJKesvWFG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSSS6cAAoJEPo9qoy8lh71um4P/1cNVUPcKfbln/Ki9fgZoKph
l+QKoephABRg9zojKhgywSGzGGeOj/GtqP2hHmXIJ34aXqc5Z6rJT5SpFAFW1ifO
oo9QCbAoqYRPQ5ywM34uQPb5mjT8d+P658miDd6TNKQAVlMeXlmEVm+JKs+luqYD
pC/eAAhD+sBJZPjBEIBjRvpWdM0UEJ7jOs1jTpwfMX3ChUIcYXrtC+eOyAahNYA+
sXA9J+H9P+w/h6pOFIkpfQbDtLAcsEuHHniCZtpdNqAVD3es2cd/nfDFBAH5MOxX
9hz5I7jUW0UMQ75V5IJxqv9ljZ550WzuzTaQyBFnfJ+DgofpYFW0wTUdHIxnL2Vj
Ri/3bNRxsFYi/ZVXgWuv8E0ZrXcRCLITzbmiBPgDzt1lghurYisS+jgkuDR1lzKd
6M3UkuwOWDg8fwaZD+nYQR3I6n5diQg+XZAX/ypZ4pkxA1krWPubsZgq2o4a5Nvl
8yE50Ewi+9iVicsouMf86Yemy0s3NTeBuLS+VQUINZyHlRD7kUVsKj8DRw8h1B4A
Oa6kVYsbGrd/3vFkpL6uSD7J1knmVwAE6OXfMJrcxtxV2NJLbhe+cUbIMXlPSmJG
PFX0BF66uLo20SBJ374iZL5yKiiYDXtMv7Jg2fXuriV0/GFgtV1ycKrfKxd4su8Y
Nm6/aeViq6tMYSOP56Qs
=0wh5
-----END PGP SIGNATURE-----

--BKm7noMCe4ah95CwMIp7LggECJKesvWFG--
