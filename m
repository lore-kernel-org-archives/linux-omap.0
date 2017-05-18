From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.12-rc cycle
Date: Thu, 18 May 2017 08:59:39 -0700
Message-ID: <42104.0308931426$1505300832@news.gmane.org>
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

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.12/fixes-v2-signed

for you to fetch changes up to bca5238816939436d72ae6bab124c4b0641a3a99:

  ARM: dts: dra7: Reduce cpu thermal shutdown temperature (2017-05-17 06:51:38 -0700)

----------------------------------------------------------------
Fixes for omaps for v4.12-rc cycle most consisting of few minor dts fixes
for various devices. Also included is a memory controller (GPMC) debug output
fix as without that the shown bootloader configured GPMC bus width will
be wrong and won't work for kernel timings:

- Add dra7 powerhold configuration to be able to shut down pmic correctly

- Fix polarity for gta04 mcbsp4 clocks for modem

- Fix Pandaboard CEC pin pull making it usable

- Fix LogicPD Torpedo camera pin mux

- Fix GPMC debug bus width

- Reduce cpu thermal shutdown temperature

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: LogicPD Torpedo: Fix camera pin mux

Andreas Kemnade (1):
      ARM: dts: gta04: fix polarity of clocks for mcbsp4

Hans Verkuil (1):
      ARM: dts: omap4: enable CEC pin for Pandaboard A4 and ES

Keerthy (1):
      ARM: dts: dra7: Add power hold and power controller properties to palmas

Ravikumar Kattekola (1):
      ARM: dts: dra7: Reduce cpu thermal shutdown temperature

Tony Lindgren (1):
      memory: omap-gpmc: Fix debug output for access width

 arch/arm/boot/dts/dra7-evm.dts                    | 2 ++
 arch/arm/boot/dts/dra7.dtsi                       | 4 ++++
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 6 +++---
 arch/arm/boot/dts/omap3-gta04.dtsi                | 3 ++-
 arch/arm/boot/dts/omap4-panda-a4.dts              | 2 +-
 arch/arm/boot/dts/omap4-panda-es.dts              | 2 +-
 drivers/memory/omap-gpmc.c                        | 2 +-
 7 files changed, 14 insertions(+), 7 deletions(-)
