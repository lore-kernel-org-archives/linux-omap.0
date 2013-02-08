From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: miscellaneous clock fixes for 3.9
Date: Fri, 8 Feb 2013 19:23:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081922440.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51077 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946830Ab3BHTXn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 14:23:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-e-for-3.9

for you to fetch changes up to b5596a89412053aa0e18b59f40dc3a3e53917937:

  Merge branch 'clock_misc_devel_a_3.9', remote-tracking branch 'remotes/pinchart/omap3isp/clock' into clock_devel_a_3.9 (2013-02-08 12:00:39 -0700)

- ----------------------------------------------------------------

Some miscellaneous OMAP2+ clock fixes, mostly related to the recent
common clock framework conversion.

Basic test logs are available here:

    http://www.pwsan.com/omap/testlogs/clock_devel_a_3.9/20130208120108/

- ----------------------------------------------------------------
vmlinux object size
(delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7)):
   text     data      bss    total  kernel
      0        0        0        0  am33xx_only
      0        0        0        0  n800_multi_omap2xxx
      0        0        0        0  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
      0        0        0        0  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
      0        0        0        0  omap2plus_defconfig_cpupm
      0        0        0        0  omap2plus_defconfig_no_pm
      0        0        0        0  omap2plus_defconfig_omap2_4_only
      0        0        0        0  omap2plus_defconfig_omap3_4_only
    +96        0      -96        0  rmk_omap3430_ldp_allnoconfig
    +32        0        0      +32  rmk_omap3430_ldp_oldconfig
    +96        0      -96        0  rmk_omap4430_sdp_allnoconfig
    +32        0        0      +32  rmk_omap4430_sdp_oldconfig


Afzal Mohammed (3):
      ARM: OMAP2+: dpll: am335x - avoid freqsel
      ARM: OMAP2+: clock data: add DEFINE_STRUCT_CLK_FLAGS helper
      ARM: OMAP AM33XX: clock data: SET_RATE_PARENT in lcd path

Laurent Pinchart (2):
      ARM: OMAP3: clock: Back-propagate rate change from cam_mclk to dpll4_m5
      omap3isp: Set cam_mclk rate directly

Paul Walmsley (1):
      Merge branch 'clock_misc_devel_a_3.9', remote-tracking branch 'remotes/pinchart/omap3isp/clock' into clock_devel_a_3.9

Rajendra Nayak (1):
      ARM: OMAP4: clock data: Add missing clkdm association for dpll_usb

 arch/arm/mach-omap2/cclock33xx_data.c |   10 ++++++----
 arch/arm/mach-omap2/cclock3xxx_data.c |   10 +++++++++-
 arch/arm/mach-omap2/cclock44xx_data.c |   13 ++++++++++++-
 arch/arm/mach-omap2/clock.h           |   11 +++++++++++
 arch/arm/mach-omap2/dpll3xxx.c        |    5 +++--
 drivers/media/platform/omap3isp/isp.c |   18 ++----------------
 drivers/media/platform/omap3isp/isp.h |    8 +++-----
 7 files changed, 46 insertions(+), 29 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFVBsAAoJEMePsQ0LvSpLt+AQAIV8Jno8rsTfMO2Fswen4KbY
UrWhWSJxl5U7Gs529cYEgvey63DnD4f1hMVDTl2szosB/JLa3K2/xuFSKcbr/ZPA
H3487iDJgov75wfg2s3nbB3fA2bObC6TeJBVWmz5AeIsZlp2ScCdsUSXHARMiTAZ
EsZ6Vmi238Y5Ho5SkWTq6P8Jq6ZwMQhA4SCWrzmJL8DfHDxZ/zk6lxUaWiZ2G31a
wkP8x+2gVVQEPsibh+oTaRFcxh8idI/JJ0B6QYisFLuojcRT9WCKOLEUqgBso0lS
k9AfPWZWdSkikTCsiZTUrIP7y5Fzcvq7hHRKrfySOVcb1mZqRXUqBFWLp472IRJY
lraqkYPq/lwyTOl9p8sd16GG7dbhWgqOjqRdmElG5QfrT13HoqpSOlUjduMG04/o
9cVu+k2e0YvhSGjBvxfDIX4a+DQ79OM5oob9XUI3Ws8FAWo20KhspGppP6zzQF+w
mdg4wa0y9C7OMouJuXfJ7Vrlg6OWUPsgRRrhKnIJ53aYr+DPG7VuxC2yI41qhM+8
lsIvqcKcTcfxIvYyTiwzMK6bSoA1l57L074KCWueBjrDoKaYOlBUaw8shfCwOfBR
xnyybR9WgqbC+Qdz6UiPIOYISQSvoNvdSzGCkHkhUXTBvVHZEFm65KTAKmRn2whJ
UsnfwMjcBUnnN3iIFSQu
=MPaC
-----END PGP SIGNATURE-----
