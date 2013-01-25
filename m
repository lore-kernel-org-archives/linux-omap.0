From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 2/3] arm: omap2: gpmc-onenand: drop __init annotation
Date: Fri, 25 Jan 2013 09:23:10 -0300
Message-ID: <1359116591-32730-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1359116591-32730-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47788 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab3AYMZ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 07:25:58 -0500
In-Reply-To: <1359116591-32730-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, zonque@gmail.com, tony@atomide.com, matthias.bgg@googlemail.com, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-mtd@lists.infradead.org, b-cousson@ti.com, grant.likely@secretlab.ca, jon-hunter@ti.com, Artem Bityutskiy <dedekind1@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

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

