From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC/PATCH v3 6/7] omap3: Export omap3isp platform device structure
Date: Thu, 25 Nov 2010 12:17:59 +0100
Message-ID: <201011251218.00331.laurent.pinchart@ideasonboard.com>
References: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com> <1290653678-15556-7-git-send-email-laurent.pinchart@ideasonboard.com> <20101125070241.GX2468@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:39263 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0KYLRu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 06:17:50 -0500
In-Reply-To: <20101125070241.GX2468@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, linux-media@vger.kernel.org

Hi Felipe,

On Thursday 25 November 2010 08:02:41 Felipe Balbi wrote:
> On Thu, Nov 25, 2010 at 03:54:37AM +0100, Laurent Pinchart wrote:
> >From: Stanimir Varbanov <svarbanov@mm-sol.com>
> >
> >The omap3isp platform device requires platform data. As the data can be
> >provided by a kernel module, the device can't be registered during arch
> >initialization.
> >
> >Remove the omap3isp platform device registration from
> >omap_init_camera(), and export the platform device structure to let
> >board code register/unregister it.
> 
> instead, why don't you...
> 
> >diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> >index d5da345..c2275d3 100644
> >--- a/arch/arm/mach-omap2/devices.c
> >+++ b/arch/arm/mach-omap2/devices.c
> >@@ -34,6 +34,8 @@
> >
> > #include "mux.h"
> > #include "control.h"
> >
> >+#include "devices.h"
> >+
> >
> > #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
> > 
> > static struct resource cam_resources[] = {
> >
> >@@ -144,16 +146,28 @@ static struct resource omap3isp_resources[] = {
> >
> > 	}
> > 
> > };
> >
> >-static struct platform_device omap3isp_device = {
> >+static void omap3isp_release(struct device *dev)
> >+{
> >+	/* Zero the device structure to avoid re-initialization complaints from
> >+	 * kobject when the device will be re-registered.
> >+	 */
> >+	memset(dev, 0, sizeof(*dev));
> >+	dev->release = omap3isp_release;
> >+}
> >+
> >+struct platform_device omap3isp_device = {
> >
> > 	.name		= "omap3isp",
> > 	.id		= -1,
> > 	.num_resources	= ARRAY_SIZE(omap3isp_resources),
> > 	.resource	= omap3isp_resources,
> >
> >+	.dev = {
> >+		.release	= omap3isp_release,
> >+	},
> >
> > };
> >
> >+EXPORT_SYMBOL_GPL(omap3isp_device);
> >
> > static inline void omap_init_camera(void)
> 
> pass platform_data as an argument to this call ? Then remove the static
> inline and export this one ?

Yes indeed, why ? :-)

I guess things like that are difficult to spot when you've had your nose on 
the code for too long. Thanks for the review, I'll fix this.

-- 
Regards,

Laurent Pinchart
