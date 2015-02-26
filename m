From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH 14/21] drm/omap: stop connector polling during suspend
Date: Thu, 26 Feb 2015 15:57:17 +0200
Message-ID: <54EF263D.5050904@linaro.org>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com> <1424956829-22892-15-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45400 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbBZN5W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:57:22 -0500
Received: by lbjb6 with SMTP id b6so10882185lbj.12
        for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2015 05:57:21 -0800 (PST)
In-Reply-To: <1424956829-22892-15-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>

Hi Tomi,

On 02/26/2015 03:20 PM, Tomi Valkeinen wrote:
> When not using proper hotplug detection, DRM polls periodically the
> connectors to find out if a cable is connected. This polling can happen
> at any time, even very late in the suspend process.
> 
> This causes a problem with omapdrm, when the poll happens during the
> suspend process after GPIOs have been disabled, leading to a crash in
> gpio_get().
> 
> This patch fixes the issue by adding suspend and resume hooks to
> omapdrm, in which we disable and enable, respectively, the polling.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/gpu/drm/omapdrm/omap_drv.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index 0ebd1315fff8..d0b1aece8cc5 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -694,9 +694,28 @@ static int pdev_remove(struct platform_device *device)
>   	return 0;
>   }
>   
> +static int omap_drm_suspend(struct device *dev)
> +{
> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +
> +	drm_kms_helper_poll_disable(drm_dev);
> +
> +	return 0;
> +}
> +
> +static int omap_drm_resume(struct device *dev)
> +{
> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +
> +	drm_kms_helper_poll_enable(drm_dev);
> +
> +	return omap_gem_resume(dev);
> +}
> +
>   #ifdef CONFIG_PM
>   static const struct dev_pm_ops omapdrm_pm_ops = {
> -	.resume = omap_gem_resume,
> +	.suspend = omap_drm_suspend,
> +	.resume = omap_drm_resume,
>   };
>   #endif
>   
> 

Could I ask you to update this patch as below, pls?

Regards,
-grygorii

===
drm/omap: add hibernation callbacks

Setting a dev_pm_ops suspend/resume pair but not a set of
hibernation functions means those pm functions will not be
called upon hibernation.
Fix this by using SET_SYSTEM_SLEEP_PM_OPS, which appropriately
assigns the suspend and hibernation handlers and move
omap_drm_suspend/omap_drm_resume under CONFIG_PM_SLEEP
to avoid build warnings.

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 7cb1c8f..4a544e4 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -715,6 +715,7 @@ static int pdev_remove(struct platform_device *device)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int omap_drm_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
@@ -732,21 +733,15 @@ static int omap_drm_resume(struct device *dev)
 
 	return omap_gem_resume(dev);
 }
-
-#ifdef CONFIG_PM
-static const struct dev_pm_ops omapdrm_pm_ops = {
-	.suspend = omap_drm_suspend,
-	.resume = omap_drm_resume,
-};
 #endif
 
+static SIMPLE_DEV_PM_OPS(omapdrm_pm_ops, omap_drm_suspend, omap_drm_resume);
+
 static struct platform_driver pdev = {
 		.driver = {
 			.name = DRIVER_NAME,
 			.owner = THIS_MODULE,
-#ifdef CONFIG_PM
 			.pm = &omapdrm_pm_ops,
-#endif
 		},
 		.probe = pdev_probe,
 		.remove = pdev_remove,
-- 1.9.1 

-- 
regards,
-grygorii
