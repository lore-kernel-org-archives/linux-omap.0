From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/6] gpio/omap: Some more driver cleanup and fixes
Date: Mon, 12 Mar 2012 11:34:25 -0600
Message-ID: <20120312173425.A6B893E07B0@localhost>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com> <CAMQu2gzdfxJms8cc3VhsVzhGq4f8x1QeY6LU6X+2eFZ4_Yv_bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMQu2gzdfxJms8cc3VhsVzhGq4f8x1QeY6LU6X+2eFZ4_Yv_bw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 23 Feb 2012 17:56:33 +0530, "Shilimkar, Santosh" <santosh.shili=
mkar@ti.com> wrote:
> On Thu, Feb 23, 2012 at 5:40 PM, Tarun Kanti DebBarma
> <tarun.kanti@ti.com> wrote:
> > The cleanup is mostly getting rid of redundant fields in struct gpi=
o_bank{}
> > as we already have them as part of bank->context now. Also, remove =
un-used
> > variable from gpio_irq_handler.
> >
> > The fix include correction of _set_gpio_irqenable() implementation =
and fix
> > type mismatch of gpio trigger parameter.
> >
> > It is baselined on top of Kevin's following series:
> > gpio/omap: cleanup and runtime PM conversion for v3.4
> > git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm=
=2Egit for_3.4/gpio/runtime-pm-cleanup
> >
> > I have applied Benoit's GPIO patches in following series on top of =
Kevin's
> > before applying my changes.
> > gpio/omap: Cleanup and adaptation to Device Tree
> > git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-d=
t.git for_3.4/dt_gpio
> >
> > Series is available here for reference:
> > git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linu=
x-omap-dev for_3.4/gpio_further_cleanup_fixes
> >
> > Power Test: Off-mode and Retention on OMAP3430 (Suspend and Idle pa=
ths).
> > Functional Test: OMAP2430, OMAP3430SDP, ZOOM3, OMAP4430, OMAP4-BLAZ=
E
> >
> > Tarun Kanti DebBarma (6):
> > =C2=A0gpio/omap: remove saved_fallingdetect, saved_risingdetect fie=
lds
> > =C2=A0gpio/omap: remove saved_wakeup field from struct gpio_bank
> > =C2=A0gpio/omap: remove suspend_wakeup field from struct gpio_bank
> > =C2=A0gpio/omap: get rid of retrigger variable in gpio_irq_handler
> > =C2=A0gpio/omap: fix trigger type to unsigned
> > =C2=A0gpio/omap: fix _set_gpio_irqenable implementation
> >
> > =C2=A0drivers/gpio/gpio-omap.c | =C2=A0 56 +++++++++++++++++++-----=
---------------------
> > =C2=A01 files changed, 24 insertions(+), 32 deletions(-)
> >
> Nice clean-up series. I have gone through this series one more time
> Thanks for updating change-logs. I noticed you dropped the edge trigg=
ered
> irq wakeup fix....I see on the list now.... Kevin has fixed that alre=
ady.
>=20
> Series looks good to me. You can add:
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

What's the status of this series?  Should I be expecting a v2?  Or am I=
 supposed
to pick up this one? (a pull req would make things easier for me)

g.
