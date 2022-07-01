Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75354C433EF
	for <linux-omap@archiver.kernel.org>; Fri,  1 Jul 2022 11:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiGAL11 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 1 Jul 2022 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiGAL1Z (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2022 07:27:25 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A99081482
        for <linux-omap@vger.kernel.org>; Fri,  1 Jul 2022 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=n5laP
        LCGGMBzjX7p1cAZ7VYDOFKgvmLjT5x79mPRnrM=; b=FavUmXTKT/5wPUg5MjMq1
        eugVlUFwpKumMHjjANW98Yfy9Oa1qbBa+DGceB82pw0N97eGhlPfqfRPN0R4rMK6
        uG2mG2KLDjrkb2Tkv07K4zrSn0nv5Pkxm6T1HXxqe6E553DpNtaYBDRLgo2AE1p6
        wpW4c1X65zmw5zf3efS/Yk=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgAHJtD62b5ibZSuFw--.17397S4;
        Fri, 01 Jul 2022 19:26:54 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tony@atomide.com, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, windhl@126.com
Subject: [PATCH 3/3] arm: omap2: prm_common: Add the refcount for new reference creation
Date:   Fri,  1 Jul 2022 19:26:49 +0800
Message-Id: <20220701112649.233322-3-windhl@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701112649.233322-1-windhl@126.com>
References: <20220701112649.233322-1-windhl@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgAHJtD62b5ibZSuFw--.17397S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF47Kr1ktr4fGw48JryfXrb_yoWfXFbE9w
        n2ga4kJr18Ga1Ig3ZrJa1fWr1Dta4rGr9rG34kJ3W5Ka90qr43CrZYyayIv347uFW2krZr
        JrZrZryYkw1jvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRED73JUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuB4xF2JVkJ3ejQAAsp
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

In omap2_prm_base_init(), for_each_matching_node_and_match() can
automatically increase and decrease the refcounting. However, a
new reference is escaped out into 'data->np', so we need to use
of_node_put() for the old reference and use of_node_get() for the
new one.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-omap2/prm_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index fb2d48cfe756..bed151e3f165 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -764,7 +764,8 @@ int __init omap2_prm_base_init(void)
 			prm_base.pa = res.start + data->offset;
 		}
 
-		data->np = np;
+		of_node_put(data->np);
+		data->np = of_node_get(np);
 
 		if (data->init)
 			data->init(data);
-- 
2.25.1

