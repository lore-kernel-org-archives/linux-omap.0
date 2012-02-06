From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: Features: Maintain dss_feats as a list
Date: Mon, 06 Feb 2012 12:42:23 +0200
Message-ID: <1328524943.1898.38.camel@deskari>
References: <1327900959-29198-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-R6sTr4EDDnKZHApkvFSc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40328 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754185Ab2BFKm2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 05:42:28 -0500
In-Reply-To: <1327900959-29198-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-R6sTr4EDDnKZHApkvFSc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2012-01-30 at 10:52 +0530, Archit Taneja wrote:
> The number of dss_feat_id members has increased to a large value, the cur=
rent
> way of assigning a subset of these features (for a particular OMAP) as a =
mask
> is no longer feasible.
>=20
> Maintain the subset of features supported as lists. Make the function
> dss_has_feature() traverse through this list.

I think this makes the code easier to maintain, so in that sense it is
good. But I do hesitate a bit, I think many features are checked in
often used code paths (the configuration done on each frame when
swapping/panning), and bit compare versus finding an item in a list
could have performance impact.

Then again, I'm purely guessing here, as it could well be that compared
to the other code, checking the features is insignificant. Thus, I'm
fine with this patch, and we can optimize it later if need be.

However, I'm anyway giving a few ideas how this could also be handled:

- 64 bit mask. Would be simple, but we'd still have a hard limit there.

- Variable length bitmask, i.e. an int or byte array from which a
particular bit is checked. There could be a ready made datatype for this
in the kernel.

- Lists like in this patch, but in sorted order. Then, if we're looking
for a feat which has, say, number 4 assigned to it, we can stop
iterating the list when we hit a feat > 4 in the list. Quite simple
optimization, but needs extra maintenance to keep the feat lists sorted.

 Tomi


--=-R6sTr4EDDnKZHApkvFSc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPL66PAAoJEPo9qoy8lh711YYP/0CptROhzbVsda3e7jV16KXC
id4qAqpddQgkuD1zr8UYLnYtSSXByA2qjEeVewLds3yRbN1iDzUQziHIuXVGtWVB
Rmf/wnlFWvTFYo06jKZQ2dXLpHSDURZl7VFvVcokFL2+GF8Wo47rWAZkWM2fOQjh
v4x5noRX4jTZtntekx76MSIoV7JeGqouqkO4ehfzz3br81zlbuwzKNVNuglShSSU
sOq5FTHZVfQnt4jQWFccZ6o9S9q8kQ1LVjM8reB502gTrksRVflqdSRs96uzQ516
3yh2Cq8LuHFRxeJL/3z4eZTS1Nbc+voargLbdZlAxVQca6RRdREUYZOoGLPpYLa9
KTHaAfdFBsW4khTQyZruVsv609sEpravxggaOLFI7JAqWWug1KTFanUq8ueCa6Jq
pMu4a5bgBwn5E4LEMDcjuJFDBYreFEGAnuwix3Ld47ivG5f2Jqe8MF+ftWM7LtSx
+qdmaOuE3nc0ueQlmPSMHdmYoY2+G0kLFRp7ShYLM/hIUEO/k+Z0tebtAmgnLwRT
d3c5jIIbCRbqc2V9zm4sYPxrgw19BYpMeFttrE57Sz4pScYtKxHOzcAGjLKmCvTG
XcQ4vUkeHSwJNff5hcxzCH9eBh793OTgjGHuLft75gdhlm5YGBtNs5ZPV/sYJEGC
FBFr1aw0ByumUJxdMB+b
=HJcS
-----END PGP SIGNATURE-----

--=-R6sTr4EDDnKZHApkvFSc--

