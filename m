From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH v3 1/4] DSS2: OMAPFB: Add support for switching memory
	regions
Date: Wed, 17 Mar 2010 19:34:07 +0200
Message-ID: <20100317173407.GD30422@localhost>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32269 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231Ab0CQRe3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 13:34:29 -0400
Content-Disposition: inline
In-Reply-To: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

couple of minor comments inlined.

On Fri, Mar 05, 2010 at 02:26:19PM +0100, Syrjala Ville (Nokia-D/Helsin=
ki) wrote:
> From: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
>=20
> Separate the memory region from the framebuffer device a little bit.
> It's now possible to select the memory region used by the framebuffer
> device using the new mem_idx parameter of omapfb_plane_info. If the
> mem_idx is specified it will be interpreted as an index into the
> memory regions array, if it's not specified the framebuffer's index i=
s
> used instead. So by default each framebuffer keeps using it's own
> memory region which preserves backwards compatibility.
>=20
> This allows cloning the same memory region to several overlays and ye=
t
> each overlay can be controlled independently since they can be
> associated with separate framebuffer devices.
>=20
> Signed-off-by: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
> ---
> Changes since v2:
> * Removed the use_count and rely on just counting all active overlays=
=2E A bit racy
>   but no chance of getting stuck in a state where memory allocation c=
an't be changed.
> * s/source_idx/mem_idx as that seems to be a little more self explana=
tory
> [...]
>=20
>  drivers/video/omap2/omapfb/omapfb-ioctl.c |  163 +++++++++++++++++++=
+-----
>  drivers/video/omap2/omapfb/omapfb-main.c  |  184 +++++++++++++++++++=
----------
>  drivers/video/omap2/omapfb/omapfb-sysfs.c |   60 ++++++++--
>  drivers/video/omap2/omapfb/omapfb.h       |   38 ++++++-
>  include/linux/omapfb.h                    |    5 +-
>  5 files changed, 339 insertions(+), 111 deletions(-)
>=20
> diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/vide=
o/omap2/omapfb/omapfb-ioctl.c
> index 1ffa760..cd00bdc 100644
> --- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
> +++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
> [...]
>  static int omapfb_query_plane(struct fb_info *fbi, struct omapfb_pla=
ne_info *pi)
>  {
>         struct omapfb_info *ofbi =3D FB2OFB(fbi);
> +       struct omap_overlay *ovl =3D ofbi->overlays[0];
> +       struct omap_overlay_info *ovli =3D &ovl->info;
>=20
>         if (ofbi->num_overlays !=3D 1) {
>                 memset(pi, 0, sizeof(*pi));
>         } else {
> -               struct omap_overlay_info *ovli;
> -               struct omap_overlay *ovl;
> -
> -               ovl =3D ofbi->overlays[0];
> -               ovli =3D &ovl->info;
> -

Is this really necessary?

>                 pi->pos_x =3D ovli->pos_x;
>                 pi->pos_y =3D ovli->pos_y;
>                 pi->enabled =3D ovli->enabled;
>                 pi->channel_out =3D 0; /* xxx */
>                 pi->mirror =3D 0;
> +               pi->mem_idx =3D get_mem_idx(ofbi);
>                 pi->out_width =3D ovli->out_width;
>                 pi->out_height =3D ovli->out_height;
>         }
> @@ -115,30 +184,57 @@ static int omapfb_setup_mem(struct fb_info *fbi=
, struct omapfb_mem_info *mi)
>         struct omapfb_info *ofbi =3D FB2OFB(fbi);
>         struct omapfb2_device *fbdev =3D ofbi->fbdev;
>         struct omapfb2_mem_region *rg;
> -       int r, i;
> +       int r =3D 0;
>         size_t size;
> +       int i;
>=20
>         if (mi->type > OMAPFB_MEMTYPE_MAX)
>                 return -EINVAL;
>=20
>         size =3D PAGE_ALIGN(mi->size);
>=20
> -       rg =3D &ofbi->region;
> +       rg =3D ofbi->region;
>=20
> -       for (i =3D 0; i < ofbi->num_overlays; i++) {
> -               if (ofbi->overlays[i]->info.enabled)
> -                       return -EBUSY;
> +       /* FIXME probably should be a rwsem ... */
> +       mutex_lock(&rg->mtx);
> +       while (rg->ref) {
> +               mutex_unlock(&rg->mtx);
> +               schedule();
> +               mutex_lock(&rg->mtx);
> +       }

Yes, rwsem would mean no unnecessary scheduling and also make things
clearer.

> [...]
>  static int omapfb_query_mem(struct fb_info *fbi, struct omapfb_mem_i=
nfo *mi)
> @@ -146,12 +242,15 @@ static int omapfb_query_mem(struct fb_info *fbi=
, struct omapfb_mem_info *mi)
>         struct omapfb_info *ofbi =3D FB2OFB(fbi);
>         struct omapfb2_mem_region *rg;
>=20
> -       rg =3D &ofbi->region;
>         memset(mi, 0, sizeof(*mi));
>=20
> +       rg =3D omapfb_get_mem_region(ofbi->region);

At some other users of region I haven't seen omapfb_get_mem_region,
like store_mirror, store_overlays_rotate.

It wouldn't have been nice to have this patch in smaller chunks. For ex=
ample
one for converting all region. to region-> and another one for adding t=
he
locking for it, then the rest.

Otherwise it looks ok to me.

--Imre

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
