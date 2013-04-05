From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v3 0/4] ARM: OMAP4+: PM: Consolidate code for re-use on OMAP5
Date: Fri, 5 Apr 2013 18:28:59 +0530
Message-ID: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: khilman@deeprootsystems.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Kevin,

As discussed on list, I split the v2 [1] series into cleanup and OMAP5 support.
This series contains the clean-up patches. I have rebased on top of Tony's
pull request and your 3.10/* branches. Series is tested on OMAP4430 SDP
with CPUIDLE and suspend. OMAP5 PM support I will post later since it has
a dependency with OMAP5 data files which are not pulled in yet.

Regards,
Santosh
[1] http://www.spinics.net/lists/linux-omap/msg88901.html


The following changes since commit 4b9ce8484d8122f2088cedf60265ae86f7822350:

  Merge branch 'for_3.10/fixes/pm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into for_3.10/omap_pm-cleanup (2013-04-05 18:10:34 +0530)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git 

for you to fetch changes up to 884ef029cb434aad124bf8413211a698597f8f7a:

  ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support (2013-04-05 18:11:06 +0530)

----------------------------------------------------------------

Santosh Shilimkar (4):
  ARM: OMAP4+: PM: Consolidate MPU subsystem PM code for re-use
  ARM: OMAP4+: PM: Consolidate OMAP4 PM code to re-use it for OMAP5
  ARM: OMAP4+: Make secondary_startup function name more consistent
  ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support

 arch/arm/mach-omap2/Makefile                       |    9 +--
 arch/arm/mach-omap2/common.h                       |    4 +-
 arch/arm/mach-omap2/cpuidle44xx.c                  |   31 ++++-----
 arch/arm/mach-omap2/omap-headsmp.S                 |    8 +--
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |   68 ++++++++++++++++----
 arch/arm/mach-omap2/omap-smp.c                     |    6 +-
 arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c}   |   58 ++++++++++++++---
 .../mach-omap2/{sleep44xx.S => sleep_omap4plus.S}  |    0
 8 files changed, 132 insertions(+), 52 deletions(-)
 rename arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c} (83%)
 rename arch/arm/mach-omap2/{sleep44xx.S => sleep_omap4plus.S} (100%)

-- 
1.7.9.5
