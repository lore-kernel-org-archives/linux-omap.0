From: Tony Lindgren <tony@atomide.com>
Subject: ASoC: Fix wrong include for McPDM
Date: Wed, 3 Oct 2012 09:52:14 -0700
Message-ID: <20121003165213.GC4840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:62044 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965019Ab2JCQwU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 12:52:20 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org

McPDM needs platt/cpu.h for omap_rev and not omap_hwmod.h.
Drivers must not include omap_hwmod.h at, it will be
private to mach-omap2 soon. Fix the problem before other
drivers will also start including omap_hwmod.h.

Note that also plat/cpu.h will be going away, so the
omap_rev check needs to be replaced with mcpdm-watchdog
flag from platform_data or DT.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Can you guys please queue this as fix for -rc1?

This removes and unnecessary dependency for making
omap_hwmod.h local to mach-omap2.

Then I'm hoping Peter will remove the plat/cpu.h
dependency for v3.8 merge window ;)

--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -40,7 +40,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <plat/omap_hwmod.h>
+#include <plat/cpu.h>
 #include "omap-mcpdm.h"
 #include "omap-pcm.h"
 
