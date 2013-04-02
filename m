From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap cleanup for v3.10 merge window
Date: Tue, 2 Apr 2013 10:29:10 -0700
Message-ID: <E1UN51T-0001nO-Kt@merlin.infradead.org>
References: <pull-1364923751-842943>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1364923751-842943>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/cleanup-v2-signed

for you to fetch changes up to c309f7f46167e85d1aae2fd31f23e7d2b5cdfbe0:

  Merge branch 'for_3.10/omap_generic_cleanup_v2' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux into omap-for-v3.10/cleanup-v2 (2013-03-28 14:45:31 -0700)

----------------------------------------------------------------

Clean up related changes for v3.10 merge window.
Mostly clock and PM related with removal of now unused
DMA channel definitions. The clock change to use SoC
specific lists will make it a little bit easier to
add support for new SoCs variants without having to patch
all over the place.

----------------------------------------------------------------
J Keerthy (1):
      ARM: OMAP2+: clock data: Remove CK_* flags

Jarkko Nikula (2):
      ARM: OMAP1: Remove unused DMA channel definitions
      ARM: OMAP2+: Remove unused DMA channel definitions

Santosh Shilimkar (8):
      ARM: OMAP2+: PM: Remove bogus fiq_[enable/disable] tuple
      ARM: OMAP4+: Remove the un-necessary cache flush from hotplug code
      ARM: OMAP4+: Remove un-necessary cacheflush in secondary CPU boot path
      ARM: OMAP4+: Remove out of placed smp_wmb() in secondary wakeup code
      ARM: OMAP4+: Move the CPU wakeup prepare code under smp_prepare_cpus()
      ARM: OMAP4: PM: Remove L4 wakeup depedency with MPU since errata fix exist now
      ARM: OMAP4: PM: Now remove L4 per clockdomain static depedency with MPU
      ARM: OMAP4: Fix the init code to have OMAP4460 errata available in DT build

Tero Kristo (1):
      ARM: OMAP4+: Use common scratchpad SAR RAM offsets for all architectures

Tony Lindgren (2):
      Merge tag 'omap-cleanup-a-for-3.10' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.10/cleanup
      Merge branch 'for_3.10/omap_generic_cleanup_v2' of git://git.kernel.org/.../ssantosh/linux into omap-for-v3.10/cleanup-v2

 arch/arm/mach-omap1/dma.h              |  41 --
 arch/arm/mach-omap2/cclock2420_data.c  | 283 +++++++-------
 arch/arm/mach-omap2/cclock2430_data.c  | 311 ++++++++-------
 arch/arm/mach-omap2/cclock33xx_data.c  | 165 ++++----
 arch/arm/mach-omap2/cclock3xxx_data.c  | 685 ++++++++++++++++++---------------
 arch/arm/mach-omap2/cclock44xx_data.c  | 515 ++++++++++++-------------
 arch/arm/mach-omap2/clock.c            |  17 +-
 arch/arm/mach-omap2/clock.h            |  20 +-
 arch/arm/mach-omap2/cpuidle34xx.c      |   3 -
 arch/arm/mach-omap2/cpuidle44xx.c      |   7 -
 arch/arm/mach-omap2/dma.h              |  70 ----
 arch/arm/mach-omap2/omap-hotplug.c     |   6 -
 arch/arm/mach-omap2/omap-smp.c         |  57 +--
 arch/arm/mach-omap2/omap4-common.c     |  16 +
 arch/arm/mach-omap2/omap4-sar-layout.h |  14 +-
 arch/arm/mach-omap2/pm24xx.c           |  11 +-
 arch/arm/mach-omap2/pm34xx.c           |   9 +-
 arch/arm/mach-omap2/pm44xx.c           |  20 +-
 18 files changed, 1059 insertions(+), 1191 deletions(-)
