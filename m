From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH v5 0/4] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Wed, 26 Nov 2014 15:52:29 -0600
Message-ID: <cover.1417038624.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45616 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbaKZVxK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2014 16:53:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Dave Gerlach <d-gerlach@ti.com>

Hi,
This series is v5 of the series to add suspend/resume support for Texas
Instruments AM335x SoC. It has gone through a rather major overhaul
since the last version and because of that has been split into multiple
different sets of patches, on which this series depends. Previous discussion
that influenced there changes can be found here [1]. This series depends on
generic sram exec mapping patch here [2], emif series here [3],
and wkup_m3_ipc series here [4]. I have pushed a branch containing the patches
from ALL required series here [5] for testing or a view of the high level
flow of the entire series.

The largest change with this revision is the introduction of a
wkup_m3_ipc driver which handles all communication with the Cortex M3
present on am335x for handling low power tasks. Previously this was
handled in the wkup_m3_rproc driver (also sent in an earlier series)
but that driver is now only responsible for booting the wkup_m3. The
wkup_m3_ipc driver exposes an API with all required PM functionality
needed by the PM code introduced by this series, so the PM code has
shrunk considerably.

Another major change is that the EMIF code previously present in the
sleep33xx asm code and pm33xx code for save and restore of EMIF context
and entry into low power mode has all been moved in to a separate EMIF
driver, further reducing the size of the PM code. Because of this, moving
the emif header defines into include/linux/ti_emif.h is no longer necessary.

Other changes include clean up of the timer suspend/resume handlers, now
look up hwmod in init and use that handle along with renaming to
*_idle/*_unidle to avoid confusion with true suspend handlers. 

Suspend support requires:
CONFIG_TI_EMIF_SRAM
CONFIG_WKUP_M3_RPROC
CONFIG_WKUP_M3_IPC

And also requires AM335x USB support to be enabled to work for multiple
cycles. If you want to load firmware from rootfs in /lib/firmware you now
must also select CONFIG_FW_LOADER_USER_HELPER_FALLBACK.

This code works with version 0x189 of the CM3 firmware found here [6] on
the next branch, /bin/am335x-pm-firmware.elf.

Regards,
Dave

[1] http://www.spinics.net/lists/linux-omap/msg109331.html
[2] http://www.spinics.net/linux/lists/kernel/msg1876629.html
[3] http://www.spinics.net/linux/lists/kernel/msg1876646.html
[4] http://www.spinics.net/linux/lists/kernel/msg1876642.html
[5] https://github.com/dgerlach/linux-pm/tree/rfc-pm-am335x-v3.18-rc6
[6] https://git.ti.com/ti-cm3-pm-firmware/amx3-cm3/commits/next

Dave Gerlach (3):
  ARM: OMAP2+: AM33XX: Add assembly code for PM operations
  ARM: OMAP2+: AM33XX: Basic suspend resume support
  ARM: OMAP2+: AM33XX: Hookup AM33XX PM code into OMAP builds

Vaibhav Bedia (1):
  ARM: OMAP2+: timer: Add suspend-resume callbacks for clkevent device

 arch/arm/boot/dts/am33xx.dtsi   |   2 +
 arch/arm/mach-omap2/Makefile    |   2 +
 arch/arm/mach-omap2/common.h    |   9 ++
 arch/arm/mach-omap2/io.c        |   1 +
 arch/arm/mach-omap2/pm.h        |   6 +
 arch/arm/mach-omap2/pm33xx.c    | 250 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sleep33xx.S | 216 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/timer.c     |  28 +++++
 8 files changed, 514 insertions(+)
 create mode 100644 arch/arm/mach-omap2/pm33xx.c
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S

-- 
2.1.0

