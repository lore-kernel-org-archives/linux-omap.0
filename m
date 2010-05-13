From: Senthilvadivu Guruswamy <svadivu@ti.com>
Subject: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB
Date: Thu, 13 May 2010 20:50:26 +0530
Message-ID: <1273764028-25822-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56001 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712Ab0EMPUm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 May 2010 11:20:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy  <svadivu@ti.com>

Hi all,

This patch series replaces the patch 
"DSS2 Include VRFB into omap2-3build only"
Thanks for the review comments. 

The intent of this series is to split the patch into 2 logical
patches and also to incorporate the comments on multi-omap build.

In this series, Kconfig is changed to have 
OMAP2_VRFB depend on ARCH_OMAP2 and ARCH_OMAP3.
This change takes care of the multi-omap builds. 

This patch would allow successful build of omap_4430sdp_defconfig 
when OMAP2_DSS and FB_OMAP2 is enabled from menuconfig.

For verification: Generated the .config on omap3_defconfig with DSS
and FB enabled. Generated .config is same with and without the patch.

List of Changed Files:
arch/arm/plat-omap/include/plat/vrfb.h
drivers/video/omap2/Kconfig
drivers/video/omap2/omapfb/Kconfig

Thanks,
Senthil
