From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: HDQ: convert HDQ to runtime PM
Date: Fri, 22 Jun 2012 08:12:10 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206220809460.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59823 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762216Ab2FVOML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 10:12:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, neilb@suse.de

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-for-3.6

for you to fetch changes up to c354a86484b61e32100eb94c1f3f0aa512958cee:

  W1: OMAP HDQ1W: use runtime PM (2012-06-21 21:40:40 -0600)

- ----------------------------------------------------------------
Convert the OMAP HDQ1W driver to use runtime PM.  Make it available on
all OMAP2+ chips that appear to have it integrated.  Fix a problem
preventing it from being used on OMAP4.

- ----------------------------------------------------------------

Particular thanks go to NeilBrown <neilb@suse.de> for his
extensive help getting the HDQ working.  There's still one
remaining fix needed for a HDQ PM-related integration bug; that will be
handled in a separate series.  (Neil's Tested-by:s were
with these patches based on an earlier version of the kernel, but
the patch contents haven't changed significantly during the
rebase.)  Thanks also to Evgeniy for his acks.

Testing logs are at:

http://www.pwsan.com/omap/bootlogs/20120621/hdq_hwmod_runtime_pm_devel_3.6__c354a86484b61e32100eb94c1f3f0aa512958cee/

The usual issues with v3.5-rc3 are all still present here: N800
MMC is broken and won't boot; 3517 boards won't NFS-mount root
and several WARN()s appear; 37xx EVM and 35xx Beagle CORE
powerdomain won't enter retention or off-mode; and 35xx Beagle
serial wakeup from suspend doesn't work.

object size (delta in bytes from v3.5-rc3 (485802a6c524e62b5924849dd727ddbb1497cc71)):
  text 	  data 	   bss 	 total 	kernel
     0 	     0 	     0 	     0 	5912osk_testconfig/vmlinux
  +132 	   +16 	     0 	  +148 	am33xx_testconfig/vmlinux
  +124 	   +24 	     0 	  +148 	n800_b_testconfig/vmlinux
  +124 	   -24 	     0 	  +100 	n800_multi_omap2xxx/vmlinux
  +124 	   -16 	     0 	  +108 	n800_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap1510_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap1_defconfig/vmlinux
  +124 	   +16 	     0 	  +140 	omap2_4_testconfig/vmlinux
 +4220 	    -8 	     0 	 +4212 	omap2plus_defconfig/vmlinux
  +124 	   +16 	     0 	  +140 	omap2plus_no_pm/vmlinux
  +128 	   -24 	     0 	  +104 	omap3_4_testconfig/vmlinux
  +128 	    +8 	     0 	  +136 	omap3_testconfig/vmlinux
  +128 	    +8 	     0 	  +136 	omap4_testconfig/vmlinux

Paul Walmsley (4):
      W1: OMAP HDQ1W: allow driver to be built on all OMAP2+
      W1: OMAP HDQ1W: use 32-bit register accesses
      ARM: OMAP2+: HDQ1W: use omap_device
      W1: OMAP HDQ1W: use runtime PM

 arch/arm/mach-omap2/devices.c |   38 ------------------
 arch/arm/mach-omap2/hdq1w.c   |   26 +++++++++++++
 drivers/w1/masters/Kconfig    |    2 +-
 drivers/w1/masters/omap_hdq.c |   86 ++++++++---------------------------------
 4 files changed, 44 insertions(+), 108 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5HyIAAoJEMePsQ0LvSpL6/IQAIO+Hcq3YlgSv+hz5CHw9kzX
DBTHBxJPuY5YWOFGGzKAE2MkSWV70GJfRP0yLI9qHCIOrHatqgWjFJmobOcZrwxz
xR/zqyomaiLg5sBIaAmb84KtBlO5VrDe9oKTa6PdXT3Dx7c2E7IMM24q/3GREkYo
SQByMTuTuw3dMrqJ/r1ZBqvh/s2CUqiuViwl69tcfDfZ3SB4/Kgg0H1D3079qkBr
PHlRAg3f6BXnqkorsJbbDum6/Lz2EEXRutwNg8jDZxc+7l73WbowJLYXi8oyUt4x
7Fr1v99Kv5fDuW3GAkkUoYWnuBF888z/0v2dTgRHSO1s5D1BpnyHg0qqKUoH9aFO
XP2gKRvKywT2wJFxhB4UL3wuSddNTiY0dgMWHXXP/QyRmxt7EPdZgQ1gJhTnlh9C
nr4Wlxn2lAf/qkkxJT/Mi6GzPYPLwXMBRuC4RbOdnaBkjzY6R869X1z46ZtuCiyO
qE3kq0MF7rbJl4Xw6LhvAqGuubE8htvr68bD5AI+qR7zxv/zv9G+CZZPweqiY/NM
8qYr13pU97NktdQFnfatIsTeBPJMljaFC654mc64w0uwdytxiZ4o0FT17YCc6iHV
/IOGIYCg72HiwDYeB1K3868s0itriy3cdR+OauTgSOnTD6WCJP5yQfJ+rGSZXlmc
XVQU3jeTpl4ZatnTUt4D
=A4qw
-----END PGP SIGNATURE-----
