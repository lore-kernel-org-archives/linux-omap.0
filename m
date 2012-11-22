From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod/PRM changes for 3.8
Date: Thu, 22 Nov 2012 00:17:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211220016160.32242@utopia.booyaka.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 558a0780b0a04862a678f7823215424b4e5501f9:

  Merge tag 'omap-cleanup-c-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/clock (2012-11-13 13:32:24 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.8

for you to fetch changes up to c567b0584c352e7f97ced003be46bed8581ddd5b:

  ARM: OMAP2+: omap_device: Correct resource handling for DT boot (2012-11-21 16:15:18 -0700)

- ----------------------------------------------------------------
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

- ----------------------------------------------------------------

vmlinux object size
(delta in bytes from TEST_ccf_558a0780_v3.7-rc
 (558a0780b0a04862a678f7823215424b4e5501f9)):
   text     data      bss    total  kernel
   +512     +256      +64     +832  am33xx_only
   +392     +248        0     +640  n800_multi_omap2xxx
   +392     +192        0     +584  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
   +756    +1256      +64    +2076  omap2plus_defconfig
   +480     +192      +32     +704  omap2plus_defconfig_2430sdp_only
   +756    +1288        0    +2044  omap2plus_defconfig_cpupm
   +756    +1296        0    +2052  omap2plus_defconfig_no_pm
   +728     +680      +64    +1472  omap2plus_defconfig_omap2_4_only
   +756     +752        0    +1508  omap2plus_defconfig_omap3_4_only
  +1128    +1212     -360    +1980  rmk_omap3430_ldp_allnoconfig
   +452     +568        0    +1020  rmk_omap3430_ldp_oldconfig
  +1128    +1212     -360    +1980  rmk_omap4430_sdp_allnoconfig
   +648     +632        0    +1280  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from TEST_ccf_558a0780_v3.7-rc (558a0780b0a04862a678f7823215424b4e5501f9))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2420n800       omap2plus_defconfig


Paul Walmsley (1):
      ARM: OMAP2+: PRM: initialize some PRM functions early

Peter Ujfalusi (2):
      ARM: OMAP2+: hwmod: Add possibility to count hwmod resources based on type
      ARM: OMAP2+: omap_device: Correct resource handling for DT boot

Rajendra Nayak (1):
      ARM: OMAP2+: hwmod: Add support for per hwmod/module context lost count

 arch/arm/mach-omap2/io.c          |    8 ++++
 arch/arm/mach-omap2/omap_device.c |   87 +++++++++++++++++++++++--------------
 arch/arm/mach-omap2/omap_hwmod.c  |   82 +++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/omap_hwmod.h  |   12 +++--
 arch/arm/mach-omap2/prm.h         |   11 ++++-
 arch/arm/mach-omap2/prm2xxx.c     |    3 +-
 arch/arm/mach-omap2/prm2xxx.h     |    3 +-
 arch/arm/mach-omap2/prm3xxx.c     |   17 +++++---
 arch/arm/mach-omap2/prm3xxx.h     |    1 +
 arch/arm/mach-omap2/prm44xx.c     |   49 ++++++++++++++++++---
 arch/arm/mach-omap2/prm44xx.h     |    1 +
 arch/arm/mach-omap2/prm_common.c  |   45 +++++++++++++++++++
 12 files changed, 249 insertions(+), 70 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrW7FAAoJEMePsQ0LvSpLA5MP/jQd3a19hhtFbUJZcTcpjDyS
56NfrigTTGKg4dvLugP9UZdL3mt6ePFLTQR+BZex5uXnRsmDyRQ5A2lqNPeqFlfY
kUWptsDAm2/sLdNEgbXutv1OFNnhWchTCvkkQsO4DIN8G15j0vQt2OcG8TnuUMLt
+hLkqstZU5QqAafMFUh0mHPHdanCoHFxFD1ugx54c9Nw2uTFagZgEFe06c0qSmJp
MIZuu1D1VTbhoY7GKIqC7WfJob9wremFI7i/D+WpGhkQ5KA9WLzzz/LW3mlZOg64
MMKABnRSP0UHDdAWqmXykqXjdG0d9JR+Dnv78y0m2NskM+6nRePoC34YTMO1i2cF
d18IeAv26ZnvncwSFNrvBGBkqx6IYtvFm9BwK47n8SuUuQJQWTtkrA6spcIbuWZ4
TS/U88gF3etgp7SrzyTRLjR1wlN3HfMZ7+ksBGbY0R86oBy16dkVRZsaFvSBZ8pV
pPK152FGTrjvrUlDktBiNZo9G860vS4Ma/uP7HAgnfd0ovTVNikneNouxa42OPed
WBaRUxTkniqeGtB2uzbfRHMud9BTw8OeCVUKTAOjkwINO+rFwC/P7Jey7csdraZ3
OeD8wBKmxRXaWRT5k68e8GA50fjTmhGk4iVqGAyNSJ/PLLQl8iCERp+PV2mbNcg2
1u+JRzyxSyqDEWIKrdMW
=gLWA
-----END PGP SIGNATURE-----
