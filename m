Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F77BC00140
	for <linux-omap@archiver.kernel.org>; Mon, 15 Aug 2022 12:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiHOMDj (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 15 Aug 2022 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiHOMDj (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 15 Aug 2022 08:03:39 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 716DE22B3F;
        Mon, 15 Aug 2022 05:03:38 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 26A7A80FB;
        Mon, 15 Aug 2022 11:56:45 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clocksource/drivers/timer-ti-dm: Fix compile test warning
Date:   Mon, 15 Aug 2022 15:03:34 +0300
Message-Id: <20220815120334.51887-1-tony@atomide.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We can get a warning with COMPILE_TEST enabled for omap_timer_match
for 'omap_timer_match' defined but not used.

Fixes: ab0bbef3ae0f ("clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1040,7 +1040,7 @@ static const struct dmtimer_platform_data am6_pdata = {
 	.timer_ops = &dmtimer_ops,
 };
 
-static const struct of_device_id omap_timer_match[] = {
+static const __maybe_unused struct of_device_id omap_timer_match[] = {
 	{
 		.compatible = "ti,omap2420-timer",
 	},
-- 
2.37.1
