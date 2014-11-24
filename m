From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/2] part 2 of omap dts changes for v3.19
Date: Mon, 24 Nov 2014 09:09:08 -0800
Message-ID: <20141124170908.GF2817@atomide.com>
References: <pull-1416703431-245942>
 <pull-1416703431-245942-2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26828 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751572AbaKXRLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 12:11:44 -0500
Content-Disposition: inline
In-Reply-To: <pull-1416703431-245942-2>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Just noticed I have the signed tag missing for this one, updated pull
request below.

* Tony Lindgren <tony@atomide.com> [141122 16:47]:
> The following changes since commit 065bd7fe50de5e6d0fd5034cbc87120a558a1219:
> 
>   ARM: dts: DRA7: Add aliases for all serial ports (2014-11-12 07:04:37 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap-for-v3.19/dt-v2

So please ignore the pull request above, below is an updated pull request
with a proper tag. I've also added few more patches that I could not apply
earlier because of pending comments.

The following changes since commit 065bd7fe50de5e6d0fd5034cbc87120a558a1219:

  ARM: dts: DRA7: Add aliases for all serial ports (2014-11-12 07:04:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/dt-part2-updated

for you to fetch changes up to f80ecaf55b4982a888272790743dabf2c715dc10:

  ARM: dts: am335x-evm: Add DCAN1 details (2014-11-24 07:56:22 -0800)

----------------------------------------------------------------
More dts changes for omaps to add support for new devices:

- Add DCAN support am335x, am437x and dra7

- Add devices for sb-t3x computers

- Add support for NovaTech OrionLXm

- Add n900 battery and si4713 support

----------------------------------------------------------------
Adam YH Lee (1):
      ARM: dts: Gumstix DuoVero: Bind vdac regulator to hdmi node

Dmitry Lifshitz (10):
      ARM: dts: cm-t3x: cleanup comments indentation
      ARM: dts: cm-t3x: add ADS7846 touchscreen support
      ARM: OMAP2+: remove cm-t3x touchscreen pdata quirk
      ARM: dts: cm-t3x: add EEPROM support
      ARM: dts: sb-t35: add EEPROM support
      ARM: dts: cm-t3x30: add keypad support
      ARM: dts: cm-t3x: add I2C1 pinmux
      ARM: dts: cm-t3x: add TV out support
      ARM: dts: sbc-t3x: add TV out display alias
      ARM: dts: sbc-t3x30: add audio support

George McCollister (1):
      ARM: dts: Add devicetree for NovaTech OrionLXm

Lokesh Vutla (1):
      ARM: dts: DRA7: Add node for RTC

Mugunthan V N (1):
      ARM: dts: am437x-gp: Add dcan support

Roger Quadros (9):
      ARM: dts: dra7: Add syscon regmap for CORE CONTROL area
      ARM: dts: DRA7: Add DCAN nodes
      ARM: dts: dra7-evm: Add CAN support
      ARM: dts: dra72-evm: Add CAN support
      ARM: dts: am4372: Add control module syscon node
      ARM: dts: am4372: Add DCAN nodes
      ARM: dts: am33xx: Add control module syscon node
      ARM: dts: am33xx: Update DCAN nodes
      ARM: dts: am335x-evm: Add DCAN1 details

Sebastian Reichel (2):
      ARM: dts: OMAP3-N900: add si4713 support
      ARM: dst: OMAP3-N900: Add n900-battery support

Vignesh R (1):
      ARM: dts: AM43xx: add tscadc DT entries for am437x-evm and am43x-epos-evm

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/am335x-evm.dts                   |  13 +
 arch/arm/boot/dts/am335x-lxm.dts                   | 362 +++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                      |  25 +-
 arch/arm/boot/dts/am4372.dtsi                      |  47 +++
 arch/arm/boot/dts/am437x-gp-evm.dts                |  34 ++
 arch/arm/boot/dts/am43x-epos-evm.dts               |   8 +
 arch/arm/boot/dts/dra7-evm.dts                     |  22 ++
 arch/arm/boot/dts/dra7.dtsi                        |  35 ++
 arch/arm/boot/dts/dra72-evm.dts                    |  23 ++
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                | 124 ++++++-
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi              |  35 ++
 arch/arm/boot/dts/omap3-n900.dts                   |  16 +
 arch/arm/boot/dts/omap3-sb-t35.dtsi                |  36 ++
 arch/arm/boot/dts/omap3-sbc-t3517.dts              |   1 +
 arch/arm/boot/dts/omap3-sbc-t3530.dts              |   1 +
 arch/arm/boot/dts/omap3-sbc-t3730.dts              |   1 +
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |   1 +
 arch/arm/mach-omap2/pdata-quirks.c                 |   3 -
 20 files changed, 775 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-lxm.dts
