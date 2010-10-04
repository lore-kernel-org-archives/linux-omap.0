From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] omap: devices: Avoid merge conflict between ASoC and OMAP hwmod changes
Date: Mon,  4 Oct 2010 15:04:53 +0300
Message-ID: <1286193893-22131-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49955 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab0JDMGK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 08:06:10 -0400
Received: by eyb6 with SMTP id 6so1765810eyb.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 05:06:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Upcoming ASoC multi-component and OMAP hwmod changes will conflict
in arch/arm/mach-omap2/devices.c. Avoid this by moving a little bit
include statement introduced by ASoC Multi-Component Support patch.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
This is intended to be merged with "ASoC: multi-component -
ASoC Multi-Component Support" patch via ASoC tree.
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 08e1ad5..512ae46 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -25,10 +25,10 @@
 #include <plat/control.h>
 #include <plat/tc.h>
 #include <plat/board.h>
+#include <plat/mcbsp.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
-#include <plat/mcbsp.h>
 
 #include "mux.h"
 
-- 
1.7.1

