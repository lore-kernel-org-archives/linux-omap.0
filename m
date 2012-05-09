From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: some hwmod data additions for 3.5
Date: Tue, 8 May 2012 18:33:31 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205081831500.28088@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42652 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab2EIAdc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 20:33:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

this pull request is for some hwmod data additions for v3.5.  It
is based on top of the commits in the omap-devel-b-for-3.5 tag.

Boot-tested on 5912OSK, N800, 2430SDP, 3517EVM, CM-T3517, 3530ES3
BeagleBoard, 37xx EVM, and 4430ES2 PandaBoard.  (Note that 3517EVM and
CM-T3517 don't boot fully to userspace due to issues with the EMAC
code and board files that are unrelated to this series.)  Static
suspend and dynamic idle to CSWR and OFF have been lightly tested on
3530ES3 BeagleBoard, 37xx EVM.  Static suspend and dynamic idle
have been lightly tested on 4430ES2 PandaBoard.  (Note that
4430ES2 Pandaboard has a UART driver-related dynamic idle issue that
is unrelated to this series.)  Boot and test logs are available at:

http://www.pwsan.com/omap/bootlogs/20120508/hwmod_data_devel_a_3.5__2db1bc2c9249950daa652ac94d677a21b4fe2f50/

object size (delta in bytes from prcm_devel_a_3.5 (0135f6a04642c192bdf4b36e06937d3387e174ff)):
 text 	 data 	  bss 	total 	kernel
    0 	    0 	    0 	    0 	5912osk_testconfig/vmlinux
 +420 	+1024 	    0 	+1444 	n800_multi_omap2xxx/vmlinux
 +452 	 +768 	    0 	+1220 	n800_testconfig/vmlinux
    0 	    0 	    0 	    0 	omap1_defconfig/vmlinux
 +452 	+1056 	    0 	+1508 	omap2_4_testconfig/vmlinux
+4548 	+1440 	    0 	+5988 	omap2plus_defconfig/vmlinux
 +452 	+1440 	    0 	+1892 	omap2plus_no_pm/vmlinux
 +252 	 +544 	  -64 	 +732 	omap3_4_testconfig/vmlinux
 +316 	 +544 	    0 	 +860 	omap3_testconfig/vmlinux
 +316 	    0 	    0 	 +316 	omap4_testconfig/vmlinux

The following changes since commit 0135f6a04642c192bdf4b36e06937d3387e174ff:

  Merge branches 'clock_am35xx_cleanup_3.5', 'prm_cm_devel_a_3.5', 'clock_devel_a_3.5' and 'pwrdm_clkdm_cleanup_3.5' into prcm_devel_a_3.5 (2012-05-07 23:55:56 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-c-for-3.5

for you to fetch changes up to 414e41286e3aeb87de140ef4c75100f9344c32b2:

  ARM: OMAP2+: WDTIMER integration: fix !PM boot crash, disarm timer after hwmod reset (2012-05-08 17:25:37 -0600)

- ----------------------------------------------------------------
Some OMAP IP block data additions for 3.5, along with a
fix for a longstanding watchdog timer integration problem.

- ----------------------------------------------------------------
Kevin Hilman (1):
      ARM: OMAP2+: WDTIMER integration: fix !PM boot crash, disarm timer after hwmod reset

Paul Walmsley (4):
      ARM: OMAP2+: HDQ1W: add custom reset function
      ARM: OMAP2+: hwmod data: add HDQ/1-wire hwmod shared data
      ARM: OMAP3: hwmod data: add HDQ/1-wire hwmod
      ARM: OMAP2xxx: hwmod data: add HDQ/1-wire hwmod

Peter Ujfalusi (2):
      ARM: OMAP3: hwmod_data: Rename the common irq for McBSP ports
      ARM: OMAP4: hwmod_data: Name the common irq for McBSP ports

Shubhrajyoti D (1):
      ARM: OMAP4: hwmod data: I2C: add flag for context restore

Tony Lindgren (1):
      ARM: OMAP2420: hwmod data: Add MMC hwmod data for 2420

Vaibhav Hiremath (1):
      ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod database

 arch/arm/mach-omap2/Makefile                                 |    5 ++++-
 arch/arm/mach-omap2/hdq1w.c                                  |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/io.c                                     |   18 ---------------
 arch/arm/mach-omap2/msdi.c                                   |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c                   |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c                   |   47 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c |    9 ++++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c      |   22 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c           |   23 ++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c                   |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c                   |   12 +++++-----
 arch/arm/mach-omap2/omap_hwmod_common_data.h                 |    5 +++++
 arch/arm/mach-omap2/wd_timer.c                               |   45 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/wd_timer.h                               |    1 +
 arch/arm/plat-omap/include/plat/hdq1w.h                      |   36 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mmc.h                        |    4 ++++
 16 files changed, 562 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hdq1w.c
 create mode 100644 arch/arm/mach-omap2/msdi.c
 create mode 100644 arch/arm/plat-omap/include/plat/hdq1w.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqborAAoJEMePsQ0LvSpLvmkP/RTk7tJonhLVwWoHie5BNvHs
VsIHLdmavIAZrElwgsCuu6MvtLxgPILXsQX8w5MS1fez9AIzLoKti5mV/0A4EzXb
VhK1acqpOz7A8YDg8xURoDBpYmJqNYpxwcv9nwBgUH/tXSceEh3VBCFxEUe6Xv9E
cyyF/0vqKewM5CrqhVAkr/3la4fe8sw58H8wlZ0H+RF2xgk9FmIUjVDDe2v7gna+
b59MtyUB+QwQRK3m5CkkEpa5GD4bEfhWWjlGZiahh+yTqV9YPGklbfNs9SkFMaR0
3i8c+DWXjS2AQ+qANIj3cpfNW8FZsJVtxLdIfqJikSV1Bc8CEJ9H26VsdwjD4ieM
+5T/NoNcwcUDllL1yFCkZhfa2yErlXQt58bo0NdjwUxOYDZsLwKHLLGE3INk0hYK
zsALMVS7PFfQs/y5UG8HSkhgyNeb8k4GWNvR2zVR01solVbtpynkGAIL1+W9Weqx
8Eq+rQOWXxpfY2ERo9I4xTMw/tlbtCStn955tjTN2uDFVsth5hPwlLZ+4Cxcs7VZ
v+OCyyhtVAV11ALR8vY1CGfaRNuTMO6CngY26I/5y1nrX7J9mlrYxrabzLox844h
tssLPh4vgYLQdRGWeWpajoZPPgwHV5BTEIp5Z+L0nqrig/Wjs+dzhiuQezyTLe4T
m31VTS8BhlgCLebZ5ixw
=fEdJ
-----END PGP SIGNATURE-----
