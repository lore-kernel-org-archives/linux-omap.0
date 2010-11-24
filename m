From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt handlers
Date: Wed, 24 Nov 2010 10:03:24 -0800
Message-ID: <871v6aa9ar.fsf@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1011241141010.1513-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:49299 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab0KXSD2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 13:03:28 -0500
Received: by pxi15 with SMTP id 15so6714pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 10:03:28 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1011241141010.1513-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Wed, 24 Nov 2010 11:43:57 -0500 (EST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 23 Nov 2010, Kevin Hilman wrote:
>
>> While I like the idea of the symmetry of having both _get_sync() and
>> _put_sync() callable from an interrupt handler, I can't currently think
>> of a situation where we would need to _put_sync() in the ISR.  A
>> standard _put() should suffice for all cases I can imagine.
>
> It's wasteful to go through the context switch to the workqueue process
> if you don't need to.  And it's time consuming; you want to power down 
> the device as soon as possible once the interrupt handler is finished, 
> right?
>
> What do you think of the pm_runtime_put_sync_suspend() proposal?

That should be fine.

Thinking of this some more, I don't have any use cases currently where
we would any sort of put in the ISR, since the ISR is usually an
indicator that something else will be accessing the device shortly after
the ISR is finished.

Kevin



