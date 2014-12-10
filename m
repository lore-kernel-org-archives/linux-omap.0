From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 4/7] arm: omap: device: add support for generating
 sysconfig data from DT
Date: Wed, 10 Dec 2014 08:48:55 -0600
Message-ID: <20141210144855.GB4602@saruman>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-5-git-send-email-balbi@ti.com>
 <54882522.20002@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49987 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757781AbaLJOte (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Dec 2014 09:49:34 -0500
Content-Disposition: inline
In-Reply-To: <54882522.20002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "Kristo, Tero" <t-kristo@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

adding linux-omap back

On Wed, Dec 10, 2014 at 04:19:06PM +0530, Lokesh Vutla wrote:
> > +	switch (prop) {
> > +	case 2:
> > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type2;
> > +		break;
> > +	case 3:
> > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type3;
> > +		break;
> > +	case 1:
> > +	default:
> > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type1;
> > +	}
> Missed hooking the class to oh?
> 	class->sysc =3D sysc;

yeah, I'll fix that.

--=20
balbi

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUiF1XAAoJEIaOsuA1yqRExbwQAJYDr9vjmAZt6DN7+y6K6N6A
ForSP+7FRtzy+wa4yls7Q6X0lsHQeFaC4ODB9+afErn/9lxPo4ffPj1Nym5SwlaJ
XA3eTMS86kh+Wjbj2QxIDlp/rQxze4ZOjXQbzDFqivF2ZfAlQCgEvDGd2Mk8sZzd
5nZNtIqlvUTGuJGhcyxleis1BvJXr9zZPFsZUI1BKpCvojGHQ5OuSzVeL1/F0ath
TevB3P7CItFqkvG8bVmZg4SC3L7v/UMhwiaIZlCg5OcW/PBT6hTPySFj7grjBSjO
4Rl8Tj7haoXpAHUJGioJfVWaqD+MEDIzEkvWc/g4LhEVqNeyigQxqXxabGasE5Mb
5p8q1+inz91EEwvs+bys998R0QVuj4Wrniwr/rS0CNsRATmtAs9ApufQnjr+tQq2
ljb+iU4q3YzQ1q+hoVsn141ii4SVzHg1Hs+5dIGbfDQyk99WQtHsYBGnjlabEPmi
uo3QIFFAjH7/hJqNYL9FonTQFOr+boswDegs2iWMQXiFCcQGeLHBnpuvCws1QZKJ
JljKOEPg4jxd14qZxl1nlx7vNBFvQEPKWUZxlHhzMifo3VTx6AtiGxpzg4Zn3VsV
QvTeaPwBVpuR2oQdhdKhuZyOVp/wrPTThxm3vgVEWJVXWwL2kOEmvsHzl5s3Cz48
WA3e7XWZvEqlN4P2Tauv
=TVr8
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
