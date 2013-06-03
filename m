From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Strange OMAP3 LCD display regression - bisected.
Date: Mon, 3 Jun 2013 10:39:02 +0300
Message-ID: <51AC4816.7050807@ti.com>
References: <20130602165019.655da2eb@notabene.brown> <51AC44A2.8050605@ti.com> <51AC46D4.9020503@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2JKSQPPPNDQAWCQLCMCOC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56275 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab3FCHjI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 03:39:08 -0400
In-Reply-To: <51AC46D4.9020503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: NeilBrown <neilb@suse.de>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

------enig2JKSQPPPNDQAWCQLCMCOC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/06/13 10:33, Rajendra Nayak wrote:
> Tomi,
>=20
>>
>> Odd, indeed. Without reverting the patch, the DSS uses a clock from th=
e
>> PRCM as func clock and for pixel clock. As the common clock framework =
is
>> somehow involved in the breakage, maybe (pure guess) something related=

>> to the PRCM clock is configured wrong.
>=20
> So whats the specific PRCM clock thats used here? I can go check if the=
re is
> something different in the way its modeled with/without common clk.

I don't know which OMAP version we're talking about, but I guess it's
OMAP3xxx.

=46rom the TRM, it's DPLL4_ALWON_FCLKOUTM4X2 for OMAP34xx and OMAP36xx.
Although that is a bit odd, as I think the x2 is only for OMAP34xx.
Maybe the clock name is wrong for OMAP36xx on my TRM...

 Tomi




------enig2JKSQPPPNDQAWCQLCMCOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRrEgWAAoJEPo9qoy8lh71+D8P+weSzZ5++XiouJjmAaZhq119
byq+9kY/LRfWPUcqE/8n1pfToCDp7GCe8sqjqEFvtxC8VMlj0otYqHqOoFGZhTyo
sMZ93hWNXZrB5nwNyA0JbJhadiKEqG4KlH+3H5klzzxS7sYtxV8JInn10VstSqnn
y1a8h5AUCqVSDLdkuox3rP13T5pyz1J4F3ixUSsuZ3GyrCp6auNHGM42cBUC3zED
WqNaK28EvZ0HbYiw6GJcPoB4JJTn0PiFDOfepZAZpxYejNz/2vPFigcisi06iWhO
OC0hhExVqRO3GRKZll7PR/LLELg9KHrOBX3Z0wwBaMtWoQHy24JAjxtahhSuIqxl
XuqtHhN+cNCPASBP+y0muLPrjqNMlSV7UKiWAlwVxqRFEpYF6rs3MGA9F8Eutu82
scT32SZTj/4TqaZ3PrapV9Vxia24t0RBT5+yuFVesPqGEAn6EIgZbYp07KXck5nu
erE0R4TMak27Ot9Wsobu5YVcNLLFatDPo14ZikWGGPMz2hdGy6KNqltz76bAQz7s
Ka5YKdx+inbocbPHEfB+xGqOGQKZSgaQ41WhAczT89ysBwVtsSFtrLbJYxRASn95
/FQPJKxgVO9D/wYvEgf3obXLNiAzMF2piVPGNQfrJwkGd4ka2vMdxErg8MYEyKhi
9z+2A4epKbmThjIzBmIr
=HHgJ
-----END PGP SIGNATURE-----

------enig2JKSQPPPNDQAWCQLCMCOC--
