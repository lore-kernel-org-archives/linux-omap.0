From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v3 00/20] ARM: OMAP3+: SmartReflex: bugfixes
Date: Wed,  1 Feb 2012 09:49:39 +0100
Message-ID: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45673 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab2BAIuL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 03:50:11 -0500
Received: by wics10 with SMTP id s10so697604wic.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 00:50:10 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Integrate the latest SmartReflex bufixes from Felipe Balbi [1] and
Nishant Menon [2], plus misc bugfixes.

Based on latest master branch of the mainline git tree (3.3.0-rc1) [3], commit
27ba234c8dfe86c96675d4ef275d1d3c1f5f7053.

[1] http://marc.info/?l=linux-omap&m=132134699423547&w=2
[2] https://github.com/nmenon/linux-omap-ti-pm/commits/linux-omap-3.0
[3] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=shortlog


Revision history:
. v3:
  fixed the error handling code

. v2:
  fixed the use of debugfs_create_* API
  minor fixes after comments on l-o ML: commits title, removed unneeded
   fields in descriptions
  removed the unneeded patches about the suspend/resume handlers

. v1:
  initial commits


Felipe Balbi (4):
  ARM: OMAP3+: SmartReflex: add missing platform_set_drvdata()
  ARM: OMAP3+: SmartReflex: move late_initcall() closer to its argument
  ARM: OMAP3+: SmartReflex: misc cleanups
  ARM: OMAP3+: SmartReflex: micro-optimization for sanity check

Jean Pihet (2):
  ARM: OMAP3+: SmartReflex: fix the use of debugfs_create_* API
  ARM: OMAP3+: SmartReflex: fix error handling

Julia Lawall (1):
  ARM: OMAP3+: SmartReflex: add missing error-handling code

Nishanth Menon (12):
  ARM: OMAP3+: SmartReflex: fix err interrupt disable sequence
  ARM: OMAP3+: SmartReflex Class3: disable errorgen before disable VP
  ARM: OMAP3+: SmartReflex: Add a shutdown hook
  ARM: OMAP3+: SmartReflex: Fix status masking in ERRCONFIG register
  ARM: OMAP3+: SmartReflex: clear ERRCONFIG_VPBOUNDINTST only on a need
  ARM: OMAP3+: hwmod: add SmartReflex IRQs
  ARM: OMAP3+: SmartReflex: introduce class init, deinit and priv data
  ARM: OMAP3+: SmartReflex: introduce notifiers flags
  ARM: OMAP3+: SmartReflex: introduce notifier_control
  ARM: OMAP3+: SmartReflex: disable spamming interrupts
  ARM: OMAP3+: SmartReflex: introduce class private data per voltage
    domain
  ARM: OMAP3+: SmartReflex Class3: restrict CPU to run on

Shweta Gulati (1):
  ARM: OMAP3+: SmartReflex: Layer Cleanup [V4]

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   31 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   19 +-
 arch/arm/mach-omap2/smartreflex-class3.c     |   16 +-
 arch/arm/mach-omap2/smartreflex.c            |  424 +++++++++++++++++++++----
 arch/arm/mach-omap2/smartreflex.h            |   42 +++-
 arch/arm/mach-omap2/sr_device.c              |   11 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 -
 7 files changed, 457 insertions(+), 88 deletions(-)

-- 
1.7.5.4

