Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C29BC6FA91
	for <linux-omap@archiver.kernel.org>; Wed, 14 Sep 2022 03:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiINDq0 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 13 Sep 2022 23:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiINDqW (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2022 23:46:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F1C6AA2A;
        Tue, 13 Sep 2022 20:46:20 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MS5kN6MCtzlVj0;
        Wed, 14 Sep 2022 11:42:20 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 11:46:17 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <linux@armlinux.org.uk>,
        <tony@atomide.com>, <bcousson@baylibre.com>, <paul@pwsan.com>,
        <krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>,
        <stefan@agner.ch>, <rmk+kernel@armlinux.org.uk>,
        <linus.walleij@linaro.org>, <broonie@kernel.org>,
        <sebastian.reichel@collabora.co.uk>, <cuigaosheng1@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
Subject: [PATCH 3/3] ARM: ftrace: remove unused ftrace_graph_caller_old() declaration
Date:   Wed, 14 Sep 2022 11:46:15 +0800
Message-ID: <20220914034615.1240860-4-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914034615.1240860-1-cuigaosheng1@huawei.com>
References: <20220914034615.1240860-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

All uses of ftrace_graph_caller_old() were removed by
commit d3c61619568c ("ARM: 8788/1: ftrace: remove old
mcount support"), so remove the declaration, too.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/arm/kernel/ftrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index a0b6d1e3812f..0320cfba5b74 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -261,7 +261,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern unsigned long ftrace_graph_call;
 extern unsigned long ftrace_graph_call_old;
-extern void ftrace_graph_caller_old(void);
 extern unsigned long ftrace_graph_regs_call;
 extern void ftrace_graph_regs_caller(void);
 
-- 
2.25.1

