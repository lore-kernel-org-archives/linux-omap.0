From: Benoit Cousson <bcousson@baylibre.com>
Subject: [GIT PULL] ARM: DTS: Fix OMAP bugs for 3.12-rc, take #2
Date: Wed, 18 Sep 2013 14:44:51 +0200
Message-ID: <5239A043.70308@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:42689 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab3IRMpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Sep 2013 08:45:07 -0400
Received: by mail-wi0-f175.google.com with SMTP id ez12so6329224wid.8
        for <linux-omap@vger.kernel.org>; Wed, 18 Sep 2013 05:45:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "khilman@linaro.org" <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Tony,

Please pull few fixes for OMAP DTS. This take #2 contains one more fix I missed from Enric.

Thanks,
Benoit



The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git tags/for_3.12-rc2/dts_signed

for you to fetch changes up to 65399f03266e138506417920952e1c8ed022ec47:

  ARM: dts: igep00x0: Add pinmux configuration for MCBSP2 (2013-09-18 14:31:58 +0200)

----------------------------------------------------------------
Fix BBB LDO voltage to avoid HDMI destruction
Fix OMAP5 wrong attribute
Fix typo in beagle xM strings
Fix missing pinmux and regulator for OMAP4 wifi
Fix missing pinmux for igep headset

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      ARM: dts: igep00x0: Add pinmux configuration for MCBSP2

Felipe Balbi (2):
      ARM: dts: OMAP5: fix reg property size
      ARM: dts: OMAP5: fix ocp2scp DTS data

Koen Kooi (1):
      ARM: dts: am335x-bone*: add DT for BeagleBone Black

Robert Nelson (1):
      ARM: dts: omap3-beagle-xm: fix string error in compatible property

Tony Lindgren (2):
      ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for pandaboard
      ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for blaze

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi | 262 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts         | 256 +----------------------------
 arch/arm/boot/dts/am335x-boneblack.dts    |  17 ++
 arch/arm/boot/dts/omap3-beagle-xm.dts     |   2 +-
 arch/arm/boot/dts/omap3-igep.dtsi         |  14 ++
 arch/arm/boot/dts/omap4-panda-common.dtsi |  46 +++++-
 arch/arm/boot/dts/omap4-sdp.dts           |  39 ++++-
 arch/arm/boot/dts/omap5.dtsi              |   7 +-
 9 files changed, 383 insertions(+), 261 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-bone-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-boneblack.dts
