From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/5] OMAP4: ES2 PRCM diff series
Date: Thu, 16 Sep 2010 18:28:21 +0530
Message-ID: <1284641906-24231-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55388 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115Ab0IPM6g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 08:58:36 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8GCwXC9014142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 07:58:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

The PRCM IP in OMAP4430 ES2 is completely validated
and is expected to be functional, unlike the one in ES1
which was untested and non functional.

This series of patches brings in all the differences
introducted by PRCM in ES2.0. Includes additional registers
added, some removed, bitfields in registers moved around.
Some changes in clock tree modelling and some in powerdomain
states supported.

This series is tested on OMAP4430 ES2 using the below series
http://www.spinics.net/lists/linux-omap/msg36023.html
and also boot tested on OMAP4430 ES1 and applied on latest
mainline.

Patches based on mainline rc4 are available here:
http://gitorious.org/omap-pm/linux for_2.6.37

Rajendra Nayak (4):
  OMAP4: PM: Update PRCM register bitshits and masks for ES2
  OMAP4: PM: Define additional registers for ES2
  OMAP4: clocks: Update clock tree for ES2
  OMAP4: powerdomain: Update DSS logic state for ES2

Santosh Shilimkar (1):
  OMAP4: powerdomain: add context_offset field

 arch/arm/mach-omap2/clock44xx_data.c          |  168 ++++++--------
 arch/arm/mach-omap2/cm-regbits-44xx.h         |  327 ++++++++++++++-----------
 arch/arm/mach-omap2/cm44xx.h                  |   90 +++++++-
 arch/arm/mach-omap2/powerdomains44xx.h        |   16 ++-
 arch/arm/mach-omap2/prm-regbits-44xx.h        |  194 ++++++++++++---
 arch/arm/mach-omap2/prm44xx.h                 |   14 +-
 arch/arm/plat-omap/include/plat/powerdomain.h |    2 +
 7 files changed, 525 insertions(+), 286 deletions(-)

