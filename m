From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 00/10] OMAP: McBSP: hwmod adaptation and runtime conversion
Date: Tue, 21 Dec 2010 13:10:31 +0530
Message-ID: <1292917231-13800-11-git-send-email-kishon@ti.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43231 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757933Ab0LUHmE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 02:42:04 -0500
In-Reply-To: <1292917231-13800-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com, kishon@ti.com

Modify OMAP McBSP driver to use omap hwmod framework and pm runtime APIs.

Created on top of linux OMAP master (linux-omap-2.6 :master)
Tested on OMAP4430 and OMAP3430 SDP boards. Verified that this patch
series does not break the OMAP1 build.

Highlights

* McBSP is designed to use multiple hwmods for a single device when the McBSP
  device has sidetone feature.

* To avoid funcionality break of OMAP1 McBSP in between the series
  and to keep the patches readable, implementation was done in two steps:
   - First modify mcbsp driver to use platform_get* APIs 
   - then convert it to use hwmod framework for OMAP2+.

* API's like omap_device_noidle() and omap_device_default_idle() is used to
  change the SYCONFIG register bits. This change is done to align with the
  discussion on [2]

* Use '.rev' of omap_hwmod class to identify OMAP3 specific settings

* Use *ST_* macros for idlest_idle bit

* Incorporate other general review comments provided for hwmod adpatation
of other OMAP driver's (eg., do pdata free after a omap_device_build())

* Retain fclk even after pm_runtime adaptation to facilitate switching of
  functional clock from one source to another

Discussions related to the first RFC patch can be found at [1]

[1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36743.html
[2]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39615.html

Charulatha V (3)
  OMAP2420: hwmod data: Add McBSP
  OMAP2430: hwmod data: Add McBSP
  OMAP3: hwmod data: Add McBSP

Benoit Cousson (1)
  OMAP4: hwmod data: Add McBSP

Kishon Vijay Abraham I (6):
  OMAP: hwmod: Add member 'name' to omap_hwmod_addr_space struct
  OMAP: McBSP: Convert McBSP to platform device model
  OMAP3: hwmod: add dev_attr for McBSP sidetone
  OMAP2+: McBSP: hwmod adaptation for McBSP
  OMAP: McBSP: use omap_device APIs to modify SYSCONFIG
  OMAP: McBSP: Add pm runtime support

 arch/arm/mach-omap1/mcbsp.c                  |  383 +++++++++++++++----
 arch/arm/mach-omap2/mcbsp.c                  |  246 ++++---------
 arch/arm/mach-omap2/omap_hwmod.c             |    1 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |  167 ++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  415 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  535 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  320 +++++++++++++++
 arch/arm/mach-omap2/prcm-common.h            |    4 +
 arch/arm/plat-omap/devices.c                 |   10 +-
 arch/arm/plat-omap/include/plat/mcbsp.h      |   26 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +-
 arch/arm/plat-omap/mcbsp.c                   |  143 +++++---
 12 files changed, 1942 insertions(+), 312 deletions(-)

