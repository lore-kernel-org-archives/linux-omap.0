From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 0/3] OMAP3 PM: CPUIdle fixes
Date: Wed, 16 Feb 2011 14:31:11 +0530
Message-ID: <1297846874-18286-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49634 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055Ab1BPI6Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 03:58:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: patches@linaro.org, Vishwanath BS <vishwanath.bs@ti.com>

This patch series has some fixes/optimization for OMAP3 cpuidle code.
Tested on ZOOM3 for cpuidle and suspend/resume with OFF mode enabled.
Patches are rebased to latest kevin's pm branch 
(commit id: b6fb54bc4bfc396a9b982d76c1c954c974290a1a)

Vishwanath BS (3):
  OMAP3 PM: Deny clock gating only for safe state
  OMAP3 PM: Update only enabled C states
  OMAP36xx PM: Updated C state latencies for OMAP3630

 arch/arm/mach-omap2/board-3630sdp.c |   19 +++++++++++++
 arch/arm/mach-omap2/board-zoom.c    |   19 +++++++++++++
 arch/arm/mach-omap2/cpuidle34xx.c   |   49 +++++++++++++++++++++++-----------
 3 files changed, 71 insertions(+), 16 deletions(-)

