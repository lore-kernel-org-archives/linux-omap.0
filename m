From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap arch timer late changes for v3.7 merge window
Date: Mon, 24 Sep 2012 14:25:52 -0700
Message-ID: <E1TGGAY-0000Fg-TQ@merlin.infradead.org>
References: <pull-1348521952-285145>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1348521952-285145>
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

The following changes since commit 3fe05bd9980df7207a35b4841a94dc2875e86960:

  Merge tag 'v3.6-rc6' into devel-dt (2012-09-24 11:42:13 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/devel-dt-arch-timer-for-v3.7

for you to fetch changes up to ef8fe6fee16f178cd80cf11b21565bca95b80182:

  Merge branch 'devel-dt-arch-timer' into devel-dt (2012-09-24 11:42:24 -0700)

----------------------------------------------------------------

Few late patches to enable arch timer for omap5
using device tree.

----------------------------------------------------------------
Santosh Shilimkar (2):
      ARM: OMAP: Add initialisation for the real-time counter.
      ARM: OMAP5: Enable arch timer support

Tony Lindgren (2):
      Merge branch 'for_3.7/omap5_arch_timer' of git://github.com/SantoshShilimkar/linux into devel-dt-arch-timer
      Merge branch 'devel-dt-arch-timer' into devel-dt

 arch/arm/boot/dts/omap5.dtsi |   12 ++++++
 arch/arm/mach-omap2/Kconfig  |    5 +++
 arch/arm/mach-omap2/timer.c  |   97 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 113 insertions(+), 1 deletion(-)
