From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 00/32] Device Tree Updates for GTA04 (A3/A4/A5 variants)
Date: Tue, 31 Jul 2018 09:11:03 +0200
Message-ID: <cover.1533021093.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk>
  asked why we have reg=<0> for port@1.
  Based on his comment we have removed the change for
  the opa362 reg property in the DT, but worked out a correct
  fix in the opa362 driver which solves the issue better.
  See: https://lore.kernel.org/patchwork/patch/968407/
* Ladislav Michl <ladis@linux-mips.org>
  has found a typo and we discussed NAND/OneNAND and
  how the partitions should be setup. A better solution
  would be to do it completely by u-boot, but unless we have
  that, we must fix it here.
* we omit the patch that replaces ti,non-removable by non-removable
  since additional internal tests have shown that it makes
  problems with finding the rootfs boot partition.
* instead we add a patch that explicitly sets broken-cd for mmc1.

PATCH V1 2018-07-25 09:00:42:
We have not upstreamed significant improvements collected
in the GTA04 vendor kernel tree for some years. The result
is that distribution kernels derived from upstream (e.g.
Debian) lag behind and miss significant features and fixes.


H. Nikolaus Schaller (32):
  ARM: dts: omap3-gta04: fix typo in backlight pins node name
  ARM: dts: omap3-gta04: fix some whitespace and tab style errors
  ARM: dts: omap3-gta04: give spi_lcd node a label so that we can
    overwrite in other DTS files
  ARM: dts: omap3-gta04: fixes for tvout / venc
  ARM: dts: omap3-gta04: add devconf1 setup for correct tvout pins
  ARM: dts: omap3-gta04: tvout: enable as display1 alias
  ARM: dts: omap3-gta04: fix touchscreen tsc2007
  ARM: dts: omap3-gta04: add pinmux for bmp085 EOC interrupt
  ARM: dts: omap3-gta04: make NAND partitions compatible with recent
    U-Boot
  ARM: dts: omap3-gta04: update gpmc NAND setup
  ARM: dts: omap3-gta04: keep vpll2 always on
  ARM: dts: omap3-gta04: add a comment how to reference the tca6507 gpio
  ARM: dts: omap3-gta04: add warning comment to vaux2 regulator
  ARM: dts: omap3-gta04: explicitly describe that mmc1 has no CD/WP
  ARM: dts: omap3-gta04: make use of input event include file and
    constants
  ARM: dts: omap3-gta04: map antenna detect GPIO to SW_LINEIN_INSERT key
    event
  ARM: dts: omap3-gta04: add camera interface parallel port
  ARM: dts: omap3-gta04: add camera pinmux
  ARM: dts: omap3-gta04: add mcbsp (audio subsystem) pinmux
  ARM: dts: omap3-gta04: add devconf0 setup for mcbsp1 clock pins
  ARM: dts: omap3-gta04: add mcbsp (audio subsystem) nodes
  ARM: dts: omap3-gta04a3: fix model name for A3 variant
  ARM: dts: omap3-gta04a4: fix model name for A4 variant
  ARM: dts: omap3-gta04a5: fix copyright of A5 variant
  ARM: dts: omap3-gta04a5: fix model name
  ARM: dts: omap3-gta04a5: fix whitepsace and tab style
  ARM: dts: omap3-gta04a5: add support for PPS
  ARM: dts: omap3-gta04a5: disable IrDA receiver to save power
  ARM: dts: omap3-gta04a5: add support for ti,wl1837 module
  ARM: dts: omap3-gta04a5: uses different sensors than gta04a4
  ARM: dts: omap3-gta04a5: define pinmux for bluetooth enable of
    ti,wl1837 module
  ARM: dts: omap3-gta04a5one: define GTA04A5 variant with OneNAND

 arch/arm/boot/dts/omap3-gta04.dtsi     | 248 +++++++++++++++++++++++++++++----
 arch/arm/boot/dts/omap3-gta04a3.dts    |   2 +-
 arch/arm/boot/dts/omap3-gta04a4.dts    |   2 +-
 arch/arm/boot/dts/omap3-gta04a5.dts    | 129 ++++++++++++++++-
 arch/arm/boot/dts/omap3-gta04a5one.dts | 114 +++++++++++++++
 5 files changed, 462 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-gta04a5one.dts

-- 
2.12.2
