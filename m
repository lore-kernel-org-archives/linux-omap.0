Return-Path: <SRS0=vynK=CM=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D97C2BC11
	for <linux-omap@archiver.kernel.org>; Thu,  3 Sep 2020 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60FD20786
	for <linux-omap@archiver.kernel.org>; Thu,  3 Sep 2020 15:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgICLYG (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:24:06 -0400
Received: from muru.com ([72.249.23.125]:41892 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgICLWk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 3 Sep 2020 07:22:40 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9A4CF80F1;
        Thu,  3 Sep 2020 11:21:33 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL] Fixes for omaps for v5.9-rc cycle
Date:   Thu,  3 Sep 2020 14:21:25 +0300
Message-Id: <pull-1599132064-54898@atomide.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.9/fixes-rc3

for you to fetch changes up to 6542e2b613c2b1952e83973dc434831332ce8e27:

  ARM: dts: omap5: Fix DSI base address and clocks (2020-08-19 08:54:33 +0300)

----------------------------------------------------------------
Fixes for omaps for v5.9-rc cycle

Few fixes for omap based devices:

- Fix of_clk_get() error handling for omap-iommu

- Fix missing audio pinctrl entries for logicpd boards

- Fix video for logicpd-som-lv after switch to generic panels

- Fix omap5 DSI clocks base

----------------------------------------------------------------
Adam Ford (3):
      ARM: dts: logicpd-torpedo-baseboard: Fix broken audio
      ARM: dts: logicpd-som-lv-baseboard: Fix broken audio
      ARM: dts: logicpd-som-lv-baseboard: Fix missing video

David Shah (1):
      ARM: dts: omap5: Fix DSI base address and clocks

Jing Xiangfeng (1):
      ARM: OMAP2+: Fix an IS_ERR() vs NULL check in _get_pwrdm()

 arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi  | 29 ++++++------------------
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi |  2 ++
 arch/arm/boot/dts/omap5.dtsi                     | 20 ++++++++--------
 arch/arm/mach-omap2/omap-iommu.c                 |  2 +-
 4 files changed, 21 insertions(+), 32 deletions(-)
