From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] soc changes for omaps for v4.14
Date: Tue, 15 Aug 2017 09:52:23 -0700
Message-ID: <39512.7597301782$1505308698@news.gmane.org>
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

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/soc-signed

for you to fetch changes up to 3af6ccc3d1b167c14fd195341092073820361de1:

  ARM: OMAP: dra7: powerdomain data: Register SoC specific powerdomains (2017-08-14 10:33:29 -0700)

----------------------------------------------------------------
SoC updates for omaps for v4.14. Most of the chages are to add
support for new dra762 SoC. The other changes are are for legacy
DMA code removal, and MMC quirk and iodelay config for dra7.

----------------------------------------------------------------
Kishon Vijay Abraham I (1):
      ARM: OMAP2+: Select PINCTRL_TI_IODELAY for SOC_DRA7XX

Lokesh Vutla (5):
      ARM: OMAP2+: board-generic: add support for dra762 family
      ARM: dra762: Add support for device identification
      ARM: dra7: hwmod: Register dra76x specific hwmod
      ARM: dra762: Enable SMP for dra762
      ARM: OMAP: dra7: powerdomain data: Register SoC specific powerdomains

Sekhar Nori (1):
      ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM

Tony Lindgren (1):
      ARM: OMAP2+: Remove unused legacy code for DMA

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/board-generic.c                |   1 +
 arch/arm/mach-omap2/dma.c                          | 148 +--------------------
 arch/arm/mach-omap2/id.c                           |   9 ++
 arch/arm/mach-omap2/omap-smp.c                     |   4 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  11 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |  31 +++++
 arch/arm/mach-omap2/powerdomains7xx_data.c         |  33 ++++-
 arch/arm/mach-omap2/soc.h                          |   5 +
 include/linux/platform_data/hsmmc-omap.h           |   3 +
 11 files changed, 101 insertions(+), 148 deletions(-)
