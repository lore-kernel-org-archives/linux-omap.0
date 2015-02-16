From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 0/4] ARM OMAP2+ GPMC: various fixes and bus children
Date: Mon, 16 Feb 2015 16:48:57 +0100
Message-ID: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org


I found a few more bugs in the GPMC driver. The first three patches should be self-explanatory:

*debug output was unaligned --> align it
*GPMCFCLKDIVIDER is used in all use cases --> always program it
*WAITMONITORINGTIME was computed in FCLK ticks instead of CLK ticks --> compute in CLK ticks

The last patch adds bus children to the GPMC. Currently, the GPMC driver
only supports direct children, which means one child with unique settings per CS region.

This patch adds explicit code inside the GPMC driver to probe for busses and
instantiate their children. (As opposed to adding the GPMC to of_default_bus_match_table
so it would be matched when the DT is first populated.)

GPMC properties apply to busses as well as direct children and map to whole CS regions.

Example:

&gpmc {
	ranges = </* CS0 */ 0 /* offset (broken) */ 0x0000 /* OCP address */ 0x1000000 /* size */ 0x1000000>;

	my_bus: nor@0,0x0000 { /* CS0; offset 0x0000 */

		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = </* address */ 0x0000 /* parent address */ 0 0x0000 /* size */ 0x1000000>;
		reg = </* parent address */0 0x0000 /* size */ 0x1000000>;
		bank-width = <2>; /* GPMC_DEVWIDTH_16BIT */

		gpmc,sync-read;
		gpmc,sync-write;
		gpmc,sync-clk-ps = ...;
		... etc. ...
		reg-io-width = <2>;
		
		my_subdev0: subdev@0x0000 { /* address 0x0000 */

			compatible = "my,driver0";
			reg = </* parent address */ 0x0000 /* size */ 0x0800000>;

		};
		... etc. ...
		my_subdevN: subdev@0x8000 { /* address 0x8000 */

			compatible = "my,driverN";
			reg = </* parent address */ 0x0000 /* size */ 0x0800000>;

		};

	};

};


Robert ABEL (4):
  ARM OMAP2+ GPMC: fix debug output alignment
  ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
  ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider bug
  ARM OMAP2+ GPMC: add bus children

 arch/arm/mach-omap2/gpmc.c | 105 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 81 insertions(+), 24 deletions(-)

-- 
2.3.0
