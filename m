From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few minor fixes for omaps for v4.20-rc cycle
Date: Thu, 29 Nov 2018 11:03:07 -0800
Message-ID: <pull-1543518110-786840@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/fixes-rc4

for you to fetch changes up to 91e43395820baad80248987608216c35da9df65b:

  Merge branch 'fixes-dts' into omap-for-v4.20/fixes (2018-11-08 09:32:24 -0800)

----------------------------------------------------------------
Few minor fixes for omaps for v4.20-rc cycle

This set of fixes contains minor regression fixes for LogicPD dts files
for MMC pinctrl and interrupts. There is also one section annotation fix
that shows up with Clang, and a fix for an unitialized field for omap1.

----------------------------------------------------------------
Adam Ford (4):
      ARM: dts: am3517: Fix pinmuxing for CD on MMC1
      ARM: dts: LogicPD Torpedo: Fix mmc3_dat1 interrupt
      ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1
      ARM: dts: am3517-som: Fix WL127x Wifi interrupt

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Nathan Chancellor (1):
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

Tony Lindgren (1):
      Merge branch 'fixes-dts' into omap-for-v4.20/fixes

 arch/arm/boot/dts/am3517-evm.dts                  | 2 +-
 arch/arm/boot/dts/am3517-som.dtsi                 | 2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi             | 2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 2 +-
 arch/arm/mach-omap1/board-ams-delta.c             | 3 +++
 arch/arm/mach-omap2/prm44xx.c                     | 2 +-
 6 files changed, 8 insertions(+), 5 deletions(-)
