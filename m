From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 00/10] OMAP: Add DT support for early init OMAP4 devices
Date: Wed, 24 Aug 2011 15:09:06 +0200
Message-ID: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: khilman@ti.com, Benoit Cousson <b-cousson@ti.com>, manjugk@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Grant, Tony,

Here are a couple of drivers / devices adaptated to DT on OMAP4.
I focused first on devices that used to be initialized before machine_init
time (postcore_initcall most of the time).

The GPIO adaptation is not taking into account the current cleanup done
by Charu / Tarun. It will have to be revisited when the cleanup will
be completed.

Patches are based on for_3.2/3_omap4_dt_base + devicetree/test
and are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/4_omap4_dt_early_devices

Comments are welcome.

Regards,
Benoit


Benoit Cousson (10):
  OMAP2+: l3-noc: Add support for device-tree
  arm/dts: OMAP4: Add a main ocp entry bound to l3-noc driver
  documentation/dt: Add l3-noc bindings
  arm/dts: OMAP4: Add mpu, dsp and iva nodes
  documentation/dt: Add mpu, dsp and iva bindings
  hwspinlock: OMAP4: Add spinlock support in DT
  documentation/dt: Add spinlock bindings
  gpio/omap: Adapt GPIO driver to DT
  arm/dts: OMAP4: Add gpio nodes
  documentation/dt: Add OMAP GPIO properties

 Documentation/devicetree/bindings/arm/omap/dsp.txt |   14 +++
 Documentation/devicetree/bindings/arm/omap/iva.txt |   18 ++++
 .../devicetree/bindings/arm/omap/l3-noc.txt        |   18 ++++
 Documentation/devicetree/bindings/arm/omap/mpu.txt |   35 +++++++
 .../devicetree/bindings/gpio/gpio-omap.txt         |   33 ++++++
 .../bindings/hwspinlock/omap-spinlock.txt          |    5 +
 arch/arm/boot/dts/omap4.dtsi                       |  105 +++++++++++++++++++-
 arch/arm/mach-omap2/Makefile                       |    6 +-
 arch/arm/mach-omap2/devices.c                      |    2 +
 arch/arm/mach-omap2/gpio.c                         |    2 +
 arch/arm/mach-omap2/omap_l3_noc.c                  |   16 +++-
 arch/arm/mach-omap2/pm.c                           |    5 +-
 drivers/gpio/gpio-omap.c                           |  103 +++++++++++++++++--
 drivers/hwspinlock/omap_hwspinlock.c               |   11 ++
 14 files changed, 359 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dsp.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/iva.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/l3-noc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/mpu.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt
 create mode 100644 Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt
