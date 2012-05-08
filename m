From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 0/2] ARM: omap_hwmod: add api to enable/disable module level wakeup
Date: Tue, 8 May 2012 14:34:15 +0530
Message-ID: <1336467857-12521-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46018 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab2EHJEh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 05:04:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

On omap2/3 module level wakeup is handled using PM_WKEN registers.
Expand the hwmod framework to handle the module level wakeup enable 
registers.

Patch series based on:
git://git.pwsan.com/linux-2.6 hwmod_soc_conditional_cleanup_3.5

Tested on Beagle-xm by enabling and disabling uart wakeups from sysfs
Series depends on following patches for testing.
http://marc.info/?l=linux-omap&m=133527588923598&w=2
http://marc.info/?l=linux-omap&m=133518614022144&w=2

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Changes from v3:
---------------
Using hwmod soc init support to populate soc specific
funcs.
http://www.spinics.net/lists/linux-omap/msg69676.html


Govindraj.R (2):
  ARM: OMAP2/3: omap_hwmod: Add api to enable/disable module level
    wakeup events
  ARM: omap3: pm: Remove uart module level wakeup configurations

 arch/arm/mach-omap2/omap_hwmod.c   |   29 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c       |   14 +++++---------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   16 ++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    9 +++++++++
 4 files changed, 59 insertions(+), 9 deletions(-)

-- 
1.7.9

