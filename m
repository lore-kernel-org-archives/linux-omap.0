Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E218AC433ED
	for <linux-omap@archiver.kernel.org>; Tue,  6 Apr 2021 09:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED8B613B3
	for <linux-omap@archiver.kernel.org>; Tue,  6 Apr 2021 09:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244824AbhDFJTj (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 6 Apr 2021 05:19:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16346 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244822AbhDFJTi (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2021 05:19:38 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF23f67Xsz94Cl;
        Tue,  6 Apr 2021 17:17:18 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 17:19:22 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        "Zhang Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] thermal: ti-soc-thermal: Remove duplicated header file inclusion
Date:   Tue, 6 Apr 2021 17:19:12 +0800
Message-ID: <20210406091912.2583-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210406091912.2583-1-thunder.leizhen@huawei.com>
References: <20210406091912.2583-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Delete one of the header files <linux/of_device.h> that are included
twice, all included header files are then rearranged alphabetically.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 35 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 8a3646e26ddd208..5e7e80b4a8171c4 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -9,30 +9,29 @@
  *   Eduardo Valentin <eduardo.valentin@ti.com>
  */
 
-#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/cpu_pm.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/export.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/interrupt.h>
-#include <linux/clk.h>
-#include <linux/gpio/consumer.h>
-#include <linux/platform_device.h>
-#include <linux/err.h>
-#include <linux/types.h>
-#include <linux/spinlock.h>
-#include <linux/sys_soc.h>
-#include <linux/reboot.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
-#include <linux/of_irq.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/cpu_pm.h>
-#include <linux/device.h>
-#include <linux/pm_runtime.h>
-#include <linux/pm.h>
-#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/reboot.h>
+#include <linux/spinlock.h>
+#include <linux/sys_soc.h>
+#include <linux/types.h>
 
 #include "ti-bandgap.h"
 
-- 
1.8.3


