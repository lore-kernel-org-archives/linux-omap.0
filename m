From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v10 0/5] usb: musb: adding multi instance support
Date: Tue, 11 Sep 2012 21:43:14 +0530
Message-ID: <1347379999-26061-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47032 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757549Ab2IKQNb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 12:13:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com

This series of patches adds multi instances support in musb driver

AM33xx and TI81xx has dual musb controller and has two usb PHY of same type.

The series applies to felipe/musb branch
	+ Vaibhav baseport patches on his tree at [4]
	+ Kishon's multi phy patches on Felipe's branch 'xceiv'
	+ Kishon's patch on phandle at [2]
	+ Damodar's recent patch at [3] 
	+ Ajay's & Damodar's patches at [5] and [6] included in this series

1. http://git.kernel.org/?p=linux/kernel/git/balbi/usb.git;a=summary
2. http://marc.info/?l=linux-usb&m=134070369306112&w=2
3. http://marc.info/?l=linux-usb&m=134200284230689&w=2
4. https://github.com/hvaibhav/am335x-linux/commits/am335x-upstream-staging
5. http://marc.info/?l=linux-usb&m=134200285530701&w=2
6. http://marc.info/?l=linux-usb&m=134208820028625&w=2

Changes from v9:
	- patches rebased on felipe/musb 
	- DT and xceiv patches not included in this series
Changes from v8:
	- included Sergei's comment, removing underscore in device tree file
	- removed duplicated signoff from patches
Changes from v7:
	- patches rebased on felipe/master branch & verified
	- included additional two patches 0001 & 0002 as part of this series
	  which are already submitted [5] & [6] 
Changes from v6:
	- Removed parent_pdev to get glue and used dev_get_getdrv() as per
	  Felipe's comment
	- use pr_debug() instead of pr_info() as per Felipe's comment
Changes from v5:
	- Removed musb->id as per Felipe's comment
	- used nop_ida as per Felipe's comment
Changes from v4:
	- Fixed Felipe's comment for adding EXPORT_SYMBOL_GPL()
	- Fixed Felipe's comment on using dev_set_mask()
Changes from v3:
	- Fixed Kishon's comment on removing "id" from phy struct and
	  removing unneeded "#else" part.
Changes from v2:
	- Fixed Sergei's comment on not using address prefix in musb_dsps
	  glue and nop transceiver dt dats.
	- Also removed the "ti" string in compatible property for nop data.
Changes from v1:
	- Defined musb_ida to manage core ids based on Felipe's comment
	  in [PATCH 01/11]

	
Ajay Kumar Gupta (3):
  usb: musb: kill global and static for multi instance
  usb: musb: dsps: add dt support
  usb: musb: dsps: remove explicit NOP device creation

B, Ravi (2):
  usb: musb: add musb_ida for multi instance support
  usb: musb: am335x: add support for dual instance

 .../devicetree/bindings/usb/am33xx-usb.txt         |   14 ++
 drivers/usb/musb/am35x.c                           |   42 ++++--
 drivers/usb/musb/blackfin.c                        |   26 +++-
 drivers/usb/musb/da8xx.c                           |   34 +++--
 drivers/usb/musb/davinci.c                         |   34 +++--
 drivers/usb/musb/musb_core.c                       |   53 +++++--
 drivers/usb/musb/musb_core.h                       |    6 +
 drivers/usb/musb/musb_debugfs.c                    |    8 +-
 drivers/usb/musb/musb_dsps.c                       |  167 ++++++++++++++------
 drivers/usb/musb/omap2430.c                        |   26 +++-
 drivers/usb/musb/tusb6010.c                        |   26 +++-
 drivers/usb/musb/ux500.c                           |   33 +++--
 12 files changed, 338 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/am33xx-usb.txt

