From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 00/13] OMAP4: Add DT support for i2c and twl6030
Date: Thu, 1 Sep 2011 19:21:16 +0200
Message-ID: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
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
Cc: manjugk@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Grant, Tony,

This is a rework of the original series done by Manju:
http://www.spinics.net/lists/linux-omap/msg55827.html

It fixes the main issue of the previous series that was not booting at all
due to the lack of twl support. That fix is mandatory to allow further
work on the regulators DT bindings.
In order to have a minimal i2c support, both i2c and twl must be added
at the same time.
Please note than some patches can be reshuffle with the previous OMAP4
series to avoid the intermediate step with static i2c initialization.

That series is as well using the hwmods binding introduced in my previous
series.
The OMAP3/beagle support will be added in an other series.

A couple of basic i2c devices are added for panda and sdp board.

Patches are based on for_3.2/4_omap4_dt_early_devices + devicetree/test
and are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/5_omap_dt_i2c_twl

Tested on PandaBoard and sdp4430.

Comments are welcome.

Regards,
Benoit


Benoit Cousson (10):
  irq: Add stub for none DT build in irqdomain.h
  mfd: twl-core: Add initial DT support for twl4030/twl6030
  documentation/dt: Add TWL4030 and TWL6030 bindings
  arm/dts: OMAP4: Add i2c controller nodes
  arm/dts: omap4-sdp: Set clock freq for i2c controllers
  arm/dts: omap4-sdp: Add twl6030 node
  arm/dts: omap4-panda: Add twl6030 node
  OMAP4: board-dt: Remove static i2c init
  arm/dts: omap4-sdp: Add i2c3 & i2c4 devices
  arm/dts: omap4-panda: Add EEPROM entry in i2c3

G, Manjunath Kondaiah (3):
  i2c: OMAP: Add DT support for i2c controller
  documentation/dt: Add OMAP i2c bindings documentation
  arm/dts: omap4-panda: Set clock freq for i2c controllers

 Documentation/devicetree/bindings/i2c/omap-i2c.txt |   30 ++++++
 .../devicetree/bindings/mfd/twl-familly.txt        |   47 +++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   48 ++++++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   66 +++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   32 +++++++
 arch/arm/mach-omap2/board-omap4-dt.c               |   15 ---
 drivers/i2c/busses/i2c-omap.c                      |   23 ++++-
 drivers/mfd/twl-core.c                             |   99 +++++++++++++++++++-
 include/linux/irqdomain.h                          |    2 +
 9 files changed, 340 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/twl-familly.txt
