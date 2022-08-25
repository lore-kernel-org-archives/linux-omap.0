Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C57C32774
	for <linux-omap@archiver.kernel.org>; Thu, 25 Aug 2022 14:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbiHYOzY (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiHYOzX (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 25 Aug 2022 10:55:23 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE7CA4B17;
        Thu, 25 Aug 2022 07:55:20 -0700 (PDT)
X-QQ-mid: bizesmtp68t1661439316t11j3pqy
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 22:55:10 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: ao4JQgu0M3/UgU+YkHy4no6bR7xESP028SxaFxkre6iLl7c8DSbTIQiTX+vGr
        9ogW7kBebPqytQIIdwXODqpdJe51v5wZMoY3IWX1+Kldkwq4A27WB/hDHEbdltI451D2NI3
        XiU8UQHl8PGTg9rKYCb9hd4bvDIPW+nDI+fBS8njGxhoQkYb6nMXeN20xGGo/ACpy8/OBd2
        kV7lLazhbm2MYA/9KEzawhWiJkMRIQ+3U+T4MYEMOqilNQkuj+Iltzfu9DNQXQi84KIqpnE
        ZBo/iFiphBYvcPgQb4IL7gdr2juZy2AYw0mZT3grpu7eRnfGos0ko7hvh2Krcfd6JWmlyyw
        ZUUhyv8dHtRgoqzXeJmnk4tDpHecAAUHBYyKgRy62coFI4vFvS+okkcnix+lNgbzAuwNqnV
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] bus: ti-sysc: Fix double word in comments
Date:   Thu, 25 Aug 2022 10:55:10 -0400
Message-Id: <20220825145510.6549-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Delete the repeated word "the" in line 918.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 51d772bb8046..2386e8013e18 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -915,7 +915,7 @@ static int sysc_check_registers(struct sysc *ddata)
  * within the interconnect target module range. For example, SGX has
  * them at offset 0x1fc00 in the 32MB module address space. And cpsw
  * has them at offset 0x1200 in the CPSW_WR child. Usually the
- * the interconnect target module registers are at the beginning of
+ * interconnect target module registers are at the beginning of
  * the module range though.
  */
 static int sysc_ioremap(struct sysc *ddata)
-- 
2.35.1

