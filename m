From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 00/18] Add support for CL-SOM-AM57X and SBC-AM57X
Date: Wed, 25 Nov 2015 08:39:32 +0200
Message-ID: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch series adds support for CompuLab CL-SOM-AM57X and
SBC-AM57X boards.

CL-SOM-AM57x is a miniature System-on-Module (SoM) based on
TI Sitara AM57x ARM Cortex-A15 System-on-Chip family.

SBC-AM57x is a single board computer, implemented with the
CL-SOM-AM57x computer-on-module providing most of the functions,
and SB-SOM-AM57x carrier board providing additional peripheral
functions and connectors.

The SBC-AM57x has the following features:


CPU:		Texas Instruments Sitara AM5728 dual-core ARM Cortex-A15, 1.5GHz =
or
		Texas Instruments Sitara AM5718 single-core ARM Cortex-A15, 1.5GHz

RAM:		DDR3, 512MB =E2=80=93 4GB

Storage:	NAND flash, 512MB - 1GB or eMMC flash, 4GB - 32GB
		SPI-flash 2MB

Ethernet:	Up to 2x 10/100/1000Mbps Ethernet ports (MAC+PHY)

WiFi/BT:	802.11b/g/n WiFi interface (TI WiLink 8 WL1801 chipset) or
		Dual-band 2x2 802.11a/b/g/n WiFi interface (TI WiLink 8 WL1837 chipse=
t)

Analog Audio:	Audio codec with stereo output, stereo input and micropho=
ne support

More details can be found here:

https://www.compulab.co.il/products/computer-on-modules/cl-som-am57x-ti=
-am5728-am5718-system-on-module/

https://www.compulab.co.il/products/sbcs/sbc-am57x-ti-am5728-am5718-sin=
gle-board-computer/

This series is based on the following patch set ("Add support for sbc-t=
43" Nikita Kiryanov):

https://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg121614.html

Dmitry Lifshitz (18):
  ARM: am57xx: cl-som-am57x: dts: add basic module support
  ARM: am57xx: cl-som-am57x: dts: add RTC support
  ARM: am57xx: cl-som-am57x: dts: add I2C3 support
  ARM: am57xx: cl-som-am57x: dts: add EEPROM support
  ARM: am57xx: cl-som-am57x: dts: add eMMC support
  ARM: am57xx: cl-som-am57x: dts: add spi-flash support
  ARM: am57xx: cl-som-am57x: dts: add dual EMAC support
  ARM: am57xx: cl-som-am57x: dts: add USB support
  ARM: am57xx: cl-som-am57x: dts: add touchscreen support
  ARM: am57xx: cl-som-am57x: dts: add analog audio support
  ARM: am57xx: sbc-am57x: dts: add basic board support
  ARM: am57xx: cl-som-am57x: dts: add MMC1 support
  ARM: am57xx: sbc-am57x: dts: add usb vbus pinmux
  ARM: am57xx: sbc-am57x: dts: add EEPROM support
  ARM: am57xx: sbc-am57x: dts: add GPIO extender support
  ARM: am57xx: sbc-am57x: dts: add LCD support
  ARM: am57xx: compulab-sb-som: dts: add HDMI connector
  ARM: am57xx: sbc-am57x: dts: add HDMI support

 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          | 606 +++++++++++++=
++++++++
 arch/arm/boot/dts/am57xx-sbc-am57x.dts             | 179 ++++++
 arch/arm/boot/dts/compulab-sb-som.dtsi             |   7 +
 5 files changed, 801 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am57xx-cl-som-am57x.dts
 create mode 100644 arch/arm/boot/dts/am57xx-sbc-am57x.dts

--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
