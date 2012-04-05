From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: drm/omap: move where DMM driver is registered
Date: Thu, 5 Apr 2012 09:41:12 -0700
Message-ID: <20120405164112.GB16546@kroah.com>
References: <1333640096-24142-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37558 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752324Ab2DEQlO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 12:41:14 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1F5CA21AC9
	for <linux-omap@vger.kernel.org>; Thu,  5 Apr 2012 12:41:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1333640096-24142-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

On Thu, Apr 05, 2012 at 10:34:56AM -0500, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
> 
> Not sure what triggered the change in behavior, but seems to
> result in recursively acquiring a mutex and hanging on boot.  But
> omap_drm_init() seems a much more sane place to register the
> driver for the DMM sub-device.
> ---
>  drivers/staging/omapdrm/omap_drv.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

Is this needed for 3.4-final?  Any older kernels like 3.3 as well?

thanks,

greg k-h
