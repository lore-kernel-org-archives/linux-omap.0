From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/8] omap_hwmod/omap_device prep work
Date: Tue, 17 Nov 2009 17:05:05 -0800
Message-ID: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61295 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353AbZKRBFL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 20:05:11 -0500
Received: by yxe17 with SMTP id 17so614173yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 17:05:16 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

In converting the UART drivers over to omap_hwmod/omap_device, I
found a few issues. 

Kevin Hilman (7):
  OMAP3: clock: add clockdomains for UART1 & 2
  OMAP: hwmod: warn on missing clockdomain
  OMAP: omap_device: deactivate latency typo
  OMAP: omap_device: add usecounting
  OMAP: omap_device: use read_persistent_clock() instead of
    getnstimeofday()
  OMAP: omap_device: warn about expected latencies only if non-zero
  OMAP: omap_device: use UINT_MAX for default wakeup latency limit

Paul Walmsley (1):
  OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE handling

 arch/arm/mach-omap2/clock34xx.h               |    2 +
 arch/arm/mach-omap2/omap_hwmod.c              |   53 ++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    8 +++-
 arch/arm/plat-omap/omap_device.c              |   43 +++++++++++++-------
 5 files changed, 86 insertions(+), 21 deletions(-)

