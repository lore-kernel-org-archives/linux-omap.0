From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCHv2 0/2] DSPBRIDGE: Improved reserved memory cleanup
Date: Tue, 16 Feb 2010 15:20:07 +0200
Message-ID: <cover.1266326009.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26586 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936Ab0BPNVK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 08:21:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, nm@ti.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, x0095840@ti.com

This patch series splits DMM_RES_OBJECT into DMM_MAP_OBJECT and DMM_RSV_OBJECT
which are used independently for mapped and reserved memory resources
accounting. This will help in cleanup of reserved memory resources which was
not handled properly before. With these patches resource cleanup mechanism
will work perfectly in a use case where a big chunk of memory is reserved and
then lot of mappings are created inside it.

v2: Addresses following comments about reducing indentation
http://marc.info/?l=linux-omap&m=126624982331523&w=2

Ameya Palande (2):
  DSPBRIDGE: Rename DMM_RES_OBJECT to DMM_MAP_OBJECT
  DSPBRIDGE: New reserved memory accounting framework

 arch/arm/plat-omap/include/dspbridge/drv.h  |   25 ++++++--
 arch/arm/plat-omap/include/dspbridge/proc.h |    5 +-
 drivers/dsp/bridge/pmgr/dmm.c               |    3 +-
 drivers/dsp/bridge/pmgr/wcd.c               |    7 +-
 drivers/dsp/bridge/rmgr/drv.c               |   84 ++++++++++++++++-----------
 drivers/dsp/bridge/rmgr/drv_interface.c     |    7 ++-
 drivers/dsp/bridge/rmgr/node.c              |    5 +-
 drivers/dsp/bridge/rmgr/proc.c              |   58 +++++++++++++++----
 8 files changed, 132 insertions(+), 62 deletions(-)

