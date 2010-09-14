From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/3 v2] omap: pm: Move the common code to allow re-use
Date: Wed, 15 Sep 2010 01:03:58 +0530
Message-ID: <1284492841-14858-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53950 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814Ab0INTeL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 15:34:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, rnayak@ti.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

(v2 is rebased on Kevin's 'pm-next' branch)

This is small series moves some common pm code out of pm34xx.c so
that omap4 can re-use this and not duplicate it.

It's boot tested on OMAP3/4 with omap3_defconfig and also simple
test with millisecond debugfs entry and suspend/resume.

Santosh Shilimkar (3):
      omap: pm-debug: Move common debug code to pm-debug.c
      omap: pm-debug: Enable wakeup_timer_milliseconds debugfs entry
      omap: pm: Move set_pwrdm_state routine to common pm.c

 arch/arm/mach-omap2/pm-debug.c |   21 ++++++++++++
 arch/arm/mach-omap2/pm.c       |   50 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h       |    4 ++-
 arch/arm/mach-omap2/pm34xx.c   |   71 ++-------------------------------------
 4 files changed, 78 insertions(+), 68 deletions(-)
