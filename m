From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/4] omap4: Control module series
Date: Mon, 16 Aug 2010 19:33:43 +0530
Message-ID: <1281967423-9346-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56046 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab0HPODx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 10:03:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On omap4 control mudule is divided in four IP blocks.
	CTRL_MODULE_CORE	0x4a002000
	PAD_CTRL_MODULE_CORE	0x4a100000
	CTRL_MODULE_WKUP	0x4a30c000
	PAD_CTRL_MODULE_WKUP	0x4a31e000
Addressing all the modules with single base address is not possible
considering 16 bit offsets. The mux code manages the pad core and pad
wakeup related base address inside the mux framework. For other usage
only control core and control pad bases are necessary. 

After some offline discussion with Tony, Paul and Benoit, following approach
is decided to address this issue.
 - Most usable registers are form CTRL_MODULE_CORE and PAD_CTRL_MODULE_CORE
 - Control core is mapped with existing APIs and to address the pad control
   module registers, a new accessor APIs is exported for OMAP4 only.
 - Mux code maps the needed bases internally so they need not be exported.
	
Thanks to,
	- Tony and Paul for there suggestion to manage this problem. 
	- And ofcourse Benoit to work with me on this series
	  
The series is generated against 2.6.36-rc1 + Tony's fixes below series
	-	[PATCH 0/6] omap fixes for upcoming 2.6.36-rc1
		http://www.spinics.net/lists/linux-omap/msg34830.html

It's tested on tested on OMAP4 and OMAP3 SDPs.

Santosh Shilimkar (4):
  omap4: control: Add ctrl_pad_base to omap_globals
  omap4: control: Add accessor api's for pad control module
  omap4: control: Add the register definition headers
  omap4: control: Fix the control module register accesses

 arch/arm/mach-omap2/control.c                      |   25 +
 arch/arm/mach-omap2/hsmmc.c                        |   67 +-
 arch/arm/mach-omap2/id.c                           |    2 +-
 .../include/mach/ctrl_module_core_44xx.h           |  391 ++++++
 .../include/mach/ctrl_module_pad_core_44xx.h       | 1409 ++++++++++++++++++++
 .../include/mach/ctrl_module_pad_wkup_44xx.h       |  236 ++++
 .../include/mach/ctrl_module_wkup_44xx.h           |   92 ++
 arch/arm/plat-omap/common.c                        |    3 +-
 arch/arm/plat-omap/include/plat/common.h           |    1 +
 arch/arm/plat-omap/include/plat/control.h          |   31 +-
 10 files changed, 2201 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h

