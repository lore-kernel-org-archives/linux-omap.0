From: Rob Clark <rob@ti.com>
Subject: Re: [PATCH] staging: drm/omap: remove reclaim_buffers callback
Date: Wed, 1 Aug 2012 12:13:38 -0500
Message-ID: <CAF6AEGuHo6MFpng76F5-j-JDK8nacEBS8rbspsGauBpVUWk51A@mail.gmail.com>
References: <1343813558-28347-1-git-send-email-cmahapatra@ti.com>
	<1343827234-15565-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54729 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab2HAROE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 13:14:04 -0400
Received: by vbbff1 with SMTP id ff1so7192337vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Aug 2012 10:14:03 -0700 (PDT)
In-Reply-To: <1343827234-15565-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: greg@kroah.com, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, sumit.semwal@ti.com

On Wed, Aug 1, 2012 at 8:20 AM, Chandrabhanu Mahapatra
<cmahapatra@ti.com> wrote:
> The reclaim_buffers callback has already been removed by Daniel Vetter
> <daniel.vetter@ffwll.ch> with his patch "drm: kill reclaim_buffers callback"
> (b0071efe82). As a result the kernel compilation fails with omapdrm support
> and so the callback for reclaim_buffers is being removed from omapdrm.
>
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>

Signed-off-by: Rob Clark <rob@ti.com>

> ---
>  drivers/staging/omapdrm/omap_drv.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
> index 342645a..b8e79eb 100644
> --- a/drivers/staging/omapdrm/omap_drv.c
> +++ b/drivers/staging/omapdrm/omap_drv.c
> @@ -778,7 +778,6 @@ static struct drm_driver omap_drm_driver = {
>                 .irq_postinstall = dev_irq_postinstall,
>                 .irq_uninstall = dev_irq_uninstall,
>                 .irq_handler = dev_irq_handler,
> -               .reclaim_buffers = drm_core_reclaim_buffers,
>  #ifdef CONFIG_DEBUG_FS
>                 .debugfs_init = omap_debugfs_init,
>                 .debugfs_cleanup = omap_debugfs_cleanup,
> --
> 1.7.10
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
