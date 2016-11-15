From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.9-rc cycle
Date: Mon, 14 Nov 2016 16:33:35 -0800
Message-ID: <41406.9648054012$1505294585@news.gmane.org>
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

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.9/fixes-for-rc-cycle

for you to fetch changes up to 1bc2f5fac34535aeb3878ce32a762a221be7a851:

  ARM: dts: omap5: board-common: fix wrong SMPS6 (VDD-DDR3) voltage (2016-11-14 13:03:21 -0800)

----------------------------------------------------------------
Fixes for omaps for v4.9-rc cycle. Except for the omap3 fix for the SoC
features printed, all these are quite trivial and tiny. The omap5 jack
detection and gpadc patches are not strictly fixes, but I wanted to get
binding document typo fixed before it pops up on other boards. The
gpadc one liner was in the same series and I applied and pushed it out
already before noticing it could have waited. The list of changes is:

- Fix omap3 SoC features printed

- Make sure OMAP_INTERCONNECT is selected for am43xx only configurations

- Add missing memory node for torpedo

- Initialize uart4_mask properly to avoid writing garbage to PRM registers

- Fix NULL pointer dereference for omap4 volt_data

- Add alias for omap5 gpadc needed by iio drivers

- Enable omap5 jack headset jack detection and fix it's binding typo

- Add missing memory node for logicpd-som-lv

- Fix wrong SMPS6 voltage for VDD-DDR3 for omap5

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: omap3: Fix memory node in Torpedo board
      ARM: omap3: Add missing memory node in SOM-LV

Colin Ian King (1):
      ARM: OMAP2+: PRM: initialize en_uart4_mask and grpsel_uart4_mask

Dave Gerlach (1):
      ARM: AM43XX: Select OMAP_INTERCONNECT in Kconfig

H. Nikolaus Schaller (4):
      dts: omap5: board-common: add phandle to reference Palmas gpadc
      dts: omap5: board-common: enable twl6040 headset jack detection
      ASoC: omap-abe-twl6040: fix typo in bindings documentation
      ARM: dts: omap5: board-common: fix wrong SMPS6 (VDD-DDR3) voltage

Nicolae Rosia (1):
      ARM: OMAP2+: avoid NULL pointer dereference

Tony Lindgren (1):
      ARM: OMAP3: Fix formatting of features printed

 .../devicetree/bindings/sound/omap-abe-twl6040.txt       |  2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi                    |  5 +++++
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi               |  4 ++--
 arch/arm/boot/dts/omap5-board-common.dtsi                |  7 ++++---
 arch/arm/mach-omap2/Kconfig                              |  1 +
 arch/arm/mach-omap2/id.c                                 | 16 +++++++++++-----
 arch/arm/mach-omap2/prm3xxx.c                            |  3 +++
 arch/arm/mach-omap2/voltage.c                            |  6 ++++++
 8 files changed, 33 insertions(+), 11 deletions(-)
