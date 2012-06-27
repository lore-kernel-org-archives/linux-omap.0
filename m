From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] staging: drm/omap: add rotation properties
Date: Wed, 27 Jun 2012 09:09:06 -0500
Message-ID: <CAF6AEGsfzJD0O_3gBPhQOFCQscQTqcXAwjcf_UMX6YiHqVvEDA@mail.gmail.com>
References: <1340805986-10670-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36948 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab2F0OJH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 10:09:07 -0400
Received: by yenl2 with SMTP id l2so905174yen.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 07:09:07 -0700 (PDT)
In-Reply-To: <1340805986-10670-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, cmahapatra@ti.com, s-guiriec@ti.com, archit@ti.com, Rob Clark <rob@ti.com>

On Wed, Jun 27, 2012 at 9:06 AM, Rob Clark <rob.clark@linaro.org> wrote=
:
> From: Rob Clark <rob@ti.com>
>
> Use tiled buffers for rotated/reflected scanout, with CRTC and plane
> properties as the interface for userspace to configure rotation.

btw, I assume the potential controversial part of the patch would be
the property names/values exposed to userspace, because we probably
should try to standardize property names/values wherever possible.

There is one difference, AFAIU, from the rotation properties proposed
for the intel driver, in that in the omap case these properties are
actually instructing the hw to do the rotation, rather than just
informing the driver that rotation was done via a shadow buffer in
userspace.

BR,
-R

