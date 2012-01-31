From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v2 00/19] ARM: OMAP3+: SmartReflex: bugfixes
Date: Tue, 31 Jan 2012 10:58:13 +0100
Message-ID: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32880 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab2AaJ65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:58:57 -0500
Received: by wgbdt10 with SMTP id dt10so67497wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:58:56 -0800 (PST)
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

Jean Pihet (1):
  ARM: OMAP3+: SmartReflex: fix the use of debugfs_create_* API

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
 arch/arm/mach-omap2/smartreflex.c            |  418 ++++++++++++++++++++++----
 arch/arm/mach-omap2/smartreflex.h            |   42 +++-
 arch/arm/mach-omap2/sr_device.c              |   11 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 -
 7 files changed, 454 insertions(+), 85 deletions(-)

-- 
1.7.5.4

