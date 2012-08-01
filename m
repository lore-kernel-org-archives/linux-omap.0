From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH] staging: drm/omap: remove reclaim_buffers callback
Date: Wed, 1 Aug 2012 15:55:14 +0530
Message-ID: <CAB2ybb_UCiJiOErQxCM3Xi-Z=+vWAH38DqeTUvgGJ_jMJ281Ng@mail.gmail.com>
References: <1343813558-28347-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:56423 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752958Ab2HAKZf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 06:25:35 -0400
Received: by pbbrp16 with SMTP id rp16so911933pbb.24
        for <linux-omap@vger.kernel.org>; Wed, 01 Aug 2012 03:25:34 -0700 (PDT)
In-Reply-To: <1343813558-28347-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: greg@kroah.com, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, rob@ti.com, tomi.valkeinen@ti.com

On Wed, Aug 1, 2012 at 3:02 PM, Chandrabhanu Mahapatra
<cmahapatra@ti.com> wrote:
> The reclaim_buffers callback has already been removed by Daniel Vetter
> <daniel.vetter@ffwll.ch> with his patch "drm: kill reclaim_buffers callback"
> for which the kernel compilation fails with omapdrm support. So, the callback
> for reclaim_buffers is removed from omapdrm.
>
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Reviewed-by: Sumit Semwal <sumit.semwal@ti.com>
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
