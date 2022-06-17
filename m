Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54366C433EF
	for <linux-omap@archiver.kernel.org>; Fri, 17 Jun 2022 14:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiFQO6h (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 17 Jun 2022 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382980AbiFQO6f (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2022 10:58:35 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21B132ED43;
        Fri, 17 Jun 2022 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=C9dWw
        lJTkPVFPy+ldljG5siVelWvaG/RDmrjHzyN2Zg=; b=hAXLU8E4EYCHfu1gvSvXw
        cO29KcVRNG2xee1bodrA6D47p5dfuioG1eSWcthuLIWZ9jVBIYh9cTRmAuPPK6QN
        v1TUMAGb9vOQ0JPCk7odkc3v3aZT/CcrBalAa2+g5tcXYAQBwnGsaZCiZj19ohMo
        TEUANFnJ17TPnxRBZDa0ZA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgBncrd8lqxiCpXrEw--.40452S2;
        Fri, 17 Jun 2022 22:58:05 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tony@atomide.com, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-omap2: display: Fix refcount leak bug
Date:   Fri, 17 Jun 2022 22:58:03 +0800
Message-Id: <20220617145803.4050918-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgBncrd8lqxiCpXrEw--.40452S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4fWry3Gry7Cr4UZr15XFb_yoW3GFc_tw
        n3Xw1fJryrta1vg3yDur4rWrsYqw45Gr17Xr92qF12ka12qF17ZrWjywn2qrWUWFWYyrW3
        Cr97GFy5CwsrJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtgAwDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7R0jF1pEAOCisQAAsp
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

In omapdss_init_fbdev(), of_find_node_by_name() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-omap2/display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 21413a9b7b6c..eb09a25e3b45 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -211,6 +211,7 @@ static int __init omapdss_init_fbdev(void)
 	node = of_find_node_by_name(NULL, "omap4_padconf_global");
 	if (node)
 		omap4_dsi_mux_syscon = syscon_node_to_regmap(node);
+	of_node_put(node);
 
 	return 0;
 }
-- 
2.25.1

