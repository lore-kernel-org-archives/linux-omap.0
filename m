Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D96C433E0
	for <linux-omap@archiver.kernel.org>; Sun, 10 Jan 2021 19:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE02F22A85
	for <linux-omap@archiver.kernel.org>; Sun, 10 Jan 2021 19:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbhAJTzq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sun, 10 Jan 2021 14:55:46 -0500
Received: from muru.com ([72.249.23.125]:42498 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbhAJTzq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:46 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id B5C5489E4;
        Sun, 10 Jan 2021 19:54:34 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: [PATCH 15/15] power: supply: cpcap-battery: Fix typo
Date:   Sun, 10 Jan 2021 21:54:03 +0200
Message-Id: <20210110195403.13758-16-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

Fix typo

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
[tony@atomide.com: separated out from charger changes]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2017 Tony Lindgren <tony@atomide.com>
  *
- * Some parts of the code based on earlie Motorola mapphone Linux kernel
+ * Some parts of the code based on earlier Motorola mapphone Linux kernel
  * drivers:
  *
  * Copyright (C) 2009-2010 Motorola, Inc.
-- 
2.30.0
