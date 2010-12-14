From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 0/4] Introduce hardware spinlock framework
Date: Tue, 14 Dec 2010 09:06:56 -0800
Message-ID: <20101214170656.GA3832@kroah.com>
References: <1291420247-18171-1-git-send-email-ohad@wizery.com>
 <AANLkTin1fd=Kei7Fo6G+uR+270HdTkc71fvsA6qjBjcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTin1fd=Kei7Fo6G+uR+270HdTkc71fvsA6qjBjcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 14, 2010 at 04:31:36PM +0200, Ohad Ben-Cohen wrote:
> Hi Greg, Tony,
>=20
> On Sat, Dec 4, 2010 at 1:50 AM, Ohad Ben-Cohen <ohad@wizery.com> wrot=
e:
> > OMAP4 introduces a Hardware Spinlock device, which provides hardwar=
e
> > assistance for synchronization and mutual exclusion between heterog=
eneous
> > processors and those not operating under a single, shared operating=
 system
> > (e.g. OMAP4 has dual Cortex-A9, dual Cortex-M3 and a C64x+ DSP).
> >
> > The intention of this hardware device is to allow remote processors=
,
> > that have no alternative mechanism to accomplish synchronization an=
d mutual
> > exclusion operations, to share resources (such as memory and/or any=
 other
> > hardware resource).
> >
> > This patchset adds hwspinlock framework that makes it possible
> > for drivers to use those hwspinlock devices and stay platform-indep=
endent.
>=20
> ...
>=20
> > =A0Documentation/hwspinlock.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A029=
9 +++++++++++++++
> > =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
1 +
> > =A0arch/arm/mach-omap2/hwspinlock.c =A0 =A0 =A0 =A0 =A0 | =A0 63 ++=
++
> > =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 64 ++++
> > =A0drivers/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +
> > =A0drivers/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A01 +
> > =A0drivers/hwspinlock/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 22 ++
> > =A0drivers/hwspinlock/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A06 +
> > =A0drivers/hwspinlock/hwspinlock.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 61 =
+++
> > =A0drivers/hwspinlock/hwspinlock_core.c =A0 =A0 =A0 | =A0557 ++++++=
++++++++++++++++++++++
> > =A0drivers/hwspinlock/omap_hwspinlock.c =A0 =A0 =A0 | =A0231 ++++++=
++++++
> > =A0include/linux/hwspinlock.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
298 +++++++++++++++
> > =A012 files changed, 1605 insertions(+), 0 deletions(-)
>=20
> Can you please have a look and say if this looks OK ?

Look at what, I don't see a patch here.

I've seen a lot of discussion about this, are all of the review comment=
s
now addressed?  Like the most important one, why is this generic code i=
f
it's only for one specific platform?

thanks,

greg k-h
