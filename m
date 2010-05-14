From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB
Date: Fri, 14 May 2010 10:23:34 +0300
Message-ID: <1273821814.2814.63.camel@tubuntu.research.nokia.com>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42440 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab0ENHXy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 03:23:54 -0400
In-Reply-To: <1273764028-25822-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "hvaibhav@ti.com" <hvaibhav@ti.com>

Hi,

On Thu, 2010-05-13 at 17:20 +0200, ext Senthilvadivu Guruswamy wrote:
> From: Senthilvadivu Guruswamy  <svadivu@ti.com>
> 
> Hi all,
> 
> This patch series replaces the patch 
> "DSS2 Include VRFB into omap2-3build only"
> Thanks for the review comments. 
> 
> The intent of this series is to split the patch into 2 logical
> patches and also to incorporate the comments on multi-omap build.
> 
> In this series, Kconfig is changed to have 
> OMAP2_VRFB depend on ARCH_OMAP2 and ARCH_OMAP3.
> This change takes care of the multi-omap builds. 
> 
> This patch would allow successful build of omap_4430sdp_defconfig 
> when OMAP2_DSS and FB_OMAP2 is enabled from menuconfig.
> 
> For verification: Generated the .config on omap3_defconfig with DSS
> and FB enabled. Generated .config is same with and without the patch.
> 
> List of Changed Files:
> arch/arm/plat-omap/include/plat/vrfb.h
> drivers/video/omap2/Kconfig
> drivers/video/omap2/omapfb/Kconfig

The patch set makes VRFB optional. What happens if VRFB is turned off,
and the user uses VRFB for a framebuffer?

 Tomi


