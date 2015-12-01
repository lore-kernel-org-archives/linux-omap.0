From: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 00/14] Add support for sbc-t43
Date: Tue,  1 Dec 2015 15:54:55 +0200
Message-ID: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series adds support for CompuLab sbc-t43 single baseboard computer.
sbc-t43 is composed of cm-t43 (the TI am437x based core module), and sb-som
baseboard. The sbc-t43 features include:

CPU:    Texas Instruments Sitara AM4379 ARM Cortex-A9, 1GHz, or
        Texas Instruments Sitara AM4376 ARM Cortex-A9, 800MHz
RAM:    128MB - 1GB, DDR3-800, 32-bit data bua
Storage:        NAND flash, 128MB - 512MB, or eMMC flash, 4GB - 32GB
                SPI-flash 2MB
Two 1000/100/10Mbps Ethernet ports
WiFi/Bluetooth/NFC
Audio codec
SD-Card slot, up to 3 USB ports
DVI/LCD connectors

CM-T43 website: http://www.compulab.co.il/products/computer-on-modules/cm-t43/
SBC-T43 website: http://www.compulab.co.il/products/sbcs/sbc-t43/

This series is based over v4.4-rc3-20-g204187f and depends on the following
patch:
https://lkml.org/lkml/2015/11/12/955
[pinctrl: Move am4372 and dra7 macros to the the SoC header files]

Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>

Changes in V2:
	- Removed unnecessary line breaks in end of file and elsewhere
	- Added spaces between strings in "compatible" properties
	- Renamed startek,startek-kd050c to startek,startek-kd050c.txt
	- s/QS-600/CM-QS600 in compulab-boards.txt
	- Changed subject lines to start with "ARM: dts:"

Nikita Kiryanov (14):
  ARM: dts: am437x: cm-t43: add basic support for sbc-t43
  ARM: dts: am437x: cm-t43: add support for module eeprom
  ARM: dts: am437x: cm-t43: add PMIC support.
  ARM: dts: am437x: cm-t43: add spi-flash support
  ARM: dts: am437x: cm-t43: add NAND support
  ARM: dts: am437x: cm-t43: add dual emac support
  ARM: dts: am437x: cm-t43: add USB support
  ARM: dts: am437x: cm-t43: add eMMC support
  ARM: dts: am437x: cm-t43: add touchscreen support
  ARM: dts: am437x: cm-t43: add pca9555 support
  ARM: dts: am437x: cm-t43: add support for baseboard eeprom
  ARM: dts: sb-som: introduce SB-SOM baseboard
  ARM: dts: am437x: cm-t43: add support for mmc1
  ARM: dts: am437x: cm-t43: add lcd support

 .../devicetree/bindings/arm/compulab-boards.txt    |   5 +
 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 .../display/panel/startek,startek-kd050c.txt       |   4 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                | 422 +++++++++++++++++++++
 arch/arm/boot/dts/am437x-sbc-t43.dts               | 180 +++++++++
 arch/arm/boot/dts/compulab-sb-som.dtsi             |  42 ++
 8 files changed, 664 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt
 create mode 100644 arch/arm/boot/dts/am437x-cm-t43.dts
 create mode 100644 arch/arm/boot/dts/am437x-sbc-t43.dts
 create mode 100644 arch/arm/boot/dts/compulab-sb-som.dtsi

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
