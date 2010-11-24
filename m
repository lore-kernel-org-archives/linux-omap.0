From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Wed, 24 Nov 2010 21:59:15 +0200
Message-ID: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
 <1290526740-27624-2-git-send-email-ohad@wizery.com> <B85A65D85D7EB246BE421B3FB0FBB59302479315FB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36270 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079Ab0KXT7h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 14:59:37 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302479315FB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kamoolkar, Mugdha" <mugdha@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Anna, Suman" <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>

Hi Mugdha,

On Wed, Nov 24, 2010 at 9:44 AM, Kamoolkar, Mugdha <mugdha@ti.com> wrot=
e:
> How do multiple clients get a handle that they can use? Are they expe=
cted to
> share the handle they get from the call above?

Currently, yes.

> What if they are independent
> clients with no means of communication between them? There may be a n=
eed of
> an API that returns the handle for a specific ID. For example, a modu=
le over
> the hwspinlock driver that does some level of management of IDs (e.g.=
 name
> to ID mapping) and enables users to get multi-core as well as multi-c=
lient
> protection on Linux.

I'm not sure I understand the use case. Can you please elaborate ?

> For example:
> struct hwspinlock *hwspinlock_get_handle(unsigned int id);

I'm afraid such an API will be easily abused, e.g., drivers that will
try to use a predefined hwspinlock id without taking care of reserving
it early enough will probably use it to overcome an "oops this
hwspinlock has already been assigned to someone else".

So let me suggest we should first understand the use case for the API
you propose, and then see how we solve it ?

> Why are some of the APIs hwspinlock_ and others hwspin_?

I'm following the regular spinlock naming, which nicely avoids having
the word 'lock' twice in the API. So you get APIs like hwspin_lock,
hwspin_unlock, hwspin_trylock. In our case we still have stuff like
hwspinlock_request and hwspinlock_free. I can probably make it
hwspin_lock_request, does that look nicer ?

>> + =A0int hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned lon=
g timeout);
>> + =A0 - lock a previously-assigned hwspinlock with a timeout limit (=
specified in
>> + =A0 =A0 jiffies). If the hwspinlock is already taken, the function=
 will busy
>> loop
>> + =A0 =A0 waiting for it to be released, but give up when the timeou=
t meets
>> jiffies.
>> + =A0 =A0 If timeout is 0, the function will never give up (therefor=
e if a faulty
>> + =A0 =A0 remote core never releases the hwspinlock, it will deadloc=
k).
> If timeout is 0, shouldn't it rather behave as a trylock? If timeout =
is
> MAX_SCHEDULE_TIMEOUT, then it should behave as a wait-forever.

Good point, thanks!

>> + =A0int hwspin_trylock(struct hwspinlock *hwlock);
>> + =A0 - attempt to lock a previously-assigned hwspinlock, but immedi=
ately fail
>> if
>> + =A0 =A0 it is already taken.
>> + =A0 =A0 Upon a successful return from this function, preemption is=
 disabled so
>> + =A0 =A0 caller must not sleep, and is advised to release the hwspi=
nlock as soon
>> as
>> + =A0 =A0 possible, in order to minimize remote cores polling on the=
 hardware
>> + =A0 =A0 interconnect.
>> + =A0 =A0 Returns 0 on success and an appropriate error code otherwi=
se (most
>> + =A0 =A0 notably -EBUSY if the hwspinlock was already taken).
>> + =A0 =A0 The function will never sleep.
> Is this function needed at all if timeout 0 behaves similar to tryloc=
k?

Yeah. Drivers should use the _trylock version when applicable because
it'd make the code more readable, and it's more intuitive (just like
the spin_trylock API).

>> + =A0struct hwspinlock *hwspinlock_unregister(unsigned int id);
>> + =A0 - to be called from the underlying vendor-specific implementat=
ion, in
>> order
>> + =A0 =A0 to unregister an existing (and unused) hwspinlock instance=
=2E
>> + =A0 =A0 Can be called from an atomic context (will not sleep) but =
not from
>> + =A0 =A0 within interrupt context.
>> + =A0 =A0 Returns the address of hwspinlock on success, or NULL on e=
rror (e.g.
>> + =A0 =A0 if the hwspinlock is sill in use).
> Does this need to be called for all hwspinlocks?

Currently, yes.

I actually am planning an improvement that would allow registering a
block of hwspinlocks; I don't think that the multiple calls of
register/unregister is that bad (it happens only once at boot), but I
want to allow sharing of the owner, ops and dev members of the
hwspinlock instances (to save some memory).

Anyway, it's not a big improvement, so I planned first to get things
merged and then look into stuff like that.

>> +int __hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned long =
to,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 int mode, unsigned long *flags)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 for (;;) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Try to take the hwspinlock */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __hwspin_trylock(hwlock, mode, fla=
gs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D -EBUSY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* The lock is already taken, let's chec=
k if the user wants
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* us to try again
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (to && time_is_before_eq_jiffies(to))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Allow platform-specific relax handler=
s to prevent
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* hogging the interconnect (no sleeping=
, though)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (hwlock->ops->relax)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hwlock->ops->relax(hwlock)=
;
> There should be a way to have an escape mechanism for the case where =
a deadlock
> has occurred due to remote side taking the spinlock and crashing.

This is exactly what the timeout parameter is for..

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
