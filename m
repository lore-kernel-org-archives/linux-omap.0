From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/6] gpio/omap: Some more driver cleanup and fixes
Date: Thu, 23 Feb 2012 17:56:33 +0530
Message-ID: <CAMQu2gzdfxJms8cc3VhsVzhGq4f8x1QeY6LU6X+2eFZ4_Yv_bw@mail.gmail.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, grant.likely@secretlab.ca, khilman@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 23, 2012 at 5:40 PM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> The cleanup is mostly getting rid of redundant fields in struct gpio_=
bank{}
> as we already have them as part of bank->context now. Also, remove un=
-used
> variable from gpio_irq_handler.
>
> The fix include correction of _set_gpio_irqenable() implementation an=
d fix
> type mismatch of gpio trigger parameter.
>
> It is baselined on top of Kevin's following series:
> gpio/omap: cleanup and runtime PM conversion for v3.4
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.g=
it for_3.4/gpio/runtime-pm-cleanup
>
> I have applied Benoit's GPIO patches in following series on top of Ke=
vin's
> before applying my changes.
> gpio/omap: Cleanup and adaptation to Device Tree
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.=
git for_3.4/dt_gpio
>
> Series is available here for reference:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-=
omap-dev for_3.4/gpio_further_cleanup_fixes
>
> Power Test: Off-mode and Retention on OMAP3430 (Suspend and Idle path=
s).
> Functional Test: OMAP2430, OMAP3430SDP, ZOOM3, OMAP4430, OMAP4-BLAZE
>
> Tarun Kanti DebBarma (6):
> =A0gpio/omap: remove saved_fallingdetect, saved_risingdetect fields
> =A0gpio/omap: remove saved_wakeup field from struct gpio_bank
> =A0gpio/omap: remove suspend_wakeup field from struct gpio_bank
> =A0gpio/omap: get rid of retrigger variable in gpio_irq_handler
> =A0gpio/omap: fix trigger type to unsigned
> =A0gpio/omap: fix _set_gpio_irqenable implementation
>
> =A0drivers/gpio/gpio-omap.c | =A0 56 +++++++++++++++++++-------------=
-------------
> =A01 files changed, 24 insertions(+), 32 deletions(-)
>
Nice clean-up series. I have gone through this series one more time
Thanks for updating change-logs. I noticed you dropped the edge trigger=
ed
irq wakeup fix....I see on the list now.... Kevin has fixed that alread=
y.

Series looks good to me. You can add:
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
