From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v3 0/3] ARM/dts: omap3: Add DT support for IGEP devices
Date: Mon,  3 Dec 2012 13:41:40 +0100
Message-ID: <1354538503-22671-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Enrico Butera <ebutera@gmail.com>, Matthias Brugger <matthias.bgg@googlemail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

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

This is a v3 of the patch-set that solves issues pointed out by
Enric Balletbo and Benoit Cousson.

The patch-set is composed of the following patches:

[PATCH v3 1/3] ARM/dts: omap3: Add generic DT support for IGEP devices
[PATCH v3 2/3] ARM/dts: omap3: Add support for IGEPv2 board
[PATCH v3 3/3] ARM/dts: omap3: Add support for IGEP COM Module

Best regards,
Javier
