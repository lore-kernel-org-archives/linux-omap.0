From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH ver. 3] PM: add synchronous runtime interface for interrupt handlers
Date: Thu, 25 Nov 2010 21:03:29 +0100
Message-ID: <201011252103.29401.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1011251052010.22247-100000@netrider.rowland.org> <201011251958.49249.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56043 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab0KYUEQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 15:04:16 -0500
In-Reply-To: <201011251958.49249.oliver@neukum.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Thursday, November 25, 2010, Oliver Neukum wrote:
> Am Donnerstag, 25. November 2010, 16:52:39 schrieb Alan Stern:
> > When a device is declared irq-safe in this way, the PM core increments
> > the parent's usage count, so the parent will never be runtime
> > suspended.  This prevents difficult situations in which an irq-safe
> > device can't resume because it is forced to wait for its non-irq-safe
> > parent.
> 
> Shouldn't you walk further up the tree if the parent itself is irq-safe?
> It seems like a waste of power to not suspend a paren, that can be
> woken in irq.

Then we should walk up the tree if the parent's parent is irq-safe and so
on, which would make us spend uncertain amount of time in the ISR (or generally
with interrupts off).  I think it's safer not to do that.

Thanks,
Rafael
