From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 00/18] OMAP3+: PM: introduce SR class 1.5
Date: Wed,  2 Mar 2011 16:25:13 +0530
Message-ID: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:48598 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756723Ab1CBKzn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:55:43 -0500
Received: by yxd5 with SMTP id 5so3214828yxd.7
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:55:41 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Hi,

This series intends to introduce SmartReflex AVS Class 1.5 support which
is now the recommended AVS class for usage in OMAP3630, OMAP4 and potentially
in later generation of silicon as well. Smartreflex class 1.5 is a software
controlled hardware calibration mechanism designed to improve dvfs latencies
and system performance as well as helping bring in additional benefits to the
system from h/w perspective. The corresponding patch has details on this class
and the implementation as well.

The series eventually results in OMAP343x based platforms using class3 and
OMAP3630, OMAP4 platforms using class1.5 automatically without modifications
or additions to board files.

This series is Based on:
a) k.org 2.6.38-rc7 (b2.6.38-rc7)
b) The following branches Kevin Hilman's tree: (pm-base-v2)
 'pm/for_2.6.38/pm-fixes', 'pm/for_2.6.39/pm-misc' and 'pm/pm-wip/cpufreq'
 http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
 Rationale: there are some sr-cleanups done here which makes at least 1 patch
 create a minor conflict (kasprintf for sr name), but should reasonably
 apply to k.org as well, and since this series is targeted for 39-rc1, builds
 on previously accepted patches.

Some good fixes needed are here (optional):
c) sr-fixes: (sr-baseline-v2)
	http://marc.info/?l=linux-omap&m=129783708019505&w=2
	http://marc.info/?l=linux-omap&m=129679846322563&w=2

Other interesting series:
i) http://marc.info/?t=129825445100003&r=1&w=2 cleanups of voltage.c
	- rebase should be minor effort
ii) http://marc.info/?l=linux-omap&m=129783700319445&w=2 fixes for omap4
	- might conflict on macro cleanup with (i)
	- should not conflict with the current series.

This series is also available at:
	git://gitorious.org/linux-omap-nm-sr/linux-omap-sr.git
	Branch: sr-1.5-v2

Note: There is also a branch dvfs-test-v2 in my tree which contains the test
version of code for OMAP3 based on Vishwa's DVFS series which is currently
being revamped. if run on OMAP4, it just throws up a bit of warnings, but
wont crash.

The series contains a bunch of bugfixes and improvements needed to introduce
Smartreflex class 1.5.

Changes in v2 since v1:
* I dropped patch 2/19 for 3630 ES revision, based on the discussion in:
	http://marc.info/?t=129811710300003&r=1&w=2
  NOTE: 3630 ES revision fixes need to be cleanly done at a later point,
  and there is not much use doing a temporary hackup job just for SR. Since
  it ain't broke atm for higher ES revs for SR, I will leave it alone.
* Fixed the bug exposed by bootloaders which setup an OPP which is not enabled
  in kernel http://marc.info/?t=129811710500010&r=1&w=2
  - parameter checks were necessary, impacted  patches 5 and 17
* Documentation update following the explanation required for
  http://marc.info/?t=129811710300007&r=1&w=2 for patch 5
  - example provided in the discussion is useful for reviewer perspective in
    commit message
Comments not incorporated from v1:
* http://marc.info/?t=129811710500007&r=1&w=2 - there is no reason to allow
  sr notifiers after class has been deinitialized, so not allowing it.
* http://marc.info/?t=129811710300004&r=1&w=2 - the omap2_init_voltage fix
  is not the intent of this series. infact handling of mpurate and
  omap2_init_voltage needs to be merged in at some future point of time.

v1: http://marc.info/?l=linux-omap&m=129811693118173&w=2

Nishanth Menon (18):
  omap3: hwmod: add smartreflex irqs
  omap3+: voltage: remove initial voltage
  omap3+: voltage: remove spurious pr_notice for debugfs
  omap3+: voltage: use IS_ERR_OR_NULL
  omap3+: voltage: use volt_data pointer instead values
  omap3+: voltage: add transdone apis
  omap3+: sr: make notify independent of class
  omap3+: sr: introduce class init,deinit and priv data
  omap3+: sr: fix cosmetic indentation
  omap3+: sr: call handler with interrupt disabled
  omap3+: sr: disable interrupt by default
  omap3+: sr: enable/disable SR only on need
  omap3+: sr: introduce notifiers flags
  omap3+: sr: introduce notifier_control
  omap3+: sr: disable spamming interrupts
  omap3+: sr: make enable path use volt_data pointer
  omap3630+: sr: add support for class 1.5
  omap3430: sr: class3: restrict cpu to run on

 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   17 +
 arch/arm/mach-omap2/pm.c                      |    3 +-
 arch/arm/mach-omap2/smartreflex-class1p5.c    |  582 +++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex-class3.c      |   21 +-
 arch/arm/mach-omap2/smartreflex.c             |  249 +++++++++--
 arch/arm/mach-omap2/voltage.c                 |  251 ++++++++---
 arch/arm/plat-omap/Kconfig                    |   17 +
 arch/arm/plat-omap/include/plat/smartreflex.h |   42 ++-
 arch/arm/plat-omap/include/plat/voltage.h     |   36 ++-
 10 files changed, 1097 insertions(+), 122 deletions(-)
 create mode 100644 arch/arm/mach-omap2/smartreflex-class1p5.c

Testing performed:
Testing with dvfs-test-v2 - http://pastebin.mozilla.org/1117872
	- transitions from all opps to all other opps,sr enabled, disable
	- platforms: SDP3430(OMAP3430), SDP3630(OMAP3630)
	(note: dvfs series does'nt support OMAP4 yet)
Testing with sr-1.5-v2 - http://pastebin.mozilla.org/1117880
	- enable disable in domain combinations, test the new debugfs entries
	  etc..
	- platforms: SDP3430(OMAP3430), SDP3630(OMAP3630), PandaBoard(OMAP4430)

Regards,
Nishanth Menon
