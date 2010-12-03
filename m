From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 0/6] Split powerdomain framework into plat specific/independent
Date: Fri,  3 Dec 2010 17:08:47 +0530
Message-ID: <1291376333-13603-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51058 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758470Ab0LCLjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 06:39:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>

OMAP4 powerdomains have some inherent differences as compared
to OMAP2/3 powerdomains, starting with register offsets being different
to clubbing of multiple controls into one register and in some cases
splitting of control into multiple registers.
There are also new features like lowpowerstatechange bits and features
like HW SAR which are no longer present in the older form.

Supporting all these in the existing powerdomain framework would mean adding
a lot of cpu_is_* checks which makes code unmaintainable going fwd.

Hence this series is an attempt to split the existing powerdomain framework
into platform independent part (which does error checking, usecounting et al)
which can be reused across OMAP's and hook up platform specific functions to
do low level programming which varies across OMAP's.

The series is boot tested on OMAP 2430sdp/3430sdp and 4430sdp platforms.
Additionally on 3430sdp, Retention and OFF support in system suspend is
also validated with a minimal kernel config (omap3_pm_defconfig from
Kevins tree hosted here 
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git)

The series is based on 2.6.37-rc4 and is available here:
git://gitorious.org/omap-pm/linux.git powerdomain-split-v3

regards,
Rajendra

Version History
---------------
Version v3
* Additional patch to move static allocs in 
powerdomins.h to powerdomains_data.c 
* Sparse warning fixes

Version v2
* powerdomain.c retained in mach-omap2 instead
of moving it to plat-omap
* All common powerdomain functions now in
powerdomain-common.c file instead of powerdomains.c
* OMAP2/3 common and specific functions in
powerdomain2xxx_3xxx.c file.
* Other minor review comment fixes

Version v1
http://marc.info/?l=linux-omap&m=128992190426815&w=2
Fixes all issues discussed on the RFC series and also has
a few other changes
* The below patch is dropped as the dependent patches for this are
still under discussion.
[RFC 6/8] OMAP: PRM: split the prm accessor api funcs for omap2/3 and omap4
http://marc.info/?l=linux-omap&m=128524531505429&w=2
* The below patch is also dropped as there are more than one context
registers to be handled in some powerdomains and hence needs to be
handled differently
[RFC 7/8] omap4: powerdomain: add context_offset field
http://marc.info/?l=linux-omap&m=128524531805435&w=2

The RFC series of these patches was posted here

Rajendra Nayak (5):
  OMAP: powerdomain: Move static allocations from powerdomains.h to a
    .c file
  OMAP: powerdomain: Infrastructure to put arch specific code
  OMAP: powerdomain: Arch specific funcs for state control
  OMAP: powerdomain: Arch specific funcs for logic control
  OMAP: powerdomain: Arch specific funcs for mem control

Santosh Shilimkar (1):
  OMAP4: powerdomain: Add pwrdm_clear_all_prev_pwrst

 arch/arm/mach-omap2/Makefile                  |    8 +-
 arch/arm/mach-omap2/clockdomains.h            |    5 +
 arch/arm/mach-omap2/io.c                      |    3 +-
 arch/arm/mach-omap2/powerdomain-common.c      |  111 +++++++
 arch/arm/mach-omap2/powerdomain.c             |  396 +++++++------------------
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c    |  227 ++++++++++++++
 arch/arm/mach-omap2/powerdomain44xx.c         |  175 +++++++++++
 arch/arm/mach-omap2/powerdomains.h            |  152 ++--------
 arch/arm/mach-omap2/powerdomains_data.c       |  159 ++++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |   44 +++-
 10 files changed, 857 insertions(+), 423 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain-common.c
 create mode 100644 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
 create mode 100644 arch/arm/mach-omap2/powerdomain44xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains_data.c

