Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9FEC433E6
	for <linux-omap@archiver.kernel.org>; Tue,  2 Feb 2021 07:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0278864E8F
	for <linux-omap@archiver.kernel.org>; Tue,  2 Feb 2021 07:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhBBHDW (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 2 Feb 2021 02:03:22 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:54741 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232210AbhBBHCv (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2021 02:02:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UNfEquR_1612249209;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNfEquR_1612249209)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 15:00:09 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tony@atomide.com
Cc:     p.zabel@pengutronix.de, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] bus: ti-sysc: remove unneeded semicolon
Date:   Tue,  2 Feb 2021 15:00:05 +0800
Message-Id: <1612249205-58955-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/bus/ti-sysc.c:1595:2-3: Unneeded semicolon
./drivers/bus/ti-sysc.c:2833:3-4: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/bus/ti-sysc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index a27d751..8b8aa9c 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1592,7 +1592,7 @@ static u32 sysc_quirk_dispc(struct sysc *ddata, int dispc_offset,
 	case SOC_UNKNOWN:
 	default:
 		return 0;
-	};
+	}
 
 	/* Remap the whole module range to be able to reset dispc outputs */
 	devm_iounmap(ddata->dev, ddata->module_va);
@@ -2830,7 +2830,7 @@ static int sysc_init_soc(struct sysc *ddata)
 			break;
 		default:
 			break;
-		};
+		}
 	}
 
 	match = soc_device_match(sysc_soc_feat_match);
-- 
1.8.3.1

