From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] onenand_init: Fix missing comma
Date: Thu,  7 May 2009 10:47:35 +0300
Message-ID: <1241682455-14057-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:22606 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbZEGHqM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 03:46:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so1871417and.1
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2009 00:46:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 71fc05a..712af59 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -123,7 +123,7 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	const int t_wph  = 30;
 	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
 	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
-	int first_time = 0, hf = 0 sync_read = 0, sync_write = 0;
+	int first_time = 0, hf = 0, sync_read = 0, sync_write = 0;
 	int err, ticks_cez;
 	int cs = cfg->cs;
 	u32 reg;
-- 
1.6.2.4

