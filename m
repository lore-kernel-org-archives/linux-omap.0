From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCHv3 0/2] DSPBRIDGE: Improved reserved memory cleanup
Date: Wed, 17 Feb 2010 16:18:30 +0200
Message-ID: <cover.1266415372.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45341 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934210Ab0BQOTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 09:19:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, x0095840@ti.com, nm@ti.com, deepak.chitriki@ti.com

This patch series splits DMM_RES_OBJECT into DMM_MAP_OBJECT and DMM_RSV_OBJECT
which are used independently for mapped and reserved memory resources
accounting. This will help in cleanup of reserved memory resources which was
not handled properly before. With these patches resource cleanup mechanism
will work perfectly in a use case where a big chunk of memory is reserved and
then lot of mappings are created inside it.

Changes since v2:
1. Removed locking from DRV_RemoveAllDMMResElements()
2. Removed cleanup variable from PROC_UnReserveMemory()
   http://marc.info/?l=linux-omap&m=126637211831587&w=2
3. Rebased patchset on top of following commit:
   DSPBRIDGE: Remove conditional check from the InputMsg function

Changed since v1:
1. Reduced indentation
   http://marc.info/?l=linux-omap&m=126624982331523&w=2

Ameya Palande (2):
  DSPBRIDGE: Rename DMM_RES_OBJECT to DMM_MAP_OBJECT
  DSPBRIDGE: New reserved memory accounting framework

 arch/arm/plat-omap/include/dspbridge/drv.h  |   24 +++++--
 arch/arm/plat-omap/include/dspbridge/proc.h |    4 +-
 drivers/dsp/bridge/pmgr/wcd.c               |    7 +-
 drivers/dsp/bridge/rmgr/drv.c               |   87 ++++++++++++++-------------
 drivers/dsp/bridge/rmgr/drv_interface.c     |    4 +-
 drivers/dsp/bridge/rmgr/node.c              |    5 +-
 drivers/dsp/bridge/rmgr/proc.c              |   52 +++++++++++++----
 7 files changed, 116 insertions(+), 67 deletions(-)

