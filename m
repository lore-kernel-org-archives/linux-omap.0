From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v4 0/5] omap: mailbox: hwmod support
Date: Thu, 16 Dec 2010 00:47:54 -0600
Message-ID: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42394 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab0LPG7R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 01:59:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, Charulatha V <charu@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tested on 3430, based of pm-core branch. Patches affecting mailbox code
may require rebase once the mailbox git pull is made.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39719.html

** v4 **
- Merged device latency info with previous patch in series.
- Removed usage of omap_device_enable_clocks and replaced for
  omap_device_[enable|disable]_hwmods to handle sysc setup and
  clocks.
- Fixed pm_runtime usage by adding its enable/disable functions,
  and now handling sysc register with it, because of changes in
  device latency functions.
- For pm_runtime, instead of adding a global variable to make use
  of pdev->dev, use 'parent' inside of 'dev' returned by device_create
  and which is stored inside omap_mbox struct, in future cleanup consider
  cleaning omap_mbox struct. 

** v3 **
- Taken mailbox hwmod as is from Benoit original branch.
- Put back numbers for irq, addresses instead of considering them
 as magic numbers.
- Follow the declaration layout for omap4 hwmods.
- Using pm_runtime to enable the clocks.

** v2 **
- Added omap4 hwmod support.
- Moved "mailbox_ick" from hwmod to hwmod_if (omap 2/3)
- Declared sysc classes for omap 2/3

** v1 **
1. omap: mailbox: initial hwmod support for omap3
Changes were made to:
- Rebase to latest code.
- Detect the hwmod by filling prcm union for omap2, without
 this it was unable to build the hwmod at runtime.
- Replace magic number for defines.
- Use ioremap again instead of relying on the one made by hwmod,
 as noted in http://patchwork.kernel.org/patch/101661/

2. omap: mailbox: initial hwmod support for omap2
Was only compiled tested!! Unfortunately I don't have the HW for it.

Benoit Cousson (1):
  OMAP4: hwmod data: add mailbox data

Felipe Contreras (2):
  OMAP3: hwmod data: add mailbox data
  OMAP: mailbox: build device using omap_device/omap_hwmod

Omar Ramirez Luna (1):
  OMAP: mailbox: use runtime pm for clk and sysc handling

omar ramirez (1):
  OMAP2: hwmod data: add mailbox data

 arch/arm/mach-omap2/devices.c              |  102 ++++++----------------------
 arch/arm/mach-omap2/mailbox.c              |   27 ++------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   73 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   72 +++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   71 +++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   67 ++++++++++++++++++
 6 files changed, 308 insertions(+), 104 deletions(-)

