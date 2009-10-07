From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v2.6.32-rc3
Date: Wed, 7 Oct 2009 11:51:12 -0700
Message-ID: <20091007185112.GJ7899@atomide.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit 374576a8b6f865022c0fd1ca62396889b23d66dd:
  Linus Torvalds (1):
        Linux 2.6.32-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Artem Bityutskiy (1):
      OMAP3: PM: introduce a new powerdomain walk helper

Daniel Walker (1):
      omap: iovmm: Add missing mutex_unlock

Hiroshi DOYU (1):
      omap: iovmm: Fix incorrect spelling

Jon Hunter (1):
      OMAP3: PM: Prevent hang in prcm_interrupt_handler

Kevin Hilman (1):
      OMAP3: PM: Enable GPIO module-level wakeups

Paul Walmsley (2):
      OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
      OMAP3: PM: PRCM interrupt: only handle selected PRCM interrupts

Rajendra Nayak (1):
      omap: Lock DPLL5 at boot

Sergio Aguirre (1):
      omapfb: Condition mutex acquisition

Tommi Rantala (2):
      omapfb: Blizzard: fix pointer to be const
      omapfb: Blizzard: constify register address tables

Tony Lindgren (2):
      omap: Fix incorrect 730 vs 850 detection
      Merge branch 'pm-fixes-32' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-fixes-for-linus

Vikram Pandita (1):
      OMAP3: PM: USBHOST: clear wakeup events on both hosts

ye janboe (1):
      omap: SRAM: flush the right address after memcpy in omap_sram_push

 arch/arm/mach-omap2/clock34xx.c               |   35 +++++
 arch/arm/mach-omap2/pm-debug.c                |    4 +-
 arch/arm/mach-omap2/pm34xx.c                  |  187 ++++++++++++++-----------
 arch/arm/mach-omap2/powerdomain.c             |   39 ++++--
 arch/arm/plat-omap/include/mach/cpu.h         |   37 ++---
 arch/arm/plat-omap/include/mach/powerdomain.h |    2 +
 arch/arm/plat-omap/iovmm.c                    |    9 +-
 arch/arm/plat-omap/sram.c                     |    3 +-
 drivers/video/omap/blizzard.c                 |   10 +-
 drivers/video/omap/omapfb_main.c              |   22 ++-
 10 files changed, 212 insertions(+), 136 deletions(-)
