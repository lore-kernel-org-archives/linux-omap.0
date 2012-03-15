From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 2/2] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Date: Fri, 16 Mar 2012 01:04:46 +0200
Message-ID: <20120315230446.GO17132@sci.fi>
References: <1331812132-9814-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:36184 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031229Ab2COXMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 19:12:31 -0400
Content-Disposition: inline
In-Reply-To: <1331812132-9814-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Mar 15, 2012 at 05:18:52PM +0530, Chandrabhanu Mahapatra wrote:
> In OMAP3 DISPC video overlays suffer from some undocumented horizonta=
l position
> and timing related limitations leading to SYNCLOST errors. Whenever t=
he image
> window is moved towards the right of the screen SYNCLOST errors becom=
e
> frequent. Checks have been implemented to see that DISPC driver rejec=
ts
> configuration exceeding above limitations.
>=20
> This code was successfully tested on OMAP3. This code is written base=
d on code
> written by Ville Syrj=E4l=E4 <ville.syrjala@nokia.com> in Linux OMAP =
kernel. Ville
> Syrj=E4l=E4 <ville.syrjala@nokia.com> had added checks for video over=
lay horizontal
> timing and DISPC horizontal blanking length limitations.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   67 +++++++++++++++++++++++++++++=
++++++++--
>  1 files changed, 64 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/ds=
s/dispc.c
> index 5a1963e..ebfa613 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1622,6 +1622,58 @@ static void calc_dma_rotation_offset(u8 rotati=
on, bool mirror,
>  	}
>  }
> =20
> +static int check_horiz_timing(enum omap_channel channel, u16 pos_x,
> +		u16 width, u16 height, u16 out_width, u16 out_height)
> +{
> +	int DS =3D DIV_ROUND_UP(height, out_height);
> +	struct omap_dss_device *dssdev =3D dispc_mgr_get_device(channel);
> +	struct omap_video_timings t =3D dssdev->panel.timings;
> +	int pcd =3D REG_GET(DISPC_DIVISORo(channel), 7, 0);

pcd doesn't exist for TV out, which is the reason why you see
'lclk/pclk' ratio used instead in the harmattan kernel.

Another thing which still seems to be wrong in the upstream code is the
use of fclk in the scaling checks. It should be checking lclk instead.

> +	unsigned long nonactive, val, blank;
> +	static const u8 limits[3] =3D { 8, 10, 20 };
> +	int i;
> +
> +	nonactive =3D t.x_res + t.hfp + t.hsw + t.hbp - out_width;
> +
> +	/*
> +	 * Atleast DS-2 lines must have already been fetched
> +	 * before the display active video period starts.
> +	 */
> +	val =3D (nonactive - pos_x) * pcd;
> +	DSSDBG("(nonactive - pos_x) * pcd =3D %lu,"
> +		" max(0, DS - 2) * width =3D %d\n",
> +		val, max(0, DS - 2) * width);
> +	if (val < max(0, DS - 2) * width)
> +		return -EINVAL;
> +
> +	/*
> +	 * Only one line can be fetched during the overlay active
> +	 * period, the rest have to be fetched during the inactive
> +	 * period.
> +	 */
> +	val =3D nonactive * pcd;
> +	DSSDBG("nonactive * pcd  =3D %lu, max(0, DS - 1) * width =3D %d\n",
> +		val, max(0, DS - 1) * width);
> +	if (val < max(0, DS - 1) * width)
> +		return -EINVAL;
> +
> +	/*
> +	 * Atleast Ceil(DS) lines should have been loaded during
> +	 * PPL (screen width) + blanking period.
> +	 */
> +	i =3D 0;
> +	if (out_height < height)
> +		i++;
> +	if (out_width < width)
> +		i++;
> +	blank =3D (t.hbp + t.hsw + t.hfp) * pcd;
> +	DSSDBG("blanking period + ppl =3D %lu (limit =3D %u)\n", blank, lim=
its[i]);
> +	if (blank <=3D limits[i])
> +		return -EINVAL;

The comment and code here are totally out of sync. IIRC the hblank
length check came directly from the TRM. I have no idea if it's correct
for more recent OMAPs, or if it was just copy pasted from the
old TRM when the TRM got adjusted for more recent chips. That is why I
stuck it into a separate function in harmattan.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
