From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/7] omap gpmc cleanup for v3.7 merge window
Date: Thu, 13 Sep 2012 19:34:10 -0700
Message-ID: <E1TCLkJ-0006Xh-Kg@merlin.infradead.org>
References: <pull-1347590052-683636>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1347590052-683636>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-gpmc-fixed-for-v3.7

for you to fetch changes up to 5c4684557b7e37afd42fa35f420f2f28bfb75442:

  mtd: nand: omap2: use gpmc provided irqs (2012-08-30 12:53:24 -0700)

----------------------------------------------------------------
Changes for GPMC (General Purpose Memory Controller) that take it
closer for being just a regular device driver.

----------------------------------------------------------------
Afzal Mohammed (10):
      ARM: OMAP2+: gpmc: update nand register helper
      ARM: OMAP2+: gpmc-nand: update gpmc-nand regs
      mtd: nand: omap2: handle nand on gpmc
      ARM: OMAP2+: gpmc-nand: update resource with memory
      ARM: OMAP2+: gpmc-onenand: provide memory as resource
      mtd: nand: omap2: obtain memory from resource
      mtd: onenand: omap2: obtain memory from resource
      ARM: OMAP2+: gpmc: Modify interrupt handling
      ARM: OMAP2+: gpmc-nand: Modify Interrupt handling
      mtd: nand: omap2: use gpmc provided irqs

 arch/arm/mach-omap2/gpmc-nand.c        |   28 ++-
 arch/arm/mach-omap2/gpmc-onenand.c     |   23 ++-
 arch/arm/mach-omap2/gpmc.c             |  156 +++++++++++++++--
 arch/arm/plat-omap/include/plat/gpmc.h |   19 ++
 arch/arm/plat-omap/include/plat/nand.h |    2 +-
 drivers/mtd/nand/omap2.c               |  301 ++++++++++++++++++++++++--------
 drivers/mtd/onenand/omap2.c            |   29 +--
 7 files changed, 445 insertions(+), 113 deletions(-)
