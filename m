From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] drm/omap: use omapdss low level API
Date: Fri, 16 Nov 2012 04:19:28 -0800
Message-ID: <20121116121928.GA20226@kroah.com>
References: <1353024058-11504-1-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44796 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab2KPMSn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 07:18:43 -0500
Content-Disposition: inline
In-Reply-To: <1353024058-11504-1-git-send-email-robdclark@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, patches@linaro.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Thu, Nov 15, 2012 at 06:00:58PM -0600, Rob Clark wrote:
> This patch changes the omapdrm KMS to bypass the omapdss "compat"
> layer and use the core omapdss API directly.  This solves some layering
> issues that would cause unpin confusion vs GO bit status, because we
> would not know whether a particular pageflip or overlay update has hit
> the screen or not.  Now instead we explicitly manage the GO bits in
> dispc and handle the vblank/framedone interrupts ourself so that we
> always know which buffers are being scanned out at any given time, and
> so on.
> 
> As an added bonus, we no longer leave the last overlay buffer pinned
> when the display is disabled, and have been able to add the previously
> missing vblank event handling.
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
> Note: this patch applies on top of staging-next plus the "OMAPDSS:
> create compat layer" patch series:
> 
> http://comments.gmane.org/gmane.linux.ports.arm.omap/89435

Hm, I can't take that patch set in staging-next, so how should this go
in?

thanks,

greg k-h
