From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 1/4] drm/omap: Don't return from modeset_init if a panel
 doesn't satisfy omapdrm requirements
Date: Tue, 5 Mar 2013 19:34:50 -0500
Message-ID: <CAF6AEGtSZ_rQQbt3JWYooduPhHHEEhv8Ra9yp5WrpWUxZOtTrA@mail.gmail.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com>
	<1362493070-17706-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:53699 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab3CFAev (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 19:34:51 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so6712328iae.25
        for <linux-omap@vger.kernel.org>; Tue, 05 Mar 2013 16:34:50 -0800 (PST)
In-Reply-To: <1362493070-17706-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tue, Mar 5, 2013 at 9:17 AM, Archit Taneja <archit@ti.com> wrote:
> modeset_init iterates through all the registered omapdss devices and has some
> initial checks to see if the panel has a driver and the required driver ops for
> it to be usable by omapdrm.
>
> The function bails out from modeset_init if a panel doesn't meet the
> requirements, and stops the registration of the future panels and encoders which
> come after it, that isn't the correct thing to do, we should go through the rest
> of the panels. Replace the 'return's with 'continue's.
>
> Signed-off-by: Archit Taneja <archit@ti.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/omapdrm/omap_drv.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index 079c54c..77b7225 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -121,7 +121,7 @@ static int omap_modeset_init(struct drm_device *dev)
>                 if (!dssdev->driver) {
>                         dev_warn(dev->dev, "%s has no driver.. skipping it\n",
>                                         dssdev->name);
> -                       return 0;
> +                       continue;
>                 }
>
>                 if (!(dssdev->driver->get_timings ||
> @@ -129,7 +129,7 @@ static int omap_modeset_init(struct drm_device *dev)
>                         dev_warn(dev->dev, "%s driver does not support "
>                                 "get_timings or read_edid.. skipping it!\n",
>                                 dssdev->name);
> -                       return 0;
> +                       continue;
>                 }
>
>                 encoder = omap_encoder_init(dev, dssdev);
> --
> 1.7.10.4
>
