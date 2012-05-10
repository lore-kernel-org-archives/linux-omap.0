From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 8/10] omap timer cleanup for v3.5 merge window
Date: Thu, 10 May 2012 11:39:19 -0700
Message-ID: <E1SSYJ1-0006UJ-Ec@merlin.infradead.org>
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

The following changes since commit bfd17879866b36e95c58721da070d9f2ac7f8901:

  Merge tag 'omap-devel-c-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-hwmod-data (2012-05-09 09:58:42 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-timer-for-v3.5

for you to fetch changes up to 1fe97c8f6a1de67a5f56e029a818903d5bed8017:

  ARM: OMAP: Make OMAP clocksource source selection using kernel param (2012-05-09 10:07:05 -0700)

----------------------------------------------------------------
Timer changes to make it easier to support various SoCs

----------------------------------------------------------------
Vaibhav Hiremath (3):
      ARM: OMAP1: Add checks for possible error condition in timer_init
      ARM: OMAP2+: Replace space with underscore in the name field of system timers
      ARM: OMAP: Make OMAP clocksource source selection using kernel param

 arch/arm/mach-omap1/common.h             |    9 ++-
 arch/arm/mach-omap1/time.c               |   16 +---
 arch/arm/mach-omap1/timer32k.c           |   28 ++++++-
 arch/arm/mach-omap2/timer.c              |  118 +++++++++++++++++++++++-------
 arch/arm/plat-omap/counter_32k.c         |   91 ++++++++++-------------
 arch/arm/plat-omap/include/plat/common.h |    2 +-
 6 files changed, 166 insertions(+), 98 deletions(-)
