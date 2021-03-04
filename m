Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538A0C433DB
	for <linux-omap@archiver.kernel.org>; Thu,  4 Mar 2021 07:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A8864EFD
	for <linux-omap@archiver.kernel.org>; Thu,  4 Mar 2021 07:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhCDHii (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 4 Mar 2021 02:38:38 -0500
Received: from muru.com ([72.249.23.125]:39326 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232707AbhCDHiY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 4 Mar 2021 02:38:24 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D889F80A3;
        Thu,  4 Mar 2021 07:38:21 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>
Subject: [PATCH 0/2] Fixes for for dra7 timer wrap errata i940
Date:   Thu,  4 Mar 2021 09:37:35 +0200
Message-Id: <20210304073737.15810-1-tony@atomide.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

Here are fixes for dra7 ARM architected timer wrap errata i940 where it
fails to wrap after 388 days. The workaround is to use two dmtimers as
the local timers instead.

Note that these patches depend on timer posted mode fixes series
"[PATCH 0/3] Fixes for timer-ti-dm systimer posted mode" for the write
status register check fix. Also the spurious timer interrupt fix is
good to have from that series.

Regards,

Tony


Tony Lindgren (2):
  clocksource/drivers/timer-ti-dm: Prepare to handle dra7 timer wrap
    issue
  clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940

 arch/arm/boot/dts/dra7-l4.dtsi             |   4 +-
 arch/arm/boot/dts/dra7.dtsi                |  20 +++
 drivers/clocksource/timer-ti-dm-systimer.c | 148 +++++++++++++++++----
 include/linux/cpuhotplug.h                 |   1 +
 4 files changed, 148 insertions(+), 25 deletions(-)

-- 
2.30.1
