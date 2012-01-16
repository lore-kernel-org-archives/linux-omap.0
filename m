From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/6] OMAPDSS: DISPC: move fifo threhold calc to dispc.c
Date: Mon, 16 Jan 2012 11:57:41 +0200
Message-ID: <1326707861.1875.1.camel@deskari>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
	 <1326455193-19716-6-git-send-email-tomi.valkeinen@ti.com>
	 <4F108D7A.4010802@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2hRMofbc/SOOrIt34o91"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:44348 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750927Ab2APJ5t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jan 2012 04:57:49 -0500
In-Reply-To: <4F108D7A.4010802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com, rob@ti.com


--=-2hRMofbc/SOOrIt34o91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-01-14 at 01:30 +0530, Archit wrote:
> Hi,
>=20
> On Friday 13 January 2012 05:16 PM, Tomi Valkeinen wrote:
> > Move fifo threshold calculation into dispc.c, as the thresholds are
> > really dispc internal thing.
> >
> > Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
>=20
> <snip>
>=20
> > diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/ds=
i.c
> > index 511ae2a..1cbb7a5 100644
> > --- a/drivers/video/omap2/dss/dsi.c
> > +++ b/drivers/video/omap2/dss/dsi.c
> > @@ -4524,14 +4524,6 @@ int omapdss_dsi_enable_te(struct omap_dss_device=
 *dssdev, bool enable)
> >   }
> >   EXPORT_SYMBOL(omapdss_dsi_enable_te);
> >
> > -void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
> > -		u32 fifo_size, u32 burst_size,
> > -		u32 *fifo_low, u32 *fifo_high)
> > -{
> > -	*fifo_high =3D fifo_size - burst_size;
> > -	*fifo_low =3D fifo_size - burst_size * 2;
> > -}
>=20
> We are removing the special treatment for overlays connected to DSI done=
=20
> before. Won't this cause the issues you saw with DSI in OMAP3?

That's true. I had it in mind at some point, but I seem to have
forgotten it.

The problem with OMAP3, DSI and fifo thresholds was never cleared, and I
haven't seen an errata about it, so there's a slim chance that it was
only a problem with the particular setup.

Are you back at the office yet? If I recall right, you had an OMAP3 DSI
cmd mode board?

Anyway, I guess it's safest if I add a hack there, which tunes the
thresholds a bit differently for OMAP3 DSI.

 Tomi


--=-2hRMofbc/SOOrIt34o91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPE/SRAAoJEPo9qoy8lh71Q/cP/jRhMDxl+MXY5Bi9WS/AO8Dn
3mlv0mSyKnaFwOo+lT/ju7rA9u88yUuWmZEolclNwD333h6uRFr9Za3PaNkh2Ipn
lMJHIKtYBkJLnMVUhqnP8Nck9lBjQ9p/bQ+DO96P3lxtCLN+5h/rJ5HLBCOWd33S
IVRKdw6Kpun7uwIwhI6L2faO2jVP+NggZmbPlLa9c/v6qF/bOMBDBEY6CXmsQZh1
bOYsgUYdqLka7iQJcKlig6cEL0Y7cma63K+sBZ2KUmEvq2p8olm24wkbGNMwsCy9
OsNx0k7QaLL6+70/bKwOASJQRxqJEnLbT/j8ab9oZY+uRUYDJI0BKji00zgB4IVH
ueop0qW0YW3Iq8n/V+ziJz61aCpurMCorIC/zIlr1SUNgpiUqRII4hbl0h7AV6tW
YFYeNsyB1AJsH1DGdf70coL3gxPhwZV7B8sP+e5o4hssF8yKhLW4H+pcIZfmMvlY
hcuyJAnXZf8M/2NegSeVBKBuxq/JetB82Epz5T+lC5zJ0ZKjgQXdu5cyr7k2PqF7
dD0CHRgQklypzAmFncSzLh+EgiLn/Q9SktP2vtFAUPblRvNJF28f1KngnzCk534g
MzPE4/GtdO0pUGRtqJHmnlNDbaT/F1h3f8vVrc9kEZOHqfVh0sJQIP5NXL+5I24S
7/1GIaORYujQtwxWuZHC
=ZMon
-----END PGP SIGNATURE-----

--=-2hRMofbc/SOOrIt34o91--

