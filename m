From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Thu, 21 Oct 2010 11:04:28 +0200
Message-ID: <201010211104.28555.arnd@arndb.de>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com> <201010192308.02018.arnd@arndb.de> <AANLkTikz-_qhjygzek4tR0CtDLih3ZQyy1mPKnXAiOiV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikz-_qhjygzek4tR0CtDLih3ZQyy1mPKnXAiOiV@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-arm-kernel@lists.infradead.org, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 21 October 2010, Ohad Ben-Cohen wrote:
> This sounds like adding a set of API that resembles spin_{unlock,lock}_irq.
> 
> My gut feeling here is that while this may be useful and simple at
> certain places, it is somewhat error prone; a driver which would
> erroneously use this at the wrong place will end up enabling
> interrupts where it really shouldn't.
> 
> Don't you feel that proving a simple spin_lock_irqsave-like API is
> actually safer and less error prone ?
> 
> I guess that is one of the reasons why spin_lock_irqsave is much more
> popular than spin_lock_irq - people just know it will never screw up.

People can screw that up in different ways, e.g.

	spin_lock_irqsave(&lock_a, flags);
	spin_lock_irqsave(&lock_b, flags); /* overwrites flags */

	spin_lock_irqrestore(&lock_b, flags);
	spin_lock_irqrestore(&lock_a, flags); /* still disabled! */

I use the presence of spin_lock_irqsave in driver code as an indication
of whether the author had any clue about locking. Most experienced
coders use the right version intuitively, while beginners often just
use _irqsave because they didn't understand the API and they were told
that using this is safe.

	Arnd
