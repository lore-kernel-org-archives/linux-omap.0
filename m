From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] soc changes for omap variants for v5.4
Date: Wed, 28 Aug 2019 11:34:49 -0700
Message-ID: <pull-1567016893-318461@atomide.com>
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

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.4/soc-signed

for you to fetch changes up to 50f57ef83d836d727902a6a7e70cca61b0d02655:

  ARM: OMAP2+: Delete an unnecessary kfree() call in omap_hsmmc_pdata_init() (2019-08-26 08:59:48 -0700)

----------------------------------------------------------------
SoC changes for omap variants for v5.4

The first change moves platform-specific asm-offsets.h to arch/arm/mach-omap2
to fix iessu with parallel build with CONFIG_IKHEADERS, and the second change
removes a useless kfree.

Note that the first change causes a trivial merge conflict with the iommu
changes for arch/arm/mach-omap2/Makefile.

----------------------------------------------------------------
Markus Elfring (1):
      ARM: OMAP2+: Delete an unnecessary kfree() call in omap_hsmmc_pdata_init()

Masahiro Yamada (1):
      ARM: OMAP2+: move platform-specific asm-offset.h to arch/arm/mach-omap2

 arch/arm/mach-omap2/.gitignore  | 1 +
 arch/arm/mach-omap2/Makefile    | 5 +++--
 arch/arm/mach-omap2/hsmmc.c     | 4 +---
 arch/arm/mach-omap2/sleep33xx.S | 2 +-
 arch/arm/mach-omap2/sleep43xx.S | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-omap2/.gitignore
