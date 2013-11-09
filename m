From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/2] ARM: OMAP2+: remove unnecesary include in gpmc driver
Date: Sat,  9 Nov 2013 17:34:01 +0100
Message-ID: <1384014842-4288-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:56016 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab3KIQfN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Nov 2013 11:35:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The GPMC driver includes arch/arm/mach-omap2/common.h but
it does not use anything on that header so can be removed.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/gpmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 51525fa..bb2c58a 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -37,7 +37,6 @@
 #include <asm/mach-types.h>
 
 #include "soc.h"
-#include "common.h"
 #include "omap_device.h"
 #include "gpmc.h"
 #include "gpmc-nand.h"
-- 
1.8.4.rc3

