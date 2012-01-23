From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC 0/2] watchdog  boot status
Date: Mon, 23 Jan 2012 16:43:06 +0530
Message-ID: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51545 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab2AWLNU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 06:13:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-watchdog@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

This patch series does the following
Patch 1:
Fixes the omap_prcm_get_reset_sources() for omap3/4

Patch 2:
Extends the WDIOC_GETBOOTSTATUS to support omap3/4.

Tested on omap3sdp and omap4sdp.

Rajendra Nayak (1):
  ARM: omap: Fix omap_prcm_get_reset_sources() for omap3/4

Shubhrajyoti D (1):
  watchdog : omap_wdt : Implement WDIOC_GETBOOTSTATUS for omap3+

 arch/arm/mach-omap2/prcm.c    |   13 ++++++++-----
 arch/arm/mach-omap2/prm44xx.h |    3 ---
 drivers/watchdog/omap_wdt.c   |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

