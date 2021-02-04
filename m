Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251DEC433DB
	for <linux-omap@archiver.kernel.org>; Thu,  4 Feb 2021 06:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C079564F51
	for <linux-omap@archiver.kernel.org>; Thu,  4 Feb 2021 06:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhBDGzE (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 4 Feb 2021 01:55:04 -0500
Received: from muru.com ([72.249.23.125]:56952 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233043AbhBDGzE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 4 Feb 2021 01:55:04 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0740780C5;
        Thu,  4 Feb 2021 06:54:34 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL] Defconfig changes for omaps for v5.12
Date:   Thu,  4 Feb 2021 08:54:15 +0200
Message-Id: <pull-1612421637-483551@atomide.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.12/defconfig-signed

for you to fetch changes up to 07bf01714f7f1db805ddaabba15251755e14b903:

  ARM: omap2plus_defconfig: Update for dropped options (2021-01-26 14:04:03 +0200)

----------------------------------------------------------------
Defconfig changes for omaps for v5.12 merge window

Update for moved and dropped options to make creating patches
against omap2plus_defconfig easier.

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: omap2plus_defconfig: Update for moved options
      ARM: omap2plus_defconfig: Update for dropped options

 arch/arm/configs/omap2plus_defconfig | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)
