From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/7] move omap mailbox to drivers & minor fixes
Date: Fri, 7 Jun 2013 20:57:18 -0500
Message-ID: <1370656638-41177-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55526 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab3FHCC5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 22:02:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, Paul Walmsley <paul@pwsan.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi,

This series moves the OMAP mailbox code to drivers/mailbox folder
and includes other minor fixes. The OMAP mailbox code is disabled
for couple of releases now because of multi-platform support,
and the move enables the driver to be built again and be functional.

These also serve as the base preparatory patches for adapting the
OMAP mailbox code to the upcoming mailbox framework, and for
device-tree conversion.

The first 4 patches in the series are minor fixes/cleanup and
are applicable for 3.10 as well, but are noop until the driver
is buildable. The 5th patch is almost identical to the one [1]
posted (an additional error check for platform_get_irq is added)
during the previous mailbox framework creation, and the last
patch is a reworked version of previous patches from Omar [2].
The first 3 patches are rebased versions from the previous
series as well.

I have tested this series on Panda 4 and Beagle-XM. I will post
the remaining preparatory patches for DT conversion and new
mailbox framework on Monday.

Suman Anna (7):
  omap: mailbox: check iomem resource before dereferencing it
  omap: mailbox: check for NULL nb in mailbox_put
  omap: mailbox: call request_irq after mbox queues are allocated
  omap: mailbox: correct the argument type for irq ops
  ARM: OMAP2+: mbox: remove dependencies with soc.h
  ARM: OMAP2+: add user and fifo info to mailbox platform data
  mailbox/omap: move the OMAP mailbox framework to drivers

[1] https://patchwork.kernel.org/patch/2261091/
[2] https://patchwork.kernel.org/patch/2260901/
    &
    https://patchwork.kernel.org/patch/2261041/

 arch/arm/configs/omap1_defconfig                   |   3 +-
 arch/arm/mach-omap1/Makefile                       |   4 -
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/devices.c                      |  13 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  14 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  13 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  13 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  15 ++
 arch/arm/plat-omap/Kconfig                         |  16 --
 arch/arm/plat-omap/Makefile                        |   3 -
 drivers/mailbox/Kconfig                            |  34 +++
 drivers/mailbox/Makefile                           |   6 +
 .../mailbox.c => drivers/mailbox/mailbox-omap1.c   |  12 +-
 .../mailbox.c => drivers/mailbox/mailbox-omap2.c   | 272 ++++++++-------------
 .../mailbox.c => drivers/mailbox/omap-mailbox.c    |  57 ++++-
 .../plat/mailbox.h => drivers/mailbox/omap-mbox.h  |  70 ++----
 drivers/remoteproc/Kconfig                         |   3 +-
 drivers/remoteproc/omap_remoteproc.c               |   2 +-
 drivers/staging/tidspbridge/Kconfig                |   3 +-
 .../tidspbridge/include/dspbridge/host_os.h        |   2 +-
 include/linux/omap-mailbox.h                       |  29 +++
 include/linux/platform_data/mailbox-omap.h         |  58 +++++
 22 files changed, 368 insertions(+), 277 deletions(-)
 rename arch/arm/mach-omap1/mailbox.c => drivers/mailbox/mailbox-omap1.c (94%)
 rename arch/arm/mach-omap2/mailbox.c => drivers/mailbox/mailbox-omap2.c (59%)
 rename arch/arm/plat-omap/mailbox.c => drivers/mailbox/omap-mailbox.c (91%)
 rename arch/arm/plat-omap/include/plat/mailbox.h => drivers/mailbox/omap-mbox.h (54%)
 create mode 100644 include/linux/omap-mailbox.h
 create mode 100644 include/linux/platform_data/mailbox-omap.h

-- 
1.8.2

