From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/3] Another Errata 430973 Update
Date: Thu, 23 Jul 2015 02:48:00 +0200
Message-ID: <1437612483-30160-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This patchset is a followup to e748994 and a6d74678, that unconditionally
enable the errata 430973 workaround for Cortex A8 CPUs.

The first patch removes the CONFIG_ARM_ERRATA_430973 guard in the Nokia N900's
IBE code, since all sold N900s are affected by the bug (AFAIK).

The next two patches update the errata's Kconfig entry, so that it's no longer
shown for multiplatform kernels and informs about the bootloader method.

-- Sebastian

Sebastian Reichel (3):
  ARM: OMAP2+: N900: always enable IBE bit
  ARM: update errata 430973 documentation
  ARM: errata 430973: move !ARCH_MULTIPLATFORM to Kconfig

 arch/arm/Kconfig                   |  5 +++++
 arch/arm/mach-omap2/board-rx51.c   |  2 --
 arch/arm/mach-omap2/pdata-quirks.c | 11 ++---------
 arch/arm/mm/proc-v7.S              |  2 +-
 4 files changed, 8 insertions(+), 12 deletions(-)

-- 
2.1.4
