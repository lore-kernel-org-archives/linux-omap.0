From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap dts fixes for v4.7 merge window
Date: Fri, 13 May 2016 10:11:41 -0700
Message-ID: <10663.8571284295$1463159592@news.gmane.org>
References: <pull-1463159315-251654>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1463159315-251654>
In-Reply-To: <pull-1463159315-251654>
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

The following changes since commit 5b6042237dc85b7e2dc26806957ebf95d205e864:

  ARM: dts: am57xx-idk: Include Industrial grade  thermal thresholds (2016-04-28 08:08:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7-dts-fixes1

for you to fetch changes up to a1f6ad14176d466c00e6a687f9c78ec6c7ad6bf8:

  ARM: dts: igep0020: Add SD card write-protect pin. (2016-05-12 13:52:25 -0700)

----------------------------------------------------------------
DTS fixes for omaps for v4.7 merge window for issues noted
with patches in Linux next:

- Fix omap5 and am57xx-idk input voltages to fix micro-sd
  probing at least for some omap5-uevm configurations

- Fix unhandled fault for igepv5 audio

- Fix UART wakeirqs for omap5 by removing WAKUP_EN flags,
  those are managed by the wakeirq and can currently confuse
  the wakeirqs as there is no handler necessarily registered

- Fix LDO7 source for igepv5

Also included are few minor changes not strictly fixes
are good to have merged:

- Fix HP T410 boot time warnings for eMMC and disable the
  unused MMC interfaces while at it

- Add dra7 gpmc dma channel

- Add igep00x0 SD card detect and write protect GPIOs

----------------------------------------------------------------
Enric Balletbo i Serra (2):
      ARM: dts: igep00x0: Add SD card-detect.
      ARM: dts: igep0020: Add SD card write-protect pin.

Franklin S Cooper Jr (1):
      ARM: dts: dra7: Add gpmc dma channel

Nicolas Chauvet (2):
      ARM: dts: Add non-removable to hsmmc on hp-t410
      ARM: dts: disable mmc by default and enable when needed for dm814x

Nishanth Menon (2):
      ARM: dts: omap5-board-common: Describe the voltage supply mapping accurately
      ARM: dts: am57xx-idk-common: Fix input supply names

Tony Lindgren (3):
      ARM: dts: Fix igepv5 audiopwon-gpio
      ARM: dts: Fix uart wakeirq on omap5 by removing WAKEUP_EN for omaps
      ARM: dts: Fix ldo7 source for HDMI on igepv5

 arch/arm/boot/dts/am57xx-idk-common.dtsi     | 32 ++++++++++---------
 arch/arm/boot/dts/dm8148-evm.dts             |  8 +++++
 arch/arm/boot/dts/dm8148-t410.dts            |  9 ++++++
 arch/arm/boot/dts/dra7.dtsi                  |  2 ++
 arch/arm/boot/dts/omap3-evm-37xx.dts         |  2 +-
 arch/arm/boot/dts/omap3-igep.dtsi            |  1 +
 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 11 +++++++
 arch/arm/boot/dts/omap3-n900.dts             |  4 +--
 arch/arm/boot/dts/omap3-n950-n9.dtsi         |  6 ++--
 arch/arm/boot/dts/omap3-zoom3.dts            |  6 ++--
 arch/arm/boot/dts/omap5-board-common.dtsi    | 48 ++++++++++++++++++++++++++--
 arch/arm/boot/dts/omap5-igep0050.dts         | 26 +++++++++++++++
 arch/arm/boot/dts/omap5-uevm.dts             | 10 ++++++
 13 files changed, 139 insertions(+), 26 deletions(-)
