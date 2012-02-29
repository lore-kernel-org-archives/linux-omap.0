From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v6 0/9] Consolidate cpuidle functionality
Date: Wed, 29 Feb 2012 10:40:28 +0100
Message-ID: <CAORVsuXvv+1r0rz=AMSNxWoKfGi+k_6=OXRFxbA=ST-M4vCeRg@mail.gmail.com>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Robert Lee <rob.lee@linaro.org>
Cc: len.brown@intel.com, khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Rob,

On Wed, Feb 29, 2012 at 4:11 AM, Robert Lee <rob.lee@linaro.org> wrote:
> This patch series moves various functionality duplicated in platform
> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> disabling was removed as it appears that all calls into
> cpuidle_call_idle will have already called local_irq_disable().
>
> NOTE to Maintainers: Platform code changes are not required due to patch 1/9
> but please review and push these platform changes as possible to allow
> this consolidation to occur.
>
> Based on 3.3-rc5 plus recent exynos cpuidle patch (affect exynos cpuidle only):
> http://www.spinics.net/lists/linux-samsung-soc/msg09467.html
>
> v5 submission can be found here:
> http://www.spinics.net/lists/arm-kernel/msg161596.html
> Changes since v5:
> * Fixed mindless bug in CONFIG_ARCH_HAS_RELAX code in drivers/cpuidle/cpuidle.c
> * Removed inline from wrapper function (thanks Mike Turquette and Rob Herring)
> * Add zeroing out of last_residency if error value is returned (thanks Mike)
> * Made drivers/cpuidle/cpuidle.c more intelligently handle en_core_tk_irqen
> flag allowing removal of the if (en_core_tk_irqen) in cpuidle_idle_call (thanks
> Daniel Lezcano)
> * Moved CPUIDLE_ARM_WFI_STATE macro to arch/arm/include/asm/cpuidle.h (thanks
> Jean Pihet)
> * Cleaned up some comments and a stray change (thanks Jean)

Except the comments I sent to the list, this version looks good:
Acked-by: Jean Pihet <j-pihet@ti.com>

Tested OK using cpuidle in RETention and OFF modes on Beagleboard
(OMAP3530 ES2.1):
Tested-by: Jean Pihet <j-pihet@ti.com>

Thanks & regards,
Jean
