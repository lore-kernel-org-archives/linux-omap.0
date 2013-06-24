From: Sekhar Nori <nsekhar@ti.com>
Subject: [GIT PULL] DaVinci SoC updates for v3.11 (part 2)
Date: Mon, 24 Jun 2013 20:12:06 +0530
Message-ID: <51C85ABE.6020505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47840 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab3FXOmg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jun 2013 10:42:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: davinci-linux-open-source-request@linux.davincidsp.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>

Hi Arnd, Olof,

Can you please pull the following EDMA related updates for v3.11?
There is a small change to drivers/dma/Kconfig that would have liked 
Vinod's ack, but the change is pretty trivial and the patches have
been out there for pretty long now.

Thanks,
Sekhar

The following changes since commit 7bb5d75ce91ca3725256c0d502624ed697231cde:

  ARM: edma: remove unused transfer controller handlers (2013-06-18 10:53:13 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.11/soc-2

for you to fetch changes up to e65abbbc5279319ab679298f8740ddf53e022a5e:

  dmaengine: edma: enable build for AM33XX (2013-06-24 15:55:08 +0530)

----------------------------------------------------------------
DaVinci SoC updates for v3.11 - part 2
--------------------------------------

This pull request adds DT and runtime PM to
EDMA ARM private API so it can be used on
DT enabled DaVinci and OMAP platforms.

Also adds DMA channel crossbar mapping
support to be used by DT-enabled platforms
which use it.

----------------------------------------------------------------
Lad, Prabhakar (1):
      ARM: edma: Convert to devm_* api

Matt Porter (4):
      dmaengine: edma: Add TI EDMA device tree binding
      ARM: edma: Add DT and runtime PM support to the private EDMA API
      ARM: edma: Add EDMA crossbar event mux support
      dmaengine: edma: enable build for AM33XX

 Documentation/devicetree/bindings/dma/ti-edma.txt |   34 +++
 arch/arm/common/edma.c                            |  329 +++++++++++++++++----
 arch/arm/mach-davinci/devices-da8xx.c             |    8 +-
 arch/arm/mach-davinci/devices-tnetv107x.c         |    4 +-
 arch/arm/mach-davinci/dm355.c                     |    4 +-
 arch/arm/mach-davinci/dm365.c                     |    4 +-
 arch/arm/mach-davinci/dm644x.c                    |    4 +-
 arch/arm/mach-davinci/dm646x.c                    |    4 +-
 arch/arm/mach-omap2/Kconfig                       |    1 +
 drivers/dma/Kconfig                               |    2 +-
 include/linux/platform_data/edma.h                |    5 +-
 11 files changed, 324 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
