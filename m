From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/8] Fix module-mode enable sequence on OMAP4
Date: Thu, 9 Jun 2011 16:24:05 +0530
Message-ID: <1307616853-28395-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40275 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753919Ab1FIKyg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jun 2011 06:54:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi,

On OMAP4, the PRCM recommended sequence for enabling
a module after power-on-reset is
-1- Force clkdm to SW_WKUP
-2- Configure desired module mode to "enable" or "auto"
-3- Wait for the desired module idle status to be FUNC
-4- Program clkdm in HW_AUTO(if supported)

This sequence applies to all older OMAPs' as well,
however since they use 'autodeps', it makes sure that
no clkdm is in IDLE, and hence not requiring a force
SW_WKUP when a module is being enabled.

OMAP4 does not need to support autodeps, because
of the dynamic dependency feature, wherein
the HW takes care of waking up a clockdomain from
idle and hence the module, whenever an interconnect
access happens to the given module.

Implementing the sequence for OMAP4 requires some of
the clockdomain handling that is currently done in
clock framework to be done as part of hwmod framework
since the step -3- above to "Wait for the desired 
module idle status to be FUNC" is done as part of
hwmod framework.

This series moves the clockdomain handling into hwmod
framework and implements the above sequence for OMAP4.

The above sequence is expected to be followed even for
optional clocks (steps -1-, -2- and -4- only) and that
makes handling it difficult as optional clocks are enabled by
drivers using direct clock framework calls and hence
do not go through the hwmod framework.

Hence this series also adds the handling of the sequence
*only for optional clocks* in clock framework.

Lastly, with this series drivers which are yet to be
adapted to PM runtime and still rely on clock calls
to enable/disable the respective *main* clocks are
expected to be broken. MMC is one such which even breaks
boot, and hence the series has a TEMP workaround patch
added which keeps l3init clockdomain always force-enabled.
This TEMP patch will gate all CORE low power transitions
but should atleast allow MPU low power transitions to
work.

The series is tested for low power state transitions
(RET/OFF) on OMAP3sdp and boot tested on OMAP4sdp.
Applies on 3.0-rc2

Rajendra Nayak (8):
  OMAP2+: clockdomain: Add an api to read idle mode
  OMAP2+: clockdomain: Add SoC support for clkdm_is_idle
  OMAP2+: PM: Initialise sleep_switch to a non-valid value
  OMAP2+: PM: idle clkdms only if already in idle
  OMAP4: PM: TEMP: Prevent l3init from idling/force sleep
  OMAP2+: hwmod: Follow the recomended PRCM clock enable sequence
  OMAP: clock: Add flags to identify optional clock nodes
  OMAP: clock: Enable clockdomain only for optional clocks

 arch/arm/mach-omap2/clock.c                 |   30 ++++++++++++------------
 arch/arm/mach-omap2/clock44xx_data.c        |   34 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomain.c           |   28 +++++++++++++++++++++-
 arch/arm/mach-omap2/clockdomain.h           |    3 ++
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c  |   12 +++++++++
 arch/arm/mach-omap2/clockdomain44xx.c       |   16 ++++++------
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c            |   20 +++++++++++++++-
 arch/arm/mach-omap2/pm.c                    |    6 +++-
 arch/arm/plat-omap/include/plat/clock.h     |    1 +
 10 files changed, 124 insertions(+), 28 deletions(-)

