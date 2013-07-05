From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/4] OMAP2+: Cleanup PRM and CM regbit headers
Date: Fri, 5 Jul 2013 16:02:33 +0530
Message-ID: <1373020357-13528-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40460 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757197Ab3GEKdR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Jul 2013 06:33:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com, benoit.cousson@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Over the years the PRM and CM headers for OMAP have been growing largely
due to autogeneration which creates headers for complete PRM and
CM register space, regardless of the actual usage of these registers in
the kernel.

The PRM and CM regbit headers in particular were found to be around 
90% unused and hence this series is an attempt to clean all unsued
data from these headers.

Rajendra Nayak (4):
  ARM: OMAP2: PRM/CM: Cleanup unused header
  ARM: OMAP3: PRM/CM: Cleanup unused header
  ARM: OMAP4: PRM/CM: Cleanup unused header
  ARM: OMAP5: PRM/CM: Cleanup unused header

 arch/arm/mach-omap2/cm-regbits-24xx.h       |  318 ----
 arch/arm/mach-omap2/cm-regbits-33xx.h       |  749 --------
 arch/arm/mach-omap2/cm-regbits-34xx.h       |  632 -------
 arch/arm/mach-omap2/cm-regbits-44xx.h       | 1558 ---------------
 arch/arm/mach-omap2/cm-regbits-54xx.h       | 1633 ----------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c  |    1 -
 arch/arm/mach-omap2/powerdomains54xx_data.c |    1 -
 arch/arm/mach-omap2/prm-regbits-24xx.h      |  247 ---
 arch/arm/mach-omap2/prm-regbits-33xx.h      |  306 ---
 arch/arm/mach-omap2/prm-regbits-34xx.h      |  481 -----
 arch/arm/mach-omap2/prm-regbits-44xx.h      | 2226 ----------------------
 arch/arm/mach-omap2/prm-regbits-54xx.h      | 2701 ---------------------------
 12 files changed, 10853 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/prm-regbits-54xx.h

-- 
1.7.9.5

