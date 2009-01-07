From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [REVIEW PATCH 2/2] Added OMAP3EVM Multi-Media Daughter Card
 Support
Date: Wed, 7 Jan 2009 07:58:32 -0200
Message-ID: <20090107075832.4889c816@pedra.chehab.org>
References: <hvaibhav@ti.com>
	<1231308470-31159-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:38778 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbZAGJ7B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 04:59:01 -0500
In-Reply-To: <1231308470-31159-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, video4linux-list@redhat.com, linux-media@vger.kernel.org

On Wed,  7 Jan 2009 11:37:50 +0530
hvaibhav@ti.com wrote:

>  arch/arm/mach-omap2/Kconfig             |    4 +
>  arch/arm/mach-omap2/Makefile            |    1 +
>  arch/arm/mach-omap2/. |  417 +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-omap3evm-dc.h |   43 ++++
>  arch/arm/mach-omap2/mux.c               |    7 +
>  arch/arm/plat-omap/include/mach/mux.h   |    4 +


> +#if defined(CONFIG_VIDEO_TVP514X) || defined(CONFIG_VIDEO_TVP514X_MODULE)
> +#include <linux/videodev2.h>
> +#include <media/v4l2-int-device.h>
> +#include <media/tvp514x.h>

This smells like a V4L driver, not an arch driver. 
We shoud take some care here, to avoid having the drivers on wrong place.
The proper place on kernel tree for V4L driver is under drivers/media/video,
not under arch/arm. All other architecture-specific V4L drivers are there.

> +/* include V4L2 camera driver related header file */
> +#if defined(CONFIG_VIDEO_OMAP3) || defined(CONFIG_VIDEO_OMAP3_MODULE)
> +#include <../drivers/media/video/omap34xxcam.h>
> +#include <../drivers/media/video/isp/ispreg.h>
> +#endif				/* #ifdef CONFIG_VIDEO_OMAP3 */
> +#endif				/* #ifdef CONFIG_VIDEO_TVP514X*/

Please, don't use ../* at your includes. IMO, the better is to create a
drivers/media/video/omap dir, and put omap2/omap3 files there, including board-omap3evm-dc.c.
This will avoid those ugly includes.

Btw, drivers/media/video/isp/ currently doesn't exist. Please submit the patch for it first.

Cheers,
Mauro
