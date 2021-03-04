Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680B6C43331
	for <linux-omap@archiver.kernel.org>; Thu,  4 Mar 2021 07:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7A64EF9
	for <linux-omap@archiver.kernel.org>; Thu,  4 Mar 2021 07:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhCDHWh (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 4 Mar 2021 02:22:37 -0500
Received: from muru.com ([72.249.23.125]:39266 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236203AbhCDHW0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 4 Mar 2021 02:22:26 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 3BC1F80A3;
        Thu,  4 Mar 2021 07:22:22 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] Fixes for timer-ti-dm systimer posted mode
Date:   Thu,  4 Mar 2021 09:21:32 +0200
Message-Id: <20210304072135.52712-1-tony@atomide.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

Here are few timer-ti-dm fixes. The first fix corrects the status bit
check order for posted mode. The other two are minor fixes noticed while
reviewing and testing the code.

Regards,

Tony


Tony Lindgren (3):
  clocksource/drivers/timer-ti-dm: Fix posted mode status check order
  clocksource/drivers/timer-ti-dm: Remove extra of_node_put()
  clocksource/drivers/timer-ti-dm: Add missing set_state_oneshot_stopped

 drivers/clocksource/timer-ti-dm-systimer.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

-- 
2.30.1
