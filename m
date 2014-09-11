From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/5] non-urgent omap fixes for v3.18 merge window
Date: Thu, 11 Sep 2014 16:28:54 -0700
Message-ID: <20454.2245636278$1410478160@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48638 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbaIKX3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 19:29:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c=
666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/=
fixes-v3.18-not-urgent

for you to fetch changes up to 31957609db529d401658adc2e91ef7df7ea42699=
:

  ARM: OMAP2+: make of_device_ids const (2014-09-11 12:37:23 -0700)

----------------------------------------------------------------
=46ixes for omaps that were not considered urgent enough
for the -rc cycle:

- Fixes for .dts files to differentiate panda and beaglebone versions
- Powerdomain fixes from Nishant Menon mostly for newer omaps
- Fixes for __initconst and of_device_ids const usage

----------------------------------------------------------------
Nishanth Menon (9):
      ARM: dts: omap4-panda: Fix model and SoC family details
      ARM: dts: am335x-bone*: Fix model name and update compatibility i=
nformation
      ARM: OMAP: DRA7: powerdomain data: fix powerdomain powerstate
      ARM: OMAP5: powerdomain data: fix powerdomain powerstate
      ARM: OMAP2+: powerdomain: pwrdm_for_each_clkdm iterate only valid=
 clkdms
      ARM: OMAP2+: powerdomain: introduce logic for finding valid power=
 domain
      ARM: OMAP4+: PM: Make logic state programmable
      ARM: OMAP4+: PM: use only valid low power state for suspend
      ARM: OMAP4+: PM: Use only valid low power state for CPU hotplug

Tony Lindgren (1):
      Merge branch 'pull/v3.18/powerdomain-fixes' of https://github.com=
/nmenon/linux-2.6-playground into omap-for-v3.18/fixes-not-urgent

Uwe Kleine-K=C3=83=C2=B6nig (2):
      ARM: omap2: make arrays containing machine compatible strings con=
st
      ARM: OMAP2+: make of_device_ids const

 arch/arm/boot/dts/am335x-bone-common.dtsi   |  3 --
 arch/arm/boot/dts/am335x-bone.dts           |  5 ++
 arch/arm/boot/dts/am335x-boneblack.dts      |  5 ++
 arch/arm/boot/dts/omap4-panda-common.dtsi   |  3 --
 arch/arm/boot/dts/omap4-panda-es.dts        |  5 ++
 arch/arm/boot/dts/omap4-panda.dts           |  5 ++
 arch/arm/mach-omap2/board-generic.c         | 26 +++++-----
 arch/arm/mach-omap2/common.h                |  2 +-
 arch/arm/mach-omap2/gpmc.c                  |  2 +-
 arch/arm/mach-omap2/irq.c                   |  2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c   |  4 ++
 arch/arm/mach-omap2/pdata-quirks.c          |  2 +-
 arch/arm/mach-omap2/pm44xx.c                |  9 +++-
 arch/arm/mach-omap2/powerdomain.c           | 79 +++++++++++++++++++++=
+++++++-
 arch/arm/mach-omap2/powerdomain.h           |  4 ++
 arch/arm/mach-omap2/powerdomains54xx_data.c | 12 ++---
 arch/arm/mach-omap2/powerdomains7xx_data.c  | 14 ++---
 arch/arm/mach-omap2/prm_common.c            |  2 +-
 arch/arm/mach-omap2/timer.c                 |  6 +--
 19 files changed, 147 insertions(+), 43 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
