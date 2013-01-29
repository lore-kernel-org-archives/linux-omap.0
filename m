From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: first set of clock and device integration
 cleanups for 3.9
Date: Tue, 29 Jan 2013 22:35:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301292234440.11442@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41058 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab3A2Wfd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jan 2013 17:35:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-a-for-3.9

for you to fetch changes up to aff2f7d90fc6553aa309db2a635d8e5d70d84916:

  ARM: OMAP2420: hwmod data/PM: use hwmod to block WFI when I2C active (2013-01-26 01:42:33 -0700)

- ----------------------------------------------------------------
Remove some dead OMAP clock and device integration code and data.
Also, clean up the way that the OMAP device integration code blocks
WFI/WFE to use a consistent mechanism, controlled by a data flag.

Basic test logs for this branch are here:

   http://www.pwsan.com/omap/testlogs/cleanup_a_3.9/20130126014242/

- ----------------------------------------------------------------

vmlinux object size
(delta in bytes from test_v3.8-rc5 (949db153b6466c6f7cad5a427ecea94985927311)):
   text     data      bss    total  kernel
  -1502       +8        0    -1494  am33xx_only
  -1574     -664        0    -2238  n800_multi_omap2xxx
  -1574     -344        0    -1918  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
  -5702    -6200        0   -11902  omap2plus_defconfig
  -5586     -320        0    -5906  omap2plus_defconfig_2430sdp_only
  -5706    -6208        0   -11914  omap2plus_defconfig_cpupm
  -1546    -6200        0    -7746  omap2plus_defconfig_no_pm
  -5670    -6200        0   -11870  omap2plus_defconfig_omap2_4_only
 -13830    -5624        0   -19454  omap2plus_defconfig_omap3_4_only
  -2164    -6216     +600    -7780  rmk_omap3430_ldp_allnoconfig
  -1538      -64        0    -1602  rmk_omap3430_ldp_oldconfig
  -2164    -6216     +600    -7780  rmk_omap4430_sdp_allnoconfig
  -1526    -5640      -64    -7230  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.8-rc5 (949db153b6466c6f7cad5a427ecea94985927311))
  avail  rsrvd   high  freed  board          kconfig
    16k   -16k      .      .  2430sdp        omap2plus_defconfig
    16k   -16k      .      .  3530es3beagle  omap2plus_defconfig
    16k   -16k      .      .  3730beaglexm   omap2plus_defconfig
    16k   -16k      .      .  37xxevm        omap2plus_defconfig
    16k   -16k      .      .  4430es2panda   omap2plus_defconfig
    16k   -16k      .      .  4460pandaes    omap2plus_defconfig
    16k   -16k      .      .  cmt3517        omap2plus_defconfig

Paul Walmsley (6):
      ARM: OMAP2+: omap_device: remove obsolete pm_lats and early_device code
      ARM: OMAP4: clock/hwmod data: start to remove some IP block control "clocks"
      ARM: OMAP4: clock/hwmod data: remove MODULEMODE entries in mux + gate combos
      ARM: OMAP2xxx: clock data: clean up unused null clocks
      ARM: OMAP2+: hwmod: add support for blocking WFI when a device is active
      ARM: OMAP2420: hwmod data/PM: use hwmod to block WFI when I2C active

 arch/arm/mach-omap2/am35xx-emac.c          |    2 +-
 arch/arm/mach-omap2/cclock2420_data.c      |   16 +-
 arch/arm/mach-omap2/cclock2430_data.c      |   16 +-
 arch/arm/mach-omap2/cclock44xx_data.c      |  578 ++++++----------------------
 arch/arm/mach-omap2/devices.c              |   25 +-
 arch/arm/mach-omap2/display.c              |    2 +-
 arch/arm/mach-omap2/dma.c                  |    2 +-
 arch/arm/mach-omap2/drm.c                  |    3 +-
 arch/arm/mach-omap2/gpio.c                 |    3 +-
 arch/arm/mach-omap2/gpmc.c                 |    2 +-
 arch/arm/mach-omap2/hdq1w.c                |    2 +-
 arch/arm/mach-omap2/hsmmc.c                |    2 +-
 arch/arm/mach-omap2/hwspinlock.c           |    3 +-
 arch/arm/mach-omap2/i2c.c                  |    3 +-
 arch/arm/mach-omap2/mcbsp.c                |    2 +-
 arch/arm/mach-omap2/msdi.c                 |    2 +-
 arch/arm/mach-omap2/omap-iommu.c           |    3 +-
 arch/arm/mach-omap2/omap_device.c          |  537 +++-----------------------
 arch/arm/mach-omap2/omap_device.h          |   79 +---
 arch/arm/mach-omap2/omap_hwmod.c           |    8 +
 arch/arm/mach-omap2/omap_hwmod.h           |    9 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    7 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   99 +++--
 arch/arm/mach-omap2/pm.c                   |    4 +-
 arch/arm/mach-omap2/pm24xx.c               |   13 -
 arch/arm/mach-omap2/pmu.c                  |    3 +-
 arch/arm/mach-omap2/serial.c               |    3 +-
 arch/arm/mach-omap2/sr_device.c            |    3 +-
 arch/arm/mach-omap2/timer.c                |    3 +-
 arch/arm/mach-omap2/usb-host.c             |   16 +-
 arch/arm/mach-omap2/usb-musb.c             |    2 +-
 arch/arm/mach-omap2/wd_timer.c             |    3 +-
 32 files changed, 292 insertions(+), 1163 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCE54AAoJEMePsQ0LvSpLMQkP/35hjU9fAf/6SZk8NUNffUaP
nRGVW34v9wbsT8tkcEQzIRiGUGeQXqOk0wczHJEf0daxmkZgzIWr/hjU9z3kUnDf
QIan3CU0YvfcQOXR9PYR7ZB2Zz2HFxySkUy99ioriWjSUE3ff0CdLNq/fB7TEeLc
2D/ourAzRfqJdCs49tGK9qbLUVEtmLDbS5+dN1KmldunZ6bvhhNtuYs72RQ+kWN0
9WkCmJYVNYS8dTg6uZi2rBSStfYJkUJ1IDjtnBe6815KiZ3q2G21KTJUrywqd324
iASZ2cnUVzFsNdWNGBHMQvWW/SmlbP7F4pimlfyd8rDHUv0K3KZEW110AB8nMpAz
XzvuseiA+OWteTa2GLrsQJg8/wx5yAYZBkgyia2Vp1o79nfgOZ54X5LsZcyuOS/w
jALgJJi2zAsqjNWpmt7BCGlCOfRQOu1I67rN6K6JdO1j66Nnc8MfpV6npds2hsH5
xArNIlj95q2frQwlC5tVvXGTpY0lJZmAz0R9eAMZ3PFF08VTSdmUCdgTK5SNUIWO
2ITee1s9BxbJxJir7YKI8c/sW5FS/oeERn6p9nR0LUWX+9+raWdx/wcZfoRRSshe
d2odyViDuHiUbE2zKK513Sikb1XNrE5A5kB+40M011BEv3DjSWXv6opbfNNsB1eF
fCuBsikVIJ+PWykLJt1F
=bbcC
-----END PGP SIGNATURE-----
