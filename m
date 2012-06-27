From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: drm/omap: add rotation properties
Date: Wed, 27 Jun 2012 12:40:22 -0700
Message-ID: <20120627194022.GA9097@kroah.com>
References: <1340805986-10670-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42137 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755752Ab2F0TkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 15:40:25 -0400
Content-Disposition: inline
In-Reply-To: <1340805986-10670-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, cmahapatra@ti.com, s-guiriec@ti.com, archit@ti.com, Rob Clark <rob@ti.com>

On Wed, Jun 27, 2012 at 09:06:26AM -0500, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
> 
> Use tiled buffers for rotated/reflected scanout, with CRTC and plane
> properties as the interface for userspace to configure rotation.
> 
> Signed-off-by: Rob Clark <rob@ti.com>
> ---
>  drivers/staging/omapdrm/omap_crtc.c      |   17 +++++
>  drivers/staging/omapdrm/omap_dmm_tiler.c |   47 ++++++++++++--
>  drivers/staging/omapdrm/omap_dmm_tiler.h |   17 ++++-
>  drivers/staging/omapdrm/omap_drv.c       |   17 +++++
>  drivers/staging/omapdrm/omap_drv.h       |   32 +++++++++-
>  drivers/staging/omapdrm/omap_fb.c        |   99 +++++++++++++++++++++++++-----
>  drivers/staging/omapdrm/omap_gem.c       |   43 ++++++++++++-
>  drivers/staging/omapdrm/omap_plane.c     |   92 ++++++++++++++++++++-------
>  8 files changed, 318 insertions(+), 46 deletions(-)

That's great you are adding new features, but how goes the progress to
get this driver out of the drivers/staging/ area and moved to the real
part of the kernel?  I don't want to keep taking new features without
seeing some progress on getting the code cleaned up and moved out first.

thanks,

greg k-h
