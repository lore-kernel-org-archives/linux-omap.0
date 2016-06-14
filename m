From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.7-rc cycle
Date: Tue, 14 Jun 2016 01:11:02 -0700
Message-ID: <20160614081101.GV22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:

  Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/fixes-powedomain

for you to fetch changes up to 6b41d44862e8f3a4b95102c6ff6cad3fccc7994b:

  ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_mem_ret (2016-06-13 01:04:01 -0700)

----------------------------------------------------------------
Fixes for omaps for v4.7-rc cycle:

- Fix dra7 for hardware issues limiting L4Per and L3init power domains
  to on state. Without this the devices may not work correctly after
  some time of use because of asymmetric aging. And related to this,
  let's also remove the unusable states.

- Always select omap interconnect for am43x as otherwise the am43x
  only configurations will not boot properly. This can happen easily
  for any product kernels that leave out other SoCs to save memory.

- Fix DSS PLL2 addresses that have gone unused for now

- Select erratum 430973 for omap3, this is now safe to do and can
  save quite a bit of debugging time for people who may have left
  it out.

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP2+: Select OMAP_INTERCONNECT for SOC_AM43XX

Nishanth Menon (4):
      ARM: OMAP2: Enable Errata 430973 for OMAP3
      ARM: OMAP: DRA7: powerdomain data: Set L3init and L4per to ON
      ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_logic_ret
      ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_mem_ret

Tomi Valkeinen (1):
      ARM: dts: DRA74x: fix DSS PLL2 addresses

 arch/arm/boot/dts/dra74x.dtsi              |  4 +-
 arch/arm/mach-omap2/Kconfig                |  2 +
 arch/arm/mach-omap2/powerdomains7xx_data.c | 76 +-----------------------------
 3 files changed, 6 insertions(+), 76 deletions(-)
