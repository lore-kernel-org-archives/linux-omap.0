Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0DAC47083
	for <linux-omap@archiver.kernel.org>; Wed,  2 Jun 2021 07:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857E961361
	for <linux-omap@archiver.kernel.org>; Wed,  2 Jun 2021 07:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhFBHVP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 2 Jun 2021 03:21:15 -0400
Received: from muru.com ([72.249.23.125]:35306 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhFBHVN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 2 Jun 2021 03:21:13 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CA9498027;
        Wed,  2 Jun 2021 07:19:37 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL 2/3] Defconfig changes for omaps for v5.14
Date:   Wed,  2 Jun 2021 10:19:10 +0300
Message-Id: <pull-1622618286-677305@atomide.com-2>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <pull-1622618286-677305@atomide.com>
References: <pull-1622618286-677305@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.14/defconfig-signed

for you to fetch changes up to e7d7b033091afaee937cd92d71903fbe774d5ff0:

  ARM: omap2plus_defconfig: Add LP5523 LED driver (2021-05-21 12:31:57 +0300)

----------------------------------------------------------------
Defconfig changes for omaps for v5.14 merge window

Defconfig changes for omap2plus_defconfig to add WL1251
and LP5523 as loadable modules for n900.

----------------------------------------------------------------
Sicelo A. Mhlongo (2):
      ARM: omap2plus_defconfig: Add WL1251 and WEXT modules
      ARM: omap2plus_defconfig: Add LP5523 LED driver

 arch/arm/configs/omap2plus_defconfig | 5 +++++
 1 file changed, 5 insertions(+)
