From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap timer changes for v3.10 merge window
Date: Thu, 4 Apr 2013 12:39:55 -0700
Message-ID: <E1UNq1A-0001f6-2L@merlin.infradead.org>
References: <pull-1365104396-577667>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1365104396-577667>
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

The following changes since commit 43231b5be657fde1c4ced180d829bbd59ceef9ad:

  Merge commit '7185684' into omap-for-v3.10/timer (2013-04-03 10:32:47 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/timer-signed

for you to fetch changes up to 7f585bbfc54fec9dcf387fd2edb2d6f4908badf8:

  Merge branch 'omap-timer-for-v3.10' of git://github.com/jonhunter/linux into omap-for-v3.10/timer (2013-04-03 10:47:59 -0700)

----------------------------------------------------------------

Clean-up for omap2+ timers from Jon Hunter <jon-hunter@ti.com>:

This series consists mainly of clean-ups for clockevents and
clocksource timers on OMAP2+ devices. The most significant change
in functionality comes from the 5th patch which is changing the
selection of the clocksource timer for OMAP3 and AM335x devices
when gptimers are used for clocksource.

Note that this series depends on 7185684 (ARM: OMAP: use
consistent error checking) in RMK's tree and 960cba6 (ARM:
OMAP5: timer: Update the clocksource name as per clock data)
in omap-for-v3.10/fixes-non-critical. So this branch is based
on a merge of 7185684 and omap-for-v3.10/fixes-non-critical
to avoid non-trivial merge conflicts.

----------------------------------------------------------------
Jon Hunter (8):
      Merge commit '6bb27d7349db51b50c40534710fe164ca0d58902' into omap-timer-for-v3.10
      ARM: OMAP2+: Display correct system timer name
      ARM: OMAP2+: Remove hard-coded test on timer ID
      ARM: OMAP2+: Simplify system timer clock definitions
      ARM: OMAP2+: Simplify system timers definitions
      ARM: OMAP3: Update clocksource timer selection
      ARM: OMAP2+: Store ID of system timers in timer structure
      ARM: OMAP4+: Fix sparse warning in system timers

Tony Lindgren (1):
      Merge branch 'omap-timer-for-v3.10' of git://github.com/jonhunter/linux into omap-for-v3.10/timer

 arch/arm/mach-omap2/board-cm-t3517.c |   2 +-
 arch/arm/mach-omap2/board-generic.c  |   2 +-
 arch/arm/mach-omap2/common.h         |   3 +-
 arch/arm/mach-omap2/timer.c          | 124 ++++++++++++++++++-----------------
 4 files changed, 66 insertions(+), 65 deletions(-)
