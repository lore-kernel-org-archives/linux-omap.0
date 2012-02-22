From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: DSS: Add runtime_pm protection around
 wait_for_vsync.
Date: Wed, 22 Feb 2012 08:49:20 +0200
Message-ID: <1329893360.1891.1.camel@lappy>
References: <1329833192-16529-1-git-send-email-archit@ti.com>
	  <1329833192-16529-4-git-send-email-archit@ti.com>
	 <1329840498.2090.36.camel@deskari> <4F4480DD.1000502@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-HmcREuGiuDH9LoKfkf2f"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:57741 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752058Ab2BVGtd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 01:49:33 -0500
Received: by mail-lpp01m010-f49.google.com with SMTP id g1so10826972lah.36
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 22:49:30 -0800 (PST)
In-Reply-To: <4F4480DD.1000502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: lajos@ti.com, linux-omap@vger.kernel.org


--=-HmcREuGiuDH9LoKfkf2f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-22 at 11:15 +0530, Archit Taneja wrote:
> On Tuesday 21 February 2012 09:38 PM, Tomi Valkeinen wrote:
> > On Tue, 2012-02-21 at 19:36 +0530, Archit Taneja wrote:
> >> From: Lajos Molnar<lajos@ti.com>
> >>
> >> If DSS is suspended during a wait_for_vsync operation, it may loose it=
s clock.
> >> Request runtime_pm around wait_for_vsync.
> >>
> >> Signed-off-by: Lajos Molnar<lajos@ti.com>
> >> Signed-off-by: Archit Taneja<archit@ti.com>
> >> ---
> >>   drivers/video/omap2/dss/dispc.c |   16 +++++++++++-----
> >>   1 files changed, 11 insertions(+), 5 deletions(-)
> >
> > This only handles omap_dispc_wait_for_irq_interruptible_timeout(),
> > there's also omap_dispc_wait_for_irq_timeout().
> >
> > However, I think it'd be better to do the runtime_get/put in the caller=
,
> > instead of in these dispc's wait funcs. While it doesn't really matter
> > with dss_mgr_wait_for_vsync(), for dss_mgr/ovl_wait_for_go() it makes
> > much more sense to get/put there just once, instead of every time the
> > omap_dispc_wait_* is called.
>=20
> Right, that makes sense. Btw, in the current code, how do we ensure that=
=20
> clocks are enabled when someone calls omap_dss_mgr_apply().

We don't. Apply does not touch any of the registers if the corresponding
manager is not enabled, so there's no need to enable clocks.

 Tomi


--=-HmcREuGiuDH9LoKfkf2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPRI/wAAoJEPo9qoy8lh71nqIP/0nDTohouMZkhfah5DQWucqu
jvLz9taqev4a6fN7s7QsRjLTzOwATChm4J6kc2YWk4jexkAuPYjqEP5Mt00rdmcd
iOLMHW33uAuYXl1nJIOcZ2VebAlfB0yzON9wRLiEU72YS5ln3bCQu04IXq1SbHMH
dVr6ymNQcnddiWF0q682CRdE5Kw54EIVrfHL7n/uHH21miTY9PXcSQTYM1PVMODn
HTtoe1KjKsiCW4KCJ516EU9cemxWU2rUYUIWAg89XWM9gJFhHYF8kfWy2UsW0HNX
LTiNGsHo1l335cvhwXcKRgyAVRfCnziOOFxvdo2ZFzYIhWBsyDVNKHxSODKDZ2z0
ayez7kwVBwS2lPOPBX8OkNpNYJmTzPMTnFJ0LDxiP4WzkkBFC/89IbvzHqBhdlP8
Sb84rCwgAL4p2JbE86J+foRF2u35Jimj9cvF40LtEuzltu2QOVmvOjPGC5fttYmE
1ryXt1Th1WYJBdLSPyK64TY6qzj2QRqwQyB4ud5B7BSnfzJlB48hzH9J1UbnJRtw
Sl0+/+k35tTkEYmULfBM6Prc/FQWBif2m4L4A9rjTR6pp3g9qMdHh9AILlM7XrVe
TECvZbV+/N5NSlejUM8mMcuCi1I4G34ijB4gnaB+qdOouKaPOem39LspO+kaPZ9D
b6w5dhIiYnQHh59pgWA/
=7XIB
-----END PGP SIGNATURE-----

--=-HmcREuGiuDH9LoKfkf2f--

