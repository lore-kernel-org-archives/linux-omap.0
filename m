Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71479C38142
	for <linux-omap@archiver.kernel.org>; Tue, 24 Jan 2023 13:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjAXNWp (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 24 Jan 2023 08:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbjAXNWo (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2023 08:22:44 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D72C3AAC
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2023 05:22:43 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CE2BF809F;
        Tue, 24 Jan 2023 13:22:41 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL] One clean-up for omap1 for v6.3
Date:   Tue, 24 Jan 2023 15:22:39 +0200
Message-Id: <pull-1674566532-427457@atomide.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v6.3/omap1-signed

for you to fetch changes up to 0414a100d6ab32721efa70ab55524540fdfe0ede:

  ARM: OMAP1: call platform_device_put() in error case in omap1_dm_timer_init() (2023-01-19 11:57:57 +0200)

----------------------------------------------------------------
One clean-up for omap1 for v6.3

One non-urgent change to use platform_device_put() instead of
platform_device_unregister().

----------------------------------------------------------------
Yang Yingliang (1):
      ARM: OMAP1: call platform_device_put() in error case in omap1_dm_timer_init()

 arch/arm/mach-omap1/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
