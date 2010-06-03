From: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [linux-pm] [PATCH 0/8]
 Suspend block api (version 8)
Date: Thu, 3 Jun 2010 13:26:48 +1000
Message-ID: <20100603132648.3b1e265e@notabene.brown>
References: <20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
	<AANLkTimISbs4X2YR_Pal9A80mpkNyCy8laWBcOgR2Cl7@mail.gmail.com>
	<20100602210224.6ae2333f@notabene.brown>
	<20100602210521.54b9cd9b@schatten.dmk.lab>
	<20100602233243.GA27666@core.coreip.homeip.net>
	<AANLkTim3WQ6qgBH5Cx5tkf-LPtYZ7L6BN6OZIJpQbET1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTim3WQ6qgBH5Cx5tkf-LPtYZ7L6BN6OZIJpQbET1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-omap@vger.kernel.org

On Wed, 2 Jun 2010 19:44:59 -0700
Arve Hj=C3=B8nnev=C3=A5g <arve@android.com> wrote:

> On Wed, Jun 2, 2010 at 4:32 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Jun 02, 2010 at 09:05:21PM +0200, Florian Mickler wrote:
> >> On Wed, 2 Jun 2010 21:02:24 +1000
> >> Neil Brown <neilb@suse.de> wrote:
> >> >
> >> > And this decision (to block suspend) really needs to be made in =
the driver,
> >> > not in userspace?
> >>
> >> Well, it fits. The requirement is a direct consequence of the inti=
mate
> >> knowledge the driver has about the driven devices.
> >
> > That is not really true. A driver does have intimate knowledge of t=
he
> > device, however it does not necessarily have an idea about the data=
 read
> > from the device. Consider the gpio_matrix driver: Arve says that it=
 has
> > to continue scanning matrix once first interrupt arrvies. But it re=
ally
> > depends on what key has been pressed - if user pressed KEY_SUSPEND =
or
> > KEY_POWER it cmight be better if we did not wait for key release bu=
t
> > initiated the action right away. The decision on how system reacts =
to a
> > key press does not belong to the driver but really to userspace.
>=20
> If we just suspend while the keypad scan is active, a second press of
> KEY_POWER would not be able wake the device up. The gpio keypad matri=
x
> driver has two operating modes. No keys are pressed: all the outputs
> are active so a key press will generate an interrupt in one of the
> inputs. Keys are pressed: Activate a single output at a time so we ca=
n
> determine which keys are pressed. The second mode is entered when the
> driver gets an interrupt in the first mode. The first mode is entered
> if the scan detected that no keys are pressed. The driver could be
> modified to stop the scan on suspend and forcibly put the device back
> in no-keys-pressed state, but pressing additional keys connected to
> the same input can no longer generate any events (the input does not
> change).
>=20

Thanks for the detailed explanation.  That helps a lot.

I see that if follows that performing a suspend while keys are pressed =
would
not be good, and keys could be pressed for arbitrarily long periods.
It does not follow that the keypad driver should therefore explicitly d=
isable
suspend.  It could simply inform user-space that the keypad is in the
alternate scan mode, so user-space can choose not to enter suspend in a=
t that
time (i.e. policy in user-space).

I can see also how one might want to express this behaviour as a PM_QOS
constraint (now that I have read a bit about PM_QOS), but I cannot see =
that
you would need to.  As the keypad driver is polling during this mode, i=
t
would presumably set a timer that would fire in the near future, and th=
e very
existence of this timer (with a duration shorter than the S3 latency) w=
ould
be enough to ensure S3 wasn't automatically entered by PM.
At most you might use set_timer_slack to give a slightly higher upper b=
ound
to the timeout.

So if we take the suspend-from-idle approach, this driver needs no
annotation, and if we take the 'fix the suspend/wake-event race' then t=
his
driver needs no special treatment - just enough to close the race, and =
some
user-space policy support.

i.e. it doesn't seem to be a special case.

NeilBrown
