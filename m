From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:17:12 +0100
Message-ID: <20100527181712.GI3543@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org> <alpine.LFD.2.00.1005271915540.3032@localhost.localdomain> <20100527173118.GE2468@srcf.ucam.org> <alpine.LFD.2.00.1005271959450.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005271959450.3032@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 08:05:39PM +0200, Thomas Gleixner wrote:

> You're just not getting it. If user space has consumed the event is
> not relevant at all.
> 
> What's relevant is whether the app has processed the event and reacted
> accordingly. That's all that matters.

And how do you know that? We can't rely on the process scheduler.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
