From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 2/2] ASoC: Modifying the license string GPLv2 for OMAP3 EVM
Date: Tue, 17 Nov 2009 21:43:42 +0530
Message-ID: <1258474422-29738-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59571 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbZKQQNl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 11:13:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, Anuj Aggarwal <anuj.aggarwal@ti.com>

Correcting the license string from GPLv2 -> GPL v2.
Found the problem while building OMAP3 ASoC driver as
module.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/omap/omap3evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
index 41a91b5..627fadb 100644
--- a/sound/soc/omap/omap3evm.c
+++ b/sound/soc/omap/omap3evm.c
@@ -144,4 +144,4 @@ module_exit(omap3evm_soc_exit);
 
 MODULE_AUTHOR("Anuj Aggarwal <anuj.aggarwal@ti.com>");
 MODULE_DESCRIPTION("ALSA SoC OMAP3 EVM");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
1.6.2.4

