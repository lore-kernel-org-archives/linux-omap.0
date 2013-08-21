From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [GIT PULL] ARM: OMAP: Device Tree for 3.12
Date: Wed, 21 Aug 2013 16:55:57 +0200
Message-ID: <5214D4FD.4060405@baylibre.com>
References: <521384D5.1050607@baylibre.com> <20130821071334.GQ7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:58767 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab3HUO4B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 10:56:01 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so313865ead.7
        for <linux-omap@vger.kernel.org>; Wed, 21 Aug 2013 07:56:00 -0700 (PDT)
In-Reply-To: <20130821071334.GQ7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Kevin & Olof,

I've just updated the branch with the few USB3 patches I missed from Felipe.

So here is a new pull-request.

Thanks,
Benoit

----------------------------------------------------------------
Add the minimal DTS support for DRA7xx based SoC core.
Add the initial support for N900 and gta04 phones.
Enable USB3 on OMAP5 evm board.
Do a lot of various cleanups.
----------------------------------------------------------------


The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:

  Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.12/dts

for you to fetch changes up to 5903208d4e2c09a3872feba6b9e2e49c64fd07ad:

  ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies (2013-08-21 16:43:21 +0200)

----------------------------------------------------------------
Afzal Mohammed (2):
      ARM: dts: AM4372: cpu(s) node per latest binding
      ARM: dts: AM4372: add few nodes

Alexandre Belloni (1):
      ARM: dts: AM33XX: Add PMU support

Benoit Cousson (1):
      ARM: OMAP5: hwmod: add missing ocp2scp hwmod data

Felipe Balbi (4):
      ARM: OMAP5: dts: fix reg property size
      ARM: OMAP5: dts: fix ocp2scp DTS data
      ARM: OMAP5: dts: add palmas-usb node
      ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies

Javier Martinez Canillas (5):
      ARM: dts: omap3-igep: add pinmux node for GPIO LED configuration
      ARM: dts: omap3-igep0020: add mux conf for GPIO LEDs
      ARM: dts: omap3-igep0030: add mux conf for GPIO LED
      ARM: dts: AM33XX: use pinmux node defined in included file
      ARM: dts: AM33XX: don't redefine OCP bus and device nodes

Kishon Vijay Abraham I (1):
      ARM: dts: omap5-uevm: Split SMPS10 in two nodes

Lars Poeschel (1):
      ARM: dts: AM33xx: Correct gpio #interrupt-cells property

Lee Jones (7):
      ARM: dts: Remove '0x's from OMAP2420 H4 DTS file
      ARM: dts: Remove '0x's from OMAP3 IGEP0020 DTS file
      ARM: dts: Remove '0x's from OMAP3 IGEP0030 DTS file
      ARM: dts: Remove '0x's from OMAP3 DTS file
      ARM: dts: Remove '0x's from OMAP3430 SDP DTS file
      ARM: dts: Remove '0x's from OMAP4 DTS file
      ARM: dts: Remove '0x's from OMAP5 DTS file

Marek Belisko (1):
      ARM: dts: Add devicetree for gta04 board.

Pavel Machek (1):
      ARM: dts: N900: Add device tree

R Sricharan (1):
      ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board

Robert Nelson (1):
      ARM: dts: omap3-beagle-xm: fix string error in compatible property

Roger Quadros (1):
      ARM: dts: omap3-beagle: Make USB host pin naming consistent

