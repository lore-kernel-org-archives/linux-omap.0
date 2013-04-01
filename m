From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: PRCM fixes for 3.10
Date: Mon, 1 Apr 2013 10:43:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304011042310.28273@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39312 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758177Ab3DAKno (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 06:43:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-for-3.10

for you to fetch changes up to 469d633d20c774ecd34ac615c838193e1e150c62:

  ARM: OMAP: dpll: enable bypass clock only when attempting dpll bypass (2013-03-31 20:43:06 -0600)

- ----------------------------------------------------------------
Some miscellaneous OMAP hwmod, powerdomain, and clock fixes for 3.10.

Basic test logs are here:

http://www.pwsan.com/omap/testlogs/prcm_fixes_a_3.10/20130331205716/

- ----------------------------------------------------------------
vmlinux object size
(delta in bytes from test_v3.9-rc5 (07961ac7c0ee8b546658717034fe692fd12eefa9)):
   text     data      bss    total  kernel
    -36       +8        0      -28  n800_multi_omap2xxx
     -4       +8        0       +4  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
    +76      +56        0     +132  omap2plus_defconfig
    +76      +16        0      +92  omap2plus_defconfig_cpupm
    +76      +80        0     +156  omap2plus_defconfig_no_pm
    +60        0        0      +60  omap2plus_defconfig_omap2_4_only
    +80      +80        0     +160  omap2plus_defconfig_omap3_4_only
    +44      +56        0     +100  rmk_omap3430_ldp_allnoconfig
    +48      +16        0      +64  rmk_omap3430_ldp_oldconfig
    +44      +56        0     +100  rmk_omap4430_sdp_allnoconfig
    +16      +16        0      +32  rmk_omap4430_sdp_oldconfig


Paul Walmsley (1):
      ARM: OMAP2+: powerdomain: avoid testing whether an unsigned char is less than 0

Rajendra Nayak (2):
      ARM: OMAP2+: hwmod: Remove unused _HWMOD_WAKEUP_ENABLED flag
      ARM: OMAP: dpll: enable bypass clock only when attempting dpll bypass

Vaibhav Hiremath (2):
      ARM: OMAP2+: AM33xx: hwmod: Add missing sysc definition to wdt1 entry
      ARM: OMAP2+: am335x: Change the wdt1 func clk src to per_32k clk

 arch/arm/mach-omap2/cclock33xx_data.c      |    8 ++++++++
 arch/arm/mach-omap2/dpll3xxx.c             |   19 +++++++++----------
 arch/arm/mach-omap2/omap_hwmod.c           |    4 ----
 arch/arm/mach-omap2/omap_hwmod.h           |    6 ++----
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   15 +++++++++++++++
 arch/arm/mach-omap2/powerdomain.c          |   18 ++++++++----------
 6 files changed, 42 insertions(+), 28 deletions(-)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRWWSNAAoJEMePsQ0LvSpLMB4P/RzdRMcPLkFBrJaG76uXXmRg
yFHJnaS8nQ5obtpu0yzmgznEhuhU9I4DpmIcqaoiAIFO55jPvsWDK1RkQaJpWzou
8DERbYURBELN33iVpChakTLmCzt9spPYqs2F0Eg9h08CpJWlhsIFj1SqRk57Ze8A
3eY/ayqpDTiRbUKzy/PocpUmbT+kwoXNZFNuguM8WQnbVlFKCC8OTVvm3K9iCGCr
30gF+RKAhbNtOMPpruJodBKkld+8rnUx/lOsvDudCs5ggszw7Kb8x4KyLRwZct1j
zQAp2We4OKluHYZjPUV1ewAQBuD0YbVJM0A7wpDU6avY4Glf849uOhx+3ScCfVR5
E+9HwpBPfDQlVzPIRhick0LaDAmPtj+68n6r+J9FBTUUTONfJDDu9jDAPPt2qn7P
fg8YUiB6tmRInx4lkxfqNuhfHUH96zc+ffQLwNJ1YDFGV460Ltk2j57ienhO/UhX
WDAB8b147rsw/dXcF2YlR6b3UjO5vILbO/eJkEPIMCsUXx7WMX729MNp9q+Hskiv
DpULnXTd3P4T7dj99/rKlhcHQ2rT9fJ2kM7tPss71j87MvihrPecxCnA/4H401p3
YQf1Mt1EpBPPodhOIiOl9TgqslIZno+R0hSDtO1th/ZuZTPrTG/KKeMqau45WYkr
iv4uHjsjFYjgvAhMV43J
=z+VJ
-----END PGP SIGNATURE-----
