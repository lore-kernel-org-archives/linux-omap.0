Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C38C43334
	for <linux-omap@archiver.kernel.org>; Sat, 18 Jun 2022 02:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiFRCGg (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 17 Jun 2022 22:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiFRCGf (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2022 22:06:35 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 852BF6BFCF;
        Fri, 17 Jun 2022 19:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EAsCU
        KKeiwY5QLBCLD7SywZlE+l74qoFoWfMvGpQHv0=; b=cOVoDSiURhPxJq7MmGH7E
        8id3oXGzTAyz7CAQsZzx4empc38ABwgfvJo23GS5zIbOnpFYoBpOypI7bzdvageo
        OPCo90Nk5ZHvC046/A3ejAzfiPBYbKqsDjInZLcMhICZ1SxcV9tnZdje1BuyBD0+
        EEVseGHEwfTFyWoxJb3hmg=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgCHGocMM61iFnKOFw--.45543S2;
        Sat, 18 Jun 2022 10:06:05 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tony@atomide.com, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-omap2: pdata-quirks: Fix refcount leak bug
Date:   Sat, 18 Jun 2022 10:06:03 +0800
Message-Id: <20220618020603.4055792-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgCHGocMM61iFnKOFw--.45543S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1rtw13Cr4xGr45Aw13Arb_yoWxtFX_Xw
        n3Ka1xXrn3Jw4Iqr1Dtr4fGr1vvwsIgrsrW34IqFn0kayUXFy7Ar4qya92qFWDuFW5K3yY
        qr4kCw15u3W2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUyCJJUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuA0kF2JVj6tbagAAsk
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

In pdata_quirks_init_clocks(), the loop contains
of_find_node_by_name() but without corresponding of_node_put().

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 13f1b89f74b8..5b99d602c87b 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -540,6 +540,8 @@ pdata_quirks_init_clocks(const struct of_device_id *omap_dt_match_table)
 
 		of_platform_populate(np, omap_dt_match_table,
 				     omap_auxdata_lookup, NULL);
+
+		of_node_put(np);
 	}
 }
 
-- 
2.25.1

