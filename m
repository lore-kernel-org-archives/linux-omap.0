From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/14] ti-sysc changes to probe devices with dts data only
Date: Mon, 25 Mar 2019 14:58:35 -0700
Message-ID: <20190325215849.13182-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are some ti-sysc interconnect target module changes that allow
dropping legacy platform data for many devices in favor of devicetree
provided data.

This series depends on patch series "[PATCH 0/7] omap changes to
allocate struct omap_hwmod dynamically".

I'll be posting patches separately to drop platform data. Meanwhile,
the easiest way to test this series is to just temporarily comment
out selected platform data entries one driver at a time. This can be
done in the SoC specific struct omap_hwmod_ocp_if array at the end of
the arch/arm/mach-omap2/omap_hwmod_*_data.c files.

Note that we are not yet handling all the quirks yet listed in
arch/arm/mach-omap2/omap_hwmod.h in "omap_hwmod.flags definitions".
We currently do not yet handle quirks for devices with:

HWMOD_NO_OCP_AUTOIDLE
HWMOD_NO_IDLEST
HWMOD_BLOCK_WFI
HWMOD_FORCE_MSTANDBY
HWMOD_RECONFIG_IO_CHAIN
HWMOD_CLKDM_NOAUTO

I'll be posting patches for these later on as needed.

Regards,

Tony


Tony Lindgren (14):
  bus: ti-sysc: Fix sysc_unprepare() when no clocks have been allocated
  bus: ti-sysc: Handle missed no-idle property in addition to
    no-idle-on-init
  bus: ti-sysc: Make functions static
  bus: ti-sysc: Move legacy platform data idling into separate functions
  bus: ti-sysc: Add separate functions for handling clocks
  bus: ti-sysc: Enable all clocks directly during init to read revision
  bus: ti-sysc: Allocate mdata as needed and do platform data based init
    later
  bus: ti-sysc: Manage clocks for the interconnect target module in all
    cases
  bus: ti-sysc: Move rstctrl reset to happen later
  bus: ti-sysc: Add support for early quirks based on register address
  bus: ti-sysc: Add quirk handling for external optional functional
    clock
  bus: ti-sysc: Pass clockactivity quirk to platform functions
  bus: ti-sysc: Handle swsup idle mode quirks
  bus: ti-sysc: Detect DMIC for debugging

 .../devicetree/bindings/bus/ti-sysc.txt       |   2 +
 arch/arm/mach-omap2/omap_hwmod.c              |  10 +
 drivers/bus/ti-sysc.c                         | 537 ++++++++++++++----
 include/linux/platform_data/ti-sysc.h         |   9 +-
 4 files changed, 438 insertions(+), 120 deletions(-)

-- 
2.21.0
