From: "Kamoolkar, Mugdha" <mugdha@ti.com>
Subject: RE: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Thu, 25 Nov 2010 11:35:02 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247931C4B@dbde02.ent.ti.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
 <1290526740-27624-2-git-send-email-ohad@wizery.com>
 <B85A65D85D7EB246BE421B3FB0FBB59302479315FB@dbde02.ent.ti.com>
 <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47984 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811Ab0KYGF7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 01:05:59 -0500
In-Reply-To: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Anna, Suman" <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>

Ohad,

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
> Sent: Thursday, November 25, 2010 1:29 AM
> To: Kamoolkar, Mugdha
> Cc: linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org; linux-a=
rm-
> kernel@lists.infradead.org; akpm@linux-foundation.org; Greg KH; Tony
> Lindgren; Cousson, Benoit; Grant Likely; Kanigeri, Hari; Anna, Suman;
> Kevin Hilman; Arnd Bergmann
> Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framewor=
k
>=20
> Hi Mugdha,
>=20
> On Wed, Nov 24, 2010 at 9:44 AM, Kamoolkar, Mugdha <mugdha@ti.com> wr=
ote:
> > How do multiple clients get a handle that they can use? Are they
> expected to
> > share the handle they get from the call above?
>=20
> Currently, yes.
>=20
> > What if they are independent
> > clients with no means of communication between them? There may be a=
 need
> of
> > an API that returns the handle for a specific ID. For example, a mo=
dule
> over
> > the hwspinlock driver that does some level of management of IDs (e.=
g.
> name
> > to ID mapping) and enables users to get multi-core as well as multi=
-
> client
> > protection on Linux.
>=20
> I'm not sure I understand the use case. Can you please elaborate ?
>=20
Consider a software module on top of the hwspinlock, which provides a=20
generic way for multi-core critical section, say GateMP. This module en=
ables=20
users to create critical section objects by name. Any other client can =
open=20
the critical section by name and get a handle to it. I would expect thi=
s=20
module to make a call to request a resource when creating the GateMP ob=
ject.=20
Suppose that the object is actually created by the remote core, and the=
 call=20
comes to Linux on the host processor to allocate the system resource (a=
s the=20
owner of the system resources). It will call hwspinlock_request, get a=20
handle, get the ID from it, and return the ID to the remote processor. =
There=20
is no point in the remote processor holding the handle that's not valid=
 in=20
its virtual space. The ID, in this case, is the single portable value t=
hat=20
every processor understands in a different way. When this object were b=
eing=20
deleted, the ID would be passed to Linux, and a corresponding Linux ent=
ity=20
would then have to get the handle from the ID and call _free.

Similarly, suppose the creation is happening from user-space, the user-=
space=20
object should store the ID in the user object, and get the handle from =
the=20
ID when performing any actions on the lock from kernel-side.

> > For example:
> > struct hwspinlock *hwspinlock_get_handle(unsigned int id);
>=20
> I'm afraid such an API will be easily abused, e.g., drivers that will
> try to use a predefined hwspinlock id without taking care of reservin=
g
> it early enough will probably use it to overcome an "oops this
> hwspinlock has already been assigned to someone else".
>=20
Really? Why would they intentionally destabilize the system like this??=
?

> So let me suggest we should first understand the use case for the API
> you propose, and then see how we solve it ?
>=20
> > Why are some of the APIs hwspinlock_ and others hwspin_?
>=20
> I'm following the regular spinlock naming, which nicely avoids having
> the word 'lock' twice in the API. So you get APIs like hwspin_lock,
> hwspin_unlock, hwspin_trylock. In our case we still have stuff like
> hwspinlock_request and hwspinlock_free. I can probably make it
> hwspin_lock_request, does that look nicer ?
>=20
No real issues with this, just seems less intuitive. I just expected al=
l the=20
module APIs to follow same convention <module>_API to make them more=20
intuitive.

