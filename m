From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/3] omap: pm: Move the common code to allow re-use
Date: Tue, 14 Sep 2010 19:25:45 +0530
Message-ID: <1284472548-32151-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58823 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab0INNz6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 09:55:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, rnayak@ti.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This is small series moves some common pm code out of pm34xx.c so
that omap4 can re-use this and not duplicate it.

It's boot tested on OMAP3/4 with omap3_defconfig and also simple
test with millisecond debugfs entry and suspend/resume.

The following changes since commit 49553c2ef88749dd502687f4eb9c258bb10a4f44:
  Linus Torvalds (1):
        Linux 2.6.36-rc4

Santosh Shilimkar (3):
      omap: pm-debug: Move common debug code to pm-debug.c
      omap: pm-debug: Enable wakeup_timer_milliseconds debugfs entry
      omap: pm: Move set_pwrdm_state routine to common pm.c

 arch/arm/mach-omap2/pm-debug.c |   26 ++++++++++++++
 arch/arm/mach-omap2/pm.c       |   50 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h       |    8 +++--
 arch/arm/mach-omap2/pm34xx.c   |   76 ++-------------------------------------
 4 files changed, 85 insertions(+), 75 deletions(-)
