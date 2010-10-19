From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Tue, 19 Oct 2010 23:57:33 +0200
Message-ID: <AANLkTimx8abJzUo-+BGbM6QxGdMF3dO=dbh_UG=FsWMZ@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <AANLkTimDdPUjo+65vBL0PTQ3b=5NpeVT28XrdkYqx3Ex@mail.gmail.com>
 <AANLkTinNfERyi_bTWc7LOKR1uRLC3E612ubFKBLxWB1E@mail.gmail.com> <201010192258.27988.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201010192258.27988.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Simon Que <sque@ti.com>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 19, 2010 at 10:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> If a hwspinlock is taken over a long period of time, its other user
>> (with which we try to achieve synchronization) might be polling the
>> OMAP interconnect for too long (trying to take the hwspinlock) and
>> thus preventing it to be used for other transactions.
>
> This sounds exactly like any other spinlock.

The difference is hardware-specific: the hwspinlock device is located
on the OMAP's L4 interconnect where access is slow, wasteful of power,
and spinning on it may prevent other peripherals from interconnecting.
