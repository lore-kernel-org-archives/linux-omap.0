From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 09/21] drm/omap: handle mismatching color format and
 buffer width
Date: Fri, 27 Feb 2015 14:01:58 +0100
Message-ID: <20150227130158.GX24485@phenom.ffwll.local>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
 <1424956829-22892-10-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:41891 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbB0NAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2015 08:00:51 -0500
Received: by wghl18 with SMTP id l18so20287627wgh.8
        for <linux-omap@vger.kernel.org>; Fri, 27 Feb 2015 05:00:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424956829-22892-10-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

On Thu, Feb 26, 2015 at 03:20:17PM +0200, Tomi Valkeinen wrote:
> omapdrm doesn't check if the width of the framebuffer and the color
> format's bits-per-pixel match.
> 
> For example, using a display with a width of 1280, and a buffer
> allocated with using 32 bits per pixel (i.e. 1280*4 = 5120 bytes), with
> a 24 bits per pixel color format, leads to the following mismatch:
> 5120/3 = 1706.666... bytes. This causes bad colors and a tilt on the
> screen.
> 
> Add a check into omapdrm to return an error if the user tries to use
> such a combination.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_fb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
> index 2975096abdf5..bf98580223d0 100644
> --- a/drivers/gpu/drm/omapdrm/omap_fb.c
> +++ b/drivers/gpu/drm/omapdrm/omap_fb.c
> @@ -463,6 +463,14 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
>  			goto fail;
>  		}
>  
> +		if (mode_cmd->width % format->planes[i].stride_bpp != 0) {

width is in pixels. No idea what you're trying to check here, but this
probably isn't it.

Also drm checks that things fit into the specified pitch (which is in
bytes), see the pichtes[i] < width * cpp check in framebuffer_check.

Cheers, Daniel
> +			dev_err(dev->dev,
> +				"buffer width (%d) is not a multiple of pixel width (%d)\n",
> +				mode_cmd->width, format->planes[i].stride_bpp);
> +			ret = -EINVAL;
> +			goto fail;
> +		}
> +
>  		size = pitch * mode_cmd->height / format->planes[i].sub_y;
>  
>  		if (size > (omap_gem_mmap_size(bos[i]) - mode_cmd->offsets[i])) {
> -- 
> 2.3.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
