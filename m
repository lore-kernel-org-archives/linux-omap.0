From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap soc chages for v4.18 merge window
Date: Mon, 21 May 2018 12:41:31 -0700
Message-ID: <pull-1526925630-789198@atomide.com-2>
References: <pull-1526925630-789198@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1526925630-789198@atomide.com>
In-Reply-To: <pull-1526925630-789198@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/soc-signed

for you to fetch changes up to 3bb3799cd4233b7c24622ae8c41455fb27a55c0f:

  Merge branch 'omap-for-v4.18/soc-fixes' into omap-for-v4.18/soc (2018-05-21 10:34:17 -0700)

----------------------------------------------------------------
SoC changes for omap variants for v4.18 merge window

This series mostly adds saving of power and clock domain registers for
am335x/am437x suspend to RTC only mode. There is also a non-urgent fix
for omap4 PM where we could end up losing GPIO interrupts if bootloader
has LOGICRETSTATE cleared for domains. And there is a clean-up patch for
omap1 to use device properties for at24 eeprom.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      ARM: omap1: osk: use device properties for at24 eeprom

Dave Gerlach (1):
      ARM: OMAP2+: prm44xx: Introduce context save/restore for am43 PRCM IO

Keerthy (3):
      ARM: OMAP2+: clockdomain: Inroduce cpu_pm notifiers for context save/restore
      ARM: OMAP2+: powerdomain: Introduce cpu_pm notifiers for context save/restore
      ARM: OMAP2+: prm44xx: Inroduce cpu_pm notifiers for context save/restore

Russ Dill (2):
      ARM: OMAP2+: Add functions to save and restore clockdomain context en-masse.
      ARM: OMAP2+: Add functions to save and restore powerdomain context

Tony Lindgren (2):
      ARM: OMAP2+: Make sure LOGICRETSTATE bits are not cleared
      Merge branch 'omap-for-v4.18/soc-fixes' into omap-for-v4.18/soc

 arch/arm/mach-omap1/board-osk.c   |  10 ++--
 arch/arm/mach-omap2/clockdomain.c |  73 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomain.h |   8 +++
 arch/arm/mach-omap2/cm33xx.c      |  53 +++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.c  |  43 ++++++++++++++++
 arch/arm/mach-omap2/pm44xx.c      |  13 +++++
 arch/arm/mach-omap2/powerdomain.c |  87 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |   7 +++
 arch/arm/mach-omap2/prm33xx.c     |  31 ++++++++++++
 arch/arm/mach-omap2/prm44xx.c     | 104 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 424 insertions(+), 5 deletions(-)
