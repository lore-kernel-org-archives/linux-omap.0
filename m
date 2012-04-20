From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 0/3] ARM: omap_hwmod: add api to enable/disable module level wakeup
Date: Fri, 20 Apr 2012 16:40:04 +0530
Message-ID: <1334920207-19160-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57610 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755157Ab2DTLK3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 07:10:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

On omap2/3 module level wakeup is handled using PM_WKEN registers.
Expand the hwmod framework to handle the module level wakeup enable 
registers.

Tested on Beagle-xm by enabling and disabling uart wakeups from sysfs
Series depends on following patch for testing.
http://marc.info/?l=linux-omap&m=133457952909998&w=2

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>

Govindraj.R (3):
  ARM: OMAP2+: omap_hwmod: Add interface to incorporate module level
    wakeup
  ARM: OMAP2+: omap_hwmod: Add api to enable/disable module level
    wakeup events
  ARM: omap3: pm: Remove uart module level wakeup configurations

 arch/arm/mach-omap2/omap_hwmod.c             |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    8 ++++++++
 arch/arm/mach-omap2/pm34xx.c                 |   14 +++++---------
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |    8 ++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |    9 +++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 ++++
 8 files changed, 70 insertions(+), 9 deletions(-)

-- 
1.7.9

