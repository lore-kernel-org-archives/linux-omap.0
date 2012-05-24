From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] staging: omapdrm: fix crash when freeing bad fb
Date: Thu, 24 May 2012 12:41:17 -0600
Message-ID: <CAF6AEGtfn=AOsLBZvS+jhqK63E_b108RFFsqvCT6rovfpAnS=w@mail.gmail.com>
References: <1337877862-5055-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40308 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933458Ab2EXSlw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 14:41:52 -0400
Received: by mail-vc0-f174.google.com with SMTP id f11so53416vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 11:41:52 -0700 (PDT)
In-Reply-To: <1337877862-5055-1-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Gross <andy.gross@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, greg@kroah.com

On Thu, May 24, 2012 at 10:44 AM, Andy Gross <andy.gross@ti.com> wrote:
> During unload, don't cleanup the framebuffer if it is not valid.
>
> Signed-off-by: Andy Gross <andy.gross@ti.com>

Reviewed-by: Rob Clark <rob.clark@linaro.org>

> ---
> =A0drivers/staging/omapdrm/omap_fbdev.c | =A0 10 +++++++---
> =A01 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/omapdrm/omap_fbdev.c b/drivers/staging/o=
mapdrm/omap_fbdev.c
> index 11acd4c..8c6ed3b 100644
> --- a/drivers/staging/omapdrm/omap_fbdev.c
> +++ b/drivers/staging/omapdrm/omap_fbdev.c
> @@ -208,7 +208,8 @@ static int omap_fbdev_create(struct drm_fb_helper=
 *helper,
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0ret =3D omap_gem_get_paddr(fbdev->bo, &paddr, true);
> =A0 =A0 =A0 =A0if (ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev->dev, "could not map (paddr=
)!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "could not map (paddr)!=
 =A0Skipping framebuffer alloc\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
> =A0 =A0 =A0 =A0}
> @@ -388,8 +389,11 @@ void omap_fbdev_free(struct drm_device *dev)
>
> =A0 =A0 =A0 =A0fbi =3D helper->fbdev;
>
> - =A0 =A0 =A0 unregister_framebuffer(fbi);
> - =A0 =A0 =A0 framebuffer_release(fbi);
> + =A0 =A0 =A0 /* only cleanup framebuffer if it is present */
> + =A0 =A0 =A0 if (fbi) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unregister_framebuffer(fbi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 framebuffer_release(fbi);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0drm_fb_helper_fini(helper);
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
