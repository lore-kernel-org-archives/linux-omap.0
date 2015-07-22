From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] drop few more legacy boards for v4.3
Date: Wed, 22 Jul 2015 02:41:17 -0700
Message-ID: <37805.3809902214$1437558172@news.gmane.org>
References: <pull-1437549432-994499>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1437549432-994499>
In-Reply-To: <pull-1437549432-994499>
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

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/legacy-v2-signed

for you to fetch changes up to 7fcf7e061edd368fac7fe4841a7f9e54c83b3ec8:

  ARM: OMAP2+: Remove legacy booting support for Pandora (2015-07-16 04:12:32 -0700)

----------------------------------------------------------------
Drop more omap3 legacy board-*.c files for v4.3. This time we're
dropping the board files for omap3logic and omap3pandora.

The reason for dropping these now rather than later is that now
we can simply revert the patches in case of unexpected issues as
we are not dropping any platform data at this point.

This leaves us with only the following board-*.c files:

BOARD                   REASON NEEDED
board-ldp.c             Still used in RMKs boot test system
board-rx51-*.c          Needs /proc/atags support for user space

Once we have the n900 legacy user space issues sorted out for
/proc/atags and system_rev, we can drop the remaining two
board-*.c files. And then one merge window after that we can
drop the legacy booting support assuming no unexpected issues
are found.

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: OMAP2+: Remove legacy booting support for LogicPD Torpedo
      ARM: OMAP2+: Remove legacy booting support for Pandora

 arch/arm/mach-omap2/Kconfig              |  20 -
 arch/arm/mach-omap2/Makefile             |   3 -
 arch/arm/mach-omap2/board-omap3logic.c   | 249 ------------
 arch/arm/mach-omap2/board-omap3pandora.c | 633 -------------------------------
 4 files changed, 905 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-omap3logic.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3pandora.c
