From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 13:36:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271334560.3239-100000@iolanthe.rowland.org>
References: <alpine.LFD.2.00.1005271905000.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42163 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932806Ab0E0RgN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 13:36:13 -0400
In-Reply-To: <alpine.LFD.2.00.1005271905000.3032@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, 27 May 2010, Thomas Gleixner wrote:

> Crap. Stop beating on those lost wakeup events. If we lose them then
> the drivers are broken and do not handle the switch over correctly. Or
> the suspend mechanism is broken as it does not evaluate the system
> state correctly. Blockers are just papering over that w/o tackling the
> real problem.

That's the point -- suspend does not evaluate the system state 
correctly because it doesn't have the necessary information.  Suspend 
blockers are a way of providing it that information.  They don't paper 
over the problem; they solve it.

Alan Stern

