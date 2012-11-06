From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH 1/3] omap gpmc : add support of setting CYCLE2CYCLEDELAY and BUSTURNAROUND
Date: Tue,  6 Nov 2012 17:44:35 +0100
Message-ID: <1352220277-4251-1-git-send-email-matthieu.castet@parrot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62480 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab2KFQos (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 11:44:48 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so317573bkc.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 08:44:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: dedekind1@gmail.com, Matthieu CASTET <matthieu.castet@parrot.com>

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
---
 arch/arm/mach-omap2/gpmc.c             |    7 ++++++-
 arch/arm/plat-omap/include/plat/gpmc.h |    2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 8ab1e1b..3957ffc 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -333,8 +333,13 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
 	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
-	if (gpmc_capability & GPMC_HAS_WR_ACCESS)
+	if (gpmc_capability & GPMC_HAS_WR_ACCESS) {
+		/* XXX check on which hardware it is supported */
+		GPMC_SET_ONE(GPMC_CS_CONFIG6,  0,  3, busturnaround);
+		GPMC_SET_ONE(GPMC_CS_CONFIG6,  8, 11, cycle2cycledelay);
+
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
+	}
 
 	/* caller is expected to have initialized CONFIG1 to cover
 	 * at least sync vs async
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 2e6e259..34ca454 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -131,6 +131,8 @@ struct gpmc_timings {
 	/* The following are only on OMAP3430 */
 	u16 wr_access;		/* WRACCESSTIME */
 	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
+	u16 cycle2cycledelay;	/* CYCLE2CYCLEDELAY */
+	u16 busturnaround;		/* BUSTURNAROUND */
 };
 
 struct gpmc_nand_regs {
-- 
1.7.10.4

