From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 3/4] ARM: OMAP2+: add legacy display for omap3 DBB056
Date: Fri, 14 Feb 2014 16:35:43 +0200
Message-ID: <52FE29BF.9040307@ti.com>
References: <1392387656-15186-1-git-send-email-chf.fritz@googlemail.com> <1392387656-15186-4-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="0IPKaTqtmAitIxMGBUPfN13osjBusFdcI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54519 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbaBNOgT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Feb 2014 09:36:19 -0500
In-Reply-To: <1392387656-15186-4-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: bcousson@baylibre.com, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--0IPKaTqtmAitIxMGBUPfN13osjBusFdcI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 14/02/14 16:20, Christoph Fritz wrote:
> Full device tree support for omapdss is not yet accomplished. Until
> then, init display by legacy platform code.
>=20
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  arch/arm/mach-omap2/dss-common.c   |   49 ++++++++++++++++++++++++++++=
++++++++
>  arch/arm/mach-omap2/dss-common.h   |    1 +
>  arch/arm/mach-omap2/pdata-quirks.c |    8 +++++-
>  3 files changed, 57 insertions(+), 1 deletion(-)

I'm not nack'ing this, but I'm again hoping to get DSS DT support for
3.15. I haven't done any bigger changes to my branch for some time now,
and I'm just waiting to get some comments/acks for the bindings.

So I suggest to also try out DSS DT for your board, based on the latest
DSS DT branch:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt=


That way you have it ready and tested if DSS DT goes forward.

 Tomi



--0IPKaTqtmAitIxMGBUPfN13osjBusFdcI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS/im/AAoJEPo9qoy8lh71fwsQAKK7Ji5aWGdM4uKddovDuJUw
n5TX66IB6VpAvWK5qC9CeAqm4LFby0wdJ/RNJE7z3I466SxHE5hAZkbKux4H0+0K
KcCmDegglqmlfXL04F1g+ZWvWBJgKUdzaCtgjzuapdyqRIgPSiPpd1qrR6w6NC6M
+9sX+MrofS+4c3bsLvoTgPEcv4N65/S5YfynvZgBVEGD7J5XimZivPYgmcuYMSgt
gJHuZ2U5+PtK+qFYkcgaFmELhZmvo0JwprYqpL1wnJBFj3MSI4ODfyIMtzygjSi7
DBiBOGyRx7FGOy7gH8NLksFhqAX0YppyXdbOMS3pGW1DUs5J92g6oGm3Nm5gx1X4
/RWxItfLSnKpZx6BZ17Q1y0xzNqjyWlAcbE3f4k77Iz8GF2bCiSifY3cUyKAE/0O
0pEy94lzOvW3UlRHRJJC3lPyJsH9xWxAh4t/aJy3FYNYvJmslGEQF7WsCQWezmdV
sTN2dyYUVaDVGjKTE1/XJj+QKufJICGVSOX5v48ePMcnXGFLf1fp2CiFl0n99fS4
G9vyZpvZVPeX4m00Meo6az+02K40FqoLeF1rOaFozDcodmxLb0H+kDza0oR67HC0
EU6FPeD0Fv3BGuO9KQDXQM5Pm+NcF3XscYvSk8RUonyWyOOBBKEgxgPhec6AMhA5
IGp9WwAtduD5g7bqSt2e
=2UK5
-----END PGP SIGNATURE-----

--0IPKaTqtmAitIxMGBUPfN13osjBusFdcI--
