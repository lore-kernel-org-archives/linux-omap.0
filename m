From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/4] Add PWM polarity flag macro for DT
Date: Tue, 23 Jul 2013 08:37:49 -0700
Message-ID: <20130723153748.GC2066@dhcp-172-17-186-34.nvidia.com>
References: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <51E81E1C.20708@wwwdotorg.org>
 <10033310.z2U2FSCElN@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:65337 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab3GWPh5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jul 2013 11:37:57 -0400
Content-Disposition: inline
In-Reply-To: <10033310.z2U2FSCElN@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris BREZILLON <linux-arm@overkiz.com>, Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Tomasz Figa <t.figa@samsung.com>


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2013 at 01:29:13PM +0200, Laurent Pinchart wrote:
> Hi Stephen,
>=20
> On Thursday 18 July 2013 10:55:56 Stephen Warren wrote:
> > On 07/17/2013 04:54 PM, Laurent Pinchart wrote:
> > > Hello,
> > >=20
> > > Here's a small patch set that replaces PWM polarity numerical constan=
ts
> > > with macros in DT.
> >=20
> > The series,
> > Reviewed-by: Stephen Warren <swarren@nvidia.com>
> >=20
> > I'm (very very) slightly hesitant about patch 3/4, since it's moving to=
wards
> > all PWMs having to use the same specifier format, whereas specifiers ar=
e at
> > least potentially binding-specific, not device-type-specific. However,
> > consistency is good; there's no need to do something different just for=
 the
> > heck of it. Equally, there's nothing actually stopping a new binding fr=
om
> > defining its own format rather than simply deferring to pwm.txt if it
> > absolutely has to, so I think this will turn out fine.
>=20
> Exactly, that's why I don't think it's an issue. pwm.txt defines a common=
=20
> format, individual bindings are free to use it or not.
>=20
> Thierry, if you're fine with the patches, could you take them in your tre=
e=20
> with Stephen's Reviewed-by, or should I report them and send you a pull=
=20
> request ?

They look good to me. I'll take them into my tree and add Stephen's
Reviwed-by. It might take me another week, though, as I'm currently
rather busy with other things.

Thierry

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR7qNMAAoJEN0jrNd/PrOhadoP/1Zy5D/e2IWjPEIb81W7pXax
w9miYMx8jARl4x4OhdQmWqT36F9Ne/b3Auk1qNBNUrDESjazDtAWfxN6WrwO80IE
sORDvyK0G75HLRByjR3kwtoM8Hs+F9jR8wYN7ptiYhqAdQBdlSTF1nAOX77EBMGj
/Vqrf0Dr9+gGt2n3AWSShV8MG54Sa/SU8tGoO+4pfvywuK2Wu4s0ApRz6yUZ7gX4
9wHHw4OF6nn6feyF6Yo56nFsgmis7MOfXDt3UJem1qoXNPykREpWL/UJxTvN/0fY
CIBDrAQgtuAwTTGpceVzK+DAIi5O4ZYj1kxn0McaEyl+rf1ieXPS3EnsY0zPaOaV
Q/PntIArP67nRYDBJzJTsZ352ldULfE+oU8izvk33GxDwIdEMUCcBGBGM8MkU4iB
wbIZ/ZG83bsH1zieppQU841UZVlgvNo2wVEiPMfUDWZSqtTjygrOth3o1EjGtsPE
QMT8iF3VoK74Fq0Bl44l3d7YZYoUmQK5zYmeDnPgSh58n9udPPlObBIaX8EY5x9Y
Uxr459Z7n9hR+5TQRwMoIf2ZNT7b9VRlnUum6XRBMb0xmvRm/9jjw+wbhDSbSQdA
Xg/lf3UIdoeR0dcvEQg/02C+xQTSoWXqf9QPwTU88eNMWyJY8IvMwKm3U0RSfqfV
eAebYYwZURBeNqBtyrD9
=s7ML
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
