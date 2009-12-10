From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] Fix build of OMAP sound drivers
Date: Thu, 10 Dec 2009 11:15:55 -0600
Message-ID: <20091210171555.GB19668@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:38183 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756402AbZLJRMn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Dec 2009 12:12:43 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, Anand Gadiyar <gadiyar@ti.com>

There are build errors when building for some of the omap2/3 boards without
enabling sound:

sound/built-in.o:(.data+0x43bc): undefined reference to `soc_codec_dev_tlv320aic23'
sound/built-in.o:(.data+0x43cc): undefined reference to `tlv320aic23_dai'

Confused me quite a bit since the drivers that had references to the
codec weren't enabled. Turns out the Makefile was using the wrong
config option to enable them. Patch below.



Reported-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index d49458a..3db8a6c 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -23,9 +23,9 @@ obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
-obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
-obj-$(CONFIG_MACH_OMAP3EVM) += snd-soc-omap3evm.o
-obj-$(CONFIG_MACH_OMAP3517EVM) += snd-soc-am3517evm.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3EVM) += snd-soc-omap3evm.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3517EVM) += snd-soc-am3517evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
