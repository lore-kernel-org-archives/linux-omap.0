From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/6] OMAPDSS: DISPC: move fifo threhold calc to dispc.c
Date: Wed, 18 Jan 2012 10:10:12 +0200
Message-ID: <1326874212.1954.30.camel@deskari>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
	 <1326455193-19716-6-git-send-email-tomi.valkeinen@ti.com>
	 <4F108D7A.4010802@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-GtbcouVYSfh45lX/O0nz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:43853 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524Ab2ARIKR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 03:10:17 -0500
In-Reply-To: <4F108D7A.4010802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com, rob@ti.com


--=-GtbcouVYSfh45lX/O0nz
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

I added a FEAT_OMAP3_DSI_FIFO_BUG flag for OMAP3s, and changed the
dispc's fifo config function to:

void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge)
{
	/*
	 * All sizes are in bytes. Both the buffer and burst are made of
	 * buffer_units, and the fifo thresholds must be buffer_unit aligned.
	 */

	unsigned buf_unit =3D dss_feat_get_buffer_size_unit();
	unsigned ovl_fifo_size, total_fifo_size, burst_size;
	int i;

	burst_size =3D dispc_ovl_get_burst_size(plane);
	ovl_fifo_size =3D dispc_ovl_get_fifo_size(plane);

	if (use_fifomerge) {
		total_fifo_size =3D 0;
		for (i =3D 0; i < omap_dss_get_num_overlays(); ++i)
			total_fifo_size +=3D dispc_ovl_get_fifo_size(i);
	} else {
		total_fifo_size =3D ovl_fifo_size;
	}

	/*
	 * We use the same low threshold for both fifomerge and non-fifomerge
	 * cases, but for fifomerge we calculate the high threshold using the
	 * combined fifo size
	 */

	if (dss_has_feature(FEAT_OMAP3_DSI_FIFO_BUG)) {
		*fifo_low =3D ovl_fifo_size - burst_size * 2;
		*fifo_high =3D total_fifo_size - burst_size;
	} else {
		*fifo_low =3D ovl_fifo_size - burst_size;
		*fifo_high =3D total_fifo_size - buf_unit;
	}
}

 Tomi


--=-GtbcouVYSfh45lX/O0nz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPFn5kAAoJEPo9qoy8lh71icwQAI+xeggbVkR1Dfi45G78cWnW
713HwMbxqDmslGc+O3mL66rVYrXBJPDNuB4tXIZkArBxZUwFBKK6mZJ8T3sQtdVO
2gAY3jEWs+oddFUkeka3X7TE7j3ViL0cmFlcZfClo5pSVtVa09WrN8K/JvFtp09+
8KBxvvvAnV7AqphPAk8+MOTdol5klWOg6IqFJ8srQ1xzjc1aXnemvYL2InSEEq5w
65e9hI3qhqUcnjCJ4mOu4uvJcJOEchqkdjjssKsvr40XyN24zz3lVwLcqVywwARA
X5lE8BsrAu9bGdsqa2hTiuFNxdY92SDW35fx1jVWMJ60BOce6KSS1/GOxe9bfCDC
P+4AyYJg9hcaldyKmy3kqn2AB4yeY2K5xzqKwaWx3Xyv+ISVUy8LZopf94eQLiqt
nfWRKWL5aSR3szcOFN4vT86vc83svGm61rNSctbsaGAaV5Jpf8kwRiACuPm7qtag
k4vLmw33wd8JGfzpodLxVyIY2tOiKiXnMBN0Ci7q05hmjma34vyPK0z5Lxx3ufTP
6ZeFTQHj73CvSt06aaKu0t7Fy90KMNUQoPmZLAF0s0UeUzn4nbhNa0nwL9bLL4ut
cPD0G2VQR4KXYjf64uO0iG5Ax6kjGSREYLMmbV72tpnq7wMISZpCFZ/TKKwLxPwZ
lxcQ3Phah7V+LVF0SSBG
=jX0F
-----END PGP SIGNATURE-----

--=-GtbcouVYSfh45lX/O0nz--

