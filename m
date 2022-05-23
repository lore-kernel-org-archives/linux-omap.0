Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E8AC433F5
	for <linux-omap@archiver.kernel.org>; Mon, 23 May 2022 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiEWPOy (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 23 May 2022 11:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbiEWPOy (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 23 May 2022 11:14:54 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 438F949FB4;
        Mon, 23 May 2022 08:14:53 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 57EF280C2;
        Mon, 23 May 2022 15:10:53 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] clocksource/drivers/timer-ti-dm: Make driver selection bool for TI K3
Date:   Mon, 23 May 2022 18:14:48 +0300
Message-Id: <20220523151448.23732-1-tony@atomide.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The clocksource drivers do not currently have loadable modules as
pointed out by Daniel Lezcano <daniel.lezcano@linaro.org>.

Let's reconsider this later on once timer removal discussion has been
done, and set timer-ti-dm to bool for TI K3 SoC.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -57,7 +57,8 @@ config DIGICOLOR_TIMER
 	  Enables the support for the digicolor timer driver.
 
 config OMAP_DM_TIMER
-	tristate "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST
+	bool "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST
+	default y if ARCH_K3
 	select TIMER_OF
 	help
 	  Enables the support for the TI dual-mode timer driver.
-- 
2.36.1
