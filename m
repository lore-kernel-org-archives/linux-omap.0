From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v3 1/4] DSS2: OMAPFB: Add support for switching memory
 regions
Date: Wed, 17 Mar 2010 15:50:45 +0200
Message-ID: <1268833845.2417.274.camel@tubuntu.research.nokia.com>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38821 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab0CQNw0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 09:52:26 -0400
In-Reply-To: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, 2010-03-05 at 14:26 +0100, Syrjala Ville (Nokia-D/Helsinki)
wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
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

Couple of comments inline. Mostly about making the patch a bit simpler.

>=20
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
> ---
> Changes since v2:
> * Removed the use_count and rely on just counting all active overlays=
=2E A bit racy
>   but no chance of getting stuck in a state where memory allocation c=
an't be changed.
> * s/source_idx/mem_idx as that seems to be a little more self explana=
tory
>=20
>  drivers/video/omap2/omapfb/omapfb-ioctl.c |  163 +++++++++++++++++++=
+-----
>  drivers/video/omap2/omapfb/omapfb-main.c  |  184 +++++++++++++++++++=
----------
>  drivers/video/omap2/omapfb/omapfb-sysfs.c |   60 ++++++++--
>  drivers/video/omap2/omapfb/omapfb.h       |   38 ++++++-
>  include/linux/omapfb.h                    |    5 +-
>  5 files changed, 339 insertions(+), 111 deletions(-)

<snip>

> +static void omapfb_calc_addr(const struct omapfb_info *ofbi,
> +                            const struct fb_var_screeninfo *var,
> +                            const struct fb_fix_screeninfo *fix,
> +                            int rotation, u32 *paddr, void __iomem *=
*vaddr)
> +{
> +       u32 data_start_p;
> +       void __iomem *data_start_v;
> +       int offset;
> +
> +       if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB) {
> +               data_start_p =3D omapfb_get_region_rot_paddr(ofbi, ro=
tation);
> +               data_start_v =3D NULL;
> +       } else {
> +               data_start_p =3D omapfb_get_region_paddr(ofbi);
> +               data_start_v =3D omapfb_get_region_vaddr(ofbi);
> +       }
> +
> +       if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB)
> +               offset =3D calc_rotation_offset_vrfb(var, fix, rotati=
on);
> +       else
> +               offset =3D calc_rotation_offset_dma(var, fix, rotatio=
n);
> +
> +       data_start_p +=3D offset;
> +       data_start_v +=3D offset;
> +
> +       if (offset)
> +               DBG("offset %d, %d =3D %d\n",
> +                   var->xoffset, var->yoffset, offset);
> +
> +       DBG("paddr %x, vaddr %p\n", data_start_p, data_start_v);
> +
> +       *paddr =3D data_start_p;
> +       *vaddr =3D data_start_v;
> +}
>=20
>  /* setup overlay according to the fb */
> -static int omapfb_setup_overlay(struct fb_info *fbi, struct omap_ove=
rlay *ovl,
> +int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overlay *o=
vl,
>                 u16 posx, u16 posy, u16 outw, u16 outh)
>  {
>         int r =3D 0;
> @@ -831,9 +863,8 @@ static int omapfb_setup_overlay(struct fb_info *f=
bi, struct omap_overlay *ovl,
>         struct fb_var_screeninfo *var =3D &fbi->var;
>         struct fb_fix_screeninfo *fix =3D &fbi->fix;
>         enum omap_color_mode mode =3D 0;
> -       int offset;
> -       u32 data_start_p;
> -       void __iomem *data_start_v;
> +       u32 data_start_p =3D 0;
> +       void __iomem *data_start_v =3D NULL;
>         struct omap_overlay_info info;
>         int xres, yres;
>         int screen_width;
> @@ -860,28 +891,9 @@ static int omapfb_setup_overlay(struct fb_info *=
fbi, struct omap_overlay *ovl,
>                 yres =3D var->yres;
>         }
>=20
> -
> -       if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB) {
> -               data_start_p =3D omapfb_get_region_rot_paddr(ofbi, ro=
tation);
> -               data_start_v =3D NULL;
> -       } else {
> -               data_start_p =3D omapfb_get_region_paddr(ofbi);
> -               data_start_v =3D omapfb_get_region_vaddr(ofbi);
> -       }
> -
> -       if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB)
> -               offset =3D calc_rotation_offset_vrfb(var, fix, rotati=
on);
> -       else
> -               offset =3D calc_rotation_offset_dma(var, fix, rotatio=
n);
> -
> -       data_start_p +=3D offset;
> -       data_start_v +=3D offset;
> -
> -       if (offset)
> -               DBG("offset %d, %d =3D %d\n",
> -                               var->xoffset, var->yoffset, offset);
> -
> -       DBG("paddr %x, vaddr %p\n", data_start_p, data_start_v);
> +       if (ofbi->region->size)
> +               omapfb_calc_addr(ofbi, var, fix, rotation,
> +                                &data_start_p, &data_start_v);
>=20
>         r =3D fb_mode_to_dss_mode(var, &mode);
>         if (r) {

Moving this code to omapfb_calc_addr() could perhaps be a separate
patch? I don't see other changes in there.

>  static struct device_attribute omapfb_attrs[] =3D {
> diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap=
2/omapfb/omapfb.h
> index cd54fdb..ce15533 100644
> --- a/drivers/video/omap2/omapfb/omapfb.h
> +++ b/drivers/video/omap2/omapfb/omapfb.h

>  static inline int omapfb_overlay_enable(struct omap_overlay *ovl,
> -               int enable)
> +                                       int enable)
>  {
>         struct omap_overlay_info info;
> +       int r;
>=20
>         ovl->get_overlay_info(ovl, &info);
> +       if (info.enabled =3D=3D enable)
> +               return 0;
>         info.enabled =3D enable;
> -       return ovl->set_overlay_info(ovl, &info);
> +       r =3D ovl->set_overlay_info(ovl, &info);
> +       if (r)
> +               return r;
> +
> +       return 0;
> +}

There are perhaps more changes here than needed. int r is not needed,
and the last lines do not need to be changed. And is if (info.enabled =3D=
=3D
enable) required by this patch, or is it just optimization? If
optimization, it could be in separate patch.

>  #endif
> diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
> index 9bdd914..5de473c 100644
> --- a/include/linux/omapfb.h
> +++ b/include/linux/omapfb.h
> @@ -85,6 +85,9 @@
>  #define OMAPFB_MEMTYPE_SRAM            1
>  #define OMAPFB_MEMTYPE_MAX             1
>=20
> +#define OMAPFB_MEM_IDX_ENABLED 0x8
> +#define OMAPFB_MEM_IDX_MASK    0x7

Should enabled be 0x80, and mask 0x7f? There are never that many mem
indexes, but is there any point in limiting the value?

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
