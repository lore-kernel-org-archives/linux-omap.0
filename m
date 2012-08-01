From: Rob Clark <rob@ti.com>
Subject: Re: [PATCH] staging: drm/omap: remove reclaim_buffers callback
Date: Wed, 1 Aug 2012 06:48:13 -0500
Message-ID: <CAF6AEGuwiUeV5QnsYW4H0=e2Ju+8MAxej3+j=6nu2=3RHiYBPA@mail.gmail.com>
References: <1343813558-28347-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1343813558-28347-1-git-send-email-cmahapatra@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: greg@kroah.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 1, 2012 at 4:32 AM, Chandrabhanu Mahapatra
<cmahapatra@ti.com> wrote:
> The reclaim_buffers callback has already been removed by Daniel Vetter
> <daniel.vetter@ffwll.ch> with his patch "drm: kill reclaim_buffers callback"
> for which the kernel compilation fails with omapdrm support. So, the callback
> for reclaim_buffers is removed from omapdrm.
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
