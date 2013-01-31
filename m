From: Hebbar Gururaja <gururaja.hebbar@ti.com>
Subject: [Patch v2 0/2] ARM: OMAP2+: AM33xx: fix hwmod & Clock Control Module
Date: Thu, 31 Jan 2013 19:55:25 +0530
Message-ID: <1359642327-5542-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35327 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab3AaO1i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 09:27:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, sudhakar.raj@ti.com, gururaja.hebbar@ti.com, linux@arm.linux.org.uk, hvaibhav@ti.com, vaibhav.bedia@ti.com

1. Add add missing HWMOD_NO_IDLEST flags
2. Fix "register offset NULL check" bug

Changes in v2:
	- As per Paul's suggestion 1st add HWMOD_NO_IDLEST flag where
	  it is necessary and then correct the clock control register
	  offset check bug.

Hebbar Gururaja (2):
  ARM: OMAP2+: AM33xx: hwmod: add missing HWMOD_NO_IDLEST flags
  ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check" bug

 arch/arm/mach-omap2/cm33xx.c               |    3 ---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
1.7.9.5

