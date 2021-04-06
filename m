Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4413BC433B4
	for <linux-omap@archiver.kernel.org>; Tue,  6 Apr 2021 09:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092AF613C4
	for <linux-omap@archiver.kernel.org>; Tue,  6 Apr 2021 09:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhDFJyC (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 6 Apr 2021 05:54:02 -0400
Received: from muru.com ([72.249.23.125]:51432 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233527AbhDFJyB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 6 Apr 2021 05:54:01 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 138C780A4;
        Tue,  6 Apr 2021 09:55:01 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL] Few more fixes for omaps for v5.12-rc cycle
Date:   Tue,  6 Apr 2021 12:53:49 +0300
Message-Id: <pull-1617702755-711306@atomide.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit b3d09a06d89f474cb52664e016849315a97e09d9:

  ARM: OMAP4: PM: update ROM return address for OSWR and OFF (2021-03-17 15:15:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.12/fixes-rc6-signed

for you to fetch changes up to fc85dc42a38405099f97aa2af709fe9504a82508:

  ARM: OMAP2+: Fix uninitialized sr_inst (2021-03-31 09:27:41 +0300)

----------------------------------------------------------------
Fixes for omaps for v5.12-rc cycle

Fix swapped mmc device order also for omap3 that got changed with the
recent PROBE_PREFER_ASYNCHRONOUS changes. While eventually the aliases
should be board specific, all the mmc device instances are all there in
the SoC, and we do probe them by default so that PM runtime can idle the
devices if left enabled from the bootloader.

Also included are two compiler warning fixes.

----------------------------------------------------------------
Tony Lindgren (3):
      ARM: OMAP2+: Fix warning for omap_init_time_of()
      ARM: dts: Fix swapped mmc order for omap3
      ARM: OMAP2+: Fix uninitialized sr_inst

 arch/arm/boot/dts/omap3.dtsi        | 3 +++
 arch/arm/mach-omap2/board-generic.c | 2 +-
 arch/arm/mach-omap2/sr_device.c     | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)
