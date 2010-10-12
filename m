From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] ASoC: OMAP4: MCPDM: Remove unnecessary include of plat/control.h
Date: Tue, 12 Oct 2010 18:57:58 +0530
Message-ID: <1286890078-32610-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41077 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932371Ab0JLN2V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Oct 2010 09:28:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Commit 346a5c890 (OMAP: control: move plat-omap/control.h
to mach-omap2/control.h) in the linux-omap tree removed
plat/control.h and most of its callers. This one slipped
through - breaking the build as below when
CONFIG_SND_OMAP_SOC_MCPDM is defined. Fix this.

  CC      sound/soc/omap/omap-mcpdm.o
sound/soc/omap/omap-mcpdm.c:35: fatal error: plat/control.h: No such file or directory
compilation terminated.
make[3]: *** [sound/soc/omap/omap-mcpdm.o] Error 1
make[2]: *** [sound/soc/omap] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
This break is reproducible on linux-next as of 20101011;
I think it also exists in mainline, but I did not check.

Probably worth taking this through the ALSA tree with Tony
or Paul's ack. 

I'm not subscribed to the alsa list. Please CC me on replies.

 sound/soc/omap/omap-mcpdm.c |    1 -
 1 file changed, 1 deletion(-)

Index: mainline/sound/soc/omap/omap-mcpdm.c
===================================================================
--- mainline.orig/sound/soc/omap/omap-mcpdm.c
+++ mainline/sound/soc/omap/omap-mcpdm.c
@@ -32,7 +32,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include <plat/control.h>
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
 #include "mcpdm.h"
