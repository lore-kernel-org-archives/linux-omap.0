From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
Date: Thu, 30 Nov 2017 23:06:33 +0100
Message-ID: <20171130220633.imkfyeiqtftnw4j4@earth>
References: <cover.1511884135.git.hns@goldelico.com>
 <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
 <20171128160437.GD28152@atomide.com>
 <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E@goldelico.com>
 <20171128161834.GE28152@atomide.com>
 <4EE1E298-6461-48FF-977C-958DD16AD83A@goldelico.com>
 <20171130152430.GM28152@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1525431231=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171130152430.GM28152@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============1525431231==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nt4vnptky4atvscp"
Content-Disposition: inline


--nt4vnptky4atvscp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 30, 2017 at 07:24:30AM -0800, Tony Lindgren wrote:
> * H. Nikolaus Schaller <hns@goldelico.com> [171128 18:35]:
> > Hi,
> >=20
> > > Am 28.11.2017 um 17:18 schrieb Tony Lindgren <tony@atomide.com>:
> > >=20
> > > * H. Nikolaus Schaller <hns@goldelico.com> [171128 16:17]:
> > >> Hi Tony,
> > >>=20
> > >>> Am 28.11.2017 um 17:04 schrieb Tony Lindgren <tony@atomide.com>:
> > >>>=20
> > >>> * H. Nikolaus Schaller <hns@goldelico.com> [171128 15:52]:
> > >>>> We can remove the unnecessary "omapdss," prefix because
> > >>>> the omapdrm driver takes care of it when matching with
> > >>>> the driver table.
> > >>>=20
> > >>> So is this needed as a fix or is this another clean-up?
> > >>>=20
> > >>> So is this is really needed as a fix?
> > >>=20
> > >> Hm. How do you differentiate between "fix" and "cleanup"?
> > >> Maybe it is more a wording than a content issue...
> > >>=20
> > >> For me it is a "fix" because it is semantically wrong to have
> > >> a prefix where it is not needed. And "fixing" it changes the
> > >> compiler output by 8 bytes.
> > >=20
> > > How about let's call it a "typo fix" then? :)
> >=20
> > Well, it is not really a typo.
>=20
> Well what if the stable people pick it into earlier stable series
> based on the word fix in the subject? That has happened before.
>=20
> I suggest you update the dts patches to use wording like
> "update compatible to use new naming" or something similar.

Patch 4/4 is a Fix and should be applied to stable trees. "omapdss,"
prefix was never supposed to be in the DTS files, is not supposed to
be in there now and will break some time in the future.

Explanation: The early init of omapdss adds the prefix at runtime,
so that the binding can use generic properties and the kernel can
use omapdss specific drivers until the generic ones can be used.

-- Sebastian

--nt4vnptky4atvscp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloggOYACgkQ2O7X88g7
+poY8w/+LukAeMDv10ezogc+xAbg7rWzErh43W2ZI/pibY0rEKuuq0yNmYsyjzov
tfDTL91fM8soDgX2+rG1E4NOdZgolNqsqbvAB4TXWrzW0ORyjdbG+D2/1rgKBfY+
h8Dn/66QNuUd6+eTx+6AANgMzjNzHLRJwoM0eISYFCU3L6EXB8YFqoXApUqY5LBg
do3v5DFqO+6obHUGJ8oJTjapCIEiIMsQ4DLFbLPIiAAJY48yNt8oWzRldcIDEzBp
s1Cs7M+Zi5PbZDl8Q2YC19Q4YcMONR03VK3W+98T6P9dl0+Al0UW1YQhw3ZaqVih
juCgcINTbVIgxI0ISzfJfiNOmOea5lLp8o++upAhhsnP2tEZHjyGe97OAc8S+ETx
a8mjNYtKsFvBVHsh/d52PIa+H7NoW3UBkQWZsxyfpzqhibJAAN5O4DJHQXpdq7uM
ce4IOR/LK7RDIGhTneW2vR//fwBMYWrQspfYTvx24N6mqe/gyw3PnYQjAsJNSXjC
YBA4T99apk6BuXiRNzM7mpbUjOKrgGNUtBQKAKD9YUcAm+HfxMPdBiAwQFHlLpVX
+BMBxARqPy3gHGoQtUyg/TlTVHRPbaF0uhQLoXuBG7Awe5CqK0BE4+Dht8ogLIQ4
4FAn98DRUhlOEs724cOGwA4DlTdBziaGuSaE9Q4r/1IuhLGaUXw=
=LhAU
-----END PGP SIGNATURE-----

--nt4vnptky4atvscp--

--===============1525431231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1525431231==--
