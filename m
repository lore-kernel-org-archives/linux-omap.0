From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] fixes for omaps for v5.1-rc cycle
Date: Thu,  4 Apr 2019 14:53:36 -0700
Message-ID: <pull-1554414783-873154@atomide.com>
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

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/fixes-signed

for you to fetch changes up to 81717283cf2c4c4d9bf8fd618cd6e5bdfe082edd:

  Merge commit '7d56bedb2730dc2ea8abf0fd7240ee99ecfee3c9' into omap-for-v5.1/fixes (2019-04-01 09:36:25 -0700)

----------------------------------------------------------------
Fixes for omaps for v5.1-rc cycle

Few small fixes for omap variants:

- Fix ams-delta gpio IDs

- Add missing of_node_put for omapdss platform init code

- Fix unconfigured audio regulators for two am335x boards

- Fix use of wrong offset for am335x d_can clocks

----------------------------------------------------------------
Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation

Julia Lawall (1):
      ARM: OMAP2+: add missing of_node_put after of_device_is_available

Peter Ujfalusi (2):
      ARM: dts: am335x-evm: Correct the regulators for the audio codec
      ARM: dts: am335x-evmsk: Correct the regulators for the audio codec

Tony Lindgren (2):
      ARM: dts: Fix dcan clkctrl clock for am3
      Merge commit '7d56bedb2730dc2ea8abf0fd7240ee99ecfee3c9' into omap-for-v5.1/fixes

 arch/arm/boot/dts/am335x-evm.dts      | 26 ++++++++++++++++++++++----
 arch/arm/boot/dts/am335x-evmsk.dts    | 26 ++++++++++++++++++++++----
 arch/arm/boot/dts/am33xx-l4.dtsi      |  4 ++--
 arch/arm/mach-omap1/board-ams-delta.c |  2 ++
 arch/arm/mach-omap2/display.c         |  4 +++-
 5 files changed, 51 insertions(+), 11 deletions(-)
