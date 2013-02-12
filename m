From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/5] am33xx related late changes for v3.8 merge window
Date: Tue, 12 Feb 2013 10:11:01 -0800
Message-ID: <E1U5KK8-0003lf-2K@merlin.infradead.org>
References: <pull-1360692662-889112>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1360692662-889112>
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

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/am33xx-signed

for you to fetch changes up to 3ad4a33158b7a2589149bc5ab29a6723d755c4ba:

  Merge tag 'omap-devel-a-for-3.9' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.9/am33xx (2013-02-09 19:55:41 -0800)

----------------------------------------------------------------

am33xx updates via Paul Walmsley <paul@pwsan.com>:

Fixes and IP block support for the TI AM33xx family of SoCs.  These
are prerequisites for power management and some PWM driver changes.

Basic test logs are available from:

   http://www.pwsan.com/omap/testlogs/am33xx_fixes_a_3.9/20130208084835/

although it must be noted that I am unable to test these patches on
AM33xx due to an unknown problem with v3.8-rc kernels:

   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg83525.html

----------------------------------------------------------------
Hebbar Gururaja (2):
      ARM: OMAP2+: AM33xx: hwmod: add missing HWMOD_NO_IDLEST flags
      ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check" bug

Philip Avinash (2):
      ARM: OMAP: AM33xx hwmod: Corrects PWM subsystem HWMOD entries
      ARM: OMAP: AM33xx hwmod: Add parent-child relationship for PWM subsystem

Tony Lindgren (1):
      Merge tag 'omap-devel-a-for-3.9' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.9/am33xx

Vaibhav Bedia (8):
      ARM: OMAP2+: AM33XX: CM: Get rid of unnecessary header inclusions
      ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__ macros in header files
      ARM: OMAP2+: AM33XX: hwmod: Register OCMC RAM hwmod
      ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with the right flags
      ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod entry
      ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod with reset status bit
      ARM: OMAP2+: AM33XX: Update the hardreset API
      ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3

 arch/arm/boot/dts/am33xx.dtsi              |  14 +
 arch/arm/mach-omap2/cm33xx.c               |   3 -
 arch/arm/mach-omap2/cm33xx.h               |   9 +-
 arch/arm/mach-omap2/omap_hwmod.c           |   5 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 443 ++++++++++++++++++-----------
 arch/arm/mach-omap2/prm33xx.c              |  11 +-
 arch/arm/mach-omap2/prm33xx.h              |   4 +-
 7 files changed, 306 insertions(+), 183 deletions(-)
