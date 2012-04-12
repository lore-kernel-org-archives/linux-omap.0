From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/2] ARM: mm: Add v7_flush_dcache_by_level() API
Date: Thu, 12 Apr 2012 16:59:45 +0530
Message-ID: <1334230187-21553-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59216 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759313Ab2DLLaM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 07:30:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Couple of patches on the ARMv7 cache code. First patch adds
v7_flush_dcache_by_level() API and second patch updates the setup
function to use the same.

R Sricharan (1):
  ARM: mm: Add v7_flush_dcache_by_level() API.

Santosh Shilimkar (1):
  ARM: mm: Flush only CPU local cache instead of all cache levels.

 arch/arm/mm/cache-v7.S |   56 ++++++++++++++++++++++++++++++++++++++---------
 arch/arm/mm/proc-v7.S  |    3 +-
 2 files changed, 47 insertions(+), 12 deletions(-)

-- 
1.7.5.4

