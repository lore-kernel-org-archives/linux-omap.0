From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 0/4] Introduce hardware spinlock framework
Date: Tue, 14 Dec 2010 16:31:36 +0200
Message-ID: <AANLkTin1fd=Kei7Fo6G+uR+270HdTkc71fvsA6qjBjcA@mail.gmail.com>
References: <1291420247-18171-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291420247-18171-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

Hi Greg, Tony,

On Sat, Dec 4, 2010 at 1:50 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> OMAP4 introduces a Hardware Spinlock device, which provides hardware
> assistance for synchronization and mutual exclusion between heterogen=
eous
> processors and those not operating under a single, shared operating s=
ystem
> (e.g. OMAP4 has dual Cortex-A9, dual Cortex-M3 and a C64x+ DSP).
>
> The intention of this hardware device is to allow remote processors,
> that have no alternative mechanism to accomplish synchronization and =
mutual
> exclusion operations, to share resources (such as memory and/or any o=
ther
> hardware resource).
>
> This patchset adds hwspinlock framework that makes it possible
> for drivers to use those hwspinlock devices and stay platform-indepen=
dent.

=2E..

> =A0Documentation/hwspinlock.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0299 =
+++++++++++++++
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
1 +
> =A0arch/arm/mach-omap2/hwspinlock.c =A0 =A0 =A0 =A0 =A0 | =A0 63 ++++
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 64 ++++
> =A0drivers/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A02 +
> =A0drivers/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A01 +
> =A0drivers/hwspinlock/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2=
2 ++
> =A0drivers/hwspinlock/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
6 +
> =A0drivers/hwspinlock/hwspinlock.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 61 ++=
+
> =A0drivers/hwspinlock/hwspinlock_core.c =A0 =A0 =A0 | =A0557 ++++++++=
++++++++++++++++++++
> =A0drivers/hwspinlock/omap_hwspinlock.c =A0 =A0 =A0 | =A0231 ++++++++=
++++
> =A0include/linux/hwspinlock.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A029=
8 +++++++++++++++
> =A012 files changed, 1605 insertions(+), 0 deletions(-)

Can you please have a look and say if this looks OK ?

If it does, where would you prefer this to go through ?

Thanks,
Ohad.
