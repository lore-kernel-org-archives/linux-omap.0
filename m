From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] pinmux dts defines for am335x for v5.2
Date: Tue, 16 Apr 2019 09:16:58 -0700
Message-ID: <pull-1555431314-599391@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Christina Quast <cquast@hanoverdisplays.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/dt-am3-signed

for you to fetch changes up to e5b258e53e58a3afd228bbef4d376c7a470cfa58:

  ARM: dts: am335x: wega: Replaced register offsets with defines (2019-04-15 08:26:28 -0700)

----------------------------------------------------------------
Add am335x pinmux defines and start using them

This series of changes adds a new pinmux instance defines for am335x,
and a new AM33XX_PADCONF macro. And then the rest of the series updates
the dts files to use it.

The reasons for doing this is the pinmux configuration has been hard to
use and read. And we need to do this for eventually for moving to use
values.

This change is done one machine at a time, and can be easily reverted
as needed in case of unexpected trouble. The old macro is still working,
and we're planning to keep it around until we eventually change to use

----------------------------------------------------------------
Christina Quast (38):
      ARM: dts: am33xx: Added macros for numeric pinmux addresses
      ARM: dts: am33xx: Added AM33XX_PADCONF macro
      ARM: dts: am335x: bone-common: Replaced register offsets with defines
      ARM: dts: am335x: boneblack-common: Replaced register offsets with defines
      ARM: dts: am335x: boneblack-wireless: Replaced register offsets with defines
      ARM: dts: am335x: pocketbeagle: Replaced register offsets with defines
      ARM: dts: am335x: baltos-ir2110: Replaced register offsets with defines
      ARM: dts: am335x: baltos-ir3220: Replaced register offsets with defines
      ARM: dts: am335x: baltos-ir5221: Replaced register offsets with defines
      ARM: dts: am335x: baltos-leds: Replaced register offsets with defines
      ARM: dts: am335x: baltos: Replaced register offsets with defines
      ARM: dts: am335x: base0033: Replaced register offsets with defines
      ARM: dts: am335x: bonegreen-wireless: Replaced register offsets with defines
      ARM: dts: am335x: boneblue: Replaced register offsets with defines
      ARM: dts: am335x: bonegreen-common: Replaced register offsets with defines
      ARM: dts: am335x: chiliboard: Replaced register offsets with defines
      ARM: dts: am335x: chilisom: Replaced register offsets with defines
      ARM: dts: am335x: cm-t335: Replaced register offsets with defines
      ARM: dts: am335x: evm: Replaced register offsets with defines
      ARM: dts: am335x: evmsk: Replaced register offsets with defines
      ARM: dts: am335x: icev2: Replaced register offsets with defines
      ARM: dts: am335x: igep0033: Replaced register offsets with defines
      ARM: dts: am335x: lxm: Replaced register offsets with defines
      ARM: dts: am335x: moxa-uc-2100-common: Replaced register offsets with defines
      ARM: dts: am335x: moxa-uc-2101: Replaced register offsets with defines
      ARM: dts: am335x: moxa-uc-8100-me-t: Replaced register offsets with defines
      ARM: dts: am335x: nano: Replaced register offsets with defines
      ARM: dts: am335x: osd3358-sm-red: Replaced register offsets with defines
      ARM: dts: am335x: osd335x-common: Replaced register offsets with defines
      ARM: dts: am335x: pcm-953: Replaced register offsets with defines
      ARM: dts: am335x: pdu001: Replaced register offsets with defines
      ARM: dts: am335x: pepper: Replaced register offsets with defines
      ARM: dts: am335x: phycore-som: Replaced register offsets with defines
      ARM: dts: am335x: sancloud-bbe: Replaced register offsets with defines
      ARM: dts: am335x: sbc-t335: Replaced register offsets with defines
      ARM: dts: am335x: shc: Replaced register offsets with defines
      ARM: dts: am335x: sl50: Replaced register offsets with defines
      ARM: dts: am335x: wega: Replaced register offsets with defines

 arch/arm/boot/dts/am335x-baltos-ir2110.dts        |  16 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts        |  38 +--
 arch/arm/boot/dts/am335x-baltos-ir5221.dts        |  42 ++--
 arch/arm/boot/dts/am335x-baltos-leds.dtsi         |   6 +-
 arch/arm/boot/dts/am335x-baltos.dtsi              | 140 +++++------
 arch/arm/boot/dts/am335x-base0033.dts             |  48 ++--
 arch/arm/boot/dts/am335x-bone-common.dtsi         | 116 ++++-----
 arch/arm/boot/dts/am335x-boneblack-common.dtsi    |  54 ++--
 arch/arm/boot/dts/am335x-boneblack-wireless.dts   |  28 +--
 arch/arm/boot/dts/am335x-boneblue.dts             | 104 ++++----
 arch/arm/boot/dts/am335x-bonegreen-common.dtsi    |   4 +-
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts   |  28 +--
 arch/arm/boot/dts/am335x-chiliboard.dts           |  66 ++---
 arch/arm/boot/dts/am335x-chilisom.dtsi            |  34 +--
 arch/arm/boot/dts/am335x-cm-t335.dts              | 190 ++++++--------
 arch/arm/boot/dts/am335x-evm.dts                  | 234 ++++++++---------
 arch/arm/boot/dts/am335x-evmsk.dts                | 292 +++++++++++-----------
 arch/arm/boot/dts/am335x-icev2.dts                | 116 ++++-----
 arch/arm/boot/dts/am335x-igep0033.dtsi            |  40 +--
 arch/arm/boot/dts/am335x-lxm.dts                  | 120 ++++-----
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi |  42 ++--
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts         |  24 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts    | 116 ++++-----
 arch/arm/boot/dts/am335x-nano.dts                 | 140 +++++------
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts       | 168 ++++++-------
 arch/arm/boot/dts/am335x-osd335x-common.dtsi      |   4 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi             |  74 +++---
 arch/arm/boot/dts/am335x-pdu001.dts               | 170 ++++++-------
 arch/arm/boot/dts/am335x-pepper.dts               | 200 +++++++--------
 arch/arm/boot/dts/am335x-phycore-som.dtsi         |  60 ++---
 arch/arm/boot/dts/am335x-pocketbeagle.dts         |  56 ++---
 arch/arm/boot/dts/am335x-sancloud-bbe.dts         |  62 ++---
 arch/arm/boot/dts/am335x-sbc-t335.dts             | 152 +++++------
 arch/arm/boot/dts/am335x-shc.dts                  | 226 +++++++++--------
 arch/arm/boot/dts/am335x-sl50.dts                 | 208 +++++++--------
 arch/arm/boot/dts/am335x-wega.dtsi                |  68 ++---
 include/dt-bindings/pinctrl/am33xx.h              | 130 +++++++++-
 include/dt-bindings/pinctrl/omap.h                |   1 +
 38 files changed, 1834 insertions(+), 1783 deletions(-)
