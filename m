From: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 00/14] Add support for sbc-t43
Date: Tue, 24 Nov 2015 15:19:01 +0200
Message-ID: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series adds support for CompuLab sbc-t43 single baseboard computer.
sbc-t43 is composed of cm-t43 (the TI am437x based core module), and sb-som
baseboard. The sbc-t43 features include:

CPU:	Texas Instruments Sitara AM4379 ARM Cortex-A9, 1GHz, or
	Texas Instruments Sitara AM4376 ARM Cortex-A9, 800MHz
RAM:	128MB - 1GB, DDR3-800, 32-bit data bua
Storage:	NAND flash, 128MB - 512MB, or eMMC flash, 4GB - 32GB
		SPI-flash 2MB
Two 1000/100/10Mbps Ethernet ports
WiFi/Bluetooth/NFC
Audio codec
SD-Card slot, up to 3 USB ports
DVI/LCD connectors

This series is based over v4.4-rc2-15-gcaa9c04 and depends on the following
patch:
https://lkml.org/lkml/2015/11/12/955
[pinctrl: Move am4372 and dra7 macros to the the SoC header files]

Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>

Nikita Kiryanov (14):
  ARM: am437x: cm-t43: dts: add basic support for sbc-t43
  ARM: am437x: cm-t43: dts: add support for module eeprom
  ARM: am437x: cm-t43: dts: add PMIC support.
  ARM: am437x: cm-t43: dts: add spi-flash support
  ARM: am437x: cm-t43: dts: add NAND support
  ARM: am437x: cm-t43: dts: add dual emac support
  ARM: am437x: cm-t43: dts: add USB support
  ARM: am437x: cm-t43: dts: add eMMC support
  ARM: am437x: cm-t43: dts: add touchscreen support
  ARM: am437x: cm-t43: dts: add pca9555 support
  ARM: am437x: cm-t43: dts: add support for baseboard eeprom
  ARM: sb-som: dts: introduce SB-SOM baseboard
  ARM: am437x: cm-t43: dts: add support for mmc1
  ARM: am437x: cm-t43: dts: add lcd support

 .../devicetree/bindings/arm/compulab-boards.txt    |   5 +
 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 .../bindings/display/panel/startek,startek-kd050c  |   4 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                | 423 +++++++++++++++++++++
 arch/arm/boot/dts/am437x-sbc-t43.dts               | 181 +++++++++
 arch/arm/boot/dts/compulab-sb-som.dtsi             |  42 ++
 8 files changed, 666 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/startek,startek-kd050c
 create mode 100644 arch/arm/boot/dts/am437x-cm-t43.dts
 create mode 100644 arch/arm/boot/dts/am437x-sbc-t43.dts
 create mode 100644 arch/arm/boot/dts/compulab-sb-som.dtsi

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
