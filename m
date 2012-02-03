From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v9 00/25] gpio/omap: driver cleanup and fixes
Date: Fri, 03 Feb 2012 13:01:16 -0800
Message-ID: <87pqdv4oo3.fsf@ti.com>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 2 Feb 2012 23:00:26 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tarun,

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:
>   Linus Torvalds (1):
>         Linux 3.3-rc2
>
> are available in the git repository at:
> http://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev
> Branch: for_3.4/gpio_cleanup_fixes_v9
>
> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.

This version is looking pretty good, and I'm almost ready to queue it up
for Grant.

However, one more minor nit.  Please fix up the compile warnings when
built without CONFIG_PM_SLEEP or CONFIG_PM_RUNTIME.

The definitons of the dev_pm_ops callbacks need to be conditional when
using the SET_*_PM_OPS() macros, otherwise you get these warnings:

  CC      drivers/gpio/gpio-omap.o
/work/kernel/omap/pm/drivers/gpio/gpio-omap.c:1142:12: warning: 'omap_gpio_suspend' defined but not used [-Wunused-function]
/work/kernel/omap/pm/drivers/gpio/gpio-omap.c:1167:12: warning: 'omap_gpio_resume' defined but not used [-Wunused-function]
/work/kernel/omap/pm/drivers/gpio/gpio-omap.c:1191:12: warning: 'omap_gpio_runtime_suspend' defined but not used [-Wunused-function]
/work/kernel/omap/pm/drivers/gpio/gpio-omap.c:1237:12: warning: 'omap_gpio_runtime_resume' defined but not used [-Wunused-function]


Thanks,

Kevin
