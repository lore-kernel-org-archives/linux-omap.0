From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] two omap fixes for v4.17-rc cycle
Date: Fri, 20 Apr 2018 10:41:02 -0700
Message-ID: <pull-1524246008-227018@atomide.com>
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

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/fixes-signed

for you to fetch changes up to fb289e3ab10c16834741bb02be740fa9d025fde0:

  Merge branch 'omap-for-v4.17/fixes-ti-sysc' into omap-for-v4.17/fixes (2018-04-19 15:48:46 -0700)

----------------------------------------------------------------
Two fixes for v4.17-rc cycle

Fix a build regression with split object directories reported by Russell
and fix range sizes for omap4 cm2 and prm modules.

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP2+: Fix build when using split object directories

Tony Lindgren (2):
      ARM: dts: Fix cm2 and prm sizes for omap4
      Merge branch 'omap-for-v4.17/fixes-ti-sysc' into omap-for-v4.17/fixes

 arch/arm/boot/dts/omap4.dtsi         |  8 ++--
 arch/arm/mach-omap2/Makefile         |  6 +--
 arch/arm/mach-omap2/pm-asm-offsets.c |  3 ++
 arch/arm/mach-omap2/sleep33xx.S      |  1 -
 arch/arm/mach-omap2/sleep43xx.S      |  1 -
 drivers/memory/emif-asm-offsets.c    | 72 +---------------------------------
 include/linux/ti-emif-sram.h         | 75 ++++++++++++++++++++++++++++++++++++
 7 files changed, 84 insertions(+), 82 deletions(-)
