From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] PM / clock_ops: provide default runtime ops and
 cleanup users
Date: Fri, 24 Apr 2015 09:57:17 +0200
Message-ID: <CAPDyKFpAm+DK4SUK_Oc7Fb+jEEQvO3355qWp52nmkJs2YX5T4A@mail.gmail.com>
References: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 23 April 2015 at 10:33, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Most users of PM clocks do the exact same thing in runtime callbacks.
> Provide default callbacks and cleanup the existing users (keystone/davinci
> /omap1/sh)
>
> Rajendra Nayak (5):
>   PM / clock_ops: Provide default runtime ops to users
>   arm: keystone: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>   arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>   arm: davinci: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>   drivers: sh: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>
>  arch/arm/mach-davinci/pm_domain.c  | 32 +-------------------------
>  arch/arm/mach-keystone/pm_domain.c | 33 +-------------------------
>  arch/arm/mach-omap1/pm_bus.c       | 37 ++----------------------------
>  drivers/base/power/clock_ops.c     | 38 ++++++++++++++++++++++++++++++
>  drivers/sh/pm_runtime.c            | 47 ++------------------------------------
>  include/linux/pm_clock.h           | 10 ++++++++
>  6 files changed, 54 insertions(+), 143 deletions(-)

I guess you don't need more acks/reviewed by for this patchset. Still,
and also for my own reference.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