Ruslan Bilovol (1):
      ARM: dts: twl6030: Move common configuration for OMAP4 boards in a separate dtsi file

 arch/arm/boot/dts/Makefile                 |   5 +-
 arch/arm/boot/dts/am335x-bone.dts          | 217 ++++++-----
 arch/arm/boot/dts/am335x-evm.dts           | 576 ++++++++++++++---------------
 arch/arm/boot/dts/am335x-evmsk.dts         | 374 ++++++++++---------
 arch/arm/boot/dts/am33xx.dtsi              |  13 +-
 arch/arm/boot/dts/am4372.dtsi              | 347 +++++++++++++++++
 arch/arm/boot/dts/dra7-evm.dts             | 140 +++++++
 arch/arm/boot/dts/dra7.dtsi                | 575 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap2420-h4.dts          |   6 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts      |   2 +-
 arch/arm/boot/dts/omap3-beagle.dts         |  24 +-
 arch/arm/boot/dts/omap3-gta04.dts          | 168 +++++++++
 arch/arm/boot/dts/omap3-igep.dtsi          |   2 +
 arch/arm/boot/dts/omap3-igep0020.dts       |  19 +-
 arch/arm/boot/dts/omap3-igep0030.dts       |  17 +-
 arch/arm/boot/dts/omap3-n900.dts           |  92 +++++
 arch/arm/boot/dts/omap3.dtsi               |   2 +-
 arch/arm/boot/dts/omap3430-sdp.dts         |  22 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi  |  21 +-
 arch/arm/boot/dts/omap4-sdp.dts            |  21 +-
 arch/arm/boot/dts/omap4.dtsi               |   2 +-
 arch/arm/boot/dts/omap5-uevm.dts           |  25 +-
 arch/arm/boot/dts/omap5.dtsi               |  13 +-
 arch/arm/boot/dts/twl6030_omap4.dtsi       |  38 ++
 arch/arm/configs/omap2plus_defconfig       |   9 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  45 +++
 include/dt-bindings/pinctrl/dra.h          |  50 +++
 27 files changed, 2148 insertions(+), 677 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra7-evm.dts
 create mode 100644 arch/arm/boot/dts/dra7.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-gta04.dts
 create mode 100644 arch/arm/boot/dts/omap3-n900.dts
 create mode 100644 arch/arm/boot/dts/twl6030_omap4.dtsi
 create mode 100644 include/dt-bindings/pinctrl/dra.h


