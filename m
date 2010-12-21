From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 0/2] OMAP: omap_device: API to modify SYSCONFIG register
Date: Tue, 21 Dec 2010 12:42:38 +0530
Message-ID: <1292915560-13601-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56256 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481Ab0LUHOJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 02:14:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com, kishon@ti.com

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
Tested on OMAP4430 and OMAP3430 SDP boards. Verified that this patch
series does not break the OMAP1 build.

Highlihgts:
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

 arch/arm/mach-omap2/omap_hwmod.c              |   35 +++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    4 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/omap_device.c              |  118 +++++++++++++++++++++++++
 4 files changed, 158 insertions(+), 0 deletions(-)

