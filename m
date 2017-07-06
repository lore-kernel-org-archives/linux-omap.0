From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.13 merge window
Date: Thu,  6 Jul 2017 02:08:27 -0700
Message-ID: <23672.6375333548$1505306212@news.gmane.org>
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

The following changes since commit 1df5eaa6bced2d8a9de305d4a5f587adf57ddf35:

  ARM: OMAP4: hwmod_data: add SHAM crypto accelerator (2017-06-14 00:53:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/fixes-merge-window

for you to fetch changes up to ff570a01b1bd15cf8a87c9ea774fc9c52ea07f15:

  ARM: dts: dra71-evm: mdio: Fix impedance values (2017-07-05 00:54:52 -0700)

----------------------------------------------------------------
Few fixes for omaps for issues found recently:

- Fix disable_irq related shared IRQ warnings for omap3 PRM

- Fix omap4 legacy code regression that accidentally removed code that
  we still need for PRM interrupts

- Fix dm8168-evm NAND pins and MMC write protect pin direction

- Fix dra71-evm mdio impedance values

----------------------------------------------------------------
Lokesh Vutla (1):
      ARM: dts: dra71-evm: mdio: Fix impedance values

Mihail Grigorov (1):
      ARM: dts: dm816x: Correct the state of the write protect pin

Tom Rini (1):
      ARM: dts: dm816x: Correct NAND support nodes

Tony Lindgren (2):
      ARM: OMAP2+: Fix omap3 prm shared irq
      ARM: OMAP4: Fix legacy code clean-up regression

 arch/arm/boot/dts/dm8168-evm.dts | 34 ++++++++++++++++++++++++-
 arch/arm/boot/dts/dm816x.dtsi    |  2 +-
 arch/arm/boot/dts/dra71-evm.dts  |  4 +--
 arch/arm/mach-omap2/pm34xx.c     |  1 -
 arch/arm/mach-omap2/prm3xxx.c    |  7 +----
 arch/arm/mach-omap2/prm44xx.c    | 55 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 11 deletions(-)
