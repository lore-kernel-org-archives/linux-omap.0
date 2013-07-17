From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Wed, 17 Jul 2013 11:20:23 -0700
Message-ID: <20130717182021.GA24079@dhcp-172-17-186-34.nvidia.com>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2883016.87pKJk9n0R@avalon>
 <51E4C073.4020407@wwwdotorg.org>
 <2989497.8E7gzkcamn@avalon>
 <51E6D037.3020706@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:53264 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab3GQSUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jul 2013 14:20:31 -0400
Content-Disposition: inline
In-Reply-To: <51E6D037.3020706@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Grant Likely <grant.likely@linaro.org>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2013 at 11:11:19AM -0600, Stephen Warren wrote:
> On 07/17/2013 05:00 AM, Laurent Pinchart wrote:
> > On Monday 15 July 2013 21:39:31 Stephen Warren wrote:
> ...
> >> But then there's a problem where people assume that the common flags a=
re
> >> always available, and somewhere they aren't... Care is needed in the
> >> choice of which common flags to define and/or how they're used.
> >=20
> > Exactly. That's why I think listing the supported common flags in indiv=
idual=20
> > bindings makes sense when some of the flags are not supported by all de=
vices.=20
> > As the only PWM flags currently used are common to all PWM devices I ca=
n leave=20
> > this out now. I have no strong preference, I'll follow your opinion on =
this.
>=20
> Yes, I guess separating the concept of defining common flags and which
> devices use them is good. And then indeed individual devices need to
> define which of the common flags they support. I'd still like to see the
> *definition* of those common flags in some central place (i.e. pwm.txt
> or a header that defines constants for it), and the other device
> bindings simply reference that for the actual definitions.

That sounds reasonable to me.

Thierry

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR5uBlAAoJEN0jrNd/PrOh97QP/1xi4cp9qXADN5RzJzjIh0Qn
rAtMQCp2NggBKz0p3yueGufLiS1izARSOb13uDJUWeFsikVyhGYng8i3ZRrlaoVA
ktBoZf5CuSGmqKyURzIBEjc1nxAj4V9H0pKrpinj2XsDBKcVsmjjVHzQRu/tDnXk
J5GKDgdl2wTwTHmg/9zrYVcuJsOuCPNm2YsGcAaR/7dL9fNHTgfhsrqTANXU+Y7Y
M1IdG3etDvFrGlDTTnYXtYpDnr49VOuGL3KrFeYaFeQIVAKN+kDbGe2WR2F3O22E
lDek6DW4hNRgLKdJIwSGIcEDw8AzcKpKHicn3DNvQQtnzzLJ4vNShJzIDfxlj0qg
ptoOjnz1MB2dsyShOI0z8PvWdhseMndQ5wpXveeJjZ5Ck46USCl3NaysTtmZPYjd
saabdM/E85g5HQZ79sggqg0st2P3l5TsEFFJ8Ie41ysf6kp8ofXYG8H/OiaAapKz
hysfTGj6tgtY9jorIO3YdkZX59ALQikfFjawUzFQ4onYcXLymkyHUQI4i20k/wVo
VQ1SIWbZ8aofbA5kqvdNH/ZSMl8uMgRLrUtd1EPx0scS6F1mf9GvQ/S6q0PKdQGM
k0yxqk0YWkFtnzM/ccrpI5g29I6mnXiOUTlFSM3V12JAW4+kh6lF7V+m2tRWft3+
aCEjtkBeqFwvYE+oJezc
=+FHU
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
