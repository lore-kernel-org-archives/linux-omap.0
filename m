Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EFBC43381
	for <linux-omap@archiver.kernel.org>; Fri, 12 Mar 2021 09:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2676564ED7
	for <linux-omap@archiver.kernel.org>; Fri, 12 Mar 2021 09:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhCLJZq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:25:46 -0500
Received: from muru.com ([72.249.23.125]:42314 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232876AbhCLJZf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 12 Mar 2021 04:25:35 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id E17968192;
        Fri, 12 Mar 2021 09:26:19 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] bus: ti-sysc: Warn about old dtb for dra7 and omap4/5
Date:   Fri, 12 Mar 2021 11:25:16 +0200
Message-Id: <20210312092516.42884-3-tony@atomide.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210312092516.42884-1-tony@atomide.com>
References: <20210312092516.42884-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Let's warn if an old incomplete dtb is detected. We now assume the dtb
is complete and does not depend on the legacy platform data.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2886,6 +2886,9 @@ static int sysc_init_soc(struct sysc *ddata)
 	switch (sysc_soc->soc) {
 	case SOC_AM3:
 	case SOC_AM4:
+	case SOC_4430 ... SOC_4470:
+	case SOC_5430:
+	case SOC_DRA7:
 		np = of_find_node_by_path("/ocp");
 		WARN_ONCE(np && of_device_is_compatible(np, "simple-bus"),
 			  "ti-sysc: Incomplete old dtb, please update\n");
-- 
2.30.2
