From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Thu, 02 Aug 2012 10:13:20 +0300
Message-ID: <1343891600.5767.12.camel@lappyti>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
	 <1343742034.2633.56.camel@deskari>
	 <CAF6AEGuqi+E7i1cuZTCts1y46E3SDUzd8E3kuW52=jRC5EksaQ@mail.gmail.com>
	 <1343812870.2645.37.camel@deskari>
	 <CAF6AEGuoVaOwwXnS3MKcoeKrtA3=Oi108jqM3iObd3EqTmC9Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-U3yKYTPVnM9foRvT2xF7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41907 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754161Ab2HBHNe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 03:13:34 -0400
Received: by lahj13 with SMTP id j13so4102816lah.25
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 00:13:31 -0700 (PDT)
In-Reply-To: <CAF6AEGuoVaOwwXnS3MKcoeKrtA3=Oi108jqM3iObd3EqTmC9Bw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>


--=-U3yKYTPVnM9foRvT2xF7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-01 at 09:25 -0500, Rob Clark wrote:
> On Wed, Aug 1, 2012 at 4:21 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:

> > I guess the fact is that DRM concepts do not really match the OMAP DSS
> > hardware, and we'll have to use whatever gives us least problems.
>=20
> Actually, I think it does map fairly well to the hardware.. at least
> more so than to omapdss ;-)

Hm, I'm not sure I understand, omapdss concepts map directly to the
hardware.

> The one area that kms mismatches a bit is decoupling of ovl from mgr
> that we have in our hw..  I've partially solved that a while back w/

What do you mean with that? Ovls and mgrs are one entity in KMS? Didn't
the drm_plane stuff separate these?

> For enabling/disabling an output (manager+encoder), this is relatively
> infrequent, so it can afford to block to avoid races.  (Like userspace
> enabling and then rapidly disabling an output part way through the
> enable.)  But enabling/disabling an overlay, or adjusting position or
> scanout address must not block.  And ideally, if possible, switching
> an overlay between two managers should not block.

Adjusting the position or address of the buffer are simple, they can be
easily done without any blocking.

But ovl enable/disable and switching an ovl to another mgr do (possibly)
take multiple vsyncs (and in the switch case, vsyncs of two separate
outputs). So if those do not block, we'll need to handle them as a state
machine and try to avoid races etc. It'll be "interesting".

However, we can sometimes do those operations immediately. So I think we
should have these conditional fast-paths in the code, and do them in
non-blocking manner when possible.

> I'll look again, but as far as I remember that at least wasn't
> addressing the performance issues from making overlay enable/disable

Right, it wasn't addressing those issues. But your branch doesn't really
address those issues either, as it doesn't handle the problems related
to ovl enable/disable.

> synchronous.  And fixing that would, I expect, trigger the same
> problems that I already spent a few days debugging before switching
> over to handle apply in omapdrm.

I was under the impression that the apply mechanism, the caching and
setting of the configs, was the major issue you had. But you're hinting
that the actual problem is related to ovl enable/disable? I haven't
tried fixing the ovl enable/disable, as I didn't know it's an issue for
omapdrm. Or are they both as big issues?

 Tomi


--=-U3yKYTPVnM9foRvT2xF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQGiiQAAoJEPo9qoy8lh715lQP/AzlLkn2PxuC7mGpT5YGZGPj
QYaR2BIKY79u6iIaybTqRlFvld3dsUC2lMOFiLkDhVfI4/x+tkIKq0577uV+Rj4Q
juth1yZiIIeu2t8q7r43kAa9shDy1gFfO0piPMc7c0pIOYInkGkUhNXL1Tvj9mGg
1v4J7N5k+4aXMOny2oUQ/pMhPx2Go1j4ly57TvGeYvBXFT5kXElTJvDGbbniUtIF
xOSmIi2V52KR2FtWHiZKi9qfCeTZL7LxiX05C5g9T7FInV47Nf7Kt97qYoE7oOrq
RVdDwfeASiByreZFE/MBHMCABWKb6mjfN6AtH3PVIYYG7A1JEqRIKH1prD9LOkox
vd/q0s8cNKcgiC2iizt8AR0oJbkjQQEdnAy78Y9D2XP1elZjPiN/yk/QMKem8/8F
mRX7OAKJLneKQ5I0Vxx+GP6VMRIPXJbvfPB5cylQcJVZ61M0pAmOWFJbWnQJSFPc
x8Y8jAYvyd/auCjkSXZAQdaeWckgYMseM9luHPoZbuJCW7Mjmv3ps/0qDbQa+llx
TEF6ixNeKlwaEPIEQX0RUyd8QKeDTJAkmIMAyekzYpBHYIKv0Qlk06AUGCOE/e45
JOAYzJYu2/PB46M+Yo3KdEfoIeZRvkco5ykKRiCgTFRkJiPsv9I89WnmtUTLDOXM
jkyP0mqsYqGS9OC26orF
=UREt
-----END PGP SIGNATURE-----

--=-U3yKYTPVnM9foRvT2xF7--

