From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches for 2.6.38,
	part two
Date: Tue, 07 Dec 2010 23:18:28 -0700
Message-ID: <20101208061657.30541.79824.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37164 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab0LHGTx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:19:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

This patch series, intended for 2.6.38:

- adds OMAP4-specific PRM and CM instance functions, which are capable
  of writing to PRM/CM instances, no matter what PRCM partition they
  appear in;

- renames the old OMAP2/3 PRM and CM functions to prefix them with
  'omap2_';

- adds OMAP4 clockdomain offset addressing to the OMAP4 clockdomain
  definitions;

- removes the (now unused) OMAP clockdomain .clkstctrl_reg field;

- moves plat-omap/include/plat/{clock,power}domain.h to mach-omap2/, si=
nce
  these are OMAP2-specific;

- moves the OMAP3 SCM padconf save code from pm34xx.c into the SCM comm=
on
  code.

This series is available via git from git://git.pwsan.com/linux-2.6 in
the branch 'pwrdm_prcm_b_2.6.38'.  It applies on top of the "OMAP:
PRCM/powerdomain/clockdomain patches for 2.6.38, part one" series,
sent earlier.

Kevin and OMAP ASoC-hackers, I'd appreciate review and acks, if
appropriate, on the patches that touch code that you maintain.  TI
OMAP4 PM people, I would appreciate any testing assistance that you
may be able to provide.  Beno=C3=AEt, I've tried to keep the kernel dat=
a
files and the output of the scripts relatively similar, but we might
need to do some tweaking of the scripts or data files to align them
in the way that makes the most sense.

Boot-tested on N800, OMAP35xx Beagle, and OMAP4430ES2 Panda.


- Paul

---

pwrdm_prcm_b_2.6.38
   text	   data	    bss	    dec	    hex	filename
5709988	 473952	5608800	11792740	 b3f164	vmlinux.orig
5712868	 474496	5608800	11796164	 b3fec4	vmlinux.patched

Paul Walmsley (11):
      OMAP4: PRCM: add OMAP4-specific accessor/mutator functions
      OMAP4: PRCM: move global reset function for OMAP4 to an OMAP4-spe=
cific file
      OMAP2/3: PRM/CM: prefix OMAP2 PRM/CM functions with "omap2_"
      OMAP4: powerdomains: add PRCM partition data; use OMAP4 PRM funct=
ions
      OMAP2+: clockdomains: split the clkdm hwsup enable/disable functi=
on
      OMAP4: CM instances: add clockdomain register offsets
      OMAP4: clockdomains: add OMAP4 PRCM data and OMAP4 support
      OMAP2/3: clockdomain: remove unneeded .clkstctrl_reg, remove some=
 direct CM register accesses
      OMAP2+: clockdomain: move header file from plat-omap to mach-omap=
2
      OMAP2+: powerdomain: move header file from plat-omap to mach-omap=
2
      OMAP3: control/PM: move padconf save code to mach-omap2/control.c


 arch/arm/mach-omap2/Makefile                     |    4=20
 arch/arm/mach-omap2/clkt2xxx_apll.c              |   10 -
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c          |    8=20
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c     |   12 -
 arch/arm/mach-omap2/clock.c                      |    2=20
 arch/arm/mach-omap2/clockdomain.c                |  209 ++++++-----
 arch/arm/mach-omap2/clockdomain.h                |   33 +-
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   42 --
 arch/arm/mach-omap2/clockdomains44xx_data.c      |  123 ++++--
 arch/arm/mach-omap2/cm-regbits-24xx.h            |    5=20
 arch/arm/mach-omap2/cm-regbits-34xx.h            |   11 +
 arch/arm/mach-omap2/cm1_44xx.h                   |   10 +
 arch/arm/mach-omap2/cm2_44xx.h                   |   25 +
 arch/arm/mach-omap2/cm2xxx_3xxx.c                |  420 +++++++++++++-=
--------
 arch/arm/mach-omap2/cm2xxx_3xxx.h                |   19 +
 arch/arm/mach-omap2/cm44xx.c                     |   52 +++
 arch/arm/mach-omap2/cm4xxx.c                     |   62 ---
 arch/arm/mach-omap2/cminst44xx.c                 |  223 ++++++++++++
 arch/arm/mach-omap2/control.c                    |   72 +++-
 arch/arm/mach-omap2/control.h                    |    1=20
 arch/arm/mach-omap2/cpuidle34xx.c                |    4=20
 arch/arm/mach-omap2/io.c                         |    4=20
 arch/arm/mach-omap2/omap_hwmod.c                 |    4=20
 arch/arm/mach-omap2/pm-debug.c                   |   12 -
 arch/arm/mach-omap2/pm.c                         |    4=20
 arch/arm/mach-omap2/pm.h                         |    2=20
 arch/arm/mach-omap2/pm24xx.c                     |  200 +++++-----
 arch/arm/mach-omap2/pm34xx.c                     |  162 ++++----
 arch/arm/mach-omap2/pm44xx.c                     |    2=20
 arch/arm/mach-omap2/powerdomain-common.c         |    1=20
 arch/arm/mach-omap2/powerdomain.c                |   14 +
 arch/arm/mach-omap2/powerdomain.h                |   30 +-
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c       |   68 ++--
 arch/arm/mach-omap2/powerdomain44xx.c            |  122 ++++--
 arch/arm/mach-omap2/powerdomains.h               |   30 --
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    4=20
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h |    2=20
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    3=20
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |    3=20
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   20 +
 arch/arm/mach-omap2/prcm.c                       |   51 +--
 arch/arm/mach-omap2/prcm44xx.h                   |   42 ++
 arch/arm/mach-omap2/prcm_mpu44xx.c               |   45 ++
 arch/arm/mach-omap2/prcm_mpu44xx.h               |   13 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c               |   34 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h               |   12 -
 arch/arm/mach-omap2/prm44xx.c                    |   79 ++++
 arch/arm/mach-omap2/prm44xx.h                    |   23 +
 arch/arm/mach-omap2/prminst44xx.c                |   74 ++++
 arch/arm/mach-omap2/prminst44xx.h                |   25 +
 arch/arm/mach-omap2/sdrc2xxx.c                   |    4=20
 arch/arm/mach-omap2/serial.c                     |    1=20
 arch/arm/plat-omap/gpio.c                        |    5=20
 arch/arm/plat-omap/include/plat/gpio.h           |    2=20
 arch/arm/plat-omap/include/plat/omap-pm.h        |    2=20
 arch/arm/plat-omap/include/plat/prcm.h           |   10 -
 arch/arm/plat-omap/mcbsp.c                       |    8=20
 arch/arm/plat-omap/omap-pm-noop.c                |    2=20
 58 files changed, 1597 insertions(+), 869 deletions(-)
 rename arch/arm/{plat-omap/include/plat/clockdomain.h =3D> mach-omap2/=
clockdomain.h} (86%)
 create mode 100644 arch/arm/mach-omap2/cm44xx.c
 delete mode 100644 arch/arm/mach-omap2/cm4xxx.c
 create mode 100644 arch/arm/mach-omap2/cminst44xx.c
 rename arch/arm/{plat-omap/include/plat/powerdomain.h =3D> mach-omap2/=
powerdomain.h} (90%)
 delete mode 100644 arch/arm/mach-omap2/powerdomains.h
 create mode 100644 arch/arm/mach-omap2/prcm44xx.h
 create mode 100644 arch/arm/mach-omap2/prcm_mpu44xx.c
 create mode 100644 arch/arm/mach-omap2/prminst44xx.c
 create mode 100644 arch/arm/mach-omap2/prminst44xx.h

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
