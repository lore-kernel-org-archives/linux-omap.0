From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 0/4] OMAP-GPMC generic timing migration
Date: Fri, 5 Oct 2012 21:30:55 +0530
Message-ID: <cover.1349450723.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41605 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab2JEQBK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 12:01:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

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

This series has been created by pulling out last 4 patches in v7
of the series,
"OMAP-GPMC: generic time calc, prepare for driver"
This was done to have easy path for common zImage gpmc cleanup patches.

Proposed generic routine has been tested on OneNAND (async) on
OMAP3EVM rev C (as mainline does not have the OneNAND support for this,
local patch were used to test). For other cases of custom timing
calculation (tusb6010, smc91x non-muxed, OneNAND sync), generic timing
calculation routine was verified by simulating on OMAP3EVM.

This series is available
        @ git://gitorious.org/x0148406-public/linux-kernel.git gpmc-timing-v1
and is based on
        linux-next (next-20121005)
and is dependent on
	http://marc.info/?l=linux-omap&m=134945131602622&w=2
	http://marc.info/?l=linux-omap&m=134945239306131&w=2

This series as such is only the first version, but these patches has
already undergone one change before being made as this series. The
change was in using ps instead of ns to prevent rounding errors.
Also along with this series documentation has been improved.

Regards
Afzal


Afzal Mohammed (4):
  ARM: OMAP2+: gpmc: generic timing calculation
  ARM: OMAP2+: onenand: generic timing calculation
  ARM: OMAP2+: smc91x: generic timing calculation
  ARM: OMAP2+: tusb6010: generic timing calculation

 Documentation/bus-devices/ti-gpmc.txt | 122 +++++++++++++
 arch/arm/mach-omap2/gpmc-onenand.c    | 124 +++++--------
 arch/arm/mach-omap2/gpmc-smc91x.c     |  43 ++---
 arch/arm/mach-omap2/gpmc.c            | 325 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.h            | 102 ++++++++---
 arch/arm/mach-omap2/usb-tusb6010.c    | 182 +++++--------------
 6 files changed, 633 insertions(+), 265 deletions(-)
 create mode 100644 Documentation/bus-devices/ti-gpmc.txt

-- 
1.7.12

