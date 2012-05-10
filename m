From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/10] more omap soc clean-up for v3.5 merge window
Date: Thu, 10 May 2012 11:39:17 -0700
Message-ID: <E1SSYHK-0005f3-Ni@merlin.infradead.org>
References: <pull-1336675159-747052>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1336675159-747052>
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

The following changes since commit b2f44dc29bfab77b10f3a709f14677f51ce3a4cd:

  ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditionally (2012-05-09 11:21:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-renames-for-v3.5

for you to fetch changes up to bb6abcf440c4c861a2131c0651b683dbd2edba84:

  ARM: OMAP2+: Kconfig: convert SOC_OMAPAM33XX to SOC_AM33XX (2012-05-10 11:10:07 -0700)

----------------------------------------------------------------
Simplify some SoC config options before things get too unreadable.

Note that this depends on a fix in omap-fixes-non-critical-for-v3.5,
so it's based on that.

----------------------------------------------------------------
Kevin Hilman (2):
      ARM: OMAP2+: Kconfig: convert SOC_OMAPTI81XX to SOC_TI81XX
      ARM: OMAP2+: Kconfig: convert SOC_OMAPAM33XX to SOC_AM33XX

 arch/arm/mach-omap2/Kconfig     |    8 ++++----
 arch/arm/mach-omap2/common.h    |    4 ++--
 arch/arm/mach-omap2/io.c        |    8 ++++----
 arch/arm/mach-omap2/irq.c       |    2 +-
 drivers/net/ethernet/ti/Kconfig |    2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)
