Return-Path: <SRS0=FBvQ=4X=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE17C10DCE
	for <linux-omap@archiver.kernel.org>; Fri,  6 Mar 2020 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBF720866
	for <linux-omap@archiver.kernel.org>; Fri,  6 Mar 2020 16:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFQT4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:19:56 -0500
Received: from muru.com ([72.249.23.125]:59058 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCFQT4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 6 Mar 2020 11:19:56 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C2A688027;
        Fri,  6 Mar 2020 16:20:41 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL 1/4] soc changes for omaps for v5.7
Date:   Fri,  6 Mar 2020 08:19:47 -0800
Message-Id: <pull-1583511417-919838@atomide.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.7/soc-signed

for you to fetch changes up to 0d53cc8b3319fc6d0d9656c428d03a3c1628c19f:

  Merge branch 'omap-for-v5.7/omap1' into omap-for-v5.7/soc (2020-03-06 07:17:10 -0800)

----------------------------------------------------------------
SoC changes for omaps for v5.7 merge window

A change to improve the warning output for device tree data
mismatch as compared to legacy platform data for ti-sysc
related interconnect target modules.

And change omap1 to request_irq() instead of setup_irq().

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: OMAP2+: Improve handling of ti-sysc related sysc_fields
      Merge branch 'omap-for-v5.7/omap1' into omap-for-v5.7/soc

afzal mohammed (1):
      ARM: OMAP: replace setup_irq() by request_irq()

 arch/arm/mach-omap1/pm.c         | 13 ++++++-------
 arch/arm/mach-omap1/time.c       | 10 +++-------
 arch/arm/mach-omap1/timer32k.c   | 10 +++-------
 arch/arm/mach-omap2/omap_hwmod.c | 19 ++++++++++++-------
 arch/arm/mach-omap2/timer.c      | 11 +++--------
 5 files changed, 27 insertions(+), 36 deletions(-)
