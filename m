Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E159C433EF
	for <linux-omap@archiver.kernel.org>; Thu,  3 Mar 2022 12:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiCCMqm (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 3 Mar 2022 07:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiCCMqm (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2022 07:46:42 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1DC184B48
        for <linux-omap@vger.kernel.org>; Thu,  3 Mar 2022 04:45:56 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6495:14e6:1343:3ecb])
        by laurent.telenet-ops.be with bizsmtp
        id 1olu2700m5ER6nL01olvU9; Thu, 03 Mar 2022 13:45:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nPkqA-002Xrr-HP; Thu, 03 Mar 2022 13:45:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nPkq9-008DA1-Qu; Thu, 03 Mar 2022 13:45:53 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] bus: ti-sysc: Drop commas after SoC match table sentinels
Date:   Thu,  3 Mar 2022 13:45:52 +0100
Message-Id: <602f74030dc746eaa9f82f115acc46e62c6be165.1646311501.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

It does not make sense to have a comma after a sentinel, as any new
elements must be added before the sentinel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/bus/ti-sysc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 54c0ee6dda3021e8..41d5e69063f5117b 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3049,7 +3049,7 @@ static const struct soc_device_attribute sysc_soc_match[] = {
 	SOC_FLAG("AM43*", SOC_AM4),
 	SOC_FLAG("DRA7*", SOC_DRA7),
 
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 /*
@@ -3070,7 +3070,7 @@ static const struct soc_device_attribute sysc_soc_feat_match[] = {
 	SOC_FLAG("OMAP3615/AM3715", DIS_IVA),
 	SOC_FLAG("OMAP3621", DIS_ISP),
 
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int sysc_add_disabled(unsigned long base)
-- 
2.25.1

