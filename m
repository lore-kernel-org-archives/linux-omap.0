From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Fri, 26 Nov 2010 09:34:53 +0200
Message-ID: <AANLkTi=sZ-4BBLAJNU5B41cAxtroGkpNomgEYO4vtx8z@mail.gmail.com>
References: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
 <536589.12568.qm@web180310.mail.gq1.yahoo.com> <AANLkTinQdNC0XaOqNyDbdYE6ZcP0QyzpN492j=Kovuea@mail.gmail.com>
 <1290716548.2529.136.camel@helium>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290716548.2529.136.camel@helium>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: MugdhaKamoolkar <mugdha@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, BenoitCousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, HariKanigeri <h-kanigeri2@ti.com>, SumanAnna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 25, 2010 at 10:22 PM, David Brownell <david-b@pacbell.net> =
wrote:
> So there's no strong reason to think this is
> actually "ggeneric". =A0Function names no longer
> specify OMAP, but without other hardware under
> the interface, calling it "generic" reflects
> more optimism than reality. =A0(That was the
> implication of my observations...)

Well, it's not omap-specific anymore. Drivers can stay
platform-agnostic, and other vendors can plug in anything they need in
order to use the same drivers (including software implementations as
mentioned below).

As I mentioned, the other two options are going back to an omap
specific driver (which will omapify drivers who use it), or putting
the driver in the omap arch folders (which some people doesn't seem to
like, e.g. http://www.spinics.net/lists/linux-arm-msm/msg00324.html).

Which one of those would you prefer to see ?

I guess that by now we have all three implementations so it's pretty
easy to switch :)

> To find other hardware spinlocks, you might be
> able to look at fault tolerant multiprocessors.
> Ages ago I worked with one of those, where any
> spinlock failures integrated with CPU/OS fault
> detection; HW cwould yank (checkpointed) CPU boards
> off the bus so they could be recovered (some
> might continue later from checkpoints, etc.)...

Is that HW supported by Linux today ?

Any chance you can share a link or any other info about it ?

>> This way platforms [2] can easily plug into the framework anything
>> they need to achieve multi-core synchronization. E.g., even in case =
a
>> platform doesn't have dedicated silicon, but still need this
>> functionality, it can still plug in an implementation which is based
>> on Peterson's shared memory mutual exclusion algorithm
>
> And maybe also standard Linux spinlocks?

Umm, possibly. Though I admit it sounds awkward a bit. It feels like
platforms, on which a mere spinlock is enough to achieve multi core
synchronization, will not really need any of the IPC drivers that are
going to use this hwspinlock framework. But I guess we need to see a
use case first.

>
> I seem to recall some iterations of the real-time patches doing a lot=
 of
> work to generalize spinlocks, since they needed multiple variants. =A0=
It
> might be worth following in those footsteps. =A0(Though I'm not sure =
they
> were thinking much about hardware support .

Any chance you can point me at a specific discussion or patchset that
you feel may be relevant ?

Thanks!
Ohad.

>
> - Dave
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
