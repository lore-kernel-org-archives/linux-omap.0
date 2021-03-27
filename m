Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB34AC433DB
	for <linux-omap@archiver.kernel.org>; Sat, 27 Mar 2021 01:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA7861A21
	for <linux-omap@archiver.kernel.org>; Sat, 27 Mar 2021 01:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhC0BiU (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 26 Mar 2021 21:38:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14493 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhC0BiG (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2021 21:38:06 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6hJ30czdzySC3;
        Sat, 27 Mar 2021 09:36:03 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 09:37:57 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        "Zhang Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] thermal: ti-soc-thermal: Remove duplicated header file inclusion
Date:   Sat, 27 Mar 2021 09:37:48 +0800
Message-ID: <20210327013749.1765-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The header file <linux/of_device.h> is already included above and can be
removed here.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 8a3646e26ddd208..d81af89166d2360 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -32,7 +32,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "ti-bandgap.h"
 
-- 
1.8.3


