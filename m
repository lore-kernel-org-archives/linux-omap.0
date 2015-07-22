From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap dts changes for v4.3, part2
Date: Wed, 22 Jul 2015 02:41:16 -0700
Message-ID: <36286.4007860937$1437558158@news.gmane.org>
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
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 80edaaead3687b47ba3760588306937439ebd7bd:

  ARM: dts: am335x-evm: Switch using simple-audio-card for audio support (2015-07-14 04:28:25 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/dt-pt2

for you to fetch changes up to f9d50fef4b6447527c2be1ad07499221c2511391:

  ARM: OMAP2+: omap3-pandora: add wifi support (2015-07-21 04:07:42 -0700)

----------------------------------------------------------------
More omap dts changes for v4.3 merge window:

- Add missing devices for pandora. Note that we're adding wl1251
  WLAN and LCD backlight support for now using legacy pdata as that
  allows us to drop the legacy board file for pandora in another
  series of patches

- Enable power button support for omap5-uevm

- Add aliases for am437x UARTs

- Add support for phyCORE phyBOARD-WEGA-AM335x rdk and
  phyCORE-AM335x SoM

- Use u16 values for tsc2046 on omap3-lilly

----------------------------------------------------------------
Aparna Balasubramanian (1):
      ARM: dts: omap5-uevm: Add Palmas power button support

Fugang Duan (1):
      ARM: dts: omap3: correct the format of u16 values for tsc2046 node

Grazvydas Ignotas (4):
      ARM: dts: omap3-pandora: miscellaneous corrections
      ARM: dts: omap3-pandora: add support for usb host and 32k buffer
      ARM: OMAP2+: omap3-pandora: add backlight support
      ARM: OMAP2+: omap3-pandora: add wifi support

Sekhar Nori (1):
      ARM: dts: am437x: add aliases for all UART instances

Teresa Remmet (2):
      ARM: dts: Add support for phyCORE-AM335x SoM
      ARM: dts: Add phyBOARD-WEGA-AM335x rdk

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi          | 368 +++++++++++++++++++++
 arch/arm/boot/dts/am335x-wega-rdk.dts              |  22 ++
 arch/arm/boot/dts/am335x-wega.dtsi                 | 151 +++++++++
 arch/arm/boot/dts/am4372.dtsi                      |   5 +
 arch/arm/boot/dts/am437x-gp-evm.dts                |   1 -
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |  12 +-
 arch/arm/boot/dts/omap3-pandora-1ghz.dts           |   2 +-
 arch/arm/boot/dts/omap3-pandora-600mhz.dts         |   2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  54 ++-
 arch/arm/boot/dts/omap5-uevm.dts                   |   7 +
 arch/arm/mach-omap2/pdata-quirks.c                 | 113 +++++++
 13 files changed, 729 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-phycore-som.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-wega-rdk.dts
 create mode 100644 arch/arm/boot/dts/am335x-wega.dtsi
