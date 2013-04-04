From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/5] gpio/omap: 2nd batch of updates for v3.10
Date: Thu, 4 Apr 2013 15:16:11 -0500
Message-ID: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60930 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763121Ab3DDUQe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 16:16:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Main change is ensuring that the state of a gpio bank is restored when
booting with device-tree. The rest of the patches are clean-ups and one
optimisation.

The patch modifying the *.dtsi files should go via Benoit Cousson's
for_3.10/dts branch [1] as it is dependent on changes in his branch but
I have included here for completeness.

Testing includes:
- Boot testing on OMAP5912 OSK, OMAP2420 H4, OMAP3430 SDP, OMAP4430 SDP
  and AM335x EVM.
- Verified that GPIO interrupts are working on OMAP5912 OSK, OMAP2420 H4,
  OMAP3430 SDP and OMAP4430 SDP by making sure networking was working
  correctly as these boards use a GPIO with the ethernet chips. Also
  checked /proc/interrupts to ensure GPIO interrupt counts are
  incrementing as expected.

[1] http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git

Jon Hunter (4):
  gpio/omap: free irq domain in probe() failure paths
  gpio/omap: optimise interrupt service routine
  gpio/omap: force restore if context loss is not detectable
  ARM: dts: OMAP2+: Identify GPIO banks that are always powered

Tarun Kanti DebBarma (1):
  gpio/omap: remove extra context restores in *_runtime_resume()

 .../devicetree/bindings/gpio/gpio-omap.txt         |    7 ++-
 arch/arm/boot/dts/omap2420.dtsi                    |    4 ++
 arch/arm/boot/dts/omap2430.dtsi                    |    4 ++
 arch/arm/boot/dts/omap3.dtsi                       |    1 +
 arch/arm/boot/dts/omap4.dtsi                       |    1 +
 arch/arm/boot/dts/omap5.dtsi                       |    1 +
 drivers/gpio/gpio-omap.c                           |   49 +++++++++++---------
 7 files changed, 44 insertions(+), 23 deletions(-)

-- 
1.7.10.4