On 21/08/2013 09:13, Tony Lindgren wrote:
> Kevin & Olof,
> 
> Care to pull the below .dts changes directly from Benoit?
> 
> * Benoit Cousson <bcousson@baylibre.com> [130820 08:08]:
>>
>> Hi Tony,
>>
>> Please pull the following commits for OMAP Device Tree for v3.12.
>>
>> Thanks,
>> Benoit
>>
>> ----------------------------------------------------------------
>> Add the minimal DTS support for DRA7xx based SoC core.
>> Add the initial support for N900 and gta04 phones.
>> Do a lot of various cleanups.
>> ----------------------------------------------------------------
>>
>> The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:
>>
>>    Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.12/dts
>>
>> for you to fetch changes up to 9f311a2325905043718da9bf649e2344b8df8473:
>>
>>    ARM: dts: omap3-beagle: Make USB host pin naming consistent (2013-08-20 14:30:07 +0200)
>>
>> ----------------------------------------------------------------
>> Afzal Mohammed (2):
>>        ARM: dts: AM4372: cpu(s) node per latest binding
>>        ARM: dts: AM4372: add few nodes
>>
>> Alexandre Belloni (1):
>>        ARM: dts: AM33XX: Add PMU support
>>
>> Javier Martinez Canillas (5):
>>        ARM: dts: omap3-igep: add pinmux node for GPIO LED configuration
>>        ARM: dts: omap3-igep0020: add mux conf for GPIO LEDs
>>        ARM: dts: omap3-igep0030: add mux conf for GPIO LED
>>        ARM: dts: AM33XX: use pinmux node defined in included file
>>        ARM: dts: AM33XX: don't redefine OCP bus and device nodes
>>
>> Kishon Vijay Abraham I (1):
>>        ARM: dts: omap5-uevm: Split SMPS10 in two nodes
>>
>> Lars Poeschel (1):
>>        ARM: dts: AM33xx: Correct gpio #interrupt-cells property
>>
>> Lee Jones (7):
>>        ARM: dts: Remove '0x's from OMAP2420 H4 DTS file
>>        ARM: dts: Remove '0x's from OMAP3 IGEP0020 DTS file
>>        ARM: dts: Remove '0x's from OMAP3 IGEP0030 DTS file
>>        ARM: dts: Remove '0x's from OMAP3 DTS file
>>        ARM: dts: Remove '0x's from OMAP3430 SDP DTS file
>>        ARM: dts: Remove '0x's from OMAP4 DTS file
>>        ARM: dts: Remove '0x's from OMAP5 DTS file
>>
>> Marek Belisko (1):
>>        ARM: dts: Add devicetree for gta04 board.
>>
>> Pavel Machek (1):
>>        ARM: dts: N900: Add device tree
>>
>> R Sricharan (1):
>>        ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board
>>
>> Robert Nelson (1):
>>        ARM: dts: omap3-beagle-xm: fix string error in compatible property
>>
>> Roger Quadros (1):
>>        ARM: dts: omap3-beagle: Make USB host pin naming consistent
>>
>> Ruslan Bilovol (1):
>>        ARM: dts: twl6030: Move common configuration for OMAP4 boards in a separate dtsi file
>>
>>   arch/arm/boot/dts/Makefile                |   5 +-
>>   arch/arm/boot/dts/am335x-bone.dts         | 217 ++++++-----
>>   arch/arm/boot/dts/am335x-evm.dts          | 576 +++++++++++++++---------------
>>   arch/arm/boot/dts/am335x-evmsk.dts        | 374 ++++++++++---------
>>   arch/arm/boot/dts/am33xx.dtsi             |  13 +-
>>   arch/arm/boot/dts/am4372.dtsi             | 347 ++++++++++++++++++
>>   arch/arm/boot/dts/dra7-evm.dts            | 140 ++++++++
>>   arch/arm/boot/dts/dra7.dtsi               | 575 +++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/omap2420-h4.dts         |   6 +-
>>   arch/arm/boot/dts/omap3-beagle-xm.dts     |   2 +-
>>   arch/arm/boot/dts/omap3-beagle.dts        |  24 +-
>>   arch/arm/boot/dts/omap3-gta04.dts         | 168 +++++++++
>>   arch/arm/boot/dts/omap3-igep.dtsi         |   2 +
>>   arch/arm/boot/dts/omap3-igep0020.dts      |  19 +-
>>   arch/arm/boot/dts/omap3-igep0030.dts      |  17 +-
>>   arch/arm/boot/dts/omap3-n900.dts          |  92 +++++
>>   arch/arm/boot/dts/omap3.dtsi              |   2 +-
>>   arch/arm/boot/dts/omap3430-sdp.dts        |  22 +-
>>   arch/arm/boot/dts/omap4-panda-common.dtsi |  21 +-
>>   arch/arm/boot/dts/omap4-sdp.dts           |  21 +-
>>   arch/arm/boot/dts/omap4.dtsi              |   2 +-
>>   arch/arm/boot/dts/omap5-uevm.dts          |  13 +-
>>   arch/arm/boot/dts/omap5.dtsi              |   4 +-
>>   arch/arm/boot/dts/twl6030_omap4.dtsi      |  38 ++
>>   include/dt-bindings/pinctrl/dra.h         |  50 +++
>>   25 files changed, 2077 insertions(+), 673 deletions(-)
>>   create mode 100644 arch/arm/boot/dts/dra7-evm.dts
>>   create mode 100644 arch/arm/boot/dts/dra7.dtsi
>>   create mode 100644 arch/arm/boot/dts/omap3-gta04.dts
>>   create mode 100644 arch/arm/boot/dts/omap3-n900.dts
>>   create mode 100644 arch/arm/boot/dts/twl6030_omap4.dtsi
>>   create mode 100644 include/dt-bindings/pinctrl/dra.h

