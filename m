From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCHv5 0/4] DSPBRIDGE: Improved reserved and mapped resource cleanup
Date: Thu, 18 Feb 2010 16:40:49 +0200
Message-ID: <cover.1266503387.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36480 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799Ab0BROlp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 09:41:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, nm@ti.com, deepak.chitriki@ti.com, x0095840@ti.com, omar.ramirez@ti.com

This patch series splits DMM_RES_OBJECT into DMM_MAP_OBJECT and DMM_RSV_OBJECT
which are used independently for mapped and reserved memory resources
accounting. This will help in cleanup of reserved memory resources which was
not handled properly before. With these patches resource cleanup mechanism
will work perfectly in a use case where a big chunk of memory is reserved and
then lot of mappings are created inside it.

Changes since v4:
1. Replace unnecessary list_for_each_entry_safe to list_for_each_entry
   http://marc.info/?l=linux-omap&m=126645721715598&w=2
2. Comments at appropriate places to explain resource tracking objects
   insertion and removals.
   http://marc.info/?l=linux-omap&m=126649541624172&w=2

Changes since v3:
1. Improved mapped memory resource cleanup

Changes since v2:
1. Removed locking from DRV_RemoveAllDMMResElements()
2. Removed cleanup variable from PROC_UnReserveMemory()
   http://marc.info/?l=linux-omap&m=126637211831587&w=2
3. Rebased patchset on top of following commit:
   DSPBRIDGE: Remove conditional check from the InputMsg function

Changed since v1:
1. Reduced indentation
   http://marc.info/?l=linux-omap&m=126624982331523&w=2

Ameya Palande (4):
  DSPBRIDGE: Rename DMM_RES_OBJECT to DMM_MAP_OBJECT
  DSPBRIDGE: New reserved memory accounting framework
  DSPBRIDGE: Fix memory corruption in DRV_ProcFreeDMMRes
  DSPBRIDGE: Improved mapped memory cleanup

 arch/arm/plat-omap/include/dspbridge/drv.h         |   44 ++---
 arch/arm/plat-omap/include/dspbridge/proc.h        |    4 +-
 .../plat-omap/include/dspbridge/resourcecleanup.h  |   11 --
 drivers/dsp/bridge/pmgr/wcd.c                      |    7 +-
 drivers/dsp/bridge/rmgr/drv.c                      |  176 +++-----------------
 drivers/dsp/bridge/rmgr/drv_interface.c            |    5 +-
 drivers/dsp/bridge/rmgr/node.c                     |    5 +-
 drivers/dsp/bridge/rmgr/proc.c                     |  105 +++++++++---
 8 files changed, 134 insertions(+), 223 deletions(-)

