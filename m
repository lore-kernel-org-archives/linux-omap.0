From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] ARM: omap: fix 4.7 gpmc networking regression
Date: Sun, 24 Jul 2016 14:10:57 +0200
Message-ID: <1469362260-20066-1-git-send-email-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

Networking is currently broken for Overo boards due to a regression in
4.7. I bisected it down to

	d2d00862dfbb ("memory: omap-gpmc: Support general purpose input
	for WAITPINs")

which changed how errors when probing gpmc child nodes are handled.
Instead of proceeding with setting up any other children as before, a
single error now aborts the whole process.

Due to an unrelated issue with a nand gpmc-node, this change broke
networking for Overo Tobi and other Overo boards with gpmc ethernet:

[    0.823364] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.823822] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    0.823974] gpiochip_find_base: found new base at 508
[    0.824096] gpio gpiochip6: (omap-gpmc): added GPIO chardev (254:6)
[    0.827148] gpiochip_setup_dev: registered GPIOs 508 to 511 on device: gpiochip6 (omap-gpmc)
[    0.827362] omap-gpmc 6e000000.gpmc: /ocp/gpmc@6e000000/nand@0,0 has malformed 'reg' property
[    0.827392] omap-gpmc 6e000000.gpmc: failed to probe DT children

This series restores the 4.6 behaviour of allowing probe of gpmc child
nodes to fail, and also fixes the problems with the Overo nand node.

Note that simply fixing the Overo NAND issue would fix the Overo
networking regression, but by restoring the 4.6 gpmc-probe behaviour
similar regressions on other OMAP systems are also avoided.

Johan


Johan Hovold (3):
  memory: omap-gpmc: allow probe of child nodes to fail
  ARM: dts: overo: fix gpmc nand cs0 range
  ARM: dts: overo: fix gpmc nand on boards with ethernet

 arch/arm/boot/dts/omap3-overo-base.dtsi             |  4 +++-
 .../arm/boot/dts/omap3-overo-chestnut43-common.dtsi |  2 --
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi      |  2 --
 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi   |  3 ---
 drivers/memory/omap-gpmc.c                          | 21 +++++++--------------
 5 files changed, 10 insertions(+), 22 deletions(-)

-- 
2.7.3
