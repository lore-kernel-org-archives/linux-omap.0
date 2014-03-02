From: Benoit Cousson <bcousson@baylibre.com>
Subject: [GIT PULL] ARM: OMAP: Device Tree for 3.15
Date: Sun, 02 Mar 2014 21:42:48 +0100
Message-ID: <531397C8.9070309@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:37616 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbaCBUmw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Mar 2014 15:42:52 -0500
Received: by mail-wg0-f49.google.com with SMTP id b13so495172wgh.32
        for <linux-omap@vger.kernel.org>; Sun, 02 Mar 2014 12:42:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Tony,

Please pull the following commits for OMAP Device Tree for v3.15.

Thanks,
Beno=EEt


The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f=
3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.=
git tags/for_3.15/dts_signed

for you to fetch changes up to 1a5fe3ca5ea192d4309dd61f3626b79ff38693c2=
:

  ARM: dts: omap4+: Add DMM bindings (2014-03-02 21:26:27 +0100)

----------------------------------------------------------------
Add craneboard devices
Add more N900 devices
Add am43x-epos-evm and am437x-gp-evm devices
Add OMAP4 DMM devices

----------------------------------------------------------------
Archit Taneja (1):
      ARM: dts: omap4+: Add DMM bindings

Darren Etheridge (1):
      pinctrl: am43xx: dt-bindings: add MUX_MODE8

Lokesh Vutla (1):
      ARM: dts: am437x-gp-evm: Add gp dts.

Nishanth Menon (2):
      ARM: dts: Add basic devices for AM3517-craneboard
      ARM: dts: omap3430-sdp: add dip switch information for MMC operat=
ion

Sebastian Reichel (6):
      ARM: dts: TWL4030: Add keypad node
      ARM: dts: OMAP3-N900: Add TWL4030 Keypad Matrix
      ARM: dts: OMAP3-N900: Add support for tsl2563
      ARM: dts: OMAP3-N900: Add tpa6130a2 support
      ARM: dts: OMAP3-N900: Add isp1704 support
      ARM: dts: OMAP3-N900: Add bq24150a support

Sourav Poddar (7):
      ARM: dts: am4372: Add pwm-cells property for ecap device.
      ARM: dts: am43x-epos-evm: Add pwm backlight support.
      ARM: dts: am43x-epos-evm: Add I2C2 data.
      ARM: dts: am43x-epos-evm: Add SPI data.
      ARM: dts: am437x-gp-evm: Add pwm backlight support.
      ARM: dts: am437x-gp-evm: Enable gpio.
      ARM: dts: am43x-gp-evm: Add matrix gpio keys.

 Documentation/devicetree/bindings/arm/omap/dmm.txt  |  22 ++++++++++
 Documentation/devicetree/bindings/arm/omap/omap.txt |   3 ++
 arch/arm/boot/dts/Makefile                          |   2 +
 arch/arm/boot/dts/am3517-craneboard.dts             | 174 ++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am4372.dtsi                       |   9 +++++
 arch/arm/boot/dts/am437x-gp-evm.dts                 | 100 ++++++++++++=
+++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts                |  67 ++++++++++++=
+++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                         |   7 ++++
 arch/arm/boot/dts/omap3-n900.dts                    |  90 ++++++++++++=
+++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3430-sdp.dts                  |   4 ++
 arch/arm/boot/dts/omap4.dtsi                        |   7 ++++
 arch/arm/boot/dts/omap5.dtsi                        |   7 ++++
 arch/arm/boot/dts/twl4030.dtsi                      |   7 ++++
 include/dt-bindings/pinctrl/am43xx.h                |   1 +
 14 files changed, 500 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt
 create mode 100644 arch/arm/boot/dts/am3517-craneboard.dts
 create mode 100644 arch/arm/boot/dts/am437x-gp-evm.dts

--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
