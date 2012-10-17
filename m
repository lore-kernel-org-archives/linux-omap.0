From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: IS_ERR_OR_NULL - please STOP telling people to use this on a whim
Date: Wed, 17 Oct 2012 20:41:57 +0100
Message-ID: <20121017194157.GM21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54314 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942Ab2JQTmK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 15:42:10 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org

People,

This is not aimed at anyone specifically - but it is aimed at everyone
who reviews patches to make them aware of this issue, and to modify their
behaviour.

I'm geting sick and tired of telling people about this.  I've just
floated the idea of removing IS_ERR_OR_NULL from the kernel tree because
it's one of the most incorrectly used and abused macros we have in the
source tree.

It would be one thing if this was only being done by people who are
submitting new code, but it's far worse than that.  Reviewers who should
know better are telling people to use it _incorrectly_.

Reviewers really need to think about your review comments.  Looking
through the kernel tree today, I see lots of uses of IS_ERR_OR_NULL(),
many of them are *buggy*.

Take a moment to think about this:

int error_value(struct device *dev, void *foo)
{
	if (IS_ERR_OR_NULL(foo))
		return PTR_ERR(foo);
	return 0;
}

Consider the value this function returns for three arguments:

1. an errno encoded pointer
2. a NULL pointer.
3. a valid pointer.

If you can't see the problem, then *do* *not* tell anyone to use
IS_ERR_OR_NULL(), because you do *not* have the understanding necessary
to make that judgement yourself - you're probably telling people to
create buggy code.

Here's the list so far of what looks like buggy uses specific to ARM.
There _are_ others elsewhere in the kernel.

drivers/media/video/s5p-mfc/s5p_mfc.c:  if (IS_ERR_OR_NULL(dev->alloc_ctx[0])) {
drivers/media/video/s5p-mfc/s5p_mfc.c-          ret = PTR_ERR(dev->alloc_ctx[0]);
drivers/media/video/s5p-mfc/s5p_mfc.c-          goto err_res;
drivers/media/video/s5p-mfc/s5p_mfc.c-  }
--
drivers/media/video/s5p-mfc/s5p_mfc.c:  if (IS_ERR_OR_NULL(dev->alloc_ctx[1])) {
drivers/media/video/s5p-mfc/s5p_mfc.c-          ret = PTR_ERR(dev->alloc_ctx[1]);
drivers/media/video/s5p-mfc/s5p_mfc.c-          goto err_mem_init_ctx_1;
drivers/media/video/s5p-mfc/s5p_mfc.c-  }
--
drivers/staging/omapdrm/omap_dmm_tiler.c:       if (IS_ERR_OR_NULL(txn))
drivers/staging/omapdrm/omap_dmm_tiler.c-               return PTR_ERR(txn);
drivers/staging/omapdrm/omap_dmm_tiler.c-
drivers/staging/omapdrm/omap_dmm_tiler.c-       tcm_for_each_slice(slice, *area, area_s) {
--
drivers/staging/omap-thermal/omap-bandgap.c:    if (IS_ERR_OR_NULL(bg_ptr)) {
drivers/staging/omap-thermal/omap-bandgap.c-            dev_err(&pdev->dev, "failed to fetch platform data\n");
drivers/staging/omap-thermal/omap-bandgap.c-            return PTR_ERR(bg_ptr);
drivers/staging/omap-thermal/omap-bandgap.c-    }
--
drivers/staging/omap-thermal/omap-thermal-common.c:     if (IS_ERR_OR_NULL(data->omap_thermal)) {
drivers/staging/omap-thermal/omap-thermal-common.c-             dev_err(bg_ptr->dev, "thermal zone device is NULL\n");
drivers/staging/omap-thermal/omap-thermal-common.c-             return PTR_ERR(data->omap_thermal);
drivers/staging/omap-thermal/omap-thermal-common.c-     }
--
drivers/staging/omap-thermal/omap-thermal-common.c:     if (IS_ERR_OR_NULL(freq_table)) {
drivers/staging/omap-thermal/omap-thermal-common.c-             dev_err(bg_ptr->dev,
drivers/staging/omap-thermal/omap-thermal-common.c-                     "%s: failed to get cpufreq table (%p)\n",
drivers/staging/omap-thermal/omap-thermal-common.c-                     __func__, freq_table);
--
drivers/staging/omap-thermal/omap-thermal-common.c:     if (IS_ERR_OR_NULL(data->cool_dev)) {
drivers/staging/omap-thermal/omap-thermal-common.c-             dev_err(bg_ptr->dev,
drivers/staging/omap-thermal/omap-thermal-common.c-                     "Failed to register cpufreq cooling device\n");
drivers/staging/omap-thermal/omap-thermal-common.c-             return PTR_ERR(data->cool_dev);
--
drivers/gpu/drm/exynos/exynos_drm_dmabuf.c:     if (IS_ERR_OR_NULL(sgt)) {
drivers/gpu/drm/exynos/exynos_drm_dmabuf.c-             ret = PTR_ERR(sgt);
drivers/gpu/drm/exynos/exynos_drm_dmabuf.c-             goto err_buf_detach;
drivers/gpu/drm/exynos/exynos_drm_dmabuf.c-     }
--
drivers/gpu/drm/exynos/exynos_drm_fbdev.c:      if (IS_ERR_OR_NULL(helper->fb)) {
drivers/gpu/drm/exynos/exynos_drm_fbdev.c-              DRM_ERROR("failed to create drm framebuffer.\n");
drivers/gpu/drm/exynos/exynos_drm_fbdev.c-              ret = PTR_ERR(helper->fb);
drivers/gpu/drm/exynos/exynos_drm_fbdev.c-              goto out;
--
