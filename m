From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/3] dts changes for omaps for v4.20
Date: Thu, 27 Sep 2018 11:56:01 -0700
Message-ID: <20180927185601.GD5662@atomide.com>
References: <pull-1537983432-167273@atomide.com>
 <pull-1537983432-167273@atomide.com-3>
 <20180927165956.1fa539de@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180927165956.1fa539de@kemnade.info>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: hns@goldelico.com, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [180927 15:04]:
> Tony Lindgren <tony@atomide.com> wrote:
> > Devicetree changes for omap variants
...
> [...]
> > H. Nikolaus Schaller (32):
> [...]
> >       ARM: dts: omap3-gta04a5one: define GTA04A5 variant with OneNAND
> That new file was not added no the makefile. Somehow that got lost
>  and I thought a separate patch was sent by Nikolaus as a straggler but
> I cannot find it at the moment.

Thanks for letting me know, I found it and applied. It was in my LKML
mail box. As it's a trivial Makefile change, I've added a v2 signed tag
with updated pull request below.

Regards,

Tony

8< ----------------------
The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/dt-signed-v2

for you to fetch changes up to 20bcd4a4d76d7474047ff4539e7d65b990bb2556:

  ARM: dts: add omap3-gta04a5one to Makefile (2018-09-27 08:29:14 -0700)

----------------------------------------------------------------
Devicetree changes for omap variants

This branch contains a series of improvments for omap3-gta04 phone,
and a series of clean-up for am335x to remove the deprecated phy_id
property.

The rest is to configure am57xx-idk boards for leds, load trigger,
and smps, am3517-evm audio configuration, beaglebone hdmi cec support,
coresight binding update, and fixes for i2c and spi warnings.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: am3517-evm: Add support for UI board and Audio

Andreas Kemnade (2):
      ARM: dts: gta04: add serial console wakeup irq
      ARM: dts: omap3-gta04: add pulldown/up settings for twl4030 gpio

Andrew F. Davis (3):
      ARM: dts: am571x-idk: Add tricolor Industrial LED support
      ARM: dts: am572x-idk: Add tricolor Industrial LED support
      ARM: dts: am571x-idk: Add Industrial input load trigger

Grygorii Strashko (27):
      ARM: dts: am335x-evm: fix number of cpsw
      ARM: dts: am335x-shc: get rid of phy_id property
      ARM: dts: am335x-pepper: get rid of phy_id property
      ARM: dts: am335x-pdu001: get rid of phy_id property
      ARM: dts: am335x-nano: get rid of phy_id property
      ARM: dts: am335x-moxa-uc-8100-me-t: get rid of phy_id property
      ARM: dts: am335x-lxm: get rid of phy_id property
      ARM: dts: am335x-igep0033: get rid of phy_id property
      ARM: dts: am335x-evmsk: get rid of phy_id property
      ARM: dts: am335x-cm-t335: get rid of phy_id property
      ARM: dts: am335x-chiliboard: get rid of phy_id property
      ARM: dts: am335x-bone-common: get rid of phy_id property
      ARM: dts: am43x-epos-evm: get rid of phy_id property
      ARM: dts: am437x-sk-evm: get rid of phy_id property
      ARM: dts: am437x-idk-evm: get rid of phy_id property
      ARM: dts: am437x-gp-evm: get rid of phy_id property
      ARM: dts: am437x-cm-t43: get rid of phy_id property
      ARM: dts: dra76-evm: get rid of phy_id property
      ARM: dts: dra72-evm: get rid of phy_id property
      ARM: dts: dra72-evm-revc: get rid of phy_id property
      ARM: dts: dra71-evm: get rid of phy_id property
      ARM: dts: dra7-evm: get rid of phy_id property
      ARM: dts: am57xx-idk-common: get rid of phy_id property
      ARM: dts: am57xx-cl-som-am57x: get rid of phy_id property
      ARM: dts: dm8148-evm: get rid of phy_id property
      ARM: dts: dm8148-t410: get rid of phy_id property
      ARM: dts: dra62x-j5eco-evm: get rid of phy_id property

H. Nikolaus Schaller (33):
      ARM: dts: omap3-gta04: fix typo in backlight pins node name
      ARM: dts: omap3-gta04: fix some whitespace and tab style errors
      ARM: dts: omap3-gta04: give spi_lcd node a label so that we can overwrite in other DTS files
      ARM: dts: omap3-gta04: fixes for tvout / venc
      ARM: dts: omap3-gta04: add devconf1 setup for correct tvout pins
      ARM: dts: omap3-gta04: tvout: enable as display1 alias
      ARM: dts: omap3-gta04: fix touchscreen tsc2007
      ARM: dts: omap3-gta04: add pinmux for bmp085 EOC interrupt
      ARM: dts: omap3-gta04: make NAND partitions compatible with recent U-Boot
      ARM: dts: omap3-gta04: update gpmc NAND setup
      ARM: dts: omap3-gta04: keep vpll2 always on
      ARM: dts: omap3-gta04: add a comment how to reference the tca6507 gpio
      ARM: dts: omap3-gta04: add warning comment to vaux2 regulator
      ARM: dts: omap3-gta04: explicitly describe that mmc1 has no CD/WP
      ARM: dts: omap3-gta04: make use of input event include file and constants
      ARM: dts: omap3-gta04: map antenna detect GPIO to SW_LINEIN_INSERT key event
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
      ARM: dts: omap3-gta04a5: define pinmux for bluetooth enable of ti,wl1837 module
      ARM: dts: omap3-gta04a5one: define GTA04A5 variant with OneNAND
      ARM: dts: add omap3-gta04a5one to Makefile

