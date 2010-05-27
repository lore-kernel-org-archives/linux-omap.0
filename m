From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:02:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271853430.29316-100000@netrider.rowland.org>
References: <20100527223512.GA11364@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:38691 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757931Ab0E0XCb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 19:02:31 -0400
In-Reply-To: <20100527223512.GA11364@srcf.ucam.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

Matthew:

Remind me why the idle/QOS power management approach won't work here.

If the difficulty is untrusted apps preventing the system from being
idle, why not assign them to QoS(NONE) as Thomas suggested?

If the difficulty is that some untrusted apps need to receive wakeup 
events, why not just decree that this is not allowed?  It seems 
reasonable that if you can't trust a program then you shouldn't allow 
it to wake up the system.

If the difficulty is that some trusted apps need to do CPU-burning
things like drawing bouncing cows in the background, why not break
these apps into two processes or threads?  One can be trusted and
receive all the wakeup events, and the other can be untrusted and draw
all the cows it likes.  We're only talking about trusted apps, most of
which would be controlled by Google, so the conversion shouldn't be too
hard.

If the difficulty is that ACPI-based systems can't use idle/QOS PM
effectively...  well, so be it.  We don't have to solve every problem
in the world right away, and just now we're mainly concerned about
helping the Android people.

Alan Stern

