From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Revert "ARM: OMAP: ctrl: Fix CONTROL_DSIPHY
 register fields"
Date: Thu, 19 Apr 2012 14:05:52 +0300
Message-ID: <1334833552.1911.20.camel@deskari>
References: <1333955479-2675-1-git-send-email-archit@ti.com>
	 <1334736386.1886.8.camel@deskari> <4F8E77BA.3000507@ti.com>
	 <20120419093158.GX25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-xoTTLu5MefcjXV2DYPow"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:38544 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753767Ab2DSLF5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 07:05:57 -0400
Received: by lahm13 with SMTP id m13so6114321lah.9
        for <linux-omap@vger.kernel.org>; Thu, 19 Apr 2012 04:05:54 -0700 (PDT)
In-Reply-To: <20120419093158.GX25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Archit Taneja <a0393947@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, paul@pwsan.com, b-cousson@ti.com


--=-xoTTLu5MefcjXV2DYPow
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-04-19 at 10:31 +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 18, 2012 at 01:43:46PM +0530, Archit Taneja wrote:
> > On Wednesday 18 April 2012 01:36 PM, Tomi Valkeinen wrote:
> >> Hi,
> >>
> >> On Mon, 2012-04-09 at 12:41 +0530, Archit Taneja wrote:
> >>> This reverts commit 46f8c3c7e95c0d30d95911e7975ddc4f93b3e237.
> >>>
> >>> The commit above swapped the DSI1_PPID and DSI2_PPID register fields =
in
> >>> CONTROL_DSIPHY to be in sync with the newer public OMAP TRMs(after ve=
rsion V).
> >>>
> >>> With this commit, contention errors were reported on DSI lanes some O=
MAP4 SDPs.
> >>> After probing the DSI lanes on OMAP4 SDP, it was seen that setting bi=
ts in the
> >>> DSI2_PPID field was pulling up voltage on DSI1 lanes, and DSI1_PPID f=
ield was
> >>> pulling up voltage on DSI2 lanes.
> >>>
> >>> This proves that the current version of OMAP4 TRM is incorrect, swap =
the
> >>> position of register fields according to the older TRM versions as th=
ey were
> >>> correct.
> >>
> >> Are we sure the bits are the same for all OMAP4 versions? I'm just
> >> wondering why the change was made to TRM...
> >
> > I've tried on OMAP4430 ES2.1 and OMAP4460 ES1.1. I can try on a couple =
=20
> > more revisions.
> >
> > As far as why the change was made in the TRM, it's a bit hard to find =
=20
> > the right people, or get response from them :), I'll give that a try=
=20
> > again.
> >
> > If we do conclude that this revert patch is needed, it might probably b=
e =20
> > a candidate for the 3.2 and 3.3 stable kernels, just wanted to point =
=20
> > that out.
>=20
> I was just going to ask about this, as I haven't noticed any improvement
> in mainline kernels since I reported the original failure...

It seems to be very difficult to find out why the TRM change was done,
and what the HW actually does. But as the boards out there are clearly
fixed by reverting the original patch, I think it's best if we just
apply the revert.

Archit, can you resend the patch with my ack, and cc
stable@vger.kernel.org (see Documentation/stable_kernel_rules.txt).

 Tomi


--=-xoTTLu5MefcjXV2DYPow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPj/GQAAoJEPo9qoy8lh71uqIP/RC0w1InBmqGwvFXTWp9uZpG
5a5DHhl1jgi5m8+mQWldiKwbVpT6xmDbGu6GEp7EdbdEMjWOe7zISBaOgS9JbE/8
wwesnsT+l3gnBtfHoWHTVWlYqbTVJ2s6ibXndGxn/aRzuD0qcqGH+LKLu8jPI3z1
Fe1wdxFSoh/buBy9OPwr5/tpf0NZu0EBtZdzN6CPkQjDTtu1dW7OV5F65oUx7mbp
yOZ2lEXgDqBqEfFaJMs5Qvd6q7mRMrWSUc42knV3u6mfIKVjwXK8dE8pvRv49MsJ
Q/hEquagHYg/hhNXgND7l50dsyS5M4GiG5XM0l+tkQIPGPcZzetH1qgWiXdx+DnU
927DcUZ/4zmNhf1dqEdJK7x62QX46ZFi1XAYR6/bG7eAMPJqhznSzXIAgdrS+QMC
asmFlCRWM710c9fMcS6s2/iDeDpRQQBuUl5taw9e9tVicIEQkq/rOB+wpHsWdx/R
/JsG+tNtf10QgWsxQrBa7p6ZO1zoLa4DBA76dNeXDVJPWKvxu7Omw2yPf9B2t0r3
jPMDSS0uQaC/MiOeYeI49W/lQgB/GHqOxFCfdvQoiLxTTqQwJpRV12brHFlOyE2N
hUitUj3sPZiOt6LcBuvTFciNhKeTV/nYA6tqYpIlBPigTQCbERZFY2JxZ5AqwKVj
JSxQUtjZN/gk5uQEXfvL
=L5KU
-----END PGP SIGNATURE-----

--=-xoTTLu5MefcjXV2DYPow--

