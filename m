From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:47:27 +0200
Message-ID: <1274982447.27810.5684.camel@twins>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	 <alpine.LFD.2.00.1005271915540.3032@localhost.localdomain>
	 <20100527173118.GE2468@srcf.ucam.org> <1274981680.27810.5636.camel@twins>
	 <20100527174019.GA3187@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527174019.GA3187@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-05-27 at 18:40 +0100, Matthew Garrett wrote:
> On Thu, May 27, 2010 at 07:34:40PM +0200, Peter Zijlstra wrote:
> > > we still need to be able to enter suspend while the system isn't idle.
> > 
> > _WHY_!?
> 
> Because if I'm running a kernel build in a tmpfs and I hit the sleep 
> key, I need to go to sleep. Blocking processes on driver access isn't 
> sufficient.

But that's a whole different issue. I agree that a forced suspend for
things like that make sense, just not for power managing a running
system. PC style hardware like that doesn't wake up from suspend for
funny things like a keypress either (good thing too).

Anyway all that already works (more or less), so I don't see the
problem.