Hans Verkuil (1):
      ARM: dts: am335x-boneblack: add cec support

Keerthy (1):
      ARM: dts: am57xx-idk-common: Hook smps12 regulator as cpu vdd-supply

Rob Herring (1):
      ARM: dts: ti: Fix SPI and I2C bus warnings

Suzuki K Poulose (1):
      ARM: dts: omap: Update coresight bindings for hardware ports

Tony Lindgren (1):
      Merge branch 'am335x-evm-port-fix' into omap-for-v4.20/dt

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi      |   6 +-
 arch/arm/boot/dts/am335x-boneblack-common.dtsi |   5 +-
 arch/arm/boot/dts/am335x-chiliboard.dts        |   6 +-
 arch/arm/boot/dts/am335x-cm-t335.dts           |   6 +-
 arch/arm/boot/dts/am335x-evm.dts               |  12 +-
 arch/arm/boot/dts/am335x-evmsk.dts             |  12 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi         |  13 +-
 arch/arm/boot/dts/am335x-lxm.dts               |  12 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts |  12 +-
 arch/arm/boot/dts/am335x-nano.dts              |  12 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts    |   2 +-
 arch/arm/boot/dts/am335x-pdu001.dts            |  14 +-
 arch/arm/boot/dts/am335x-pepper.dts            |  12 +-
 arch/arm/boot/dts/am335x-shc.dts               |   1 -
 arch/arm/boot/dts/am3517-evm-ui.dtsi           | 220 +++++++++++++++++++++
 arch/arm/boot/dts/am3517-evm.dts               |   1 +
 arch/arm/boot/dts/am4372.dtsi                  |   2 +-
 arch/arm/boot/dts/am437x-cm-t43.dts            |  12 +-
 arch/arm/boot/dts/am437x-gp-evm.dts            |   6 +-
 arch/arm/boot/dts/am437x-idk-evm.dts           |   6 +-
 arch/arm/boot/dts/am437x-sk-evm.dts            |  12 +-
 arch/arm/boot/dts/am43x-epos-evm.dts           |   6 +-
 arch/arm/boot/dts/am571x-idk.dts               |  84 +++++++-
 arch/arm/boot/dts/am572x-idk-common.dtsi       |  76 +++++++
 arch/arm/boot/dts/am572x-idk.dts               |   4 -
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts      |  14 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi       |  18 +-
 arch/arm/boot/dts/dm8148-evm.dts               |  14 +-
 arch/arm/boot/dts/dm8148-t410.dts              |  14 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts         |  14 +-
 arch/arm/boot/dts/dra7-evm.dts                 |  14 +-
 arch/arm/boot/dts/dra7.dtsi                    |   2 +-
 arch/arm/boot/dts/dra71-evm.dts                |   4 +-
 arch/arm/boot/dts/dra72-evm-revc.dts           |   4 +-
 arch/arm/boot/dts/dra72-evm.dts                |   8 +-
 arch/arm/boot/dts/dra76-evm.dts                |   4 +-
 arch/arm/boot/dts/keystone-k2g.dtsi            |   2 +-
 arch/arm/boot/dts/omap2.dtsi                   |   4 +-
 arch/arm/boot/dts/omap2430.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts          |  17 +-
 arch/arm/boot/dts/omap3-beagle.dts             |  17 +-
 arch/arm/boot/dts/omap3-gta04.dtsi             | 262 ++++++++++++++++++++++---
 arch/arm/boot/dts/omap3-gta04a3.dts            |   2 +-
 arch/arm/boot/dts/omap3-gta04a4.dts            |   2 +-
 arch/arm/boot/dts/omap3-gta04a5.dts            | 129 +++++++++++-
 arch/arm/boot/dts/omap3-gta04a5one.dts         | 114 +++++++++++
 arch/arm/boot/dts/omap3-n9.dts                 |   2 +-
 48 files changed, 1102 insertions(+), 116 deletions(-)
 mode change 100755 => 100644 arch/arm/boot/dts/am335x-osd3358-sm-red.dts
 create mode 100644 arch/arm/boot/dts/am3517-evm-ui.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-gta04a5one.dts
