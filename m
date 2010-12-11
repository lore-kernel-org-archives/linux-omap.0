From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v3 0/5] omap: mailbox: hwmod support
Date: Fri, 10 Dec 2010 19:51:01 -0600
Message-ID: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44311 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118Ab0LKCCT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 21:02:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, Charulatha V <charu@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tested on 3430, based of pm-core branch. It may require rebase once
the mailbox git pull is made.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39719.html

** v3 **
- Taken mailbox hwmod as is from Benoit original branch.
- Put back numbers for irq, addresses instead of considering them
  as magic numbers.
- Follow the declaration layout for omap4 hwmods.
- Using pm_runtime to enable the clocks.

TBD: Cleanup, once omap_device_get_rt_va can be called by drivers
using pdev and the proper omap_device_reset API is submitted.

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

Felipe Contreras (3):
  OMAP3: hwmod data: add mailbox data
  OMAP: mailbox: build device using omap_device/omap_hwmod
  OMAP: mailbox: add omap_device latency information

omar ramirez (1):
  OMAP2: hwmod data: add mailbox data

 arch/arm/mach-omap2/devices.c              |  102 ++++++----------------------
 arch/arm/mach-omap2/mailbox.c              |   18 ++---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   73 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   72 +++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   71 +++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   68 ++++++++++++++++++
 6 files changed, 310 insertions(+), 94 deletions(-)

