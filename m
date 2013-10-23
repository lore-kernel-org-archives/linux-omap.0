From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/4] omap late clock and system control module cleanup for
 v3.13 merge window
Date: Wed, 23 Oct 2013 07:36:42 -0700
Message-ID: <E1VYzZ1-0008NO-No@merlin.infradead.org>
References: <pull-1382539003-174282>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1382539003-174282>
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

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/cm-scm-cleanup-signed

for you to fetch changes up to 54b89756a14aa1043507ce0811b4b6c02c5dddcc:

  Merge tag 'for-v3.13/cm-scm-cleanup-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.13/cm-scm-cleanup (2013-10-20 08:55:19 -0700)

----------------------------------------------------------------

Via Paul Walmsley <paul@pwsan.com>:

Move some of the OMAP2+ CM and System Control Module direct
register accesses into CM- and System Control
Module-specific "drivers" underneath arch/arm/mach-omap2/.  This
is a prerequisite for moving this code out of arch/arm/mach-omap2/ into
drivers/.

Basic test logs are available here:

http://www.pwsan.com/omap/testlogs/cm_scm_cleanup_a_v3.13/20131019101809/

----------------------------------------------------------------
Tero Kristo (5):
      ARM: OMAP2: CM/PM: remove direct register accesses outside CM code
      ARM: OMAP3: clock: add API to enable/disable autoidle for a single clock
      ARM: OMAP3: McBSP: do not access CM register directly
      ARM: OMAP3: CM/control: move CM scratchpad save to CM driver
      ARM: OMAP3: control: add API for setting IVA bootmode

Tony Lindgren (1):
      Merge tag 'for-v3.13/cm-scm-cleanup-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.13/cm-scm-cleanup

 arch/arm/mach-omap2/clkt2xxx_apll.c          |  4 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      | 11 ++---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c | 24 +++-------
 arch/arm/mach-omap2/clock.c                  | 38 ++++++++++++++++
 arch/arm/mach-omap2/clock.h                  |  2 +
 arch/arm/mach-omap2/cm2xxx.c                 | 67 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm2xxx.h                 |  8 ++++
 arch/arm/mach-omap2/cm3xxx.c                 | 22 +++++++++
 arch/arm/mach-omap2/cm3xxx.h                 |  1 +
 arch/arm/mach-omap2/control.c                | 54 +++++++---------------
 arch/arm/mach-omap2/control.h                |  1 +
 arch/arm/mach-omap2/mcbsp.c                  | 16 +++----
 arch/arm/mach-omap2/pm24xx.c                 | 24 +---------
 arch/arm/mach-omap2/pm34xx.c                 |  3 +-
 14 files changed, 177 insertions(+), 98 deletions(-)
