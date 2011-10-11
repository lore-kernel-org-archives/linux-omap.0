From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH 7/7] arm: omap: smartreflex: micro-optimization for
 sanity check
Date: Tue, 11 Oct 2011 15:19:23 +0300
Message-ID: <20111011121922.GM10155@legolas.emea.dhcp.ti.com>
References: <1318249579-4089-1-git-send-email-balbi@ti.com>
 <1318249579-4089-7-git-send-email-balbi@ti.com>
 <4E9426F9.2080601@ru.mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+2GlJm56SCtLHYlr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:33416 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942Ab1JKMTe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 08:19:34 -0400
Received: by bkbzv15 with SMTP id zv15so10291678bkb.32
        for <linux-omap@vger.kernel.org>; Tue, 11 Oct 2011 05:19:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E9426F9.2080601@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>


--+2GlJm56SCtLHYlr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2011 at 03:22:33PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 10-10-2011 16:26, Felipe Balbi wrote:
>=20
> >val&&  (val !=3D 1) =3D=3D val>  1
>=20
> >Signed-off-by: Felipe Balbi<balbi@ti.com>
> >---
> >  arch/arm/mach-omap2/smartreflex.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> >diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/sma=
rtreflex.c
> >index 7bdabfa..4b0d6a8 100644
> >--- a/arch/arm/mach-omap2/smartreflex.c
> >+++ b/arch/arm/mach-omap2/smartreflex.c
> >@@ -866,7 +866,7 @@ static int omap_sr_autocomp_store(void *data, u64 va=
l)
> >  	}
> >
> >  	/* Sanity check */
> >-	if (val&&  (val !=3D 1)) {
> >+	if (val>  1) {
> >  		pr_warning("%s: Invalid argument %lld\n", __func__, val);
>=20
>    The format specified should be "%llu"?

and what does that have to do with $SUBJECT ??

--=20
balbi

--+2GlJm56SCtLHYlr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOlDRKAAoJEIaOsuA1yqRE5C0P/RzJwgqIHFXQwzjjY30XCEYn
nZRLxiSrSvtLcjM1MI9cHsalG0p3mhq2Z+hWWp6a5Qq/r1alfCBrm97fhvLTegpl
+QbXl+LKciQuoWFHtzyGkucN54xKMehy8NC/zeQCzvUVTGbQ32gf7pvudzByWuJQ
2Rj4sYiqhu/+gBj1oAiS+KG6O3o4XlyvQL+0djLCUR73rVJqnNjvOhyrfHKuPmGe
a+/gTqH2orx2uPLqtUaf6zFilQZYZxzIFdYJq1urmBxtBjTbtgpqTxikrmWbbYLQ
nOn0bqcs9cmiF5FSyTv7bPxCHMn/+wpaqluIxJofqj7QKPu0x7vo4iz75lEa7jkd
rzznxQ3JTacu5kscXf6rv6p1AGUEaYdBUc2EJdEkp7fN3SRcjc6eBFapmlVOxv/t
DoaGcqtJ77vUNRH5FCcEeAMf/TXmjdEAq4a4/VFB9FFFPkoHFeysHaW2iFWHfOYD
93QYDwWFWPKohonLC1yE93//Wbh1f3PVucLuIz87KYwbEcV33/HjVxRgHvNjxfWH
F0lBdouNrGHDvvQtzOqMkfq5R1ioz74Jsxr8RI6Us2m5foLhFAe/0UdNp+SvzSjm
hb4uPBiPnaYXxO6IAsIGYox+VedATZ4D1bazGypO5xMyIQyomuo41EcXxN+AJe3s
Jjq5oaLCyGmT5NVl2g02
=eOT0
-----END PGP SIGNATURE-----

--+2GlJm56SCtLHYlr--
