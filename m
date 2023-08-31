Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCB0C83F3B
	for <linux-omap@archiver.kernel.org>; Thu, 31 Aug 2023 18:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbjHaScD (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 31 Aug 2023 14:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347034AbjHaScD (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 31 Aug 2023 14:32:03 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94D9CE5F;
        Thu, 31 Aug 2023 11:32:00 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="174628367"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 03:32:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 689FD400CEF1;
        Fri,  1 Sep 2023 03:31:58 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/4] mfd: palmas: Remove trailing comma in the terminator entry
Date:   Thu, 31 Aug 2023 19:31:50 +0100
Message-Id: <20230831183153.63750-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831183153.63750-1-biju.das.jz@bp.renesas.com>
References: <20230831183153.63750-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Remove trailing comma in the terminator entry for OF table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/mfd/palmas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 6e562bab62e4..769538b50903 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -499,7 +499,7 @@ static const struct of_device_id of_palmas_match_tbl[] = {
 		.compatible = "ti,tps65917",
 		.data = &tps65917_data,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);
 
-- 
2.25.1

