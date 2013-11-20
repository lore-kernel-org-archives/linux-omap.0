From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 00/11]: add remaining support for IGEP boards
Date: Wed, 20 Nov 2013 02:06:04 +0100
Message-ID: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:34687 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab3KTBH1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 20:07:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

In order to make mach-omap2 Device Tree only, the board file for
IGEP boards was removed even when support for wifi and display
was still not supported by its DTS.

This is a second version of a patch-set that adds support for
these remaining peripherals and also adds support for USB,
HDMI and user LED for the am33xx SoC based IGEP Aquila board.

The patch-set is composed of the following patches:

Enric Balletbo i Serra (7):
      ARM: dts: omap3-igep: Fix bus-width for mmc1.
      ARM: dts: omap3-igep: Add support for LBEE1USJYC WiFi connected to SDIO.
      ARM: dts: omap3-igep: Update to use the TI AM/DM37x processor.
      ARM: dts: AM33XX BASE0033: add pinmux and hdmi node to enable display
      ARM: dts: AM33XX BASE0033: add pinmux and user led support.
      ARM: dts: AM33XX BASE0033: add 32KBit EEPROM support.
      ARM: dts: AM33XX IGEP0033: add USB support.

Javier Martinez Canillas (4):
      ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices
      ARM: dts: omap3-igep0020: Add pinmuxing for DVI output
      ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus
      ARM: dts: omap3-igep0020: name twl4030 VPLL2 regulator as vdds_dsi

Changes since v1:

 Don't add a workaround in drivers/video/omap2/dss/dpi.c to use the
 VPLL2 regulator from twl4030 if VDDS_DSI regulator is not linked to
 the DPI device since the used regulator is a per board configuration.

 Instead add a regulator-name = "vdds_dsi" property to the regulator
 in the IGEPv2 DTS file as suggested by Tony Lindgren. 

Tony,

Most of these patches are just DTS changes so they have to be picked
by Benoit besides the following patch that has to go through your tree

[PATCH 10/11] ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus

Since we have removed the board file for IGEP boards I think these
can be considered as regression fixes for 3.13 although I don't mind
if you prefer to wait for 3.14.

Thanks a lot and best regards,
Javier
