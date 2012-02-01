From: Don Zickus <dzickus@redhat.com>
Subject: Re: In many cases softlockup can not be reported after disabling IRQ
 for long time
Date: Wed, 1 Feb 2012 09:58:02 -0500
Message-ID: <20120201145802.GF5650@redhat.com>
References: <CAOwKts8zS1rYA+Y4k-vb8YAaR=aFd1BwryhhWWnWLQyrYrNqyA@mail.gmail.com>
 <20120131154748.GA5650@redhat.com>
 <CAOwKts_dTvc4LiCZUXN9oYzty1pkDEn_VQwPKY=EoVzk0n6tFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOwKts_dTvc4LiCZUXN9oYzty1pkDEn_VQwPKY=EoVzk0n6tFA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 01, 2012 at 10:18:09AM +0800, TAO HU wrote:
> Hi, Don
>=20
> Thanks for your feedback!
>=20
> Unfortunately, the hardlockup depends on NMI which is not available o=
n
> ARM (Cortex-A9) per my understanding.
> Our system uses OMAP4430. Any more suggestions?

Ah.  I wrongly assumed this is x86. Sorry about that.

Ok, so this is what is going on.  The softlockup check is just a high
priority thread that periodically runs.  If preemption is disabled that
thread can't run (or any threads for that matter) and a softlockup
condition will exist.  However, in order to determine that, a periodic
hrtimer has to come along and do the actual check.

If that check fails, then the warning is printed out.  However that
accuracy is based on the resolution of that hrtimer which I set to abou=
t
1/5 the watchdog threshold or 1 second in this case.

Unfortunately, if you disable the irqs, then that timer can't fire and =
now
we don't have a way to trigger the softlockup check until interrupts ar=
e
re-enabled.

On x86, we have a backup plan for disabled interrupts and that is the
hardlockup check which rely on NMIs (something that still fires even wh=
en
interrupts are disabled).

If on ARM you don't have NMIs, then it will be difficult to check for
softlockups when interrupts are disabled.  Though I do recall sparc doi=
ng
something clever like using IRQ0 as a special purpose IRQ to emulate an
NMI (IOW, software purposely avoided masking IRQ0).  So when an interru=
pt
came in on that irq, it was never blocked and always ran based on the i=
rq
nesting rules.

I don't know ARM well enough to give any solution for your problem, but=
 my
reason above is why it isn't working the way you intended.

Cheers,
Don

>=20
> On Tue, Jan 31, 2012 at 11:47 PM, Don Zickus <dzickus@redhat.com> wro=
te:
> > On Tue, Jan 31, 2012 at 03:28:09PM +0800, TAO HU wrote:
> >> Resend with a new subject
> >>
> >> On Wed, Jan 25, 2012 at 4:24 PM, TAO HU <tghk48@motorola.com> wrot=
e:
> >> > Hi, All
> >> >
> >> > While playing kernel 3.0.8 with below test code, it does NOT rep=
ort
> >> > any softlockup with 60%~70% chances.
> >> > NOTE: the softlockup timeout is set to 10 seconds (i.e.
> >> > watchdog_thresh=3D5) in my test.
> >> > ... ...
> >> > preempt_disable();
> >> > local_irq_disable();
> >> > for (i =3D 0; i < 20; i++)
> >> > =A0 =A0 =A0 mdelay(1000);
> >> > local_irq_enable();
> >> > preempt_enable();
> >> > ... ...
> >> >
> >> > However, if I remove local_irq_disable()/local_irq_enable() it w=
ill
> >> > report softlockup with no problem.
> >> > I believe it is due to that after local_irq_enable()
> >> > touch_softlockup_watchdog() is called prior softlockup timer.
> >
> > Hi Hu,
> >
> > Honestly, you should be getting hardlockup warnings if you are disa=
bling
> > interrupts. =A0Do you see anything in the console output?
> >
> > Cheers,
> > Don
>=20
>=20
>=20
> --=20
> Best Regards
> Hu Tao
