From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt
 handlers
Date: Wed, 24 Nov 2010 11:43:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011241141010.1513-100000@iolanthe.rowland.org>
References: <87mxozd1ho.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57953 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751443Ab0KXQn5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 11:43:57 -0500
In-Reply-To: <87mxozd1ho.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Tue, 23 Nov 2010, Kevin Hilman wrote:

> While I like the idea of the symmetry of having both _get_sync() and
> _put_sync() callable from an interrupt handler, I can't currently think
> of a situation where we would need to _put_sync() in the ISR.  A
> standard _put() should suffice for all cases I can imagine.

It's wasteful to go through the context switch to the workqueue process
if you don't need to.  And it's time consuming; you want to power down 
the device as soon as possible once the interrupt handler is finished, 
right?

What do you think of the pm_runtime_put_sync_suspend() proposal?

Alan Stern

