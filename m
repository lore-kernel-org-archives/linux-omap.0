From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 13:29:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271327560.3239-100000@iolanthe.rowland.org>
References: <1274980420.27810.5557.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1274980420.27810.5557.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Thomas Gleixner <tglx@linutronix.de>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010, Peter Zijlstra wrote:

> On Thu, 2010-05-27 at 13:04 -0400, Alan Stern wrote:
> > 
> > Does this mean you believe "echo mem >/sys/power/state" is bad and
> > should be removed?  Or "echo disk >/sys/power/state"?  They pay no
> > attention to latencies or other requirements. 
> 
> Those are a whole different beast, those are basically a quick-off
> button like thing. Forced suspend is conceptually a very different beast
> from power-saving a running system.

They may be different conceptually.  Nevertheless, Android uses forced 
suspend as a form of power saving.  Until better mechanisms are in 
place, it makes sense.

Alan Stern
