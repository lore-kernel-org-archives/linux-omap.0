From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v3 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Fri,  4 Feb 2011 14:21:42 +0000
Message-ID: <1296829307-21439-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64788 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab1BDOWE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 09:22:04 -0500
Received: by wwa36 with SMTP id 36so2403321wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 06:22:03 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

This set of patches, along with some other patches under
discussion on alkml, should enable omap3 and omap4 kernels to be
built with CONFIG_THUMB2_KERNEL.

This patch set builds on recent cleanup done by the omap
maintainers.

It is also more aggressive than my last post: all affected
low-level code is now built in Thumb-2.  At least some of this
code definitely works, most features have been tested
successfully.  Further testing is still welcome.

Seems to work with CONFIG_SMP_ON_UP and CONFIG_THUMB2_KERNEL
enabled on Beagle xM A2 and Panda A1.

Thanks also to Santosh Shilimkar <santosh.shilimkar@ti.com>
for his help with testing.

v3:
    * make SMC instruction syntax more consistent
    * remove do_wfi() in favour of the generic wfi() macro

As part of my ongoing commitment to the environment, this patch
contains over 90% recycled material.

Details below.

Cheers,
Dave


The patches can be found, along with a buildable working tree,
in the following repo:

git://git.linaro.org/people/dmart/linux-2.6-arm.git

 * arm/omap-thumb2: has the patches proposed here
 * arm/omap-thumb2+merged: additionally has some patches cherry-
        picked from other trees which are needed in order for the
        patches on arm/omap-thumb2 to work usefully.
 * dirty/arm/omap-thumb2+merged: buildable test tree, which adds
        2 local patches to work around a toolchain bug.

A working kernel config for this tree is here:
http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config :

  CONFIG_SMP_ON_UP=y
  CONFIG_THUMB2_KERNEL=y
  CONFIG_SERIAL_OMAP=n (to avoid garbage on xM; for Panda use console=ttyS2)

(The config is derived from the linaro omap config and so turns on
loads of modules -- don't feel you have to build them all...)


Cherry-picked patches originated from Russell's devel tree
and Tony Lindgren's omap-testing tree:

http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git devel

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-testing

This series also depends on one un-merged patch to generic-ise
the wfi() macro:

git://git.linaro.org/people/dmart/linux-2.6-arm.git arm/wfi-macro

Dave Martin (5):
  ARM: omap4: Replace custom do_wfi() with generic wfi()
  ARM: omap4: Convert END() to ENDPROC() for correct linkage with
    CONFIG_THUMB2_KERNEL
  ARM: omap3: Remove hand-encoded SMC instructions
  ARM: omap3: Thumb-2 compatibility for sram34xx.S
  ARM: omap3: Thumb-2 compatibility for sleep34xx.S

 arch/arm/mach-omap2/include/mach/omap4-common.h |    7 ---
 arch/arm/mach-omap2/omap-headsmp.S              |    2 +-
 arch/arm/mach-omap2/omap-hotplug.c              |    3 +-
 arch/arm/mach-omap2/omap44xx-smc.S              |    8 ++--
 arch/arm/mach-omap2/pm44xx.c                    |    3 +-
 arch/arm/mach-omap2/sleep34xx.S                 |   56 ++++++++++++++++-------
 arch/arm/mach-omap2/sram34xx.S                  |   28 ++++++++---
 7 files changed, 68 insertions(+), 39 deletions(-)

