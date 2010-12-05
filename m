From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/5] ARM: GIC: cleanup
Date: Sun, 5 Dec 2010 11:33:11 +0000
Message-ID: <20101205113311.GC9138__7590.40280613608$1291548879$gmane$org@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47142 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498Ab0LELeZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 06:34:25 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anton Vorontsov <avorontsov@mvista.com>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaur>

This patch series cleans up the GIC code, consolidating some of the
per-platform practices into the common GIC code.

One notable change is to the initialization methods - we used to
require platforms to pass in the address of the per-CPU interfaces
despite them always being identical between all cores.  This was
nonsense, as even in the extremely unlikely event that they were
different, we aren't storing them in a per-CPU manner.

The GIC initialization methods are now simpler: one call to gic_init()
from the boot CPU, and a call to gic_secondary_init() as each
secondary CPU starts - and no need for platforms to keep track of
the address anymore.

One question remains on this: on platforms where there are more than
one GIC, do these have separate CPU interfaces as well?

We also consolidate gic_cpu_base_addr to save platforms using that -
but only for the first GIC, and therefore we can have a common
get_irqnr_preamble assembler macro for platforms which make use of
this.

Lastly, we move the GIC data to __read_mostly - and when we have
support for this feature, we benefit from avoiding potential cache
line ping-pongs between cores for data so marked.

 arch/arm/common/gic.c                             |   59 +++++++++++++-------
 arch/arm/include/asm/hardware/entry-macro-gic.S   |    7 +++
 arch/arm/include/asm/hardware/gic.h               |    6 ++-
 arch/arm/mach-cns3xxx/core.c                      |    7 +--
 arch/arm/mach-cns3xxx/core.h                      |    1 -
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S  |    5 --
 arch/arm/mach-msm/board-msm8x60.c                 |    7 +--
 arch/arm/mach-omap2/include/mach/entry-macro.S    |    1 +
 arch/arm/mach-omap2/include/mach/omap4-common.h   |    1 -
 arch/arm/mach-omap2/omap-smp.c                    |    2 +-
 arch/arm/mach-omap2/omap4-common.c                |   11 ++--
 arch/arm/mach-realview/core.c                     |    3 -
 arch/arm/mach-realview/core.h                     |    1 -
 arch/arm/mach-realview/include/mach/entry-macro.S |    5 --
 arch/arm/mach-realview/platsmp.c                  |    2 +-
 arch/arm/mach-realview/realview_eb.c              |   14 ++---
 arch/arm/mach-realview/realview_pb1176.c          |   11 ++--
 arch/arm/mach-realview/realview_pb11mp.c          |   10 ++--
 arch/arm/mach-realview/realview_pba8.c            |    6 +-
 arch/arm/mach-realview/realview_pbx.c             |   13 ++---
 arch/arm/mach-s5pv310/cpu.c                       |    6 +--
 arch/arm/mach-s5pv310/include/mach/smp.h          |    2 -
 arch/arm/mach-s5pv310/platsmp.c                   |    2 +-
 arch/arm/mach-tegra/include/mach/entry-macro.S    |    2 +-
 arch/arm/mach-tegra/irq.c                         |    4 +-
 arch/arm/mach-tegra/platsmp.c                     |    2 +-
 arch/arm/mach-ux500/cpu.c                         |    4 +-
 arch/arm/mach-ux500/include/mach/entry-macro.S    |    1 +
 arch/arm/mach-ux500/platsmp.c                     |    2 +-
 arch/arm/mach-vexpress/core.h                     |    2 -
 arch/arm/mach-vexpress/ct-ca9x4.c                 |    7 +--
 arch/arm/mach-vexpress/include/mach/entry-macro.S |    5 --
 arch/arm/mach-vexpress/platsmp.c                  |    2 +-
 33 files changed, 100 insertions(+), 113 deletions(-)

