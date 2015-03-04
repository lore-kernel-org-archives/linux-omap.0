From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] pinctrl: Introduce support for iodelay module in TI SoCs
Date: Tue, 3 Mar 2015 18:00:35 -0600
Message-ID: <1425427237-11511-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40860 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216AbbCDABH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2015 19:01:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>

Hi,

SoCs such as DRA7 family from Texas Instruments also include a highly
configurable hardware block called the IOdelay block. This block
allows very specific custom fine tuning for electrical characteristics
of IO pins that are necessary for functionality and device lifetime
requirements.

IODelay module exists on it's own register space with registers
allocated for various pins. A set of values (derived from either
automated tools OR from device datasheet) is then computed on a
per-chip basis(to account for die specific variations) to generate a
set of delay parameters that are programmed to one or more registers
for the delay path of the io line. This is used in specific instances
such as MMC to achieve high-throughput modes, and most pins dont
usually need tweaking functionality provided by this driver.

Even though this kind of operates similar to a pinctrl model,
functionally, it is a characteristics tuning which does not completely
fit the standard pinconf model either.

In addition to the regular pin muxing modes supported by the
pinctrl-single, additional configuration for this block for specific
pins may also be mandatory in certain cases.

Series based on v4.0-rc1

Nishanth Menon (2):
  pinctrl: bindings: pinctrl: Add support for TI's IODelay
    configuration
  pinctrl: Introduce TI IOdelay configuration driver

 .../bindings/pinctrl/ti,iodelay-pinctrl.txt        |   86 ++
 drivers/pinctrl/Kconfig                            |   11 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-ti-iodelay.c               |  963 ++++++++++++++++++++
 include/dt-bindings/pinctrl/dra.h                  |    6 +
 5 files changed, 1067 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,iodelay-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-ti-iodelay.c

-- 
1.7.9.5

