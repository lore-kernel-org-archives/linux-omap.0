From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions void
Date: Thu, 23 Jan 2014 08:40:01 +0100
Message-ID: <20140123074001.GA3080@samfundet.no>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Yijing Wang <wangyijing@huawei.com>
Cc: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@ke
List-Id: linux-omap@vger.kernel.org

Around Thu 23 Jan 2014 15:12:46 +0800 or thereabout, Yijing Wang wrote:
> Currently, clocksource_register() and __clocksource_register_scale()
> functions always return 0, it's pointless, make functions void.
> And remove the dead code that check the clocksource_register_hz()
> return value.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

For the avr32 related change

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/arm/mach-davinci/time.c                    |    5 ++---
>  arch/arm/mach-msm/timer.c                       |    4 +---
>  arch/arm/mach-omap2/timer.c                     |    8 +++-----
>  arch/avr32/kernel/time.c                        |    4 +---
>  arch/blackfin/kernel/time-ts.c                  |    6 ++----
>  arch/microblaze/kernel/timer.c                  |    3 +--
>  arch/mips/jz4740/time.c                         |    6 +-----
>  arch/mips/loongson/common/cs5536/cs5536_mfgpt.c |    3 ++-
>  arch/openrisc/kernel/time.c                     |    3 +--
>  arch/powerpc/kernel/time.c                      |    6 +-----
>  arch/um/kernel/time.c                           |    6 +-----
>  arch/x86/platform/uv/uv_time.c                  |   14 ++++++--------
>  drivers/clocksource/acpi_pm.c                   |    3 ++-
>  drivers/clocksource/cadence_ttc_timer.c         |    6 +-----
>  drivers/clocksource/exynos_mct.c                |    4 +---
>  drivers/clocksource/i8253.c                     |    3 ++-
>  drivers/clocksource/mmio.c                      |    3 ++-
>  drivers/clocksource/samsung_pwm_timer.c         |    5 +----
>  drivers/clocksource/scx200_hrt.c                |    3 ++-
>  drivers/clocksource/tcb_clksrc.c                |    8 +-------
>  drivers/clocksource/timer-marco.c               |    2 +-
>  drivers/clocksource/timer-prima2.c              |    2 +-
>  drivers/clocksource/vt8500_timer.c              |    4 +---
>  include/linux/clocksource.h                     |    8 ++++----
>  kernel/time/clocksource.c                       |    6 ++----
>  kernel/time/jiffies.c                           |    3 ++-
>  26 files changed, 45 insertions(+), 83 deletions(-)

<snipp diffs>

-- 
HcE
