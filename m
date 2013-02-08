From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: clean up and standardize WFI handling for
 3.9
Date: Fri, 8 Feb 2013 17:27:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081726480.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50473 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946785Ab3BHR1n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 12:27:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-for-3.9

for you to fetch changes up to 814a18a5d026464f56b3616704b985f9942b29a6:

  ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC active (2013-02-06 13:48:56 -0700)

- ----------------------------------------------------------------
On OMAP2+ devices, standardize and clean up WFI entry and WFI blocking.

Basic test logs are available here:

   http://www.pwsan.com/omap/testlogs/wfi_devel_a_3.9/20130208085027/

- ----------------------------------------------------------------
vmlinux object size
(delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7)):
   text     data      bss    total  kernel
    +64        0        0      +64  am33xx_only
    -64        0        0      -64  n800_multi_omap2xxx
    -64        0        0      -64  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
    -40       +8        0      -32  omap2plus_defconfig
    -64        0        0      -64  omap2plus_defconfig_2430sdp_only
    -40       +8        0      -32  omap2plus_defconfig_cpupm
   -104       +8        0      -96  omap2plus_defconfig_no_pm
    -40       +8        0      -32  omap2plus_defconfig_omap2_4_only
    +64        0        0      +64  omap2plus_defconfig_omap3_4_only
   -116       +8      +44      -64  rmk_omap3430_ldp_allnoconfig
    +64        0        0      +64  rmk_omap3430_ldp_oldconfig
   -116       +8      +44      -64  rmk_omap4430_sdp_allnoconfig
    +64        0        0      +64  rmk_omap4430_sdp_oldconfig


Paul Walmsley (4):
      ARM: OMAP2xxx: PM: enter WFI via inline asm if CORE stays active
      ARM: OMAP2+: hwmod: add support for blocking WFI when a device is active
      ARM: OMAP2420: hwmod data/PM: use hwmod to block WFI when I2C active
      ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC active

 arch/arm/mach-omap2/omap_hwmod.c           |    8 ++++++++
 arch/arm/mach-omap2/omap_hwmod.h           |    9 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 ++++++-
 arch/arm/mach-omap2/pm24xx.c               |   23 +++++------------------
 arch/arm/mach-omap2/sleep24xx.S            |   19 -------------------
 6 files changed, 34 insertions(+), 39 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFTVMAAoJEMePsQ0LvSpLIFgP/0jbDcII8oox7kf2QrNrgtZq
2OXWuO6r8QNzIV0/YsZXhGWtpqOPjt64nkirgo0uo5jYnbKjSeels5o1rlz1wlSe
o+GVZ6K+F1bHqEK8F1dLLrss1WbtnewTrDG8Fmm0KcXk6TJENZIuk55A0gn2fLN1
iIpKoD4sw2l45fWaZokn7Ka6wPmKXvxWX+u1Rsyj5k9jCNoTUQxGg8LOPnhaw1s+
LG9u9RulRm5WRPIKL69/5/H+fCxUgStvaIbX/+WYyVb39noqzgd0OGysE1US2KGS
XMD7EFz3W1fQPpShrZym8wnG1O4ZSbNo93GGa70Y5xolFmrAu9uG5yjx8XSFQEOC
zyWRbWNeePj5HmttrsizPEt+Lqi3jZo+0gF/6cLgfCET2nq0NuQxJTmdhT/rhWLv
+idhr2f34XdokTVU4zpjT+tnUdnAFPIQPrcMmwPF2+fs92KdO1RoSq+sHkEaFvwN
Wo8TPXxhRK4QRT8sSMBNg1HLiLFKz5nHDfzWokH5OEfByoEzSwYa79N1ORfSo84+
grg+PewKe/wuQtRAR6mwe2xvaGVmtJKdflSasc2D1FXKiPtdajT8p5MqxM3nZ1o5
8EzXiEF5iIYAW+RQhGBFt10ruHZWMWMpqjBk6CjU+O6G12qE3aF5qiexawQkU0Ew
rp2PD3gzB1QITrtsBhxV
=ejwV
-----END PGP SIGNATURE-----
