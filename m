From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Tue, 19 Oct 2010 22:51:22 +0200
Message-ID: <AANLkTinXR7OcfTpA6cWhRGzceekD6KQgnxOLeBKXP3WB@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287387875-14168-2-git-send-email-ohad@wizery.com> <201010191921.21007.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201010191921.21007.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 19, 2010 at 7:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 18 October 2010 09:44:33 Ohad Ben-Cohen wrote:
>> + =A0int omap_hwspin_lock(struct omap_hwspinlock *hwlock, unsigned l=
ong *flags);
>> ...
>> + =A0 =A0 The flags parameter is a pointer to where the interrupts s=
tate of the
>> + =A0 =A0 caller will be saved at.
>
> This seems to encourage sloppy coding: The only variant you allow is =
the one
> that corresponds to Linux's spin_lock_irqsave()

Yes, this is a hardware requirement to minimize the period of time in
which the hwspinlock is taken, in order to prevent lengthy polling on
the interconnect (preventing it from serving other transactions).

>, which is generally discouraged
> in all places where you know if you need to disable interrupts or not=
=2E
>
> IMHO the default should be a version that only allows locks that don'=
t get
> taken at IRQ time and consequently don't require saving the interrupt=
 flags.

Please note that the hwspinlocks should never be used to achieve
synchronization with Linux contexts running on the same cpu - it's
always about achieving mutual exclusion with a remote processor.

So whether the lock is taken at IRQ time or not does not affect the
requirement to disable interrupts while it is taken (very differently
from local spin_lock{_irqsave} synchronizations).

Thanks,
Ohad.

>
> =A0 =A0 =A0 =A0Arnd
>
