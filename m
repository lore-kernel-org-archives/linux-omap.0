From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:25:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005271924170.3032@localhost.localdomain>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010, Alan Stern wrote:

> On Thu, 27 May 2010, Felipe Balbi wrote:
> 
> > On Thu, May 27, 2010 at 05:06:23PM +0200, ext Alan Stern wrote:
> > >If people don't mind, here is a greatly simplified summary of the
> > >comments and objections I have seen so far on this thread:
> > >
> > >	The in-kernel suspend blocker implementation is okay, even
> > >	beneficial.
> > 
> > I disagree here. I believe expressing that as QoS is much better. Let 
> > the kernel decide which power state is better as long as I can say I 
> > need 100us IRQ latency or 100ms wakeup latency.
> 
> Does this mean you believe "echo mem >/sys/power/state" is bad and
> should be removed?  Or "echo disk >/sys/power/state"?  They pay no

mem should be replaced by an idle suspend to ram mechanism

> attention to latencies or other requirements.

s2disk is a totally different beast as it shuts down the box into the
complete power off state.

Thanks,

	tglx
