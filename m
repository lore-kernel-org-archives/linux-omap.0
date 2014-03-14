From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC 0/9] Introduce OPP modifier for ARM SoCs
Date: Fri, 14 Mar 2014 14:25:26 -0500
Message-ID: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
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
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Jisheng Zhang <jszhang@marvell.com>, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Anson Huang <Anson.Huang@freescale.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq@vger.kernel.org, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

There are many SoCs that can have different operating points supported
depending on different conditions even for otherwise identical parts. 
It does not make sense to define many different iterations of a device tree
file for each possible permutation of the same device especially when this data
may exist within the part. 

This proposal introduces a framework and example driver to help in enabling
or disabling appropriate OPPs based on a register value. The information needed
for deciding which OPPs are to be enabled is defined in the device tree in a
table so that one device tree file is able to support any version of the part.
This series is mostly untested besides 335x and only is intended to demonstrate
the approach for dynamically changing available OPPs.

The framework allows other drivers to register themselves and
then through a single function call modify which OPPs are available for a device.

The included opp-modifier-reg driver can already support many different SoCs
that have a manufacturer modifiable register defining which OPPs are possible
on the SoC. This series includes example entries for am335x, am437x, omap4,
dra7, and imx6q. 

The opp-modifier-reg driver expects all possible OPPs to be loaded for the
device already and then is able to modify the table based on the details
passed compared to the defined register.

This RFC only applies to MPU OPPs and only supports modifying the OPP list to
contain supported OPPs during boot but this driver could easily be extended
to support modifying the OPPs of other IPs that have them easily by placing
the hook (in patch 3 here) elsewhere. The hook for opp-modifier was placed
in its current only as a proof of concept; if there is a better location it
should be moved.

This series is tested on am33xx but must be used with 2.x+ silicon as the
earlier revision does not support the same OPPs. Also for the additional OPPs
the maximum voltage supplied by the regulator for the MPU rail on both am335
and am437x would need to be extended but those patches were left out of this
series to focus on opp-modifier.

Comments? Is this a reasonable direction to take?

Dave Gerlach (9):
  opp-modifier: Introduce OPP Modifier Framework
  opp-modifier: Add opp-modifier-reg driver
  PM / OPP: Add hook to modify OPPs after they are loaded.
  ARM: dts: AM33XX: Add opp-modifier device entry and add higher OPPs
  ARM: dts: AM4372: Add opp-modifier device entry and add higher OPPs
  ARM: dts: omap443x: Add opp-modifier entry and add higher OPPs
  ARM: dts: omap4460: Add opp-modifier entry and add higher OPPs
  ARM: dts: dra7: Add opp-modifier device entry and add higher OPPs
  ARM: dts: imx6q: Add opp-modifier device entry

 .../devicetree/bindings/power/opp-modifier.txt     | 111 +++++++++
 arch/arm/boot/dts/am33xx.dtsi                      |  27 ++-
 arch/arm/boot/dts/am4372.dtsi                      |  30 +++
 arch/arm/boot/dts/dra7.dtsi                        |  18 ++
 arch/arm/boot/dts/imx6q.dtsi                       |  18 ++
 arch/arm/boot/dts/omap443x.dtsi                    |  16 ++
 arch/arm/boot/dts/omap4460.dtsi                    |  17 ++
 drivers/base/power/opp.c                           |   8 +
 drivers/power/Makefile                             |   2 +
 drivers/power/opp/Makefile                         |   2 +
 drivers/power/opp/core.c                           | 126 ++++++++++
 drivers/power/opp/opp-modifier-reg.c               | 259 +++++++++++++++++++++
 include/dt-bindings/opp/imx.h                      |  17 ++
 include/dt-bindings/opp/ti.h                       |  33 +++
 include/linux/opp-modifier.h                       |  35 +++
 15 files changed, 717 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/opp-modifier.txt
 create mode 100644 drivers/power/opp/Makefile
 create mode 100644 drivers/power/opp/core.c
 create mode 100644 drivers/power/opp/opp-modifier-reg.c
 create mode 100644 include/dt-bindings/opp/imx.h
 create mode 100644 include/dt-bindings/opp/ti.h
 create mode 100644 include/linux/opp-modifier.h

-- 
1.9.0
