From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Tue, 30 Nov 2010 11:00:58 -0800
Message-ID: <20101130190058.GX17222@atomide.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
 <1290526740-27624-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1290526740-27624-2-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

* Ohad Ben-Cohen <ohad@wizery.com> [101123 07:27]:
> Add a common, platform-independent, hwspinlock framework.
> 
> Hardware spinlock devices are needed, e.g., in order to access data
> that is shared between remote processors, that otherwise have no
> alternative mechanism to accomplish synchronization and mutual exclusion
> operations.

<snip>

> +  int hwspin_lock(struct hwspinlock *hwlock);
> +   - lock a previously assigned hwspinlock. If the hwspinlock is already
> +     taken, the function will busy loop waiting for it to be released.
> +     Note: if a faulty remote core never releases this lock, this function
> +     will deadlock.
> +     This function will fail only if hwlock is invalid. Otherwise, it will
> +     always succeed (or deadlock; see above) and it will never sleep.
> +     Upon a successful return from this function, preemption is disabled so
> +     the caller must not sleep, and is advised to release the hwspinlock as
> +     soon as possible, in order to minimize remote cores polling on the
> +     hardware interconnect.
...

> +  int hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned long timeout);
> +   - lock a previously-assigned hwspinlock with a timeout limit (specified in
> +     jiffies). If the hwspinlock is already taken, the function will busy loop
> +     waiting for it to be released, but give up when the timeout meets jiffies.
> +     If timeout is 0, the function will never give up (therefore if a faulty
> +     remote core never releases the hwspinlock, it will deadlock).
> +     Upon a successful return from this function, preemption is disabled so
> +     the caller must not sleep, and is advised to release the hwspinlock as
> +     soon as possible, in order to minimize remote cores polling on the
> +     hardware interconnect.
> +     Returns 0 when successful and an appropriate error code otherwise (most
> +     notably -ETIMEDOUT if the hwspinlock is still busy after timeout meets
> +     jiffies). The function will never sleep.

Do we even need the hwspin_lock variants, why can't we always use the
hwspin_lock_timeout variants?

To me the idea of looping waiting for some external system to release
a lock is not a good idea..

Regards,

Tony
