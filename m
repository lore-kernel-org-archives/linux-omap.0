From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/5] am33xx data for v3.6 merge window
Date: Tue, 10 Jul 2012 06:05:56 -0700
Message-ID: <E1SoaA9-0001Je-6V@merlin.infradead.org>
References: <pull-1341925556-888624>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1341925556-888624>
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

The following changes since commit ecc46cfdad7499a21296f0757059c4965f1fbc98:

  ARM: OMAP2+: Remove unnecessary ifdef around __omap2_set_globals (2012-07-05 08:05:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-am33xx-data-for-v3.6

for you to fetch changes up to 79ab2664336d73245023a236345bb31f2b0a2dfe:

  Merge tag 'omap-devel-e-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-am33xx-data (2012-07-05 08:18:04 -0700)

----------------------------------------------------------------

This branch adds clock data for am33xx. Note that eventually these
will use the common clock framework, but those patches are not quite
ready yet for omaps. This branch depends on omap-cleanup-part2-for-v3.6
branch.

----------------------------------------------------------------
Paul Walmsley (1):
      ARM: OMAP3+: clock: Move common clksel_rate & clock data to common file

Tony Lindgren (1):
      Merge tag 'omap-devel-e-for-3.5' of git://git.kernel.org/.../pjw/omap-pending into devel-am33xx-data

Vaibhav Hiremath (1):
      ARM: OMAP3+: clock33xx: Add AM33XX clock tree data

 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/clock.h                   |   14 +
 arch/arm/mach-omap2/clock33xx_data.c          | 1105 +++++++++++++++++++++++++
 arch/arm/mach-omap2/clock3xxx_data.c          |   20 +-
 arch/arm/mach-omap2/clock44xx_data.c          |   72 --
 arch/arm/mach-omap2/clock_common_data.c       |   77 ++
 arch/arm/mach-omap2/io.c                      |    2 +
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 8 files changed, 1204 insertions(+), 88 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock33xx_data.c
