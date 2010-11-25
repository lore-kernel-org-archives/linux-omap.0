From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH v3 6/7] omap3: Export omap3isp platform device
 structure
Date: Thu, 25 Nov 2010 09:02:41 +0200
Message-ID: <20101125070241.GX2468@legolas.emea.dhcp.ti.com>
References: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1290653678-15556-7-git-send-email-laurent.pinchart@ideasonboard.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44362 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751373Ab0KYHCs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 02:02:48 -0500
Received: by mail-gy0-f182.google.com with SMTP id 3so10895468gyf.27
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 23:02:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290653678-15556-7-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com

On Thu, Nov 25, 2010 at 03:54:37AM +0100, Laurent Pinchart wrote:
>From: Stanimir Varbanov <svarbanov@mm-sol.com>
>
>The omap3isp platform device requires platform data. As the data can be
>provided by a kernel module, the device can't be registered during arch
>initialization.
>
>Remove the omap3isp platform device registration from
>omap_init_camera(), and export the platform device structure to let
>board code register/unregister it.

instead, why don't you...

>diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>index d5da345..c2275d3 100644
>--- a/arch/arm/mach-omap2/devices.c
>+++ b/arch/arm/mach-omap2/devices.c
>@@ -34,6 +34,8 @@
> #include "mux.h"
> #include "control.h"
>
>+#include "devices.h"
>+
> #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
>
> static struct resource cam_resources[] = {
>@@ -144,16 +146,28 @@ static struct resource omap3isp_resources[] = {
> 	}
> };
>
>-static struct platform_device omap3isp_device = {
>+static void omap3isp_release(struct device *dev)
>+{
>+	/* Zero the device structure to avoid re-initialization complaints from
>+	 * kobject when the device will be re-registered.
>+	 */
>+	memset(dev, 0, sizeof(*dev));
>+	dev->release = omap3isp_release;
>+}
>+
>+struct platform_device omap3isp_device = {
> 	.name		= "omap3isp",
> 	.id		= -1,
> 	.num_resources	= ARRAY_SIZE(omap3isp_resources),
> 	.resource	= omap3isp_resources,
>+	.dev = {
>+		.release	= omap3isp_release,
>+	},
> };
>+EXPORT_SYMBOL_GPL(omap3isp_device);
>
> static inline void omap_init_camera(void)

pass platform_data as an argument to this call ? Then remove the static
inline and export this one ?

-- 
balbi
