From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.6-rc1
Date: Fri, 1 Apr 2016 09:01:15 -0700
Message-ID: <20160401160115.GM9329@atomide.com>
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

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/fixes-rc1

for you to fetch changes up to 6f40fed1c911f218e1e189a404b26ef19effabb5:

  ARM: dts: am335x-baltos-ir5221: fix cpsw_emac0 link type (2016-03-30 14:33:22 -0700)

----------------------------------------------------------------
Fixes for omaps against v4.6-rc1. Mostly minor fixes for the newer
SoCs with few board fixes and a fix for a long time hwmod bug:

- Fix cpsw_emac0 link type for baltos-ir5221

- Fix interrupt type for TWD

- Fix edma memcpy channel allocation for am43x

- Fix am43x-epos sycntimer32k by using the correct assigned clock

- Fix interconnect barrier for dra7

- Fix a long time hwmod bug for updating sysconfig register properly

- Fix flakey booting on dm814x where USB reset needs a delay

And there is one minor change that is not strictly a fix, but is
good to have for proper hardware detection:

- Detect dra7 silicon revision 2.0 properly

----------------------------------------------------------------
Jon Hunter (1):
      ARM: OMAP: Correct interrupt type for ARM TWD

Lokesh Vutla (2):
      ARM: OMAP2+: hwmod: Fix updating of sysconfig register
      ARM: dts: AM43x-epos: Fix clk parent for synctimer

Nishanth Menon (1):
      ARM: OMAP2: Fix up interconnect barrier initialization for DRA7

Tero Kristo (1):
      ARM: dts: am43xx: fix edma memcpy channel allocation

Tony Lindgren (2):
      ARM: OMAP2+: Use srst_udelay for USB on dm814x
      Merge tag 'for-v4.6-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.6/fixes

Vishal Mahaveer (1):
      ARM: DRA722: Add ID detect for Silicon Rev 2.0

Yegor Yefremov (1):
      ARM: dts: am335x-baltos-ir5221: fix cpsw_emac0 link type

 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 5 ++++-
 arch/arm/boot/dts/am4372.dtsi              | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts       | 5 +++++
 arch/arm/boot/dts/omap4.dtsi               | 2 +-
 arch/arm/mach-omap2/id.c                   | 4 ++--
 arch/arm/mach-omap2/io.c                   | 1 +
 arch/arm/mach-omap2/omap_hwmod.c           | 8 ++++----
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 2 ++
 arch/arm/mach-omap2/soc.h                  | 1 +
 9 files changed, 21 insertions(+), 9 deletions(-)
