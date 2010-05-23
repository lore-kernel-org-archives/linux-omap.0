From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/6] introduce generic OMAP SOC features
Date: Sat, 22 May 2010 22:36:33 -0500
Message-ID: <1274585799-16226-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42192 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754817Ab0EWDgx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 May 2010 23:36:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Senthilvadivu Gurusamy <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Vishwanath S <vishwa.s@ti.com>, linux-omap@vger.kernel.org

With OMAP4 we have the need to have SOC independent features
handling. This makes sense from a long run as other OMAP4
derivatives gets generated in parallel to OMAP3 generation
of chips.

Example usages:
	http://marc.info/?t=127376415000008&r=1&w=2
	http://marc.info/?t=127265012000008&r=1&w=2

This series attempts to introduce a framework which could
be used from OMAP1 onwards.

Caveat: this series just introduces the framework by reorganizing
the existing data, it does not attempt to define what the features
for OMAP1,2,3,4 would be. As usual, comments are welcome.

NOTE: Tested on OMAP3430, 3630, OMAP4. Requesting help to verify on
other platforms as well - OMAP1,2 etc..(only very limited change has
been done for these, expectation is for them to continue to function).

Nishanth Menon (6):
  omap1: rename check_revision
  omap2/3: id: fix sparse warning
  omap: generic: introduce a single check_revision
  omap: improve OMAP3_HAS_FEATURE
  omap: introduce OMAP_SHOW_FEATURE
  omap: move generic omap3 features to generic

 arch/arm/mach-omap1/id.c              |    2 +-
 arch/arm/mach-omap1/io.c              |    1 -
 arch/arm/mach-omap2/id.c              |   36 +++++++---------
 arch/arm/mach-omap2/io.c              |    2 +-
 arch/arm/plat-omap/common.c           |   14 ++++++
 arch/arm/plat-omap/include/plat/cpu.h |   72 ++++++++++++++++++++++-----------
 6 files changed, 80 insertions(+), 47 deletions(-)

scripts/bloat-o-meter vmlinux.master vmlinux
add/remove: 2/5 grow/shrink: 8/9 up/down: 1500/-1504 (-4)
function                                     old     new   delta
omap2_check_revision                         168    1528   +1360
omap_check_revision                            -      60     +60
ubifs_scan                                   632     676     +44
rd_load_image                               1340    1352     +12
test_hash                                   1088    1092      +4
omap_features                                  -       4      +4
in4_pton                                     360     364      +4
ieee80211_assoc_done                        1840    1844      +4
elf_core_dump                               3632    3636      +4
__posix_lock_file                           1264    1268      +4
ubifs_tnc_end_commit                        1468    1464      -4
nfs3_listxattr                               272     268      -4
jffs2_build_xattr_subsystem                 1428    1424      -4
generic_file_aio_read                       1692    1688      -4
do_task_stat                                1424    1420      -4
onenand_read_ops_nolock                     1016    1008      -8
musb_host_rx                                2672    2660     -12
arch_get_unmapped_area                       528     512     -16
scsi_io_completion                          1204    1184     -20
omap4_check_revision                         128       -    -128
omap3_check_features                         172       -    -172
omap24xx_check_revision                      252       -    -252
omap3_check_revision                         316       -    -316
omap3_cpuinfo                                560       -    -560

Cc: Tony Lindgren <tony@atomide.com>
Cc: Angelo Arrifano <miknix@gmail.com>
Cc: "Zebediah C. McClure" <zmc@lurian.net>
Cc: Alistair Buxton <a.j.buxton@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Senthilvadivu Gurusamy <svadivu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Cc: Vishwanath S <vishwa.s@ti.com>
Cc: linux-omap@vger.kernel.org

Regards,
Nishanth Menon
