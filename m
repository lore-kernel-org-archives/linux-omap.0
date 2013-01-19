From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 2/3] arm: omap2: gpmc-onenand: drop __init annotation
Date: Sat, 19 Jan 2013 19:27:56 -0300
Message-ID: <1358634477-25868-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358634477-25868-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49260 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab3ASW2g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Jan 2013 17:28:36 -0500
In-Reply-To: <1358634477-25868-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, thomas.petazzoni@free-electrons.com, martinez.javier@gmail.com, zonque@gmail.com, grant.likely@secretlab.ca, eballetbo@gmail.com, matthias.bgg@googlemail.com, jon-hunter@ti.com, b-cousson@ti.com, tony@atomide.com, Ezequiel Garcia <elezegarcia@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

gpmc_onenand_init() will be called from another driver's probe() function,
so drop the __init annotation, in order to prevent section mismatches.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 94a349e..fadd8743 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -356,7 +356,7 @@ static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
 	return ret;
 }
 
-void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
+void gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 {
 	int err;
 
-- 
1.7.8.6

