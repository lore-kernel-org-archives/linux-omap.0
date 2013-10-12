From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/6] omap non-urgent fixes for v3.13 merge window
Date: Fri, 11 Oct 2013 18:44:57 -0700
Message-ID: <10225.4580393948$1381542344@news.gmane.org>
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
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/fixes-not-urgent-signed

for you to fetch changes up to 8ff875e7f93e900e7a7e78f1c9c05a22b33c27cf:

  ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit declarations. (2013-10-08 11:04:22 -0700)

----------------------------------------------------------------
Fixes for omaps that were not considered urgent for the -rc series.
Just minor build fixes, removal of dead code, and a patch to
use the die ID for increasing boot time entropy.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: OMAP1: fix incorrect placement of __initdata tag

Linus Walleij (1):
      ARM: OMAP2+: throw the die id into the entropy pool

Majunath Goudar (1):
      ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit declarations.

Michael Opdenacker (1):
      ARM: OMAP: remove deprecated IRQF_DISABLED

 arch/arm/mach-omap1/common.h   |  3 +++
 arch/arm/mach-omap1/fpga.c     |  3 +--
 arch/arm/mach-omap1/gpio15xx.c |  8 ++++----
 arch/arm/mach-omap1/gpio16xx.c | 22 +++++++++++-----------
 arch/arm/mach-omap1/gpio7xx.c  | 30 +++++++++++++++---------------
 arch/arm/mach-omap1/pm.c       |  1 -
 arch/arm/mach-omap1/time.c     |  2 +-
 arch/arm/mach-omap1/timer32k.c |  2 +-
 arch/arm/mach-omap2/id.c       | 12 ++++++++++++
 arch/arm/mach-omap2/timer.c    |  2 +-
 arch/arm/plat-omap/dma.c       |  1 -
 11 files changed, 49 insertions(+), 37 deletions(-)
