From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v5 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Thu, 17 Feb 2011 12:42:33 +0000
Message-ID: <1297946558-13436-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48463 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab1BQMmy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 07:42:54 -0500
Received: by wyb28 with SMTP id 28so2469342wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 04:42:52 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, patches@linaro.org

This set of patches, along with some other patches under
discussion on alkml, should enable omap3 and omap4 kernels to be
built with CONFIG_THUMB2_KERNEL.

This patch set builds on recent cleanup done by the omap
maintainers.

At least some of this code definitely works, most features have
been tested successfully.  Further testing, especially of Thumb-2
behaviour, is still welcome.

Seems to work with CONFIG_SMP_ON_UP and CONFIG_THUMB2_KERNEL
enabled on Beagle xM A2 and Panda A1.

Thanks also to Santosh Shilimkar and Kevin Hilman for their help
with testing.


v3:
    * make SMC instruction syntax more consistent
    * remove do_wfi() in favour of the generic wfi() macro

v4:
    * revert to the OMAP-specific do_wfi() implementation, pending
      discussion of how generic macros can/should be provided

v5:
    * use ARM for low-level code in mach-omap2/*34xx.S, for
      correct interoperation with non-Thumb-capable firmware.

I've stripped the Acked/Tested-bys from the major patches to
mach-omap2/*34xx.S, since the reversion to ARM constitutes a
significant change -- I would be grateful if people could re-
test / re-review if they have the chance.

For best future compatibility, I've left the changes which
avoid architecturally deprecated features.


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
  CONFIG_SERIAL_OMAP=y (to avoid garbage on xM; for Panda use console=ttyS2)

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
  ARM: omap4: Provide do_wfi() for Thumb-2
  ARM: omap4: Convert END() to ENDPROC() for correct linkage with
    CONFIG_THUMB2_KERNEL
  ARM: omap3: Remove hand-encoded SMC instructions
  ARM: omap3: Thumb-2 compatibility for sram34xx.S
  ARM: omap3: Thumb-2 compatibility for sleep34xx.S

 arch/arm/mach-omap2/include/mach/omap4-common.h |    4 ++
 arch/arm/mach-omap2/omap-headsmp.S              |    2 +-
 arch/arm/mach-omap2/omap44xx-smc.S              |    8 ++--
 arch/arm/mach-omap2/sleep34xx.S                 |   62 ++++++++++++++++++----
 arch/arm/mach-omap2/sram34xx.S                  |   36 ++++++++++---
 5 files changed, 87 insertions(+), 25 deletions(-)