> Signed-off-by: Rob Clark <rob@ti.com>
> ---
> =A0drivers/staging/omapdrm/omap_crtc.c =A0 =A0 =A0| =A0 17 +++++
> =A0drivers/staging/omapdrm/omap_dmm_tiler.c | =A0 47 ++++++++++++--
> =A0drivers/staging/omapdrm/omap_dmm_tiler.h | =A0 17 ++++-
> =A0drivers/staging/omapdrm/omap_drv.c =A0 =A0 =A0 | =A0 17 +++++
> =A0drivers/staging/omapdrm/omap_drv.h =A0 =A0 =A0 | =A0 32 +++++++++-
> =A0drivers/staging/omapdrm/omap_fb.c =A0 =A0 =A0 =A0| =A0 99 ++++++++=
+++++++++++++++++-----
> =A0drivers/staging/omapdrm/omap_gem.c =A0 =A0 =A0 | =A0 43 ++++++++++=
++-
> =A0drivers/staging/omapdrm/omap_plane.c =A0 =A0 | =A0 92 ++++++++++++=
++++++++-------
> =A08 files changed, 318 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/staging/omapdrm/omap_crtc.c b/drivers/staging/om=
apdrm/omap_crtc.c
> index 8b864af..7479dcb 100644
> --- a/drivers/staging/omapdrm/omap_crtc.c
> +++ b/drivers/staging/omapdrm/omap_crtc.c
> @@ -191,10 +191,25 @@ static int omap_crtc_page_flip_locked(struct dr=
m_crtc *crtc,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int omap_crtc_set_property(struct drm_crtc *crtc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct drm_property *property, uint64_t=
 val)
> +{
> + =A0 =A0 =A0 struct omap_crtc *omap_crtc =3D to_omap_crtc(crtc);
> + =A0 =A0 =A0 struct omap_drm_private *priv =3D crtc->dev->dev_privat=
e;
> +
> + =A0 =A0 =A0 if (property =3D=3D priv->rotation_prop) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crtc->invert_dimensions =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(val =
& ((1LL << DRM_ROTATE_90) | (1LL << DRM_ROTATE_270)));
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return omap_plane_set_property(omap_crtc->plane, proper=
ty, val);
> +}
> +
> =A0static const struct drm_crtc_funcs omap_crtc_funcs =3D {
> =A0 =A0 =A0 =A0.set_config =3D drm_crtc_helper_set_config,
> =A0 =A0 =A0 =A0.destroy =3D omap_crtc_destroy,
> =A0 =A0 =A0 =A0.page_flip =3D omap_crtc_page_flip_locked,
> + =A0 =A0 =A0 .set_property =3D omap_crtc_set_property,
> =A0};
>
> =A0static const struct drm_crtc_helper_funcs omap_crtc_helper_funcs =3D=
 {
> @@ -231,6 +246,8 @@ struct drm_crtc *omap_crtc_init(struct drm_device=
 *dev,
> =A0 =A0 =A0 =A0drm_crtc_init(dev, crtc, &omap_crtc_funcs);
> =A0 =A0 =A0 =A0drm_crtc_helper_add(crtc, &omap_crtc_helper_funcs);
>
> + =A0 =A0 =A0 omap_plane_install_properties(omap_crtc->plane, &crtc->=
base);
> +
> =A0 =A0 =A0 =A0return crtc;
>
> =A0fail:
> diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.c b/drivers/stagi=
ng/omapdrm/omap_dmm_tiler.c
> index 9d83060..68da290 100644
> --- a/drivers/staging/omapdrm/omap_dmm_tiler.c
> +++ b/drivers/staging/omapdrm/omap_dmm_tiler.c
> @@ -401,8 +401,26 @@ int tiler_release(struct tiler_block *block)
> =A0* Utils
> =A0*/
>
> -/* calculate the tiler space address of a pixel in a view orientatio=
n */
> -static u32 tiler_get_address(u32 orient, enum tiler_fmt fmt, u32 x, =
u32 y)
> +/* calculate the tiler space address of a pixel in a view orientatio=
n...
> + * below description copied from the display subsystem section of TR=
M:
> + *
> + * When the TILER is addressed, the bits:
> + * =A0 [28:27] =3D 0x0 for 8-bit tiled
> + * =A0 =A0 =A0 =A0 =A0 =A0 0x1 for 16-bit tiled
> + * =A0 =A0 =A0 =A0 =A0 =A0 0x2 for 32-bit tiled
> + * =A0 =A0 =A0 =A0 =A0 =A0 0x3 for page mode
> + * =A0 [31:29] =3D 0x0 for 0-degree view
> + * =A0 =A0 =A0 =A0 =A0 =A0 0x1 for 180-degree view + mirroring
> + * =A0 =A0 =A0 =A0 =A0 =A0 0x2 for 0-degree view + mirroring
> + * =A0 =A0 =A0 =A0 =A0 =A0 0x3 for 180-degree view
> + * =A0 =A0 =A0 =A0 =A0 =A0 0x4 for 270-degree view + mirroring
> + * =A0 =A0 =A0 =A0 =A0 =A0 0x5 for 270-degree view
> + * =A0 =A0 =A0 =A0 =A0 =A0 0x6 for 90-degree view
> + * =A0 =A0 =A0 =A0 =A0 =A0 0x7 for 90-degree view + mirroring
> + * Otherwise the bits indicated the corresponding bit address to acc=
ess
> + * the SDRAM.
> + */
> +static u32 tiler_get_address(enum tiler_fmt fmt, u32 orient, u32 x, =
u32 y)
> =A0{
> =A0 =A0 =A0 =A0u32 x_bits, y_bits, tmp, x_mask, y_mask, alignment;
>
> @@ -414,8 +432,11 @@ static u32 tiler_get_address(u32 orient, enum ti=
ler_fmt fmt, u32 x, u32 y)
> =A0 =A0 =A0 =A0x_mask =3D MASK(x_bits);
> =A0 =A0 =A0 =A0y_mask =3D MASK(y_bits);
>
> - =A0 =A0 =A0 if (x < 0 || x > x_mask || y < 0 || y > y_mask)
> + =A0 =A0 =A0 if (x < 0 || x > x_mask || y < 0 || y > y_mask) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG("invalid coords: %u < 0 || %u > %u =
|| %u < 0 || %u > %u",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x, x, x=
_mask, y, y, y_mask);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* account for mirroring */
> =A0 =A0 =A0 =A0if (orient & MASK_X_INVERT)
> @@ -436,11 +457,22 @@ dma_addr_t tiler_ssptr(struct tiler_block *bloc=
k)
> =A0{
> =A0 =A0 =A0 =A0BUG_ON(!validfmt(block->fmt));
>
> - =A0 =A0 =A0 return TILVIEW_8BIT + tiler_get_address(0, block->fmt,
> + =A0 =A0 =A0 return TILVIEW_8BIT + tiler_get_address(block->fmt, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0block->area.p0.x * geo=
m[block->fmt].slot_w,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0block->area.p0.y * geo=
m[block->fmt].slot_h);
> =A0}
>
> +dma_addr_t tiler_tsptr(struct tiler_block *block, uint32_t orient,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint32_t x, uint32_t y)
> +{
> + =A0 =A0 =A0 struct tcm_pt *p =3D &block->area.p0;
> + =A0 =A0 =A0 BUG_ON(!validfmt(block->fmt));
> +
> + =A0 =A0 =A0 return tiler_get_address(block->fmt, orient,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (p->x * geom[block->fmt=
].slot_w) + x,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (p->y * geom[block->fmt=
].slot_h) + y);
> +}
> +
> =A0void tiler_align(enum tiler_fmt fmt, uint16_t *w, uint16_t *h)
> =A0{
> =A0 =A0 =A0 =A0BUG_ON(!validfmt(fmt));
> @@ -448,11 +480,14 @@ void tiler_align(enum tiler_fmt fmt, uint16_t *=
w, uint16_t *h)
> =A0 =A0 =A0 =A0*h =3D round_up(*h, geom[fmt].slot_h);
> =A0}
>
> -uint32_t tiler_stride(enum tiler_fmt fmt)
> +uint32_t tiler_stride(enum tiler_fmt fmt, uint32_t orient)
> =A0{
> =A0 =A0 =A0 =A0BUG_ON(!validfmt(fmt));
>
> - =A0 =A0 =A0 return 1 << (CONT_WIDTH_BITS + geom[fmt].y_shft);
> + =A0 =A0 =A0 if (orient & MASK_XY_FLIP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1 << (CONT_HEIGHT_BITS + geom[fm=
t].x_shft);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1 << (CONT_WIDTH_BITS + geom[fmt=
].y_shft);
> =A0}
>
> =A0size_t tiler_size(enum tiler_fmt fmt, uint16_t w, uint16_t h)
> diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.h b/drivers/stagi=
ng/omapdrm/omap_dmm_tiler.h
> index 7b1052a..740911d 100644
> --- a/drivers/staging/omapdrm/omap_dmm_tiler.h
> +++ b/drivers/staging/omapdrm/omap_dmm_tiler.h
> @@ -54,7 +54,18 @@ struct tiler_block {
> =A0#define TILER_WIDTH =A0 =A0 =A0 =A0 =A0 =A0 (1 << (CONT_WIDTH_BITS=
 - SLOT_WIDTH_BITS))
> =A0#define TILER_HEIGHT =A0 =A0 =A0 =A0 =A0 =A0(1 << (CONT_HEIGHT_BIT=
S - SLOT_HEIGHT_BITS))
>
> -/* tiler space addressing bitfields */
> +/*
> +Table 15-11. Coding and Description of TILER Orientations
> +S Y X =A0Description =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 Alternate description
> +0 0 0 =A00-degree view =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 Natural view
> +0 0 1 =A00-degree view with vertical mirror =A0 =A0 =A0180-degree vi=
ew with horizontal mirror
> +0 1 0 =A00-degree view with horizontal mirror =A0 =A0180-degree view=
 with vertical mirror
> +0 1 1 =A0180-degree view
> +1 0 0 =A090-degree view with vertical mirror =A0 =A0 270-degree view=
 with horizontal mirror
> +1 0 1 =A0270-degree view
> +1 1 0 =A090-degree view
> +1 1 1 =A090-degree view with horizontal mirror =A0 270-degree view w=
ith vertical mirror
> + */
> =A0#define MASK_XY_FLIP =A0 =A0 =A0 =A0 =A0 (1 << 31)
> =A0#define MASK_Y_INVERT =A0 =A0 =A0 =A0 =A0(1 << 30)
> =A0#define MASK_X_INVERT =A0 =A0 =A0 =A0 =A0(1 << 29)
> @@ -90,7 +101,9 @@ int tiler_release(struct tiler_block *block);
>
> =A0/* utilities */
> =A0dma_addr_t tiler_ssptr(struct tiler_block *block);
> -uint32_t tiler_stride(enum tiler_fmt fmt);
> +dma_addr_t tiler_tsptr(struct tiler_block *block, uint32_t orient,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint32_t x, uint32_t y);
> +uint32_t tiler_stride(enum tiler_fmt fmt, uint32_t orient);
> =A0size_t tiler_size(enum tiler_fmt fmt, uint16_t w, uint16_t h);
> =A0size_t tiler_vsize(enum tiler_fmt fmt, uint16_t w, uint16_t h);
> =A0void tiler_align(enum tiler_fmt fmt, uint16_t *w, uint16_t *h);
> diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/oma=
pdrm/omap_drv.c
> index 4beab94..342645a 100644
> --- a/drivers/staging/omapdrm/omap_drv.c
> +++ b/drivers/staging/omapdrm/omap_drv.c
> @@ -649,6 +649,8 @@ static int dev_firstopen(struct drm_device *dev)
> =A0*/
> =A0static void dev_lastclose(struct drm_device *dev)
> =A0{
> + =A0 =A0 =A0 int i;
> +
> =A0 =A0 =A0 =A0/* we don't support vga-switcheroo.. so just make sure=
 the fbdev
> =A0 =A0 =A0 =A0 * mode is active
> =A0 =A0 =A0 =A0 */
> @@ -657,6 +659,21 @@ static void dev_lastclose(struct drm_device *dev=
)
>
> =A0 =A0 =A0 =A0DBG("lastclose: dev=3D%p", dev);
>
> + =A0 =A0 =A0 /* need to restore default rotation state.. not sure if=
 there is
> + =A0 =A0 =A0 =A0* a cleaner way to restore properties to default sta=
te? =A0Maybe
> + =A0 =A0 =A0 =A0* a flag that properties should automatically be res=
tored to
> + =A0 =A0 =A0 =A0* default state on lastclose?
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (i =3D 0; i < priv->num_crtcs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drm_object_property_set_value(&priv->cr=
tcs[i]->base,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->r=
otation_prop, 0);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < priv->num_planes; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drm_object_property_set_value(&priv->pl=
anes[i]->base,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->r=
otation_prop, 0);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0ret =3D drm_fb_helper_restore_fbdev_mode(priv->fbdev);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBG("failed to restore crtc mode");
> diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/oma=
pdrm/omap_drv.h
> index f238d57..bfdf9d3 100644
> --- a/drivers/staging/omapdrm/omap_drv.h
> +++ b/drivers/staging/omapdrm/omap_drv.h
> @@ -59,6 +59,26 @@ struct omap_drm_private {
> =A0 =A0 =A0 =A0struct list_head obj_list;
>
> =A0 =A0 =A0 =A0bool has_dmm;
> +
> + =A0 =A0 =A0 /* properties: */
> + =A0 =A0 =A0 struct drm_property *rotation_prop;
> +};
> +
> +/* this should probably be in drm-core to standardize amongst driver=
s */
> +#define DRM_ROTATE_0 =A0 0
> +#define DRM_ROTATE_90 =A01
> +#define DRM_ROTATE_180 2
> +#define DRM_ROTATE_270 3
> +#define DRM_REFLECT_X =A04
> +#define DRM_REFLECT_Y =A05
> +
> +/* parameters which describe (unrotated) coordinates of scanout with=
in a fb: */
> +struct omap_drm_window {
> + =A0 =A0 =A0 uint32_t rotation;
> + =A0 =A0 =A0 int32_t =A0crtc_x, crtc_y; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* signed because can be offscreen */
> + =A0 =A0 =A0 uint32_t crtc_w, crtc_h;
> + =A0 =A0 =A0 uint32_t src_x, src_y;
> + =A0 =A0 =A0 uint32_t src_w, src_h;
> =A0};
>
> =A0#ifdef CONFIG_DEBUG_FS
> @@ -87,6 +107,10 @@ int omap_plane_mode_set(struct drm_plane *plane,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint32_t src_w, uint32_t src_h);
> =A0void omap_plane_on_endwin(struct drm_plane *plane,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void (*fxn)(void *), void *arg);
> +void omap_plane_install_properties(struct drm_plane *plane,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct drm_mode_object *obj);
> +int omap_plane_set_property(struct drm_plane *plane,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct drm_property *property, uint64_t=
 val);
>
> =A0struct drm_encoder *omap_encoder_init(struct drm_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_overlay_manager *mgr);
> @@ -114,8 +138,8 @@ struct drm_gem_object *omap_framebuffer_bo(struct=
 drm_framebuffer *fb, int p);
> =A0int omap_framebuffer_replace(struct drm_framebuffer *a,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct drm_framebuffer *b, void *arg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void (*unpin)(void *arg, struct drm_ge=
m_object *bo));
> -void omap_framebuffer_update_scanout(struct drm_framebuffer *fb, int=
 x, int y,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay_info *info);
> +void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_drm_window *win, struct oma=
p_overlay_info *info);
> =A0struct drm_connector *omap_framebuffer_get_next_connector(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct drm_framebuffer *fb, struct drm=
_connector *from);
> =A0void omap_framebuffer_flush(struct drm_framebuffer *fb,
> @@ -157,8 +181,12 @@ int omap_gem_get_pages(struct drm_gem_object *ob=
j, struct page ***pages,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool remap);
> =A0int omap_gem_put_pages(struct drm_gem_object *obj);
> =A0uint32_t omap_gem_flags(struct drm_gem_object *obj);
> +int omap_gem_rotated_paddr(struct drm_gem_object *obj, uint32_t orie=
nt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x, int y, dma_addr_t *paddr);
> =A0uint64_t omap_gem_mmap_offset(struct drm_gem_object *obj);
> =A0size_t omap_gem_mmap_size(struct drm_gem_object *obj);
> +int omap_gem_tiled_size(struct drm_gem_object *obj, uint16_t *w, uin=
t16_t *h);
> +int omap_gem_tiled_stride(struct drm_gem_object *obj, uint32_t orien=
t);
>
> =A0struct dma_buf * omap_gem_prime_export(struct drm_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct drm_gem_object *obj, int flags)=
;
> diff --git a/drivers/staging/omapdrm/omap_fb.c b/drivers/staging/omap=
drm/omap_fb.c
> index 74260f0..446801d 100644
> --- a/drivers/staging/omapdrm/omap_fb.c
> +++ b/drivers/staging/omapdrm/omap_fb.c
> @@ -18,6 +18,7 @@
> =A0*/
>
> =A0#include "omap_drv.h"
> +#include "omap_dmm_tiler.h"
>
> =A0#include "drm_crtc.h"
> =A0#include "drm_crtc_helper.h"
> @@ -137,30 +138,100 @@ static const struct drm_framebuffer_funcs omap=
_framebuffer_funcs =3D {
> =A0 =A0 =A0 =A0.dirty =3D omap_framebuffer_dirty,
> =A0};
>
> +static uint32_t get_linear_addr(struct plane *plane,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct format *format, int n, int=
 x, int y)
> +{
> + =A0 =A0 =A0 uint32_t offset;
> +
> + =A0 =A0 =A0 offset =3D plane->offset +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (x * format->planes[n].=
stride_bpp) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (y * plane->pitch / for=
mat->planes[n].sub_y);
> +
> + =A0 =A0 =A0 return plane->paddr + offset;
> +}
> +
> =A0/* update ovl info for scanout, handles cases of multi-planar fb's=
, etc.
> =A0*/
> -void omap_framebuffer_update_scanout(struct drm_framebuffer *fb, int=
 x, int y,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay_info *info)
> +void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_drm_window *win, struct oma=
p_overlay_info *info)
> =A0{
> =A0 =A0 =A0 =A0struct omap_framebuffer *omap_fb =3D to_omap_framebuff=
er(fb);
> =A0 =A0 =A0 =A0const struct format *format =3D omap_fb->format;
> =A0 =A0 =A0 =A0struct plane *plane =3D &omap_fb->planes[0];
> - =A0 =A0 =A0 unsigned int offset;
> + =A0 =A0 =A0 uint32_t x, y, orient =3D 0;
> +
> + =A0 =A0 =A0 info->color_mode =3D format->dss_format;
> +
> + =A0 =A0 =A0 info->pos_x =A0 =A0 =A0=3D win->crtc_x;
> + =A0 =A0 =A0 info->pos_y =A0 =A0 =A0=3D win->crtc_y;
> + =A0 =A0 =A0 info->out_width =A0=3D win->crtc_w;
> + =A0 =A0 =A0 info->out_height =3D win->crtc_h;
> + =A0 =A0 =A0 info->width =A0 =A0 =A0=3D win->src_w;
> + =A0 =A0 =A0 info->height =A0 =A0 =3D win->src_h;
> +
> + =A0 =A0 =A0 x =3D win->src_x;
> + =A0 =A0 =A0 y =3D win->src_y;
> +
> + =A0 =A0 =A0 if (omap_gem_flags(plane->bo) & OMAP_BO_TILED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint32_t w =3D win->src_w;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint32_t h =3D win->src_h;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (win->rotation & 0xf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(fb->dev->dev, "=
invalid rotation: %02x",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (uint32_t)win->rotation);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fallthru to default =
to no rotation */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case BIT(DRM_ROTATE_0):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 orient =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case BIT(DRM_ROTATE_90):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 orient =3D MASK_XY_FLIP=
 | MASK_X_INVERT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case BIT(DRM_ROTATE_180):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 orient =3D MASK_X_INVER=
T | MASK_Y_INVERT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case BIT(DRM_ROTATE_270):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 orient =3D MASK_XY_FLIP=
 | MASK_Y_INVERT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 offset =3D plane->offset +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (x * format->planes[0].=
stride_bpp) +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (y * plane->pitch / for=
mat->planes[0].sub_y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (win->rotation & BIT(DRM_REFLECT_X))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 orient ^=3D MASK_X_INVE=
RT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (win->rotation & BIT(DRM_REFLECT_Y))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 orient ^=3D MASK_Y_INVE=
RT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* adjust x,y offset for flip/invert: *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (orient & MASK_XY_FLIP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 swap(w, h);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (orient & MASK_Y_INVERT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 y +=3D h - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (orient & MASK_X_INVERT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x +=3D w - 1;
>
> - =A0 =A0 =A0 info->color_mode =A0 =3D format->dss_format;
> - =A0 =A0 =A0 info->paddr =A0 =A0 =A0 =A0=3D plane->paddr + offset;
> - =A0 =A0 =A0 info->screen_width =3D plane->pitch / format->planes[0]=
=2Estride_bpp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_gem_rotated_paddr(plane->bo, orien=
t, x, y, &info->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->rotation_type =3D OMAP_DSS_ROT_TI=
LER;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->screen_width =A0=3D omap_gem_tile=
d_stride(plane->bo, orient);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->paddr =A0 =A0 =A0 =A0 =3D get_lin=
ear_addr(plane, format, 0, x, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->rotation_type =3D OMAP_DSS_ROT_DM=
A;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->screen_width =A0=3D plane->pitch;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* convert to pixels: */
> + =A0 =A0 =A0 info->screen_width /=3D format->planes[0].stride_bpp;
>
> =A0 =A0 =A0 =A0if (format->dss_format =3D=3D OMAP_DSS_COLOR_NV12) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0plane =3D &omap_fb->planes[1];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D plane->offset +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (x * fo=
rmat->planes[1].stride_bpp) +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (y * pl=
ane->pitch / format->planes[1].sub_y);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->p_uv_addr =3D plane->paddr + offs=
et;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->rotation_type =3D=3D OMAP_DSS=
_ROT_TILER) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(!(omap_gem_flag=
s(plane->bo) & OMAP_BO_TILED));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_gem_rotated_paddr(=
plane->bo, orient,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 x/2, y/2, &info->p_uv_addr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->p_uv_addr =3D get=
_linear_addr(plane, format, 1, x, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->p_uv_addr =3D 0;
> =A0 =A0 =A0 =A0}
> @@ -377,7 +448,7 @@ struct drm_framebuffer *omap_framebuffer_init(str=
uct drm_device *dev,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size =3D pitch * mode_cmd->height / fo=
rmat->planes[i].sub_y;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size > (bos[i]->size - mode_cmd->of=
fsets[i])) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size > (omap_gem_mmap_size(bos[i]) =
- mode_cmd->offsets[i])) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev->dev, "pro=
vided buffer object is too small! %d < %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0bos[i]->size - mode_cmd->offsets[i], size);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> diff --git a/drivers/staging/omapdrm/omap_gem.c b/drivers/staging/oma=
pdrm/omap_gem.c
> index 3a0d035..74082aa 100644
> --- a/drivers/staging/omapdrm/omap_gem.c
> +++ b/drivers/staging/omapdrm/omap_gem.c
> @@ -339,6 +339,17 @@ size_t omap_gem_mmap_size(struct drm_gem_object =
*obj)
> =A0 =A0 =A0 =A0return size;
> =A0}
>
> +/* get tiled size, returns -EINVAL if not tiled buffer */
> +int omap_gem_tiled_size(struct drm_gem_object *obj, uint16_t *w, uin=
t16_t *h)
> +{
> + =A0 =A0 =A0 struct omap_gem_object *omap_obj =3D to_omap_bo(obj);
> + =A0 =A0 =A0 if (omap_obj->flags & OMAP_BO_TILED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *w =3D omap_obj->width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *h =3D omap_obj->height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return -EINVAL;
> +}
>
> =A0/* Normal handling for the case of faulting in non-tiled buffers *=
/
> =A0static int fault_1d(struct drm_gem_object *obj,
> @@ -832,6 +843,36 @@ fail:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> +/* Get rotated scanout address (only valid if already pinned), at th=
e
> + * specified orientation and x,y offset from top-left corner of buff=
er
> + * (only valid for tiled 2d buffers)
> + */
> +int omap_gem_rotated_paddr(struct drm_gem_object *obj, uint32_t orie=
nt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x, int y, dma_addr_t *paddr)
> +{
> + =A0 =A0 =A0 struct omap_gem_object *omap_obj =3D to_omap_bo(obj);
> + =A0 =A0 =A0 int ret =3D -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&obj->dev->struct_mutex);
> + =A0 =A0 =A0 if ((omap_obj->paddr_cnt > 0) && omap_obj->block &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (omap_obj->flags & OMAP=
_BO_TILED)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *paddr =3D tiler_tsptr(omap_obj->block,=
 orient, x, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 mutex_unlock(&obj->dev->struct_mutex);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/* Get tiler stride for the buffer (only valid for 2d tiled buffers)=
 */
> +int omap_gem_tiled_stride(struct drm_gem_object *obj, uint32_t orien=
t)
> +{
> + =A0 =A0 =A0 struct omap_gem_object *omap_obj =3D to_omap_bo(obj);
> + =A0 =A0 =A0 int ret =3D -EINVAL;
> + =A0 =A0 =A0 if (omap_obj->flags & OMAP_BO_TILED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D tiler_stride(gem2fmt(omap_obj->=
flags), orient);
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/* acquire pages when needed (for example, for DMA where physicall=
y
> =A0* contiguous buffer is not required
> =A0*/
> @@ -1402,7 +1443,7 @@ void omap_gem_init(struct drm_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usergart[i].height =3D h;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usergart[i].height_shift =3D ilog2(h);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usergart[i].stride_pfn =3D tiler_stride=
(fmts[i]) >> PAGE_SHIFT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usergart[i].stride_pfn =3D tiler_stride=
(fmts[i], 0) >> PAGE_SHIFT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usergart[i].slot_shift =3D ilog2((PAGE=
_SIZE / h) >> i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (j =3D 0; j < NUM_USERGART_ENTRIES=
; j++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct usergart_entry =
*entry =3D &usergart[i].entry[j];
> diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/o=
mapdrm/omap_plane.c
> index 7997be7..6931d06 100644
> --- a/drivers/staging/omapdrm/omap_plane.c
> +++ b/drivers/staging/omapdrm/omap_plane.c
> @@ -20,6 +20,7 @@
> =A0#include <linux/kfifo.h>
>
> =A0#include "omap_drv.h"
> +#include "omap_dmm_tiler.h"
>
> =A0/* some hackery because omapdss has an 'enum omap_plane' (which wo=
uld be
> =A0* better named omap_plane_id).. and compiler seems unhappy about h=
aving
> @@ -43,10 +44,9 @@ struct omap_plane {
> =A0 =A0 =A0 =A0struct omap_overlay *ovl;
> =A0 =A0 =A0 =A0struct omap_overlay_info info;
>
> - =A0 =A0 =A0 /* Source values, converted to integers because we don'=
t support
> - =A0 =A0 =A0 =A0* fractional positions:
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 unsigned int src_x, src_y;
> + =A0 =A0 =A0 /* position/orientation of scanout within the fb: */
> + =A0 =A0 =A0 struct omap_drm_window win;
> +
>
> =A0 =A0 =A0 =A0/* last fb that we pinned: */
> =A0 =A0 =A0 =A0struct drm_framebuffer *pinned_fb;
> @@ -289,6 +289,7 @@ static void update_scanout(struct drm_plane *plan=
e)
> =A0{
> =A0 =A0 =A0 =A0struct omap_plane *omap_plane =3D to_omap_plane(plane)=
;
> =A0 =A0 =A0 =A0struct omap_overlay_info *info =3D &omap_plane->info;
> + =A0 =A0 =A0 struct omap_drm_window *win =3D &omap_plane->win;
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0ret =3D update_pin(plane, plane->fb);
> @@ -299,11 +300,10 @@ static void update_scanout(struct drm_plane *pl=
ane)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 omap_framebuffer_update_scanout(plane->fb,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_plane->src_x, omap=
_plane->src_y, info);
> + =A0 =A0 =A0 omap_framebuffer_update_scanout(plane->fb, win, info);
>
> =A0 =A0 =A0 =A0DBG("%s: %d,%d: %08x %08x (%d)", omap_plane->ovl->name=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_plane->src_x, omap=
_plane->src_y,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->src_x, win->src_y,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(u32)info->paddr, (u32=
)info->p_uv_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->screen_width);
> =A0}
> @@ -316,21 +316,18 @@ int omap_plane_mode_set(struct drm_plane *plane=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint32_t src_w, uint32_t src_h)
> =A0{
> =A0 =A0 =A0 =A0struct omap_plane *omap_plane =3D to_omap_plane(plane)=
;
> + =A0 =A0 =A0 struct omap_drm_window *win =3D &omap_plane->win;
> +
> + =A0 =A0 =A0 win->crtc_x =3D crtc_x;
> + =A0 =A0 =A0 win->crtc_y =3D crtc_y;
> + =A0 =A0 =A0 win->crtc_w =3D crtc_w;
> + =A0 =A0 =A0 win->crtc_h =3D crtc_h;
>
> =A0 =A0 =A0 =A0/* src values are in Q16 fixed point, convert to integ=
er: */
> - =A0 =A0 =A0 src_x =3D src_x >> 16;
> - =A0 =A0 =A0 src_y =3D src_y >> 16;
> - =A0 =A0 =A0 src_w =3D src_w >> 16;
> - =A0 =A0 =A0 src_h =3D src_h >> 16;
> -
> - =A0 =A0 =A0 omap_plane->info.pos_x =3D crtc_x;
> - =A0 =A0 =A0 omap_plane->info.pos_y =3D crtc_y;
> - =A0 =A0 =A0 omap_plane->info.out_width =3D crtc_w;
> - =A0 =A0 =A0 omap_plane->info.out_height =3D crtc_h;
> - =A0 =A0 =A0 omap_plane->info.width =3D src_w;
> - =A0 =A0 =A0 omap_plane->info.height =3D src_h;
> - =A0 =A0 =A0 omap_plane->src_x =3D src_x;
> - =A0 =A0 =A0 omap_plane->src_y =3D src_y;
> + =A0 =A0 =A0 win->src_x =3D src_x >> 16;
> + =A0 =A0 =A0 win->src_y =3D src_y >> 16;
> + =A0 =A0 =A0 win->src_w =3D src_w >> 16;
> + =A0 =A0 =A0 win->src_h =3D src_h >> 16;
>
> =A0 =A0 =A0 =A0/* note: this is done after this fxn returns.. but if =
we need
> =A0 =A0 =A0 =A0 * to do a commit/update_scanout, etc before this retu=
rns we
> @@ -359,6 +356,8 @@ static int omap_plane_update(struct drm_plane *pl=
ane,
>
> =A0static int omap_plane_disable(struct drm_plane *plane)
> =A0{
> + =A0 =A0 =A0 struct omap_plane *omap_plane =3D to_omap_plane(plane);
> + =A0 =A0 =A0 omap_plane->win.rotation =3D BIT(DRM_ROTATE_0);
> =A0 =A0 =A0 =A0return omap_plane_dpms(plane, DRM_MODE_DPMS_OFF);
> =A0}
>
> @@ -409,10 +408,60 @@ void omap_plane_on_endwin(struct drm_plane *pla=
ne,
> =A0 =A0 =A0 =A0install_irq(plane);
> =A0}
>
> +/* helper to install properties which are common to planes and crtcs=
 */
> +void omap_plane_install_properties(struct drm_plane *plane,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct drm_mode_object *obj)
> +{
> + =A0 =A0 =A0 struct drm_device *dev =3D plane->dev;
> + =A0 =A0 =A0 struct omap_drm_private *priv =3D dev->dev_private;
> + =A0 =A0 =A0 struct drm_property *prop;
> +
> + =A0 =A0 =A0 prop =3D priv->rotation_prop;
> + =A0 =A0 =A0 if (!prop) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct drm_prop_enum_list props[]=
 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { DRM_R=
OTATE_0, =A0 "rotate-0" },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { DRM_R=
OTATE_90, =A0"rotate-90" },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { DRM_R=
OTATE_180, "rotate-180" },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { DRM_R=
OTATE_270, "rotate-270" },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { DRM_R=
EFLECT_X, =A0"reflect-x" },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { DRM_R=
EFLECT_Y, =A0"reflect-y" },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D drm_property_create_bitmask(de=
v, 0, "rotation",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 props, =
ARRAY_SIZE(props));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->rotation_prop =3D prop;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 drm_object_attach_property(obj, prop, 0);
> +}
> +
> +int omap_plane_set_property(struct drm_plane *plane,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct drm_property *property, uint64_t=
 val)
> +{
> + =A0 =A0 =A0 struct omap_plane *omap_plane =3D to_omap_plane(plane);
> + =A0 =A0 =A0 struct omap_drm_private *priv =3D plane->dev->dev_priva=
te;
> + =A0 =A0 =A0 int ret =3D -EINVAL;
> +
> + =A0 =A0 =A0 if (property =3D=3D priv->rotation_prop) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl =3D omap_plane=
->ovl;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG("%s: rotation: %02x", ovl->name, (u=
int32_t)val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_plane->win.rotation =3D val;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->is_enabled(ovl))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_plane_dpms=
(plane, DRM_MODE_DPMS_ON);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0static const struct drm_plane_funcs omap_plane_funcs =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.update_plane =3D omap_plane_update,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.disable_plane =3D omap_plane_disable,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.destroy =3D omap_plane_destroy,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_property =3D omap_plane_set_proper=
ty,
> =A0};
>
> =A0/* initialize plane */
> @@ -455,6 +504,8 @@ struct drm_plane *omap_plane_init(struct drm_devi=
ce *dev,
> =A0 =A0 =A0 =A0drm_plane_init(dev, plane, possible_crtcs, &omap_plane=
_funcs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_plane->formats, o=
map_plane->nformats, priv);
>
> + =A0 =A0 =A0 omap_plane_install_properties(plane, &plane->base);
> +
> =A0 =A0 =A0 =A0/* get our starting configuration, set defaults for pa=
rameters
> =A0 =A0 =A0 =A0 * we don't currently use, etc:
> =A0 =A0 =A0 =A0 */
> @@ -463,7 +514,6 @@ struct drm_plane *omap_plane_init(struct drm_devi=
ce *dev,
> =A0 =A0 =A0 =A0omap_plane->info.rotation =3D OMAP_DSS_ROT_0;
> =A0 =A0 =A0 =A0omap_plane->info.global_alpha =3D 0xff;
> =A0 =A0 =A0 =A0omap_plane->info.mirror =3D 0;
> - =A0 =A0 =A0 omap_plane->info.mirror =3D 0;
>
> =A0 =A0 =A0 =A0/* Set defaults depending on whether we are a CRTC or =
overlay
> =A0 =A0 =A0 =A0 * layer.
> --
> 1.7.9.5
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
