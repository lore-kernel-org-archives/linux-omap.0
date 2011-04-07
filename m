From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 0/6] ARM: runtime PM: consolidate runtime PM implementations
Date: Wed,  6 Apr 2011 17:02:43 -0700
Message-ID: <1302134569-22825-1-git-send-email-khilman@ti.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@suse.com>, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

This series aims to consolidate OMAP and SH-mobile runtime PM
implementations around the new device power domains.

In 2.6.39, device power domains were added (commit
7538e3db6e015e890825fbd9f8659952896ddd5b, PM: add support for device
power domains).  In converting both OMAP and SH-mobile to use device
power domains, the overlap between implementations was almost 100%.  

To share the runtime PM implementation based on simple clock gating,
move it to arch/arm/common and initialize it from OMAP and SH-mobile.

Also, OMAP was the only user of platform_bus_set_pm_ops().  Now that
it has been converted to device power domains, remove
platform_bus_set_pm_ops().

Kevin Hilman (6):
  ARM: sh-mobile: runtime PM: convert to device powerdomains
  OMAP2+: PM: move runtime PM implementation to use device power
    domains
  OMAP1: runtime PM: drop platform bus implementation
  ARM: move SH-mobile runtime PM to arm/common for sharing with other
    platforms
  ARM: use common clock-based runtime PM implementation on SH-mobile &
    OMAP1
  Revert "driver core: platform_bus: allow runtime override of
    dev_pm_ops"

 arch/arm/common/Makefile            |    1 +
 arch/arm/common/pm_runtime_clock.c  |  176 +++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/pm_runtime.h   |   17 ++++
 arch/arm/mach-omap1/Makefile        |    2 +-
 arch/arm/mach-omap1/pm_bus.c        |  100 --------------------
 arch/arm/mach-omap1/pm_runtime.c    |   18 ++++
 arch/arm/mach-omap2/Makefile        |    6 +-
 arch/arm/mach-omap2/pm_bus.c        |   85 -----------------
 arch/arm/mach-shmobile/pm_runtime.c |  152 +-----------------------------
 arch/arm/plat-omap/omap_device.c    |   22 +++++
 drivers/base/platform.c             |   35 -------
 include/linux/platform_device.h     |    3 -
 12 files changed, 241 insertions(+), 376 deletions(-)
 create mode 100644 arch/arm/common/pm_runtime_clock.c
 create mode 100644 arch/arm/include/asm/pm_runtime.h
 delete mode 100644 arch/arm/mach-omap1/pm_bus.c
 create mode 100644 arch/arm/mach-omap1/pm_runtime.c
 delete mode 100644 arch/arm/mach-omap2/pm_bus.c

-- 
1.7.4

