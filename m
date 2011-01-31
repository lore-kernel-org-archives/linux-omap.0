From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 0/2] OMAP: omap_device: API to  modify SYSCONFIG register
Date: Mon, 31 Jan 2011 18:04:46 +0530
Message-ID: <1296477288-26253-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37585 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755342Ab1AaMic (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 07:38:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

Certain peripherals require autoidle bits to be disabled before performing
some operations. This patch series provides APIs in omap_device layer to
modify the SYSCONFIG register.

Since current implementation of PM run time framework does not support
changing sysconfig settings during middle of the on going operation,
these APIs will support the same.

For e.g McBSP 2 and 3 in OMAP3 has sidetone feature which requires
autoidle to be disabled before starting the sidetone.

McBSP also requires the SYSCONFIG to be in NOIDLE when ELEMENTSYNCH
mode is selected for DMA operation.

Created on top of linux OMAP master (linux-omap-2.6 :master)
Tested on OMAP4430, OMAP3430 and OMAP2430 SDP boards. Verified that this patch
series does not break the OMAP1 build.

V2:
Mutex is replaced with spinlock.

V1:
* Creates 3 separate API's to change the idle mode to NOIDLE, SMARTIDLE
 and FORCEIDLE and one more API to change the idlemode to default value
 based on the hwmod flag. This change is done to align with the discussion
 on [3]

* Added hwmod mutex in omap hwmod APIs that modifies SYSCONFIG register.

* omap_hwmod_set_slave_idlemode() is not modified to take true/false kind-of
argument since 3 states are associated with SIDLE bits (force, no and smart).

These changes were made to align with Benoit's and Paul's comments for a
similar patch written by Manjunath [1] for changing MSTANDBY bits.

The discussions that happened for the RFC patch can be found at [2]

[1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39647.html
[2]: https://patchwork.kernel.org/patch/134371/
[3]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39615.html

Kishon Vijay Abraham I (2):
  OMAP: hwmod: API to handle autoidle mode
  OMAP: omap_device: API to modify AUTOIDLE and SMARTIDLE bits

 arch/arm/mach-omap2/omap_hwmod.c              |   36 +++++
 arch/arm/plat-omap/include/plat/omap_device.h |    6 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/omap_device.c              |  176 +++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 0 deletions(-)

