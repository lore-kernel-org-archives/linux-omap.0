From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Lost fixes?
Date: Thu, 15 Mar 2012 10:28:45 +0000
Message-ID: <20120315102845.GB16389@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>, Grant Likely <grant.likely@secretlab.ca>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

These fixes are a collection from other people which resolve various
issues found with the new kautobuilder.  They're now a month old, and
as far as I can see, have not been merged into Linus' tree.

What's the status of them, and when are they going to be merged?

Thanks.

 arch/arm/mach-omap2/Makefile                 |    5 +----
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    2 +-
 arch/arm/mach-omap2/clock.c                  |    2 +-
 arch/arm/mach-omap2/clock.h                  |    2 +-
 arch/arm/mach-omap2/smartreflex.c            |    2 +-
 arch/arm/plat-omap/clock.c                   |    2 +-
 arch/arm/plat-omap/dma.c                     |    2 +-
 arch/arm/plat-omap/include/plat/clock.h      |    4 ++--
 drivers/cpufreq/Kconfig.arm                  |    6 ++++++
 drivers/cpufreq/Makefile                     |    2 +-
 drivers/mfd/da9052-spi.c                     |    4 ++--
 kernel/irq/chip.c                            |    3 +--
 12 files changed, 19 insertions(+), 17 deletions(-)

