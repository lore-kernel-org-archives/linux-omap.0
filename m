From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH ver. 2] PM: add synchronous runtime interface for interrupt handlers
Date: Mon, 22 Nov 2010 00:45:19 +0100
Message-ID: <201011220045.20059.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1011201437450.8483-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41620 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297Ab0KUXqJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Nov 2010 18:46:09 -0500
In-Reply-To: <Pine.LNX.4.44L0.1011201437450.8483-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org

On Saturday, November 20, 2010, Alan Stern wrote:
> On Sat, 20 Nov 2010, Alan Stern wrote:
> 
> > On Sat, 20 Nov 2010, Rafael J. Wysocki wrote:
> > 
> > > On Friday, November 19, 2010, Alan Stern wrote:
...
> > 
> > I don't think Linus will object to this.  What he doesn't like is when
> > some code drops a lock, reacquires it, and then behaves as though the
> > lock had been held all along.  That's not the case here; rpm_idle()  
> > does not depend on any state remaining unchanged across the callback.
> 
> One other thing I forgot to mention...  If Linus doesn't like the way
> the new code drops the spinlock and then reacquires it, then he must
> also not like the existing code, which does the same thing.  The only
> difference lies in whether or not interrupts are re-enabled.

The problem I have with this change is that switching interrupts off really is
a part of the locking operation, so using spin_unlock() after spin_lock_irq...()
is kind of like releasing the lock partially, which I don't think is valid
(even if we're going to reacquire the lock immediately).

Thanks,
Rafael
