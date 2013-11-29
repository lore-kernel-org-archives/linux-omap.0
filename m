From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in GPMC driver
Date: Fri, 29 Nov 2013 20:18:16 +0100
Message-ID: <1385752697-13700-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40428 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab3K2TTe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 14:19:34 -0500
In-Reply-To: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The GPMC driver includes arch/arm/mach-omap2/common.h but
does not use anything on that header so it can be removed.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/gpmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index d24926e..9035cd4 100644
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
1.8.4.2

