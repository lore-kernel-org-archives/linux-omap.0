From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] dts changes for omaps for v4.21
Date: Thu, 29 Nov 2018 11:57:42 -0800
Message-ID: <pull-1543521343-338334@atomide.com-3>
References: <pull-1543521343-338334@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1543521343-338334@atomide.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/dt-signed

for you to fetch changes up to 0ec47be539e323ef4919fd63ea2f4162bf74892e:

  ARM: dts: am437x-gp-evm: Add sleep state for beeper pins (2018-11-19 10:32:43 -0800)

----------------------------------------------------------------
Device tree changes for omaps for v4.21 merge window

These changes mostly configure pinctrl for am437x-gp-evm. There is
also non-critical fix for a comment for Clang, and we enable earlycon
for am3517-evm.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: am3517-evm: Enable earlycon stdout path

Dave Gerlach (5):
      ARM: dts: am437x-gp-evm: Add state for ddr3 vtt toggle pin
      ARM: dts: am437x-gp-evm: Add pinctrl for unused_pins
      ARM: dts: am437x-gp-evm: Add pinctrl for debugss pins
      ARM: dts: am437x-gp-evm: Add uart0 pinctrl default and sleep states
      ARM: dts: am437x-gp-evm: Add pinmux for gpio0 wake

Keerthy (1):
      ARM: dts: am437x-gp-evm: Add sleep state for beeper pins

Nathan Chancellor (1):
      ARM: dts: omap3-gta04: Fix comment block

 arch/arm/boot/dts/am3517-evm.dts    |   4 ++
 arch/arm/boot/dts/am437x-gp-evm.dts | 127 +++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/omap3-gta04.dtsi  |   2 +-
 3 files changed, 122 insertions(+), 11 deletions(-)
