From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 22:38:19 +0100
Message-ID: <20100527213819.GB9916@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1005271724430.3239-100000@iolanthe.rowland.org> <alpine.LFD.2.00.1005272332320.3478@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005272332320.3478@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 11:33:32PM +0200, Thomas Gleixner wrote:
> On Thu, 27 May 2010, Alan Stern wrote:
> > The two of you are talking at cross purposes.  Thomas is referring to 
> > idle-based suspend and Matthew is talking about forced suspend.
> 
> Yes, and forced suspend to disk is the same as force suspend to disk,
> which has both nothing to do with sensible resource management.

It doesn't matter. Current forced suspend to RAM is racy with respect to 
wakeup events and should be fixed.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
