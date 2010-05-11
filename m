From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/5] OMAP4: power framework fixes
Date: Tue, 11 May 2010 12:57:05 +0530
Message-ID: <1273562830-9758-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59548 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441Ab0EKH1Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 May 2010 03:27:16 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4B7RDNj006836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 02:27:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

Hi,

This is a short series of fixes for OMAP4 in the PM frameworks,
clock/clockdomain and powerdomain.

regards,
Rajendra

Rajendra Nayak (5):
  OMAP4 clock: Support clk_set_parent
  OMAP: timers: Fix clock source names for OMAP4
  OMAP4 powerdomain: Fix pwrsts flags for ALWAYS ON domains
  OMAP4 clockdomain: Fix omap2_clkdm_clk_enable/disable api for 44xx
  OMAP4 powerdomain: Support LOWPOWERSTATECHANGE for powerdomains

 arch/arm/mach-omap2/clockdomain.c             |    6 +++++
 arch/arm/mach-omap2/powerdomain.c             |   28 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains44xx.h        |   13 +++++++++-
 arch/arm/plat-omap/clock.c                    |    3 --
 arch/arm/plat-omap/dmtimer.c                  |    4 +-
 arch/arm/plat-omap/include/plat/powerdomain.h |    7 ++++++
 6 files changed, 54 insertions(+), 7 deletions(-)

