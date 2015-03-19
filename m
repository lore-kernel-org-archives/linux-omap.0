From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap legacy boot clean-up for v4.1
Date: Thu, 19 Mar 2015 16:14:01 -0700
Message-ID: <46679.9080292278$1426807247@news.gmane.org>
References: <pull-1426799683-420388>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1426799683-420388>
In-Reply-To: <pull-1426799683-420388>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/v4.1-legacy

for you to fetch changes up to 01ea0d4247bb3a224a66007e0a1291232c15d61a:

  ARM: OMAP2+: Remove legacy support for omap3 TouchBook (2015-03-16 17:07:26 -0700)

----------------------------------------------------------------
Drop three omap3 legacy board-*.c files

We want to get omap3 moved over to device tree only based booting.

These three board-*.c files seem to be inactive, so let's attempt
to drop them now rather than later. With these dropped, we have
omap3 device tree conversion status in a known state. Then we know
that we have .dts support for the remaining omap3 board-*.c files,
or it's being worked on.

By dropping these files now, we can simply revert them if really
needed for the next few merge cycles if we run into suprises.
Reverting things later on will not be so easily done.

----------------------------------------------------------------
Tony Lindgren (3):
      ARM: OMAP3: Remove legacy support for EMA-Tech Stalker board
      ARM: OMAP3: Remove legacy support for devkit8000
      ARM: OMAP2+: Remove legacy support for omap3 TouchBook

 arch/arm/mach-omap2/Kconfig                |  18 -
 arch/arm/mach-omap2/Makefile               |   4 -
 arch/arm/mach-omap2/board-devkit8000.c     | 654 -----------------------------
 arch/arm/mach-omap2/board-omap3stalker.c   | 433 -------------------
 arch/arm/mach-omap2/board-omap3touchbook.c | 395 -----------------
 5 files changed, 1504 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-devkit8000.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3stalker.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c
