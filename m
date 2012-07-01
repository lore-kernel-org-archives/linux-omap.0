From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/6] omap PM changes for PRCM I/O chain wakeup and cpuidle
 for v3.6 merge window
Date: Sun, 1 Jul 2012 02:01:17 -0700
Message-ID: <E1SlGJB-0004Dl-Dd@merlin.infradead.org>
References: <pull-1341133277-501333>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1341133277-501333>
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

The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-pm-for-v3.6

for you to fetch changes up to d660e9b92b44f113c3fc345a8ce66ffa56a3506f:

  ARM: OMAP2+: PM: fix IRQ_NOAUTOEN removal by mis-merge (2012-06-29 07:19:52 -0700)

----------------------------------------------------------------
Here are some omap PM changes that reimplement omap PRCM I/O chain
code for wake-ups, and improve idle latencies for cpuidle.

----------------------------------------------------------------
Jean Pihet (3):
      ARM: OMAP3: PM: cpuidle: default to C1 in next_valid_state
      ARM: OMAP3: PM: cpuidle: optimize the PER latency in C1 state
      ARM: OMAP3: PM: cpuidle: optimize the clkdm idle latency in C1 state

Kevin Hilman (5):
      ARM: OMAP2+: PRM: fix compile for OMAP4-only build
      ARM: OMAP2+: powerdomain: allow pre/post transtion to be per pwrdm
      ARM: OMAP3: PM: call pre/post transition per powerdomain
      ARM: OMAP3: PM: cleanup cam_pwrdm leftovers
      ARM: OMAP2+: PM: fix IRQ_NOAUTOEN removal by mis-merge

Mohan V (1):
      ARM: OMAP3: PM: correct enable/disable of daisy io chain

Rajendra Nayak (1):
      ARM: OMAP4: PRM: Add IO Daisychain support

Tero Kristo (1):
      ARM: OMAP3+: PRM: Enable IO wake up

Tony Lindgren (2):
      Merge tag 'omap-devel-c-for-3.6' of git://git.kernel.org/.../pjw/omap-pending into devel-pm
      Merge branch 'for_3.6/pm/performance' of git://git.kernel.org/.../khilman/linux-omap-pm into devel-pm

Vishwanath BS (3):
      ARM: OMAP3: PM: Move IO Daisychain function to omap3 prm file
      ARM: OMAP3PLUS: hwmod: reconfigure IO Daisychain during hwmod mux
      ARM: OMAP3: PM: Remove IO Daisychain control from cpuidle

 arch/arm/mach-omap2/cpuidle34xx.c         |   71 +++++++++++------------------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c          |   38 ++++++++++++++-
 arch/arm/mach-omap2/pm34xx.c              |   63 ++++++-------------------
 arch/arm/mach-omap2/powerdomain.c         |   16 +++++--
 arch/arm/mach-omap2/powerdomain.h         |    4 +-
 arch/arm/mach-omap2/prcm-common.h         |    8 ++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c        |   48 +++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h        |    6 ++-
 arch/arm/mach-omap2/prm44xx.c             |   63 ++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm44xx.h             |    2 +
 11 files changed, 216 insertions(+), 107 deletions(-)
