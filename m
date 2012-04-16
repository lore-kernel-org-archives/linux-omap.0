From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 0/2] ARM: omap_hwmod: add api to enable/disable module level wakeup
Date: Mon, 16 Apr 2012 18:10:51 +0530
Message-ID: <1334580053-17242-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38337 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab2DPMlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 08:41:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Govindraj.R" <govindraj.raja@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

On omap2/3 module level wakeup is handled using PM_WKEN registers.
Expand the hwmod framework to handle the module level wakeup enable 
registers.

Tested on Beagle-xm by enabling and disabling uart wakeups from sysfs
Series depends on following patch for testing.
http://marc.info/?l=linux-omap&m=133457952909998&w=2

Govindraj.R (2):
  ARM: OMAP2+: omap_hwmod: Add interface to incorporate module level
    wakeup
  ARM: OMAP2+: omap_hwmod: Add api to enable/disable module level
    wakeup events

 arch/arm/mach-omap2/omap_hwmod.c             |   31 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    6 +++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    6 +++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    8 ++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +++
 5 files changed, 55 insertions(+), 0 deletions(-)

-- 
1.7.9

