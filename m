From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2] ARM: OMAP2+: CM: make some structures, function arguments and pointers as const
Date: Mon,  6 Nov 2017 14:15:38 +0100
Message-ID: <1509974140-10860-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, tony@atomide.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make some pointers and function arguments as const. After this change,
make the structures of type cm_ll_data as const.

Bhumika Goyal (2):
  ARM: OMAP2+: CM: make some pointers and function arguments as const
  ARM: OMAP2+: CM: make cm_ll_data structures as const

 arch/arm/mach-omap2/cm.h         | 4 ++--
 arch/arm/mach-omap2/cm2xxx.c     | 2 +-
 arch/arm/mach-omap2/cm33xx.c     | 2 +-
 arch/arm/mach-omap2/cm3xxx.c     | 2 +-
 arch/arm/mach-omap2/cm_common.c  | 6 +++---
 arch/arm/mach-omap2/cminst44xx.c | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

-- 
1.9.1
