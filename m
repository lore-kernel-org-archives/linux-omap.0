From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few omap fixes for v5.5-rc cycle
Date: Tue,  7 Jan 2020 09:29:41 -0800
Message-ID: <pull-1578418121-413328@atomide.com>
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
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit e709ed70d122e94cb426b1e1f905829eae19a009:

  bus: ti-sysc: Fix missing reset delay handling (2019-12-12 08:20:10 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.5/fixes-rc5

for you to fetch changes up to 03729cfa0d543bc996bf959e762ec999afc8f3d2:

  soc: ti: wkup_m3_ipc: Fix race condition with rproc_boot (2019-12-17 15:18:36 -0800)

----------------------------------------------------------------
Fixes for omaps for v5.5-rc cycle

Here are few fixes for v5.5-rc cycle:

- Two corner case fixes related to ti-sysc driver clock issues

- Fixes for am57xx dts for pcie gpios

- Beagle-x15 regulator dts fix

- Fix for wkup_m3_ipc driver race

----------------------------------------------------------------
Dave Gerlach (1):
      soc: ti: wkup_m3_ipc: Fix race condition with rproc_boot

Kishon Vijay Abraham I (3):
      ARM: dts: am57xx-beagle-x15/am57xx-idk: Remove "gpios" for  endpoint dt nodes
      ARM: dts: am571x-idk: Fix gpios property to have the correct  gpio number
      ARM: dts: beagle-x15-common: Model 5V0 regulator

Tony Lindgren (2):
      ARM: OMAP2+: Fix ti_sysc_find_one_clockdomain to check for to_clk_hw_omap
      bus: ti-sysc: Fix iterating over clocks

 arch/arm/boot/dts/am571x-idk.dts                |  6 +-----
 arch/arm/boot/dts/am572x-idk-common.dtsi        |  4 ----
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 25 +++++++++++++++++++++----
 arch/arm/mach-omap2/pdata-quirks.c              |  6 +++++-
 drivers/bus/ti-sysc.c                           | 10 ++++++++--
 drivers/soc/ti/wkup_m3_ipc.c                    |  4 ++--
 6 files changed, 37 insertions(+), 18 deletions(-)
