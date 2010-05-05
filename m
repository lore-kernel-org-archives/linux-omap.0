From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/18] omap platform data and board updates for 2.6.35 merge
	window
Date: Wed, 05 May 2010 12:32:25 -0700
Message-ID: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55784 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143Ab0EETca (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:32:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap patches for review. This series is pretty much
all platform data and board init updates for omap1/2/3.

The omap4 patches are still coming, but seem to need a bit more work.

Regards,

Tony

---

Ajay Kumar Gupta (1):
      AM35x: fix UI card EHCI port and LCD dependency

Janusz Krzysztofik (1):
      omap1: amsdelta: defconfig updates

Jarkko Nikula (3):
      omap: rx51: Change the TWL4030 VMMC2 voltage constraints andsupply name
      omap: rx51: Add i2c2 board_info with tlv320aic3x
      omap: rx51: Add supplies for the tlv320aic3x codec driver

Sriram (6):
      can:ti_hecc: board specific hookup on AM3517EVM
      can:ti_hecc: Enable CAN support on AM3517
      AM35xx EMAC : define submodule offsets
      AM35xx : Platform specific hookup for EMAC module
      OMAP3 : clock data: Update name string for EMAC clocks
      AM3517 defconfig update : enable EMAC support

Steve Sakoman (1):
      omap: Overo: Add support for second ethernet port

Thomas Weber (2):
      omap: Devkit8000: Add mux initialization
      omap: Devkit8000: Update default configuration

Vaibhav Hiremath (1):
      OMAP2/3: Add V4L2 DSS driver support in device.c

Viral Mehta (3):
      omap2: Add I2C bus 1 initialisation for 2430sdp
      omap2: Add OHCI USB platform init for 2430 SDP
      omap2: select ARCH_OMAP_OTG for OMAP2430 SDP


 arch/arm/configs/am3517_evm_defconfig        |   92 ++++++++++++++-
 arch/arm/configs/ams_delta_defconfig         |    9 +
 arch/arm/configs/devkit8000_defconfig        |  157 +++++++++++++++-----------
 arch/arm/mach-omap2/Kconfig                  |    1 
 arch/arm/mach-omap2/board-2430sdp.c          |   21 +++
 arch/arm/mach-omap2/board-am3517evm.c        |  146 ++++++++++++++++++++++++
 arch/arm/mach-omap2/board-devkit8000.c       |  155 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-overo.c            |   14 ++
 arch/arm/mach-omap2/board-rx51-peripherals.c |   77 +++++++++++--
 arch/arm/mach-omap2/clock3xxx_data.c         |    4 -
 arch/arm/mach-omap2/devices.c                |   28 +++++
 arch/arm/mach-omap2/include/mach/am35xx.h    |   20 +++
 12 files changed, 632 insertions(+), 92 deletions(-)

-- 
Signature
