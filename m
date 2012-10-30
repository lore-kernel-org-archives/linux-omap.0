From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] ARM: OMAP: hwmod/omapd_device: Fix for resource handling in DT boot
Date: Tue, 30 Oct 2012 12:24:54 +0100
Message-ID: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39872 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654Ab2J3LZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 07:25:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

Changes since v1:
- If the device does not have DMA resource do not try to recreate the resources

Intro mail from v1:

This series resolves the issue we currently have with the resource handling when
booting with DT.
In short: at the moment the omap_device_alloc() decides if it needs to update the
OF filled resources based on the number of resources on the device and in the
hwmod database.
This prevents us from removing hwmod data for platforms (OMAP5) which does not
support non DT boot anymore.

With this series we can make sure that the DT provided resources are used and we
only append the DMA resources to the device from hwmod.
I have added extra check to prepare us when the DMA resource can be filled via
OF. In this case we do not update the resources at all.

Tony, Benoit, Paul: Not sure if this qualify for 3.7 inclusion, but for sure
going to help us to clean up the OMAP5 hwmod database.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: OMAP: hwmod: Add possibility to count hwmod resources based on
    type
  ARM: OMAP: omap_device: Correct resource handling for DT boot

 arch/arm/mach-omap2/omap_hwmod.c             | 27 +++++----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |  2 +-
 arch/arm/plat-omap/omap_device.c             | 87 ++++++++++++++++++----------
 3 files changed, 72 insertions(+), 44 deletions(-)

-- 
1.7.12.4

