From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 00/19] OMAP3+: PM: introduce SR class 1.5
Date: Sat,  5 Mar 2011 20:59:03 +0530
Message-ID: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:34575 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752451Ab1CEP3i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:29:38 -0500
Received: by gyh3 with SMTP id 3so1853214gyh.22
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:29:35 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

Hi,

This series intends to introduce SmartReflex AVS Class 1.5 support which
is now the recommended AVS class for usage in OMAP3630, OMAP4 and potentially
in later generation of silicon as well. Smartreflex class 1.5 is a software
controlled hardware calibration mechanism designed to improve DVFS latencies
and system performance as well as helping bring in additional benefits to the
system from h/w perspective. The corresponding patch has details on this class
and the implementation as well.

The series eventually results in OMAP343x based platforms using class 3 and
OMAP3630, OMAP4 platforms using class 1.5 automatically without modifications
or additions to board files.

The series contains a bunch of bugfixes and improvements needed to introduce
SmartReflex AVS class 1.5.

This series is Based on:
a) k.org 2.6.38-rc7 (b2.6.38-rc7)
b) The pm-core branch Kevin Hilman's tree: (pm-base-v3)
 http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary

Some good fixes needed are here (optional):
c) sr-fixes: (sr-baseline-v3)
	https://patchwork.kernel.org/patch/611991/
	https://patchwork.kernel.org/patch/611951/
	https://patchwork.kernel.org/patch/611961/
	https://patchwork.kernel.org/patch/611971/

This series is also available at:
	git://gitorious.org/linux-omap-nm-sr/linux-omap-sr.git
	Branch: sr-1.5-v3

Changes in v3 since v2:
* On request from OMAP PM maintainer, the series is now rebased to
  pm-core of linux-omap-pm tree
  http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
  Ref: http://marc.info/?l=linux-omap&m=129911240208955&w=2
  the voltage files and structures have been reorganized
  in pm-core, so the same code looks a little different now.
* Changes throughout the series for typos, spell corrections,
  using uppercase for abbreviations
* Updated commit message for patches 3, 6, 9 and 15
* Dropped patch http://marc.info/?t=129906354500012&r=1&w=2
* Added patch 2 in the series for pm-core branch (build warning)
* Included a squashed series from Jaarko(patch 9):
	http://marc.info/?l=linux-omap&m=129908137900427&w=2
  This was rebased to pm-core+ my series
* patch 10 changed x ^ y check to x != y to basically get the same behavior
  but a little more readable without thinking bitops ;)
* patch 12 - changed class_init/deinit to start/stop APIs

v2: http://marc.info/?l=linux-omap&m=129906334611444&w=2
v1: http://marc.info/?l=linux-omap&m=129811693118173&w=2

Jarkko Nikula (1):
  OMAP3+: SR: Reuse sr_[start|stop]_vddautocomp functions

Nishanth Menon (18):
  OMAP3: hwmod: add SmartReflex IRQs
  OMAP3+: voltage: fix build warning
  OMAP3+: voltage: remove initial voltage
  OMAP3+: voltage: remove spurious pr_notice for debugfs
  OMAP3+: voltage: use IS_ERR_OR_NULL
  OMAP3+: voltage: use volt_data pointer instead values
  OMAP3+: voltage: add transdone APIs
  OMAP3+: SR: make notify independent of class
  OMAP3+: SR: disable interrupt by default
  OMAP3+: SR: enable/disable SR only on need
  OMAP3+: SR: fix cosmetic indentation
  OMAP3+: SR: introduce class start,stop and priv data
  OMAP3+: SR: introduce notifiers flags
  OMAP3+: SR: introduce notifier_control
  OMAP3+: SR: disable spamming interrupts
  OMAP3+: SR: make enable path use volt_data pointer
  OMAP3630+: SR: add support for class 1.5
  OMAP3430: SR: class3: restrict CPU to run on

 arch/arm/mach-omap2/Makefile               |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   17 +
 arch/arm/mach-omap2/pm.c                   |    3 +-
 arch/arm/mach-omap2/smartreflex-class1p5.c |  582 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex-class3.c   |   21 +-
 arch/arm/mach-omap2/smartreflex.c          |  288 +++++++++++----
 arch/arm/mach-omap2/smartreflex.h          |   39 ++-
 arch/arm/mach-omap2/voltage.c              |  241 +++++++++---
 arch/arm/mach-omap2/voltage.h              |   40 ++-
 arch/arm/plat-omap/Kconfig                 |   17 +
 10 files changed, 1106 insertions(+), 143 deletions(-)
 create mode 100644 arch/arm/mach-omap2/smartreflex-class1p5.c

Testing performed:
Testing with sr-1.5-v3 - http://pastebin.mozilla.org/1117880
	- enable disable in domain combinations, test the new debugfs entries
	  etc..
	- platforms: SDP3430(OMAP3430), SDP3630(OMAP3630), PandaBoard(OMAP4430)

Testing with dvfs-test-v2 (not v3)
	The DVFS series no longer applies on pm-core with the cleanups
	that have taken place. I have been unable to test the latest
	series with it yet.
	V2 of the series was tested with:
	http://pastebin.mozilla.org/1117872
	- transitions from all opps to all other opps,sr enabled, disable
	- platforms: SDP3430(OMAP3430), SDP3630(OMAP3630)
	(further note: dvfs series does'nt support OMAP4 yet)

Regards,
Nishanth Menon
