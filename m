From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 00/21] OMAP3+: SR: bugfixes
Date: Wed, 25 Jan 2012 16:16:02 +0100
Message-ID: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38092 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab2AYPQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 10:16:41 -0500
Received: by wics10 with SMTP id s10so3853554wic.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 07:16:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Integrate the latest SmartReflex bufixes from Felipe Balbi [1] and
Nishant Menon [2].

Based on latest master branch of the mainline git tree (3.3.0-rc1) [3], commit
f8275f9694b8adf9f3498e747ea4c3e8b984499b.

[1] http://marc.info/?l=linux-omap&m=132134699423547&w=2
[2] https://github.com/nmenon/linux-omap-ti-pm/commits/linux-omap-3.0
[3] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=shortlog


Colin Cross (1):
  ARM: omap2+: smartreflex: move smartreflex suspend to suspend_noirq

Felipe Balbi (4):
  arm: omap: smartreflex: add missing platform_set_drvdata()
  arm: omap: smartreflex: move late_initcall() closer to its argument
  arm: omap: smartreflex: clean ups all over
  arm: omap: smartreflex: micro-optimization for sanity check

Julia Lawall (1):
  arch/arm/mach-omap2/smartreflex.c: add missing error-handling code

Nishanth Menon (14):
  OMAP3+: PM: SR: add suspend/resume handlers
  Revert "OMAP3+: PM: SR: add suspend/resume handlers"
  OMAP3+: Smartreflex: fix err interrupt disable sequence
  OMAP3+: PM: SR/Class3: disable errorgen before disable VP
  OMAP3+: Smartreflex: Add a shutdown hook
  OMAP3+: Smartreflex: Fix status masking in ERRCONFIG register
  OMAP3+: Smartreflex: clear ERRCONFIG_VPBOUNDINTST only on a need
  OMAP3: hwmod: add SmartReflex IRQs
  OMAP3+: SR: introduce class init,deinit and priv data
  OMAP3+: SR: introduce notifiers flags
  OMAP3+: SR: introduce notifier_control
  OMAP3+: SR: disable spamming interrupts
  OMAP3+: SR: introduce class private data per voltage domain
  OMAP3430: SR: class3: restrict CPU to run on

Shweta Gulati (1):
  OMAP3+: SR Layer Cleanup [V4]

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   31 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   19 +-
 arch/arm/mach-omap2/smartreflex-class3.c     |   16 +-
 arch/arm/mach-omap2/smartreflex.c            |  408 ++++++++++++++++++++++----
 arch/arm/mach-omap2/smartreflex.h            |   42 +++-
 arch/arm/mach-omap2/sr_device.c              |   11 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 -
 7 files changed, 449 insertions(+), 80 deletions(-)

-- 
1.7.5.4

