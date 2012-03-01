From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [PATCH v7 0/9] Consolidate cpuidle functionality
Date: Thu, 1 Mar 2012 14:57:54 -0600
Message-ID: <CAMXH7KGJtSyeGwEN4jz9TRPxHUjtreMHRG-4WDChB0BC88P=OA@mail.gmail.com>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: rjw@sisk.pl, len.brown@intel.com
Cc: khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 29, 2012 at 6:42 PM, Robert Lee <rob.lee@linaro.org> wrote:
> This patch series moves various functionality duplicated in platform
> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> disabling was removed as it appears that all calls into
> cpuidle_call_idle will have already called local_irq_disable().
>

I'm told that I forgot to add the Acks from the previous v6 to this ver=
sion:

Acked-by: Jean Pihet <j-pihet@ti.com> (v6)
Tested-by: Jean Pihet <j-pihet@ti.com> (v6, omap3)
Tested-by: Amit Daniel <amit.kachhap@linaro.org> (v6, Exynos4)
=46or the generic cpuidle changes:
Reviewed-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

If anyone sees other omissions or has any suggested changes or
improvements in my patch submissions semantics, please let me know.

Thanks,
Rob

> Rafael,
>
> Could you review this patchset and merge patch 1/9 once its ready? =A0=
It
> seems pretty close to being acceptable. =A0The get_maintainer script =
shows
> Len Brown as the cpuidle maintainer but I've been unable to get a res=
ponse
> from him so far. =A0If you are not the right person, could you sugges=
t
> who I can make this request to? =A0Thanks.
>
> Note to platform maintainers:
>
> Platform patches (2/9 to 9/9) in this patchset are not required to wo=
rk
> with patch 1/9 but please review and push these platform changes as p=
ossible
> to allow this consolidation to occur.
>
> Based on 3.3-rc5 plus recent exynos cpuidle patch (affects exynos cpu=
idle only):
> http://www.spinics.net/lists/linux-samsung-soc/msg09467.html
>
> v6 submission tested successfully on Exynos (thanks Amit Kacchap) and=
 OMAP3
> (thanks Jean Pihet) platforms.
>
> v6 submission can be found here:
> http://www.spinics.net/lists/arm-kernel/msg162018.html
> Changes since v6:
> * Made some =A0struct whitespace alignment changes.
> * Fixed a coding style violation (thanks Jean Pihet)
> * Fixed a bug in davinci cpuidle (thanks Jean Pihet)
> * Corrected the common ARM cpuidle WFI state description to be ARM pl=
atform
> =A0agnostic (thanks Kevin Hilman)
> * Fixed the problem causing x86 and PPC builds to fail (thanks Deepth=
i)
> * Re-added a line of code that was mistakenly removed (thanks Deepthi=
)
>
> Robert Lee (9):
> =A0cpuidle: Add common time keeping and irq enabling
> =A0ARM: at91: Consolidate time keeping and irq enable
> =A0ARM: exynos: Consolidate time keeping and irq enable
> =A0ARM: kirkwood: Consolidate time keeping and irq enable
> =A0ARM: davinci: Consolidate time keeping and irq enable
> =A0ARM: omap: Consolidate OMAP3 time keeping and irq enable
> =A0ARM: omap: Consolidate OMAP4 time keeping and irq enable
> =A0ARM: shmobile: Consolidate time keeping and irq enable
> =A0SH: shmobile: Consolidate time keeping and irq enable
>
> =A0arch/arm/include/asm/cpuidle.h =A0 =A0 =A0 =A0| =A0 22 +++++++++
> =A0arch/arm/kernel/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/kernel/cpuidle.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 21 +++++++=
+
> =A0arch/arm/mach-at91/cpuidle.c =A0 =A0 =A0 =A0 =A0| =A0 67 +++++++++=
+-----------------
> =A0arch/arm/mach-davinci/cpuidle.c =A0 =A0 =A0 | =A0 82 +++++++++++++=
-------------------
> =A0arch/arm/mach-exynos/cpuidle.c =A0 =A0 =A0 =A0| =A0 53 ++---------=
----------
> =A0arch/arm/mach-kirkwood/cpuidle.c =A0 =A0 =A0| =A0 72 ++++++++-----=
---------------
> =A0arch/arm/mach-omap2/cpuidle34xx.c =A0 =A0 | =A0 42 +++++++--------=
--
> =A0arch/arm/mach-omap2/cpuidle44xx.c =A0 =A0 | =A0 21 +-------
> =A0arch/arm/mach-shmobile/cpuidle.c =A0 =A0 =A0| =A0 31 +++----------
> =A0arch/sh/kernel/cpu/shmobile/cpuidle.c | =A0 10 +---
> =A0drivers/cpuidle/cpuidle.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 79 +++++++=
++++++++++++++++++------
> =A0include/linux/cpuidle.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13 +++++=
-
> =A013 files changed, 233 insertions(+), 282 deletions(-)
> =A0create mode 100644 arch/arm/include/asm/cpuidle.h
> =A0create mode 100644 arch/arm/kernel/cpuidle.c
>
