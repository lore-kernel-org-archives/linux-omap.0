Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D98BC4707F
	for <linux-omap@archiver.kernel.org>; Wed, 26 May 2021 03:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C0961432
	for <linux-omap@archiver.kernel.org>; Wed, 26 May 2021 03:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhEZDJY (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 25 May 2021 23:09:24 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:34766 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbhEZDJX (ORCPT
        <rfc822;linux-omap@vger.kernel.org>);
        Tue, 25 May 2021 23:09:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ua7zwQJ_1621998469;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Ua7zwQJ_1621998469)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 May 2021 11:07:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tony@atomide.com
Cc:     haojian.zhuang@linaro.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] pinctrl: Fix kernel-doc
Date:   Wed, 26 May 2021 11:07:44 +0800
Message-Id: <1621998464-10918-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Fix function name in pinctrl-single.c kernel-doc comment
to remove a warning found by clang_w1.

drivers/pinctrl/pinctrl-single.c:1523: warning: expecting prototype for
pcs_irq_handle(). Prototype was for pcs_irq_chain_handler() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pinctrl/pinctrl-single.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 2c9c983..7834d5d 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1513,7 +1513,7 @@ static irqreturn_t pcs_irq_handler(int irq, void *d)
 }
 
 /**
- * pcs_irq_handle() - handler for the dedicated chained interrupt case
+ * pcs_irq_chain_handler() - handler for the dedicated chained interrupt case
  * @desc: interrupt descriptor
  *
  * Use this if you have a separate interrupt for each
-- 
1.8.3.1

