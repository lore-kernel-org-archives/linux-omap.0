Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D011C433DB
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 15:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8118652EB
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 15:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCHPTc (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:19:32 -0500
Received: from muru.com ([72.249.23.125]:41032 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhCHPTZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 8 Mar 2021 10:19:25 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 63E5B80D4;
        Mon,  8 Mar 2021 15:20:07 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/9] Drop legacy data for omap5
Date:   Mon,  8 Mar 2021 17:19:02 +0200
Message-Id: <20210308151911.43203-1-tony@atomide.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

Here are the changes to drop legacy data for omap5 as we can now boot with
devicetree data using genpd and simple-pm-bus.

These patches are against v5.12-rc2, and depend on the following series of
patches:

[PATCH 00/11] Update omap5 dts files to probe with genpd

Regards,

Tony

Tony Lindgren (9):
  ARM: OMAP2+: Drop legacy platform data for omap5 dmm
  ARM: OMAP2+: Drop legacy platform data for omap5 emif
  ARM: OMAP2+: Drop legacy platform data for omap5 mpu
  ARM: OMAP2+: Drop legacy platform data for omap5 sata
  ARM: OMAP2+: Drop legacy platform data for omap5 l4_wkup
  ARM: OMAP2+: Drop legacy platform data for omap5 l4_per
  ARM: OMAP2+: Drop legacy platform data for omap5 l4_cfg
  ARM: OMAP2+: Drop legacy platform data for omap5 l3
  ARM: OMAP2+: Drop legacy platform data for omap5 hwmod

 arch/arm/boot/dts/omap5.dtsi               |   4 -
 arch/arm/mach-omap2/Kconfig                |   1 -
 arch/arm/mach-omap2/Makefile               |   1 -
 arch/arm/mach-omap2/io.c                   |   2 -
 arch/arm/mach-omap2/omap_hwmod.h           |   1 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 467 ---------------------
 6 files changed, 476 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_54xx_data.c

-- 
2.30.1
