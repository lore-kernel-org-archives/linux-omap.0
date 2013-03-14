From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/2] Fix crash on OMAP with CONFIG_DEBUG_SLAB
Date: Thu, 14 Mar 2013 18:06:56 +0530
Message-ID: <1363264618-5071-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48443 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab3CNMkC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 08:40:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, phaber@broadcom.com, Rajendra Nayak <rnayak@ti.com>

These patches mainly fix the crash that was reported with
CONFIG_DEBUG_SLAB enabled on OMAPs, due to the early clock
initializations.

Tested on Panda ES (omap4460), beagle Xm (omap3630) and
BeagleBoneBlack (AM335x)

Rajendra Nayak (2):
  ARM: OMAP2+: clocks: Have consistent naming for parent name arrays
  ARM: OMAP2+: clocks: Pass static parent pointers to common clock core

 arch/arm/mach-omap2/cclock2420_data.c |  314 ++++++++++-------
 arch/arm/mach-omap2/cclock2430_data.c |  332 ++++++++++--------
 arch/arm/mach-omap2/cclock33xx_data.c |   74 +++-
 arch/arm/mach-omap2/cclock3xxx_data.c |  599 ++++++++++++++++++---------------
 arch/arm/mach-omap2/cclock44xx_data.c |  240 ++++++++++---
 arch/arm/mach-omap2/clock.h           |   15 +-
 6 files changed, 965 insertions(+), 609 deletions(-)

-- 
1.7.9.5

