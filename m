From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 0/2] Device tree support for TWL regulators
Date: Thu, 23 Feb 2012 17:05:52 +0530
Message-ID: <1329996954-27083-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44551 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab2BWLgP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 06:36:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

Re-sending as these patches did not make it to the lists due to
issues with my 'git send-email'

v3 has mainly 2 differences from v2
-1- TWL driver now uses just one table for both dt and
non-dt based lookup for driver data.
-2- All common regulator nodes for twl4030 and twl6030 are
now defined in the twl4030.dtsi and twl6030.dtsi instead of
repeating the nodes in all board files, which also means
the patch ('arm/dts: twl: Pass regulator data from dt')
has a dependency with the series from Benoit which adds the
twl4030.dtsi and twl6030.dtsi files[1].

I have tested the patches on omap4panda and omap3beagle boards.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
	for_3.4/dt_i2c_twl

Rajendra Nayak (2):
  regulator: twl: adapt twl-regulator driver to dt
  arm/dts: twl: Pass regulator data from dt

 .../bindings/regulator/twl-regulator.txt           |   63 ++++++
 arch/arm/boot/dts/omap3-beagle.dts                 |    6 +
 arch/arm/boot/dts/twl4030.dtsi                     |   18 ++
 arch/arm/boot/dts/twl6030.dtsi                     |   60 +++++
 drivers/regulator/twl-regulator.c                  |  227 +++++++++++++-------
 5 files changed, 301 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt

