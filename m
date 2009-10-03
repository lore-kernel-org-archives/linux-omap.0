From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH 6/8] omapfb: Condition mutex acquisition
Date: Sat, 3 Oct 2009 11:38:18 -0700
Message-ID: <6cb013310910031138k6086d1faje44d1582e5db9422@mail.gmail.com>
References: <20091002223510.11962.21751.stgit@localhost> <20091002224413.11962.12302.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:43758 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710AbZJCSjO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Oct 2009 14:39:14 -0400
In-Reply-To: <20091002224413.11962.12302.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Imre Deak <imre.deak@nokia.com>, Sergio Aguirre <saaguirre@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Fri, Oct 2, 2009 at 3:44 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> From: Sergio Aguirre <saaguirre@ti.com>
>
> This fixes a bug introduced by this commit ID:
>
> =A0commit 537a1bf059fa312355696fa6db80726e655e7f17
> =A0Author: Krzysztof Helt <krzysztof.h1@wp.pl>
> =A0Date: =A0 Tue Jun 30 11:41:29 2009 -0700
>
> =A0 =A0fbdev: add mutex for fb_mmap locking
>
> In which a mutex was added when changing smem_start and smem_len fiel=
ds,
> so the mutex inside the fb_mmap() call is actually used.
>
> The problem was that set_fb_fix, which modifies the above 2 fields,
> was called before and after registering the framebuffer,
> which when used before registration, lead to a failed attempt to
> use an uninitialized mutex.
>
> Solution: Don't use mutex before framebuffer registration.
>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Acked-by: Imre Deak <imre.deak@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> =A0drivers/video/omap/omapfb_main.c | =A0 22 ++++++++++++++--------
> =A01 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/om=
apfb_main.c
> index 125e605..0d0c8c8 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -393,7 +393,7 @@ static void omapfb_sync(struct fb_info *fbi)
> =A0* Set fb_info.fix fields and also updates fbdev.
> =A0* When calling this fb_info.var must be set up already.
> =A0*/
> -static void set_fb_fix(struct fb_info *fbi)
> +static void set_fb_fix(struct fb_info *fbi, int from_init)
> =A0{
> =A0 =A0 =A0 =A0struct fb_fix_screeninfo *fix =3D &fbi->fix;
> =A0 =A0 =A0 =A0struct fb_var_screeninfo *var =3D &fbi->var;
> @@ -403,10 +403,16 @@ static void set_fb_fix(struct fb_info *fbi)
>
> =A0 =A0 =A0 =A0rg =3D &plane->fbdev->mem_desc.region[plane->idx];
> =A0 =A0 =A0 =A0fbi->screen_base =A0 =A0 =A0 =A0=3D rg->vaddr;
> - =A0 =A0 =A0 mutex_lock(&fbi->mm_lock);
> - =A0 =A0 =A0 fix->smem_start =A0 =A0 =A0 =A0 =3D rg->paddr;
> - =A0 =A0 =A0 fix->smem_len =A0 =A0 =A0 =A0 =A0 =3D rg->size;
> - =A0 =A0 =A0 mutex_unlock(&fbi->mm_lock);
> +
> + =A0 =A0 =A0 if (!from_init) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&fbi->mm_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fix->smem_start =A0 =A0 =A0 =A0 =3D rg-=
>paddr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fix->smem_len =A0 =A0 =A0 =A0 =A0 =3D r=
g->size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&fbi->mm_lock);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fix->smem_start =A0 =A0 =A0 =A0 =3D rg-=
>paddr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fix->smem_len =A0 =A0 =A0 =A0 =A0 =3D r=
g->size;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0fix->type =3D FB_TYPE_PACKED_PIXELS;
> =A0 =A0 =A0 =A0bpp =3D var->bits_per_pixel;
> @@ -704,7 +710,7 @@ static int omapfb_set_par(struct fb_info *fbi)
> =A0 =A0 =A0 =A0int r =3D 0;
>
> =A0 =A0 =A0 =A0omapfb_rqueue_lock(fbdev);
> - =A0 =A0 =A0 set_fb_fix(fbi);
> + =A0 =A0 =A0 set_fb_fix(fbi, 0);
> =A0 =A0 =A0 =A0r =3D ctrl_change_mode(fbi);
> =A0 =A0 =A0 =A0omapfb_rqueue_unlock(fbdev);
>
> @@ -904,7 +910,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, =
struct omapfb_mem_info *mi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (old_size !=3D size) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (size) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memcpy=
(&fbi->var, new_var, sizeof(fbi->var));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fb_=
fix(fbi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fb_=
fix(fbi, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Set=
 these explicitly to indicate that the
> @@ -1504,7 +1510,7 @@ static int fbinfo_init(struct omapfb_device *fb=
dev, struct fb_info *info)
> =A0 =A0 =A0 =A0var->bits_per_pixel =3D fbdev->panel->bpp;
>
> =A0 =A0 =A0 =A0set_fb_var(info, var);
> - =A0 =A0 =A0 set_fb_fix(info);
> + =A0 =A0 =A0 set_fb_fix(info, 1);
>
> =A0 =A0 =A0 =A0r =3D fb_alloc_cmap(&info->cmap, 16, 0);
> =A0 =A0 =A0 =A0if (r !=3D 0)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

Tested-by: Cory Maccarrone <darkstar6262@gmail.com>

This patch works beautifully for omap850-based devices.  I need only
add a board file and LCD resolution parameters, and I get a fully
working framebuffer.

I have tested with linux-omap master (commit
6469d1c660f8751ff39836c81970cdbe46953057), adding only the board/lcd
files on HTC Herald.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
