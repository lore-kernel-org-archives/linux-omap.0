From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/5] omap soc changes for v3.18 merge window
Date: Thu, 11 Sep 2014 16:28:55 -0700
Message-ID: <29148.0989232243$1410478163@news.gmane.org>
References: <pull-1410478051-378788>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48788 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbaIKX3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 19:29:13 -0400
In-Reply-To: <pull-1410478051-378788>
In-Reply-To: <pull-1410478051-378788>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit d7eb67f7fef9c046f27a975118da2324de65a90c:

  Merge branch 'pull/v3.18/powerdomain-fixes' of https://github.com/nmenon/linux-2.6-playground into omap-for-v3.18/fixes-not-urgent (2014-09-08 15:04:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/soc-for-v3.18

for you to fetch changes up to 377fb3f5d9a34b2913939e0620c1c585b5913bab:

  ARM: OMAP5+: Reuse OMAP4 PM code for OMAP5 and DRA7 (2014-09-09 19:13:41 -0700)

----------------------------------------------------------------
SoC related changes for omaps for v3.18 merge window:

- PM changes to make the code easier to use on newer SoCs
- PM changes for newer SoCs suspend and resume and wake-up events
- Minor clean-up to remove dead Kconfig options

Note that these have a dependency to the fixes-v3.18-not-urgent
tag and is based on a commit in that series.

----------------------------------------------------------------
Keerthy (1):
      ARM: AM437x: use pdata quirks for pinctrl information

Mark Brown (1):
      ARM: omap: Remove stray ARCH_HAS_OPP references

Nishanth Menon (10):
      ARM: OMAP4+: prminst: provide function to find prm_dev instance offset
      ARM: OMAP4: PRM: use the generic prm_inst to allow logic to be abstracted
      ARM: OMAP4+: PRM: register interrupt information from DT
      ARM: OMAP4+: PRM: remove "wkup" event
      ARM: OMAP4+: PRM: Enable wakeup capability for OMAP5, DRA7
      ARM: OMAP3+: PRM: register interrupt information from DT
      ARM: OMAP5: use pdata quirks for pinctrl information
      ARM: DRA7: use pdata quirks for pinctrl information
      ARM: dts: OMAP3+: Add PRM interrupt
      ARM: OMAP5+: Reuse OMAP4 PM code for OMAP5 and DRA7

Rajendra Nayak (3):
      ARM: OMAP5 / DRA7: PM: Avoid all SAR saves
      ARM: OMAP5 / DRA7: Enable CPU RET on suspend
      ARM: DRA7: Add hook in SoC initcalls to enable pm initialization

Santosh Shilimkar (6):
      ARM: OMAP5 / DRA7: PM: Update CPU context register offset
      ARM: OMAP5 / DRA7: PM: Set MPUSS-EMIF clock-domain static dependency
      ARM: OMAP5 / DRA7: PM / wakeupgen: Enables ES2 PM mode by default
      ARM: OMAP5 / DRA7: PM: Enable Mercury retention mode on CPUx powerdomains
      ARM: OMAP5 / DRA7: PM: Provide a dummy startup function for CPU hotplug
      ARM: OMAP5: Add hook in SoC initcalls to enable pm initialization

Tony Lindgren (1):
      Merge branch 'pull/v3.18/for-omap-soc' of https://github.com/nmenon/linux-2.6-playground into omap-for-v3.18/soc

 arch/arm/boot/dts/dra7.dtsi               |   1 +
 arch/arm/boot/dts/omap3.dtsi              |   1 +
 arch/arm/boot/dts/omap4.dtsi              |   1 +
 arch/arm/boot/dts/omap5.dtsi              |   1 +
 arch/arm/mach-omap2/Kconfig               |   5 --
 arch/arm/mach-omap2/Makefile              |  12 ++--
 arch/arm/mach-omap2/common.h              |   2 +-
 arch/arm/mach-omap2/io.c                  |   6 ++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 102 +++++++++++++++++++++---------
 arch/arm/mach-omap2/omap-secure.h         |   1 +
 arch/arm/mach-omap2/omap-wakeupgen.c      |  20 +++++-
 arch/arm/mach-omap2/omap-wakeupgen.h      |   1 +
 arch/arm/mach-omap2/pdata-quirks.c        |  10 +++
 arch/arm/mach-omap2/pm.h                  |   1 +
 arch/arm/mach-omap2/pm44xx.c              |  48 ++++++++++++--
 arch/arm/mach-omap2/prm3xxx.c             |  18 ++++++
 arch/arm/mach-omap2/prm44xx.c             |  90 ++++++++++++++++++++++----
 arch/arm/mach-omap2/prminst44xx.c         |  40 +++++++-----
 arch/arm/mach-omap2/prminst44xx.h         |   3 +
 19 files changed, 290 insertions(+), 73 deletions(-)
