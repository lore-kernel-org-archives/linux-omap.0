From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH v2 0/2] ARM: OMAP2+: Export SoC information to userspace using SoC infrastructure
Date: Wed,  6 Feb 2013 20:59:54 +0200
Message-ID: <1360177196-18196-1-git-send-email-ruslan.bilovol@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This patch series is an attempt to export some OMAP SoC
information (like name, revision etc.) to userspace.
The first patch does some unification of OMAP SoC
information representation in current sources.
Second patch adds exactly needed changes using
exists in Linux kernel SoC infrastructure.

-----------------------------------------
v2:
- changed cpu_* -> soc_* variable names
- rebased on top of 'omap-for-v3.9/soc' branch of tmlind/linux-omap tree

Ruslan Bilovol (2):
  ARM: OMAP2+: SoC name and revision unification
  ARM: OMAP2+: Export SoC information to userspace

 arch/arm/mach-omap2/common.h |    8 +++
 arch/arm/mach-omap2/id.c     |  154 +++++++++++++++++++++++++++++++-----------
 arch/arm/mach-omap2/io.c     |    1 +
 arch/arm/plat-omap/Kconfig   |    1 +
 4 files changed, 126 insertions(+), 38 deletions(-)

-- 
1.7.9.5
