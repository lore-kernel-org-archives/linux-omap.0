From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap late prcm changes for v3.8 merge window
Date: Mon, 26 Nov 2012 17:06:12 -0800
Message-ID: <E1Td9dE-0007rM-Ui@merlin.infradead.org>
References: <pull-1353978372-642963>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1353978372-642963>
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

The following changes since commit 558a0780b0a04862a678f7823215424b4e5501f9:

  Merge tag 'omap-cleanup-c-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/clock (2012-11-13 13:32:24 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/devel-prcm-signed

for you to fetch changes up to 8b9c1ac2e11a9fb3a5a8860fb7570ff7633aa7f7:

  Merge tag 'omap-devel-a-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/devel-pcrm (2012-11-26 12:32:50 -0800)

----------------------------------------------------------------

omap prcm changes via Paul Walmsley <paul@pwsan.com>:

Some miscellaneous OMAP hwmod changes for 3.8, along with a PRM
change needed for one of the hwmod patches to function.

Basic test logs for this branch on top of Tony's
omap-for-v3.8/clock branch at commit
558a0780b0a04862a678f7823215424b4e5501f9 are here:

http://www.pwsan.com/omap/testlogs/hwmod_devel_a_3.8/20121121161522/

However, omap-for-v3.8/clock at 558a0780 does not include some fixes
that are needed for a successful test.  With several reverts,
fixes, and workarounds applied, the following test logs were
obtained:

http://www.pwsan.com/omap/testlogs/TEST_hwmod_devel_a_3.8/20121121162719/

which indicate that the series tests cleanly.

----------------------------------------------------------------
Paul Walmsley (1):
      ARM: OMAP2+: PRM: initialize some PRM functions early

Peter Ujfalusi (2):
      ARM: OMAP2+: hwmod: Add possibility to count hwmod resources based on type
      ARM: OMAP2+: omap_device: Correct resource handling for DT boot

Rajendra Nayak (1):
      ARM: OMAP2+: hwmod: Add support for per hwmod/module context lost count

Tony Lindgren (1):
      Merge tag 'omap-devel-a-for-3.8' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.8/devel-pcrm

 arch/arm/mach-omap2/io.c          |  8 ++++
 arch/arm/mach-omap2/omap_device.c | 87 +++++++++++++++++++++++++--------------
 arch/arm/mach-omap2/omap_hwmod.c  | 82 +++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/omap_hwmod.h  | 12 ++++--
 arch/arm/mach-omap2/prm.h         | 11 ++++-
 arch/arm/mach-omap2/prm2xxx.c     |  3 +-
 arch/arm/mach-omap2/prm2xxx.h     |  3 +-
 arch/arm/mach-omap2/prm3xxx.c     | 17 ++++----
 arch/arm/mach-omap2/prm3xxx.h     |  1 +
 arch/arm/mach-omap2/prm44xx.c     | 49 ++++++++++++++++++----
 arch/arm/mach-omap2/prm44xx.h     |  1 +
 arch/arm/mach-omap2/prm_common.c  | 45 ++++++++++++++++++++
 12 files changed, 249 insertions(+), 70 deletions(-)
