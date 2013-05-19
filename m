From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod/serial: fix DT case
Date: Sun, 19 May 2013 23:33:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1305192331390.2656@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43984 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679Ab3ESXde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 May 2013 19:33:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a-for-3.10-rc

for you to fetch changes up to 3260c76055afc6c9396e5ad9f9e599505ea8891f:

  ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis (2013-05-19 16:37:15 -0600)

- ----------------------------------------------------------------
Fix the OMAP serial driver to work correctly on OMAP4 when booting
with DT.

Basic build, boot, and PM test logs are here - unfortunately, not for
the DT case yet:

http://www.pwsan.com/omap/testlogs/uart_idle_fix_v3.10-rc/20130519164010/

- ----------------------------------------------------------------
Rajendra Nayak (2):
      ARM: OMAP2+: hwmod: Fix sidle programming in _enable_sysc()/_idle_sysc()
      ARM: OMAP2+: hwmod: Add a new flag to handle SIDLE in SWSUP only in active

Santosh Shilimkar (4):
      ARM: OMAP2+: hwmod-data: UART IP needs software control to manage sidle modes
      ARM: OMAP2+: serial: Remove the un-used slave idle hooks
      SERIAL: OMAP: Remove the slave idle handling from the driver
      ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis

 arch/arm/mach-omap2/omap_hwmod.c                   |  111 +++++---------------
 arch/arm/mach-omap2/omap_hwmod.h                   |    7 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +-
 arch/arm/mach-omap2/serial.c                       |   31 ------
 drivers/tty/serial/omap-serial.c                   |   23 ----
 include/linux/platform_data/serial-omap.h          |    2 -
 9 files changed, 48 insertions(+), 145 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRmWDGAAoJEMePsQ0LvSpLdIQQAKz+lypLDtGQ3ub62W+1jn6m
z8Et8mLAtdzPU5VFl5ow6Wr2ohFPqoFnK2I2bX1QJZUAyPfZVYRWY/vaapu29/FN
xpRxwrjlGP2jUHjUgOtHjtAywIChHmb+1i6w2YrMZqyYZ9vsXZSKDLSnAZpfgaFJ
Z0LxTARCF5TQZYo/vedzyQBLek5v7THYiAbwhaZa08mO+qO2oZMnnYgBax/4VCEg
ZcJBfEloB6W2re8p1JNqz1w/irbytPiaYJuMj1HHolM4MOgqGML+n4EYsZ61O3Pz
ZGtrLPoafPV0n1snJdAWadifWG4fDO7y1y1tD4sxR586AsRLIOZxNKhQ+8WMUoym
c6aeLmFtPjQF9L7DjawXASRav2yyldhQnhwGPHZ7woz62Ah54SoHQ2qg4UblLOfB
0BvPe9J/4PthoZV/gjeFOMoa/3Qe+DOV0PSn8WuhhD1CBnNyEj49I40RPmBB1sab
FhTPWZRiRX5ShFLrwhXrcCtUu73fhH3aOGHYtg96Pv4m2pcd63pNucENqotHxoXK
LEyBTg60XD24rpzDMeOfUqrX9mByzqX+1B96IQQ5czU0nE+LOugQ6738GMDhvXM+
0n0m7lRcCF1SHwUveoGgtGQ3N8nix6F28Ei+YXFGOu/Kgs3O5cwN1OjaVVwNrSDA
5YklPSOrg1rhK1WxoRFw
=OI73
-----END PGP SIGNATURE-----
