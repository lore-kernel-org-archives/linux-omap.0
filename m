From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC 0/6] ARM: OMAP2+: AM43x/AM335x prcm reset driver
Date: Mon, 2 Sep 2013 19:41:55 +0530
Message-ID: <cover.1378129416.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Benoit Cousson <bcousson@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

Hi,

This is an attempt to achieve reset on AM43x/AM335x based SoC's with
reset driver making use of the reset framework.

prcm node is added in device tree, which would hold reset bindings.
Initially node was made as a one that represents reset functionality
of SoC. but ended up with node for prcm (which is felt to be natural
choice) instead. I am a bit doubtful whether placement of prcm node in
root node as in this series is the right thing.

Reset driver gets probed for specific prcm node, the same defines
register details to be used for a particular SoC (using ".data" field
associated with ".compatible" in driver match table).

Another option to handle different SoC's would be to add register
details to DT and let the driver extract it from DT. I vaguely
remember seeing a thread mentioning that putting register details in
DT is not preferred. But open to putting register level details
instead in DT if that is being generally preferred. This would have
advantage that adding reset support for a new SoC would be easier, but
would have to put more thought before doing so as DT bindings should
not change.

With the approach taken here, for supporting a new SoC with new prcm
register details, driver would have to be updated much like the way a
pci based ethernet driver would have to be updated to handle a new IP
version that is not register level compatible with the existing ones.

In this series out of the three IP's (gfx, m3, pruss) that would need
reset support, here as a proof of concept only gfx is taken care.
Other's can be easily supported by adding new register data array
entries.

Two new reset API's are provided to check whether reset is ready and
to clear reset. This would be required in case IP needs to mix reset
handling procedure with power/clock managment procedure to achieve
proper reset and these procedures are sometimes IP specific that would
make it difficult to handle reset fully in pm_runtime platform support.

*------*
client IP handling s/w (DT based) should do as follows:

1. Specify reset handle in the relevant DT node, for eg.

	myip@deadbeef {
		:
		:
		/* here prcm is the handle to reset binding node */
		resets = <&prcm 0>;
	};

2. In driver, that require reset to be deasserted,
 (this is the sequence required for gfx on AM43x/AM335x, this would
  depend on requirements of the IP)

	mydriver_probe(struct platform device *pdev)
	{
		:
		:
		reset_control_get(&pdev->dev, NULL);
		reset_control_clear_reset();
		reset_control_deassert();
		pm_runtime_get_sync();
		if (reset_control_is_reset() != true)
			goto err;
		reset_control_put();
		:
		:
	}

*------*

May be removing reset handling in hwmod can be considered by making
use of reset driver.

Or as another extreme, perhaps, other logic's in the prcm can be
handled by a new prcm driver and then this reset driver can be a child
of it.

Regards
Afzal


Afzal Mohammed (6):
  reset: is_reset and clear_reset api's
  doc: dt: binding: omap: am43x/am335x prcm reset
  reset: am43x/am335x support
  ARM: OMAP2+: AM43x/AM335x: have reset controller
  ARM: dts: AM335x: prcm node (for reset)
  ARM: dts: AM4372: prcm node (for reset)

 .../devicetree/bindings/arm/omap/prcm.txt          |  13 ++
 arch/arm/boot/dts/am33xx.dtsi                      |   6 +
 arch/arm/boot/dts/am4372.dtsi                      |   6 +
 arch/arm/mach-omap2/Kconfig                        |   2 +
 drivers/reset/Kconfig                              |  14 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/amx3_reset.c                         | 157 +++++++++++++++++++++
 drivers/reset/core.c                               |  32 +++++
 include/linux/reset-controller.h                   |   2 +
 include/linux/reset.h                              |   2 +
 10 files changed, 235 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/prcm.txt
 create mode 100644 drivers/reset/amx3_reset.c

-- 
1.8.3.4
