From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 13:41:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271340030.3239-100000@iolanthe.rowland.org>
References: <alpine.LFD.2.00.1005271924170.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1005271924170.3032@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010, Thomas Gleixner wrote:

> > Does this mean you believe "echo mem >/sys/power/state" is bad and
> > should be removed?  Or "echo disk >/sys/power/state"?  They pay no
> 
> mem should be replaced by an idle suspend to ram mechanism

In other words, you are suggesting that not only should the Android
patches not be accepted, in addition a large part of the PM suspend
framework should be rewritten?

Alan Stern
