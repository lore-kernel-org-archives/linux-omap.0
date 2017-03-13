From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/4] ARM: DRA7: Fix DCAN1 stuck-in-transition
Date: Mon, 13 Mar 2017 13:53:12 +0200
Message-ID: <1489405996-10718-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: bcousson@baylibre.com, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On DRA7 platform, DCAN1 module has an issue when it's clockdomain
(WKUPAON) is configured in HW_AUTO. After DCAN1 is enabled and disabled
the module remains stuck in transition.

Suggested workaround by Silicon team is to disable HW_AUTO for
WKUPAON clockdomain when DCAN1 module is active.

These patches provide a new flag for hwmod data to support this
behaviour and fix up dra7 hwmod data as well to fix this issue
on dra7x-evms.

This patch allows DCAN1 to be functional as well as not prevent
Core Retention as WKUPAON clockdomain is put back into HW_AUTO
whenever DCAN1 is not active (e.g. runtime suspended).

Without this series, we can see the following warning messages
when the CAN interface is brought up and down.

~# ifconfig can0 up
[   36.418299] net can0: c_can_hw_raminit_wait_syscon: time out
[   36.424642] c_can_platform 4ae3c000.can can0: setting BTR=1c04 BRPE=0000
~# ifconfig can0 down
[   50.488786] omap_hwmod: dcan1: _wait_target_disable failed
[   50.502855] omap_hwmod: dcan1: _wait_target_disable failed

cheers,
-roger

Roger Quadros (3):
  ARM: OMAP2+ hwmod: Allow modules to disable HW_AUTO
  ARM: DRA7: hwmod: Fix DCAN1 stuck in transition
  ARM: DRA7: hwmod_data: Prevent wait_target_disable error for
    usb_otg_ss

Sekhar Nori (1):
  ARM: OMAP2+: omap_hwmod: provide space for more hwmod flags

 arch/arm/mach-omap2/omap_hwmod.c          | 4 ++--
 arch/arm/mach-omap2/omap_hwmod.h          | 7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.7.4
