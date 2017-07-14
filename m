From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 0/2] mmc: omap: Remove Unused Code
Date: Fri, 14 Jul 2017 18:16:42 +0530
Message-ID: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, rk@ti.com, nsekhar@ti.com, linus.walleij@linaro.org, hkallweit1@gmail.com, peter.ujfalusi@ti.com, Faiz Abbas <faiz_abbas@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series removes some code in omap_hsmmc.c
and hsmmc.c and members from hsmmc.h and 
hsmmc-omap.h which are not used anymore post 
conversion to device-tree.

Patch 2 depends on Patch 1

Faiz Abbas (2):
  ARM: OMAP2+: hsmmc.c: Remove dead code
  mmc: host: omap_hsmmc: remove unused platform callbacks

 arch/arm/mach-omap2/hsmmc.c              | 239 +------------------------------
 arch/arm/mach-omap2/hsmmc.h              |   9 --
 drivers/mmc/host/omap_hsmmc.c            |  11 --
 include/linux/platform_data/hsmmc-omap.h |  10 --
 4 files changed, 2 insertions(+), 267 deletions(-)

-- 
2.7.4
