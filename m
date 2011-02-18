From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 00/13] OMAP: McBSP: hwmod adaptation  and runtime conversion
Date: Fri, 18 Feb 2011 19:52:15 +0530
Message-ID: <1298038948-19871-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54284 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757820Ab1BRO2H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 09:28:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, peter.ujfalusi@nokia.com
Cc: p-basak2@ti.com, kishon@ti.com, charu@ti.com, shubhrajyoti@ti.com

Modify OMAP McBSP driver to use omap hwmod framework and pm runtime  APIs.

Created on top of linux OMAP master (linux-omap-2.6 :master)

Did digital loopback testing on OMAP4430, OMAP3430, OMAP2430 and OMAP
1710 SDP boards.
Tested audio on 3430 SDP board (by me) and N810 (by Jarkko Nikula).
Tested PM with audio and verified the patch series does not cause regression.
PM testing comprises of suspend/resume between consecutive audio playback.
Support for suspend/resume in the middle of audio playback will be done by
audio guys on top of this patch series.

Patch series requires the following patch to be present
http://permalink.gmane.org/gmane.linux.ports.arm.omap/51132
http://permalink.gmane.org/gmane.linux.ports.arm.omap/51133
http://permalink.gmane.org/gmane.linux.ports.arm.omap/51134

V3:
* Fixed a few minor comments related to patch subject and patch description.

* Driver is adapted to handle the unique irq line (since this is the standard
 from OMAP4).

* Removed duplication of memory address space entries in platform device model
 and hwmod database for OMAP1/2 and 3.

* Put sysconfig in force idle when the mcbsp is freed (HW bug workaround for
 the device to hit retention).

V2:
* Added omap_hwmod_lookup() in the callback to omap_hwmod_for_each_by_class()
 to obtain hwmod data for sidetone. Previously this nesting of hwmod APIs was
 prevented by the use of mutex.

* Added a revision member in hwmod database inorder to facilitate the driver
 to differentiate between different OMAP.

* Created APIs to pass DMA params from McBSP driver to client drivers

* Cleaned up sound soc by removing the use of macros to obtain base address
 and DMA channel number and instead use APIs exposed by the driver.

* Removed macros defined in mcbsp driver for data that is obtained from
 hwmod database

V1:
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

* Add member 'name' to omap_hwmod_addr_space struct so that the driver need
 not rely on the order to get the proper resource [3].

Discussions related to the first RFC patch can be found at [1]

[1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36743.html
[2]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39615.html
[3]: https://patchwork.kernel.org/patch/233211/

Charulatha V (3):
  OMAP2420: hwmod data: Add McBSP
  OMAP2430: hwmod data: Add McBSP
  OMAP3: hwmod data: Add McBSP

Kishon Vijay Abraham I (10):
  OMAP: hwmod: allow hwmod to provide address space accessible from
    SDMA
  OMAP: McBSP: Convert McBSP to platform device model
  OMAP4: hwmod: Naming of address space
  OMAP3: hwmod: add dev_attr for McBSP sidetone
  OMAP2+: McBSP: hwmod adaptation for McBSP
  OMAP: McBSP: use omap_device APIs to modify SYSCONFIG
  OMAP: McBSP: Add pm runtime support
  OMAP: McBSP: APIs to pass DMA params from McBSP driver to client
    drivers
  ASoC: McBSP: get hw params from McBSP driver
  OMAP: hwmod: Removal of macros for data that is obtained from hwmod
    database

 arch/arm/mach-omap1/mcbsp.c                  |  327 +++++++++++++++----
 arch/arm/mach-omap2/mcbsp.c                  |  231 +++----------
 arch/arm/mach-omap2/omap_hwmod.c             |    1 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |  129 ++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  322 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  449 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    8 +
 arch/arm/mach-omap2/prcm-common.h            |    4 +
 arch/arm/plat-omap/devices.c                 |   10 +-
 arch/arm/plat-omap/include/plat/mcbsp.h      |   50 ++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +-
 arch/arm/plat-omap/mcbsp.c                   |  210 +++++++++---
 sound/soc/omap/omap-mcbsp.c                  |  126 +-------
 13 files changed, 1419 insertions(+), 452 deletions(-)

