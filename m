From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Thu, 9 Feb 2012 09:28:04 -0800
Message-ID: <20120209172804.GA27532@kroah.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41121 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab2BIRhR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 12:37:17 -0500
Received: by pbcun15 with SMTP id un15so1715824pbc.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 09:37:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

On Fri, Jan 13, 2012 at 02:41:59PM -0600, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
> 
> Register OMAP DRM/KMS platform device, and reserve a CMA region for
> the device to use for buffer allocation.
> 
> v1: initial patch
> v2: move platform data structs into plat-omap to avoid having to
>     #include headers from drivers/staging and cleanups
> 
> Signed-off-by: Rob Clark <rob@ti.com>
> ---
> Note: after applying this patch there will be duplicate copies of the
> platform data structs (until the 2nd patch is applied).  But I tested
> to ensure this does not cause build breaks.  So the 2nd patch which
> should go thru staging tree is safe to be held until this patch hits
> Linus's master branch.
> 
>  arch/arm/plat-omap/Makefile           |    2 +-
>  arch/arm/plat-omap/common.c           |    3 +-
>  arch/arm/plat-omap/drm.c              |   83 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/drm.h |   70 +++++++++++++++++++++++++++
>  4 files changed, 156 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/plat-omap/drm.c
>  create mode 100644 arch/arm/plat-omap/include/plat/drm.h

Did this ever get applied?  As I can't apply 2/2 without it, please feel
free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

to 2/2 when some dri/omap developer commits this one.

thanks,

greg k-h
