From: Rob Lee <rob.lee@linaro.org>
Subject: [git pull] Consolidate cpuidle functionality
Date: Thu, 8 Mar 2012 19:58:23 -0600
Message-ID: <CAMXH7KEwQM37R++8moXB8Q41_fBXOnVY2hXJGFQmTQ20oeFPEQ@mail.gmail.com>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
	<87y5reivhb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87y5reivhb.fsf@ti.com>
Sender: linux-sh-owner@vger.kernel.org
To: sfr@canb.auug.org.au
Cc: rjw@sisk.pl, len.brown@intel.com, nicolas.pitre@linaro.org, venki@google.com, linaro-dev@lists.linaro.org, linux-sh@vger.kernel.org, tony@atomide.com, nicolas.ferre@atmel.com, linux@arm.linux.org.uk, ccross@google.com, kernel@wantstofly.org, kgene.kim@samsung.com, mturquette@linaro.org, daniel.lezcano@linaro.org, magnus.damm@gmail.com, arnd.bergmann@linaro.org, jon-hunter@ti.com, patches@linaro.org, nsekhar@ti.com, jean.pihet@newoldbits.com, Baohua.Song@csr.com, vincent.guittot@linaro.org, linux-omap@vger.kernel.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, g.trinabh@gmail.com, linux-pm@vger.kernel.org, broonie@opensource.wolfsonmicro.com, amit.kucheria@linaro.org, lethal@linux-sh.org, amit.kachhap@linaro.org, Kevin Hilman <khilman@ti.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Hello Stephen,

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

  Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:
  git://git.linaro.org/people/rob_lee/linux.git cpuidle_consol_pull

Robert Lee (8):
      cpuidle: Add common time keeping and irq enabling
      ARM: at91: Consolidate time keeping and irq enable
      ARM: kirkwood: Consolidate time keeping and irq enable
      ARM: davinci: Consolidate time keeping and irq enable
      ARM: omap: Consolidate OMAP3 time keeping and irq enable
      ARM: omap: Consolidate OMAP4 time keeping and irq enable
      ARM: shmobile: Consolidate time keeping and irq enable
      SH: shmobile: Consolidate time keeping and irq enable

 arch/arm/include/asm/cpuidle.h        |   22 +++++++++
 arch/arm/kernel/Makefile              |    2 +-
 arch/arm/kernel/cpuidle.c             |   21 ++++++++
 arch/arm/mach-at91/cpuidle.c          |   67 ++++++++++-----------------
 arch/arm/mach-davinci/cpuidle.c       |   82 +++++++++++++-------------------
 arch/arm/mach-kirkwood/cpuidle.c      |   72 ++++++++--------------------
 arch/arm/mach-omap2/cpuidle34xx.c     |   42 +++++++----------
 arch/arm/mach-omap2/cpuidle44xx.c     |   21 +-------
 arch/arm/mach-shmobile/cpuidle.c      |   31 +++----------
 arch/sh/kernel/cpu/shmobile/cpuidle.c |   10 +---
 drivers/cpuidle/cpuidle.c             |   79 +++++++++++++++++++++++++------
 include/linux/cpuidle.h               |   13 +++++-
 12 files changed, 227 insertions(+), 235 deletions(-)
 create mode 100644 arch/arm/include/asm/cpuidle.h
 create mode 100644 arch/arm/kernel/cpuidle.c

The top-commit id is

	bd7fd2ab3ee38df371ece6cd4997d6660b3e1c95

Acked-by: Jean Pihet<j-pihet@ti.com>  (v6)
Tested-by: Jean Pihet<j-pihet@ti.com>  (v6, omap3)
Tested-by: Amit Daniel<amit.kachhap@linaro.org>  (v6, Exynos4)
Tested-by: Robert Lee<rob.lee@linaro.org>  (imx51, imx6q)
Reviewed-by: Kevin Hilman <khilman@ti.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Deepthi Dharwar<deepthi@linux.vnet.ibm.com> (core cpuidle only)

These changes move various functionality duplicated in platform
cpuidle drivers to the core cpuidle driver and common arch arm code. Also,
the irq disabling in the platform code was removed as all calls into
cpuidle_call_idle() will have already called local_irq_disable().

