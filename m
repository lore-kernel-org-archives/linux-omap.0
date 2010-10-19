From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Tue, 19 Oct 2010 19:21:20 +0200
Message-ID: <201010191921.21007.arnd@arndb.de>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com> <1287387875-14168-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1287387875-14168-2-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 18 October 2010 09:44:33 Ohad Ben-Cohen wrote:
> +  int omap_hwspin_lock(struct omap_hwspinlock *hwlock, unsigned long *flags);
> ...
> +     The flags parameter is a pointer to where the interrupts state of the
> +     caller will be saved at.

This seems to encourage sloppy coding: The only variant you allow is the one
that corresponds to Linux's spin_lock_irqsave(), which is generally discouraged
in all places where you know if you need to disable interrupts or not.

IMHO the default should be a version that only allows locks that don't get
taken at IRQ time and consequently don't require saving the interrupt flags.

	Arnd
