From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Tue, 25 Jan 2011 13:37:52 +0000
Message-ID: <20110125133752.GI13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com> <20110124110609.GJ16202@n2100.arm.linux.org.uk> <20110124111114.GA19409@n2100.arm.linux.org.uk> <AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com> <20110125103231.GD11507@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101251418260.31804@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56873 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab1AYNi2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 08:38:28 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101251418260.31804@localhost6.localdomain6>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 25, 2011 at 02:23:10PM +0100, Thomas Gleixner wrote:
> On Tue, 25 Jan 2011, Russell King - ARM Linux wrote:
> > On Mon, Jan 24, 2011 at 11:39:13PM -0800, Colin Cross wrote:
> > > On Mon, Jan 24, 2011 at 3:11 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > On Mon, Jan 24, 2011 at 11:06:09AM +0000, Russell King - ARM Li=
nux wrote:
> > > >> On Mon, Jan 24, 2011 at 02:21:17PM +0530, Santosh Shilimkar wr=
ote:
> > > >> > In CPU low power state, local timer looses its register cont=
ext. This
> > > >> > patch adds context save restore hooks which can be used by p=
latforms
> > > >> > appropriately.
> > > >>
> > > >> I thought the whole point of CLOCK_EVT_FEAT_C3STOP was that th=
e generic
> > > >> timer stuff wouldn't rely on it being kept alive?
> > > >>
> > > >> Hmm, it looks like we bypass the clockevents code by only sett=
ing the
> > > >> TWD load value at initialization time, not when we switch to p=
eriodic
> > > >> mode. =A0We really ought to rewrite it whenever we switch back=
 to periodic
> > > >> mode.
> > > >>
> > > >> I suspect fixing that means you won't need this save/restore s=
upport.
> > > >
> > > > Untested, but should do what's required.
> > > >
> > > > diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_tw=
d.c
> > > > index fd91566..60636f4 100644
> > > > --- a/arch/arm/kernel/smp_twd.c
> > > > +++ b/arch/arm/kernel/smp_twd.c
> > > > @@ -36,6 +36,7 @@ static void twd_set_mode(enum clock_event_mod=
e mode,
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* timer load already set up */
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl =3D TWD_TIMER_CONTROL_ENABL=
E | TWD_TIMER_CONTROL_IT_ENABLE
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| TWD_TIMER_CONT=
ROL_PERIODIC;
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(twd_timer_rate / HZ,=
 twd_base + TWD_TIMER_LOAD);
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > > > =A0 =A0 =A0 =A0case CLOCK_EVT_MODE_ONESHOT:
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* period set, and timer enabled=
 in 'next_event' hook */
> > > > @@ -81,7 +82,7 @@ int twd_timer_ack(void)
> > > >
> > > > =A0static void __cpuinit twd_calibrate_rate(void)
> > > > =A0{
> > > > - =A0 =A0 =A0 unsigned long load, count;
> > > > + =A0 =A0 =A0 unsigned long count;
> > > > =A0 =A0 =A0 =A0u64 waitjiffies;
> > > >
> > > > =A0 =A0 =A0 =A0/*
> > > > @@ -116,10 +117,6 @@ static void __cpuinit twd_calibrate_rate(v=
oid)
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("%lu.%02luMHz.\n", twd_ti=
mer_rate / 1000000,
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(twd_timer_rate =
/ 1000000) % 100);
> > > > =A0 =A0 =A0 =A0}
> > > > -
> > > > - =A0 =A0 =A0 load =3D twd_timer_rate / HZ;
> > > > -
> > > > - =A0 =A0 =A0 __raw_writel(load, twd_base + TWD_TIMER_LOAD);
> > > > =A0}
> > > >
> > > > =A0/*
> > >=20
> > > This doesn't work for oneshot timers if the TWD_TIMER_CONTROL reg=
ister
> > > gets reset by cpu idle between twd_set_mode and twd_set_next_even=
t.
> > > Shadowing ctrl in a percpu variable and rewriting it during every=
 call
> > > to twd_set_next_event does work, but that's not much different, a=
nd a
> > > little less efficient, than just saving and restoring the control=
 and
> > > load registers in idle.  It does have the advantage that platform=
s
> > > don't need any extra calls.
> >=20
> > The next question is can we teach the generic time infrastructure a=
bout
> > this so we don't have to modify every clock event driver for it?  W=
e
> > really need to get away from having this kind of knowledge buried d=
own
> > in the lowest levels of every driver.
>=20
> In which way? I mean the generic code issues a call to the set_mode
> function when we leave the broadcast mode. So what should the generic
> code do more ?

I can't say because these patches only add the hooks, there's no
implementation yet which uses the hooks.

Given the description about _why_ those hooks are necessary, it seems
that something is required.  Either we start adding custom hacks to
each clockevent driver as is done with this patch, or we get some
generic help in place.

I'm not thrilled by the custom hack approach - and I thought the
clockevent stuff was created to stop this kind of thing happening.

I suggest we defer this until there's a visible use case available.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
