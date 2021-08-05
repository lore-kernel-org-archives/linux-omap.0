Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CEEC4320A
	for <linux-omap@archiver.kernel.org>; Thu,  5 Aug 2021 08:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B44F61078
	for <linux-omap@archiver.kernel.org>; Thu,  5 Aug 2021 08:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhHEIrZ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 5 Aug 2021 04:47:25 -0400
Received: from muru.com ([72.249.23.125]:35974 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239660AbhHEIrZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 5 Aug 2021 04:47:25 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 38B088061;
        Thu,  5 Aug 2021 08:47:08 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL 1/3] SoC changes for omaps for v5.15
Date:   Thu,  5 Aug 2021 11:46:42 +0300
Message-Id: <pull-1628153040-834155@atomide.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.15/soc-signed

for you to fetch changes up to 8d5a937f10ed091e14fc57a4158f59983e2934cf:

  MAINTAINERS: Adopt SanCloud dts files as supported (2021-07-27 11:54:52 +0300)

----------------------------------------------------------------
SoC changes for omaps for v5.15

Update MAINTAINERS for SanCloud devices and drop unused old Kconfig

----------------------------------------------------------------
Paul Barker (1):
      MAINTAINERS: Adopt SanCloud dts files as supported

Peter Robinson (1):
      arm: omap2: Drop MACH_OMAP3517EVM entry

 MAINTAINERS                 | 6 ++++++
 arch/arm/mach-omap2/Kconfig | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)
