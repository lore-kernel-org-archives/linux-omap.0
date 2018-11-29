From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] soc changes for omaps for v4.21
Date: Thu, 29 Nov 2018 11:57:40 -0800
Message-ID: <pull-1543521343-338334@atomide.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/soc-signed

for you to fetch changes up to b76455335447fa8b73ebc0ca768e46ee74fcd329:

  ARM: OMAP2+: timer: Remove obsolete inclusion of <asm/smp_twd.h> (2018-11-19 10:06:36 -0800)

----------------------------------------------------------------
SoC changes for omaps for v4.21 merge window

Few more non-critical section annotation fixes for Clang and
remove obsolete timer header inclusion.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: OMAP2+: timer: Remove obsolete inclusion of <asm/smp_twd.h>

Nathan Chancellor (2):
      ARM: OMAP2+: hwmod: Fix some section annotations
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

 arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
 arch/arm/mach-omap2/prm44xx.c    | 2 +-
 arch/arm/mach-omap2/timer.c      | 1 -
 3 files changed, 4 insertions(+), 5 deletions(-)
