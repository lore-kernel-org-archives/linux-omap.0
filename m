From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v4 0/3] ARM/dts: omap3: Add DT support for IGEP devices
Date: Wed, 19 Dec 2012 14:33:07 +0100
Message-ID: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:41651 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab2LSNd3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 08:33:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Jon Hunter <jon-hunter@ti.com>, Matthias Brugger <matthias.bgg@googlemail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

IGEP technology devices are TI OMAP3 SoC based industrial embedded
and computer-on-module boards. This patch-set adds initial device
tree support for these devices.

The device trees allows to boot from an MMC and are working all the
components that already have device tree support on OMAP3 SoCs:

- MMC/SD
- UARTs
- GPIO LEDs
- TWL4030 codec audio
- pinmux/pinconf pinctrl

Some peripheral are still not working such as Flash storage and
Ethernet but support for these will also be included once the
OMAP GPMC device tree binding patches land on mainline.

This is a v4 of the patch-set that adds MMC mux pins setup and
fixes a build issue due recent changes on twl4030.dtsi.

The patch-set is composed of the following patches:

[PATCH v4 1/3] ARM/dts: omap3: Add generic DT support for IGEP devices
[PATCH v4 2/3] ARM/dts: omap3: Add support for IGEPv2 board
[PATCH v4 3/3] ARM/dts: omap3: Add support for IGEP COM Module
