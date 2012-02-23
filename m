From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/2] OMAP: Section mismatch warning fixes
Date: Thu, 23 Feb 2012 12:28:28 +0530
Message-ID: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59046 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869Ab2BWG6o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 01:58:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony,

Below are couple of section mismatch warning fixes for v3.3-rc5

Santosh Shilimkar (2):
  ARM: OMAP: fix section mismatch warning for omap4_hotplug_cpu()
  ARM: OMAP: Fix section mismatch warning for platform_cpu_die()

 arch/arm/mach-omap2/omap-hotplug.c        |    2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.4.1

