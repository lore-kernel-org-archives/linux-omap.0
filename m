From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/2] ARM: OMAP4: powerdomain: Misc powerdomain fix and associated cleanup
Date: Mon, 12 Mar 2012 20:04:31 +0530
Message-ID: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44868 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755480Ab2CLOev (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 10:34:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Paul,
Can you please have at this series ?
First patch is the bug fix and second one is the cleanup which you proposed some
time back.

Santosh Shilimkar (2):
  ARM: OMAP: powerdomain: Wait for powerdomain transition in
    pwrdm_state_switch()
  ARM: OMAP: powerdomain: Get rid off duplicate
    pwrdm_clkdm_state_switch() API

 arch/arm/mach-omap2/clock.c       |    2 +-
 arch/arm/mach-omap2/clockdomain.c |    7 +++----
 arch/arm/mach-omap2/powerdomain.c |   14 +++++---------
 arch/arm/mach-omap2/powerdomain.h |    1 -
 4 files changed, 9 insertions(+), 15 deletions(-)

-- 
1.7.4.1

