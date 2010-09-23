From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 0/8] Split powerdomain framework into plat specfic/independent
Date: Thu, 23 Sep 2010 18:04:43 +0530
Message-ID: <1285245291-26442-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40350 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547Ab0IWMfC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 08:35:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

OMAP4 powerdomains have some inherent differences as compared
to OMAP2/3 powerdomains, starting with register offsets being different
to clubbing of multiple controls into one register and in some cases
splitting of control into multiple registers.
There are also new features like lowpowerstatechange bits and features
like HW SAR which are no longer present in the older form.

Supporting all these in the existing powerdomain framework would mean adding
a lot of cpu_is_* checks which makes code unmaintainable going fwd.

Hence this RFC series is an attempt to split the existing powerdomain framework
into platform independent part (which does error checking, usecounting et al)
which can be reused across OMAP's and hook up platform specific functions to
do low level programming which varies across OMAP's.

The series has a dependency on the following patch series
http://marc.info/?l=linux-omap&m=128146137929118&w=2
http://marc.info/?l=linux-omap&m=128464495603506&w=2

This series along with all the dependent series patches can be
found here
git://gitorious.org/omap-pm/linux.git powerdomain-split

Rajendra Nayak (6):
  OMAP: powerdomain: Move powerdomain.c from mach-omap2 to plat-omap
  OMAP: powerdomain: Infrastructure to put arch specific code
  OMAP: powerdomain: Arch specific funcs for state control
  OMAP: powerdomain: Arch specific funcs for logic control
  OMAP: powerdomain: Arch specific funcs for mem control
  OMAP: PRM: split the prm accessor api funcs for omap2/3 and omap4

Santosh Shilimkar (2):
  omap4: powerdomain: add context_offset field
  omap4: powerdomain: Add pwrdm_clear_all_prev_pwrst

 arch/arm/mach-omap2/Makefile                     |   10 +-
 arch/arm/mach-omap2/clockdomain.c                |   16 +-
 arch/arm/mach-omap2/control.c                    |    8 +-
 arch/arm/mach-omap2/io.c                         |    5 +-
 arch/arm/mach-omap2/pm-debug.c                   |    4 +-
 arch/arm/mach-omap2/pm24xx.c                     |   48 ++--
 arch/arm/mach-omap2/pm34xx.c                     |   98 +++---
 arch/arm/mach-omap2/powerdomains.c               |  111 ++++++
 arch/arm/mach-omap2/powerdomains.h               |   13 +
 arch/arm/mach-omap2/powerdomains2xxx.c           |  212 ++++++++++++
 arch/arm/mach-omap2/powerdomains44xx.c           |  177 ++++++++++
 arch/arm/mach-omap2/powerdomains44xx.h           |   14 +
 arch/arm/mach-omap2/prcm.c                       |  123 +++++---
 arch/arm/mach-omap2/prm.h                        |   26 +-
 arch/arm/plat-omap/Makefile                      |    6 +-
 arch/arm/plat-omap/include/plat/powerdomain.h    |   24 ++-
 arch/arm/plat-omap/include/plat/prcm.h           |   12 +-
 arch/arm/{mach-omap2 => plat-omap}/powerdomain.c |  399 ++++++----------------
 18 files changed, 868 insertions(+), 438 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomains.c
 create mode 100644 arch/arm/mach-omap2/powerdomains2xxx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains44xx.c
 rename arch/arm/{mach-omap2 => plat-omap}/powerdomain.c (70%)

