Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1806CC432BE
	for <linux-omap@archiver.kernel.org>; Thu, 19 Aug 2021 06:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1776112D
	for <linux-omap@archiver.kernel.org>; Thu, 19 Aug 2021 06:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhHSGfT (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 19 Aug 2021 02:35:19 -0400
Received: from muru.com ([72.249.23.125]:48808 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhHSGfT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 19 Aug 2021 02:35:19 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 2A3E480C7;
        Thu, 19 Aug 2021 06:35:03 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [GIT PULL] Fix for omap gpt12 timer error handling
Date:   Thu, 19 Aug 2021 09:34:36 +0300
Message-Id: <pull-1629354796-830948@atomide.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 353b7a55dcaf5fb8758e09ebe2ddf5f3adbac7c5:

  Merge branch 'fixes-v5.14' into fixes (2021-07-27 11:25:08 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.14/gpt12-fix-signed

for you to fetch changes up to 06a089ef644934372a3062528244fca3417d3430:

  bus: ti-sysc: Fix error handling for sysc_check_active_timer() (2021-08-11 08:34:46 +0300)

----------------------------------------------------------------
Fix for omap gpt12 timer error handling

Two of the recent fixes for ti-sysc driver had bad interaction for a
function return value that caused one of the fixes to not work so we
need to change the return value handling. Otherwise early beagleboard
variants still have a boot issue.

----------------------------------------------------------------
Tony Lindgren (1):
      bus: ti-sysc: Fix error handling for sysc_check_active_timer()

 drivers/bus/ti-sysc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