This patchset is bisect safe.  Also, the core cpuidle and arch changes of the
first commit do not require any changes to the arch and platform cpuidle
drivers, though those arch and platform change should be made to take
advantage of the new consolidation function.

Stephen, this patch has been reviewed, tested, and ACK'd per the list above but
cpuidle maintainer Len Brown has been out on vacation for a couple of weeks so
I am sending you this pull request as time is running out to get this into
v3.4.  I've had a brief communication with Andrew Morton about
this as well so he is aware of this situation.  I am fairly new to the
community so please let me know if you see anything that needs my attention or
anything I should be doing differently.

I've checked these changes against the recent linux-next tags and there is
currently one small conflict due to a small change in
arch/arm/mach-at91/cpuidle.c.  I'd be happy to assist in resolving this issue
if needed.  Also, in my patchset submissions I include changes for a
Samsung Exynos cpuidle platform driver patch that was accepted a couple of
weeks ago but it hasn't yet made it to an rc so I am not including it in this
request.

---------------------------

patchset submission history:

v7 submission can be found here:
http://www.spinics.net/lists/arm-kernel/msg162290.html

v7 changes:
* Made some  struct whitespace alignment changes.
* Fixed a coding style violation (thanks Jean Pihet)
* Fixed a bug in davinci cpuidle (thanks Jean Pihet)
* Corrected the common ARM cpuidle WFI state description to be ARM platform
 agnostic (thanks Kevin Hilman)
* Fixed the problem causing x86 and PPC builds to fail (thanks Deepthi)
* Re-added a line of code that was mistakenly removed (thanks Deepthi)

v6 submission can be found here:
http://www.spinics.net/lists/arm-kernel/msg162018.html

v6 changes:
* Fixed mindless bug in CONFIG_ARCH_HAS_RELAX code in drivers/cpuidle/cpuidle.c
* Removed inline from wrapper function (thanks Mike Turquette and Rob Herring)
* Add zeroing out of last_residency if error value is returned (thanks Mike)
* Made drivers/cpuidle/cpuidle.c more intelligently handle en_core_tk_irqen
flag allowing removal of the if (en_core_tk_irqen) in cpuidle_idle_call (thanks
Daniel Lezcano)
* Moved CPUIDLE_ARM_WFI_STATE macro to arch/arm/include/asm/cpuidle.h (thanks
Jean Pihet)
* Cleaned up some comments and a stray change (thanks Jean)

v5 submission can be found here:
http://www.spinics.net/lists/arm-kernel/msg161596.html

v5 changes:
* Added common cpu_do_idle function to core cpuidle
* Added time keep irq en wrapper to core cpuidle
* Removed pre/post enter
* Re-added platforms that can use new common code.

v4 submission can be found here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082742.html

v4 changes:
* Removed drivers/cpuidle/common.c
** Removed the initialization helper functions
** Removed the wrapper used to consolidate time keeping and irq enable/disable
* Add time keeping and local_irq_disable handling in cpuidle_call_idle().
* Made necessary modifications to a few platforms that required the most changes
** Note on omap3: changed structure of omap3_idle_drvdata and added
  per_next_state and per_saved_state vars to accomodate new framework.

v3 submission can be found here:
http://www.spinics.net/lists/arm-kernel/msg156751.html

v3 changes:
* Made various code organization and style changes as suggested in v2 review.
 (thanks Mark Brown, Rob Herring, Mike Turquette, Kevin Hillman, Daniel Lezcano)
* Removed at91 use of common code.  A separate effort is underway to clean
at91 code and the author has offered to convert to common interface as part
of those changes (if this common interface is accepted in time).
* Made platform cpuidle_driver objects __initdata and dynamically added one
persistent instance of this object in common code.
* Removed imx5 pm usage of gpc_dvfs clock as it is no longer needed after
being enabled during clock initialization.
* Re-organized patches.

v2 submission can be found here:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/144199

v2 changes:
* Common interface moved to drivers/cpuidle and made non arch-specific.
* Made various fixes and suggested additions to the common cpuidle
code from v1 review. (Thanks Rob Herring and Mark Brown)
* Added callback for filling in driver_data field as needed.
* Modified the various platforms with these changes.

v1 submission can be found here:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/142791

Thanks,
Rob
