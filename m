From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 00/10] OMAP-GPMC: generic time calc, prepare for driver
Date: Tue, 21 Aug 2012 16:11:56 +0530
Message-ID: <cover.1345524670.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43118 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755146Ab2HUKmH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 06:42:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, jon-hunter@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Hi,

This series provides a generic gpmc timing calculation routine. There
were three peripherals (OneNAND, tusb6010, smc91x) using custom timing
calculations, they are migrated to use the generic timing calculation.

Such a generic routine would help create a driver out of gpmc platform
code, which would be peripheral agnostic and thus lead to DT finally.
Input to generic timing calculation routine would be gpmc peripheral
timings, output - translated timings that gpmc can understand. Later,
to DT'ify, gpmc peripheral timings could be passed through DT. Input
timings that has been used here are selected such that it represents
those that are present in peripheral timing datasheets.

Proposed generic routine has been tested on OneNAND (async) on
OMAP3EVM rev C (as mainline does not have the OneNAND support for this,
local patch were used to test). For other cases of custom timing
calculation (tusb6010, smc91x non-muxed, OneNAND sync), generic timing
calculation routine was verified by simulating on OMAP3EVM. Codebase
for such a testing is available
@ git://gitorious.org/x0148406-public/linux-kernel.git gpmc-prep-v6-verify

Regarding "we_on" for onenand async, it was found that even for muxed
address/data, it need not be greater than "adv_wr_off", but rather
could be derived from write setup time for peripheral from start of
access, hence would more be in line with peripheral timings. With
"we_on" calculated this way, it was working fine. If it is required in
some cases to have "we_on" same as "wr_data_mux_bus" (i.e. greater
than "adv_wr_off") other than for IP's not having "wr_data_mux_bus",
another variable could be added to indicate it, but such a
requirement is not expected though.

It has been observed that "adv_rd_off" & "adv_wr_off" are currently
calculated by adding an offset over "oe_on" & "we_on" respectively
in the case of smc91x. But peripheral datasheet does not specify
so and so "adv_rd(wr)_off" has been derived (to be specific, made
ignorant of "oe_on" & "we_on") observing datasheet rather than adding
an offset. Hence this generic routine is expected to work for smc91x
(91C96 RX51 board). This was verified on smsc911x (9220 on OMAP3EVM)
- a similar ethernet controller.

Also this series contains, patches 1-3 of v5 in addition to
minor cleanups that were low hanging fruits came across upon
implementing generic timing routine. One such is credited to
Jon Hunter, relevant patch is 1/2 of his series
@ http://marc.info/?l=linux-omap&m=134090910321284&w=2

This series has been tested on OMAP3EVM. As mentioned above, generic
timing could be tested on OneNAND hardware working in async mode.
Also generic timing calculation for other cases was validated by
comparing output values of existing custom timing calculation routine
& the new generic one, these conditions were simulated on OMAP3EVM


This series is available
	@ git://gitorious.org/x0148406-public/linux-kernel.git gpmc-prep-v6

and is made on top of
	http://marc.info/?l=linux-omap&m=134554192102899&w=2

which is based over 3.6-rc1.

Regards
Afzal

v6:
	1. Generic timing calculation, move existing users of custom
	 calculation to use the new generic one
	2. Set OneNAND part to async mode before gpmc configuration
	3. Move extra delay time user handling to proper patch
	 (3/10 -> 2/10)
	4. Modify nand init for OMAP3EVM too as support got added
v5:
	Use flags for sync_read/write, hv, vhf
v4:
	Reorganize OneNAND set_sync/async functions in a better way
v3:
	1. Refactor OneNAND set_sync/async functions to separate out
	 timing and configurations
	2. Handle bool type timings too
	3. Swap patches 2 & 3 due to dependency of OneNAND change on
	 newly added bool type timings
v2:
	1. Make use of timing api for setting clock activation time,
	 and remove direct writing to register for clock activation.
	2. Move ensuring that async mode in OneNAND has been setup from
	 set_sync to setup function, improve commit message

Afzal Mohammed (9):
  ARM: OMAP2+: nand: unify init functions
  ARM: OMAP2+: gpmc: handle additional timings
  ARM: OMAP2+: onenand: refactor for clarity
  ARM: OMAP2+: gpmc: find features by ip rev check
  ARM: OMAP2+: gpmc: remove cs# in sync clk div calc
  ARM: OMAP2+: gpmc: generic timing calculation
  ARM: OMAP2+: onenand: generic timing calculation
  ARM: OMAP2+: smc91x: generic timing calculation
  ARM: OMAP2+: tusb6010: generic timing calculation

Jon Hunter (1):
  ARM: OMAP2+: GPMC: Remove unused OneNAND get_freq() platform function

 arch/arm/mach-omap2/board-devkit8000.c     |    8 +-
 arch/arm/mach-omap2/board-flash.c          |   45 ++--
 arch/arm/mach-omap2/board-flash.h          |    6 +-
 arch/arm/mach-omap2/board-igep0020.c       |    2 +-
 arch/arm/mach-omap2/board-ldp.c            |    4 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    8 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    8 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    8 +-
 arch/arm/mach-omap2/board-overo.c          |    7 +-
 arch/arm/mach-omap2/board-zoom.c           |    5 +-
 arch/arm/mach-omap2/common-board-devices.c |   46 ----
 arch/arm/mach-omap2/common-board-devices.h |    1 -
 arch/arm/mach-omap2/gpmc-onenand.c         |  334 +++++++++++---------------
 arch/arm/mach-omap2/gpmc-smc91x.c          |   43 ++--
 arch/arm/mach-omap2/gpmc.c                 |  363 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/usb-tusb6010.c         |  180 ++++-----------
 arch/arm/plat-omap/include/plat/gpmc.h     |   82 ++++++-
 arch/arm/plat-omap/include/plat/onenand.h  |    8 -
 18 files changed, 707 insertions(+), 451 deletions(-)