> >> + =A0int hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned l=
ong
> timeout);
> >> + =A0 - lock a previously-assigned hwspinlock with a timeout limit
> (specified in
> >> + =A0 =A0 jiffies). If the hwspinlock is already taken, the functi=
on will
> busy
> >> loop
> >> + =A0 =A0 waiting for it to be released, but give up when the time=
out meets
> >> jiffies.
> >> + =A0 =A0 If timeout is 0, the function will never give up (theref=
ore if a
> faulty
> >> + =A0 =A0 remote core never releases the hwspinlock, it will deadl=
ock).
> > If timeout is 0, shouldn't it rather behave as a trylock? If timeou=
t is
> > MAX_SCHEDULE_TIMEOUT, then it should behave as a wait-forever.
>=20
> Good point, thanks!
>=20
> >> + =A0int hwspin_trylock(struct hwspinlock *hwlock);
> >> + =A0 - attempt to lock a previously-assigned hwspinlock, but imme=
diately
> fail
> >> if
> >> + =A0 =A0 it is already taken.
> >> + =A0 =A0 Upon a successful return from this function, preemption =
is
> disabled so
> >> + =A0 =A0 caller must not sleep, and is advised to release the hws=
pinlock
> as soon
> >> as
> >> + =A0 =A0 possible, in order to minimize remote cores polling on t=
he
> hardware
> >> + =A0 =A0 interconnect.
> >> + =A0 =A0 Returns 0 on success and an appropriate error code other=
wise
> (most
> >> + =A0 =A0 notably -EBUSY if the hwspinlock was already taken).
> >> + =A0 =A0 The function will never sleep.
> > Is this function needed at all if timeout 0 behaves similar to tryl=
ock?
>=20
> Yeah. Drivers should use the _trylock version when applicable because
> it'd make the code more readable, and it's more intuitive (just like
> the spin_trylock API).
Agreed.

>=20
> >> + =A0struct hwspinlock *hwspinlock_unregister(unsigned int id);
> >> + =A0 - to be called from the underlying vendor-specific implement=
ation,
> in
> >> order
> >> + =A0 =A0 to unregister an existing (and unused) hwspinlock instan=
ce.
> >> + =A0 =A0 Can be called from an atomic context (will not sleep) bu=
t not
> from
> >> + =A0 =A0 within interrupt context.
> >> + =A0 =A0 Returns the address of hwspinlock on success, or NULL on=
 error
> (e.g.
> >> + =A0 =A0 if the hwspinlock is sill in use).
> > Does this need to be called for all hwspinlocks?
>=20
> Currently, yes.
>=20
Ok, that should be fine.

> I actually am planning an improvement that would allow registering a
> block of hwspinlocks; I don't think that the multiple calls of
> register/unregister is that bad (it happens only once at boot), but I
> want to allow sharing of the owner, ops and dev members of the
> hwspinlock instances (to save some memory).
>=20
> Anyway, it's not a big improvement, so I planned first to get things
> merged and then look into stuff like that.
>=20
> >> +int __hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned lon=
g to,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 int mode, unsigned long *flags)
> >> +{
> >> + =A0 =A0 int ret;
> >> +
> >> + =A0 =A0 for (;;) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Try to take the hwspinlock */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __hwspin_trylock(hwlock, mode, f=
lags);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D -EBUSY)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* The lock is already taken, let's ch=
eck if the user
> wants
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* us to try again
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (to && time_is_before_eq_jiffies(to))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Allow platform-specific relax handl=
ers to prevent
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* hogging the interconnect (no sleepi=
ng, though)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (hwlock->ops->relax)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hwlock->ops->relax(hwloc=
k);
> > There should be a way to have an escape mechanism for the case wher=
e a
> deadlock
> > has occurred due to remote side taking the spinlock and crashing.
>=20
> This is exactly what the timeout parameter is for..
>=20
I was looking at the situation where someone does not use the lock with=
=20
timeout. In that case, do we say that there's no way out? And the syste=
m=20
will hang and need a re-boot? Or do we still want to enable some way to=
=20
forcibly break the wait after it has happened for an unreasonably long =
time?

> Thanks,
> Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
