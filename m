From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [GIT PULL] ARM: l2x0: kexex, cleanup and optimisation for 2.6.37
Date: Wed, 29 Sep 2010 13:09:48 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02838@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33499 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab0I2Hlr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 03:41:47 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Linus Walleij <linus.ml.walleij@gmail.com>, "per.xx.fransson@stericsson.com" <per.xx.fransson@stericsson.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>

The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:
  Linus Torvalds (1):
        Linux 2.6.36-rc5

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git l2x0-pull-rmk

Catalin Marinas (1):
      ARM: Improve the L2 cache performance when PL310 is used

Per Fransson (1):
      ARM: ux500 specific L2 cache code

Santosh Shilimkar (4):
      omap4: l2x0: Override the default l2x0_disable
      ARM: l2x0: Fix coding-style in the cache-l2x0.h
      ARM: l2x0: Determine the cache size
      ARM: l2x0: Optimise the range based operations

Thomas Gleixner (2):
      arm: Disable outer (L2) cache in kexec
      arm: Implement l2x0 cache disable functions

 arch/arm/include/asm/hardware/cache-l2x0.h |    9 ++-
 arch/arm/include/asm/outercache.h          |   24 +++++++++
 arch/arm/kernel/machine_kexec.c            |    3 +
 arch/arm/mach-omap2/omap4-common.c         |   13 +++++
 arch/arm/mach-ux500/cpu.c                  |   45 ++++++++++++++++
 arch/arm/mm/Kconfig                        |    8 +++
 arch/arm/mm/cache-l2x0.c                   |   78 +++++++++++++++++++++++++--
 7 files changed, 171 insertions(+), 9 deletions(-)

Regards,
Santosh
Thread where this was discussed:
http://marc.info/?l=linux-omap&m=128396111204338&w=2

