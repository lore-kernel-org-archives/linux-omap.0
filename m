From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 00/19] Add support for CL-SOM-AM57X and SBC-AM57X
Date: Tue,  1 Dec 2015 20:03:02 +0200
Message-ID: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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

https://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg121905.html

Changes in V2:
	- Removed unnecessary line breaks in end of file and elsewhere
	- Changed subject lines to start with "ARM: dts:"
	- PMIC moved from I2C1 to I2C4
	- Fixed SPI flash compatible string
	- Skipped resetting ETH PHYs
	- Fixed HDMI lanes polarity

Dmitry Lifshitz (19):
  ARM: dts: am57xx: cl-som-am57x: add basic module support
  ARM: dts: am57xx: cl-som-am57x: dts: add RTC support
  ARM: dts: am57xx: cl-som-am57x: add I2C3 support
  ARM: dts: am57xx: cl-som-am57x: add EEPROM support
  ARM: dts: am57xx: cl-som-am57x: add eMMC support
  ARM: dts: am57xx: cl-som-am57x: add spi-flash support
  ARM: dts: am57xx: cl-som-am57x: add dual EMAC support
  ARM: dts: am57xx: cl-som-am57x: add USB support
  ARM: dts: am57xx: cl-som-am57x: add touchscreen support
  ARM: dts: am57xx: cl-som-am57x: add analog audio support
  ARM: dts: am57xx: sbc-am57x: add basic board support
  ARM: dts: am57xx: cl-som-am57x: add MMC1 support
  ARM: dts: am57xx: sbc-am57x: add usb vbus pinmux
  ARM: dts: am57xx: sbc-am57x: add EEPROM support
  ARM: dts: am57xx: sbc-am57x: add GPIO expander support
  ARM: dts: am57xx: sbc-am57x: add LCD support
  ARM: dts: am57xx: compulab-sb-som: add HDMI connector
  ARM: dts: am57xx: sbc-am57x: add HDMI support
  ARM: dts: am57xx: cl-som-am57x: skip resetting ETH PHYs

 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          | 617 +++++++++++++=
++++++++
 arch/arm/boot/dts/am57xx-sbc-am57x.dts             | 179 ++++++
 arch/arm/boot/dts/compulab-sb-som.dtsi             |   7 +
 5 files changed, 812 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am57xx-cl-som-am57x.dts
 create mode 100644 arch/arm/boot/dts/am57xx-sbc-am57x.dts

--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
