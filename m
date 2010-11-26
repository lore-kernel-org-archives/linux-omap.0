From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Fri, 26 Nov 2010 10:53:10 +0200
Message-ID: <AANLkTin5Tfcuy0WcHJ22rWC8niwZCj8SZAMKLz0p9jwc@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
 <1290526740-27624-2-git-send-email-ohad@wizery.com> <20101126045912.GC6598@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:65210 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab0KZIxc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 03:53:32 -0500
In-Reply-To: <20101126045912.GC6598@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hari Kanigeri <h-kanigeri2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@deeprootsystems.com>, akpm@linux-foundation.org, Suman Anna <s-anna@ti.com>

On Fri, Nov 26, 2010 at 6:59 AM, Olof Johansson <olof@lixom.net> wrote:
>> +#define pr_fmt(fmt) =A0 =A0"%s: " fmt, __func__
>
> Not used.

Yes, it is, check out how the pr_* macros are implemented:

#define pr_info(fmt, ...) \
        printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)

I use it to ensure that the function name is printed with any pr_*
macro, without having to explicitly specify the __func__ param every
time.


>> +int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned =
long *flags)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (unlikely(!hwlock)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("invalid hwlock\n");
>
> These kind of errors can get very spammy for buggy drivers.

Yeah, but that's the purpose - I want to catch such egregious drivers
who try to crash the kernel.

> It's likely
> more useful to either do a WARN_ON(), and/or move them under a debug
> config option.

Why would you prefer to compile out reporting of such extremely buggy b=
ehavior ?

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> + =A0 =A0 if (unlikely(mode =3D=3D HWLOCK_IRQSTATE && flags =3D=3D N=
ULL)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("invalid flags pointer (null)\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* This spin_lock{_irq, _irqsave} serves three purposes:
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* 1. Disable preemption, in order to minimize the perio=
d of time
>> + =A0 =A0 =A0* =A0 =A0in which the hwspinlock is taken. This is impo=
rtant in order
>> + =A0 =A0 =A0* =A0 =A0to minimize the possible polling on the hardwa=
re interconnect
>> + =A0 =A0 =A0* =A0 =A0by a remote user of this lock.
>> + =A0 =A0 =A0* 2. Make the hwspinlock SMP-safe (so we can take it fr=
om
>> + =A0 =A0 =A0* =A0 =A0additional contexts on the local host).
>> + =A0 =A0 =A0* 3. Ensure that in_atomic/might_sleep checks catch pot=
ential
>> + =A0 =A0 =A0* =A0 =A0problems with hwspinlock usage (e.g. scheduler=
 checks like
>> + =A0 =A0 =A0* =A0 =A0'scheduling while atomic' etc.)
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (mode =3D=3D HWLOCK_IRQSTATE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D spin_trylock_irqsave(&hwlock->lock=
, *flags);
>> + =A0 =A0 else if (mode =3D=3D HWLOCK_IRQ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D spin_trylock_irq(&hwlock->lock);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D spin_trylock(&hwlock->lock);
>> +
>> + =A0 =A0 /* is lock already taken by another context on the local c=
pu ? */
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> +
>> + =A0 =A0 /* try to take the hwspinlock device */
>> + =A0 =A0 ret =3D hwlock->ops->trylock(hwlock);
>> +
>> + =A0 =A0 /* if hwlock is already taken, undo spin_trylock_* and exi=
t */
>> + =A0 =A0 if (!ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mode =3D=3D HWLOCK_IRQSTATE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&hw=
lock->lock, *flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (mode =3D=3D HWLOCK_IRQ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&hwlock->l=
ock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&hwlock->lock)=
;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* We can be sure the other core's memory operations
>> + =A0 =A0 =A0* are observable to us only _after_ we successfully tak=
e
>> + =A0 =A0 =A0* the hwspinlock, so we must make sure that subsequent =
memory
>> + =A0 =A0 =A0* operations will not be reordered before we actually t=
ook the
>> + =A0 =A0 =A0* hwspinlock.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* Note: the implicit memory barrier of the spinlock abo=
ve is too
>> + =A0 =A0 =A0* early, so we need this additional explicit memory bar=
rier.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 mb();
>
> rmb() should be sufficient here.

It's not.

We need to make sure that our writes, too, will not be reordered
before that barrier. Otherwise, we might end up changing protected
shared memory during the critical section of the remote processor
(before we acquire the lock we must not read from, or write to, the
protected shared memory).

I guess I need to add a comment about this.

>> +int __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned l=
ong *flags)
>> +{
>> + =A0 =A0 if (unlikely(!hwlock)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("invalid hwlock\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> + =A0 =A0 if (unlikely(mode =3D=3D HWLOCK_IRQSTATE && flags =3D=3D N=
ULL)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("invalid flags pointer (null)\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* We must make sure that memory operations, done before=
 unlocking
>> + =A0 =A0 =A0* the hwspinlock, will not be reordered after the lock =
is released.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* That's the purpose of this explicit memory barrier.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* Note: the memory barrier induced by the spin_unlock b=
elow is too
>> + =A0 =A0 =A0* late; the other core is going to access memory soon a=
fter it will
>> + =A0 =A0 =A0* take the hwspinlock, and by then we want to be sure o=
ur memory
>> + =A0 =A0 =A0* operations are already observable.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 mb();
>
> wmb() should be sufficient here.

No - here, too, we need to make sure that also our read operations
will not be reordered after the barrier. Otherwise, we might end up
reading memory that has already been changed by a remote processor
that is just about to acquire the lock.

>
>> +
>> + =A0 =A0 hwlock->ops->unlock(hwlock);
>> +
>> + =A0 =A0 /* Undo the spin_trylock{_irq, _irqsave} called while lock=
ing */
>> + =A0 =A0 if (mode =3D=3D HWLOCK_IRQSTATE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&hwlock->lock, *fla=
gs);
>> + =A0 =A0 else if (mode =3D=3D HWLOCK_IRQ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&hwlock->lock);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&hwlock->lock);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(__hwspin_unlock);
>> +

>> + =A0 =A0 /* mark this hwspinlock as available */
>> + =A0 =A0 tmp =3D radix_tree_tag_set(&hwspinlock_tree, hwlock->id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HWSPINLOCK_UNUSED);
>> +
>> + =A0 =A0 /* this implies an unrecoverable bug. at least rant */
>> + =A0 =A0 WARN_ON(tmp !=3D hwlock);
>
> I don't see how this could ever happen?

It can't. Unless there's a bug somewhere.

That's why:
1. It is a WARN_ON - I don't care if someone compiles this out
2. There is no error handler for this (simply because there can never
be an error handler for buggy code). It's just a rant, meant to catch
an unlikely buggy event.

The reason I did this is because I like to check return values. Even
if it's only for sanity sake.

Since it's not a hot path this shouldn't matter to anyone, but if
people are still bothered by it, it can be removed.

>> +/**
>> + * hwspinlock_unregister() - unregister an hw spinlock
>> + * @id: index of the specific hwspinlock to unregister
>> + *
>> + * This function should be called from the underlying platform-spec=
ific
>> + * implementation, to unregister an existing (and unused) hwspinloc=
k.
>> + *
>> + * Can be called from an atomic context (will not sleep) but not fr=
om
>> + * within interrupt context.
>> + *
>> + * Returns the address of hwspinlock @id on success, or NULL on fai=
lure
>
> Why not just return int for success / fail and have the driver keep t=
rack
> of the lock pointers too?

Because it's elegant. This way drivers don't need to keep track of the =
pointers.

It can be changed, with an extra cost of code (duplicated for each
implementation) and memory, but why would we want to do that ?

> Or, if you for some reason is attached to the ptr-return case, please=
 make it return
> standard ERR_PTR instead.

ERR_PTR patterns have been reasonably argued against in the previous
discussion, and I heartily agreed (see
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37453.html).

>> + =A0 =A0 /* look for an unused lock */
>> + =A0 =A0 ret =3D radix_tree_gang_lookup_tag(&hwspinlock_tree, (void=
 **)&hwlock,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 0, 1, HWSPINLOCK_UNUSED);
>> + =A0 =A0 if (ret =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("a free hwspinlock is not availabl=
e\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 hwlock =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* sanity check: we shouldn't get more than we requested f=
or */
>> + =A0 =A0 WARN_ON(ret > 1);
>
> No need to check, unless you're debugging the radix code.

Again, this is me preferring to check return values for sanity sake.

The one time that this may yield true (e.g. code has erroneously
changed) is well worth it.

It shouldn't bother anyone since it's not a hot path, but as I said
earlier, if people don't like it that much, it can be removed.

>
>> + =A0 =A0 /* mark as used and power up */
>> + =A0 =A0 ret =3D __hwspinlock_request(hwlock);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 hwlock =3D NULL;
>> +
>> +out:
>> + =A0 =A0 spin_unlock(&hwspinlock_tree_lock);
>> + =A0 =A0 return hwlock;
>> +}
>> +EXPORT_SYMBOL_GPL(hwspinlock_request);
>> +
>
> [...]
>
>> +/**
>> + * hwspinlock_free() - free a specific hwspinlock
>> + * @hwlock: the specific hwspinlock to free
>> + *
>> + * This function mark @hwlock as free again.
>> + * Should only be called with an @hwlock that was retrieved from
>> + * an earlier call to omap_hwspinlock_request{_specific}.
>> + *
>> + * Can be called from an atomic context (will not sleep) but not fr=
om
>> + * within interrupt context (simply because there is no use case fo=
r
>> + * that yet).
>> + *
>> + * Returns 0 on success, or an appropriate error code on failure
>> + */
>> +int hwspinlock_free(struct hwspinlock *hwlock)
>> +{
>> + =A0 =A0 struct hwspinlock *tmp;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (!hwlock) {
>
> Some alloc/free APIs will just silently return for these cases.

True.

Some other free API will simply crash.

Does it bother so much if we stick to the safe side here ?

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("invalid hwlock\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_lock(&hwspinlock_tree_lock);
>> +
>> + =A0 =A0 /* make sure the hwspinlock is used */
>> + =A0 =A0 ret =3D radix_tree_tag_get(&hwspinlock_tree, hwlock->id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HWSPINLOCK_UNUSED);
>> + =A0 =A0 if (ret =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(hwlock->dev, "%s: hwlock is alread=
y free\n", __func__);
>
> Double free. WARN_ON() seems appropriate?

I don't want that this message will ever get compiled out.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* notify the underlying device that power is not needed *=
/
>> + =A0 =A0 ret =3D pm_runtime_put(hwlock->dev);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 /* mark this hwspinlock as available */
>> + =A0 =A0 tmp =3D radix_tree_tag_set(&hwspinlock_tree, hwlock->id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HWSPINLOCK_UNUSED);
>> +
>> + =A0 =A0 /* sanity check (this shouldn't happen) */
>> + =A0 =A0 WARN_ON(tmp !=3D hwlock);
>
> No need for this.

Please see explanations above why I added those sanity checks (despite
my explicit comment saying this shouldn't happen).


Thanks!
Ohad.

>
>> +
>> + =A0 =A0 module_put(hwlock->owner);
>> +
>> +out:
>> + =A0 =A0 spin_unlock(&hwspinlock_tree_lock);
>> + =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(hwspinlock_free);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Generic hardware spinlock interface");
>> +MODULE_AUTHOR("Ohad Ben-Cohen <ohad@wizery.com>");
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
