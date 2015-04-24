From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/5] PM / clock_ops: provide default runtime ops and
 cleanup users
Date: Fri, 24 Apr 2015 16:51:03 +0200
Message-ID: <CAMuHMdWMjULD8jQDA-U6tumnCd=Q7jhZ2koha4CKU-K50tJXmw@mail.gmail.com>
References: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
	<2234398.3O5UMXvvlN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <2234398.3O5UMXvvlN@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 24, 2015 at 4:41 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, April 23, 2015 02:03:08 PM Rajendra Nayak wrote:
>> Most users of PM clocks do the exact same thing in runtime callbacks.
>> Provide default callbacks and cleanup the existing users (keystone/davinci
>> /omap1/sh)
>>
>> Rajendra Nayak (5):
>>   PM / clock_ops: Provide default runtime ops to users
>>   arm: keystone: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>>   arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>>   arm: davinci: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>>   drivers: sh: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>>
>>  arch/arm/mach-davinci/pm_domain.c  | 32 +-------------------------
>>  arch/arm/mach-keystone/pm_domain.c | 33 +-------------------------
>>  arch/arm/mach-omap1/pm_bus.c       | 37 ++----------------------------
>>  drivers/base/power/clock_ops.c     | 38 ++++++++++++++++++++++++++++++
>>  drivers/sh/pm_runtime.c            | 47 ++------------------------------------
>>  include/linux/pm_clock.h           | 10 ++++++++
>>  6 files changed, 54 insertions(+), 143 deletions(-)
>
> It is not particularly clear to me who is supposed to apply this series, but
> I can do that if people don't have problems with that.

All later patches depend on the first patch.

For shmobile, Simon has queued up changes for drivers/sh/pm_runtime.c,
but I think they don't conflict with this series.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
