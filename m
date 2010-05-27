From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 23:55:13 +0200
Message-ID: <201005272355.13222.rjw@sisk.pl>
References: <20100527140655.GA28048@srcf.ucam.org> <20100527182058.GL3543@srcf.ucam.org> <20100527200950.44305cef@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527200950.44305cef@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Gleixner <tglx@linutronix.de>, Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 27 May 2010, Alan Cox wrote:
> > > If one works so does the other.
> > 
> > Not at all. The entire point of opportunistic suspend is that I don't 
> > care is currently in TASK_RUNNABLE or has a timer that's due to expire 
> > in 100msec - based on policy (through not having any held suspend 
> > blockers), I'll go to sleep. That's easily possible on PCs.
> 
> Yes I appreciate what suspend blockers are trying to do. Now how does
> that connect with my first sentence ?

I guess what Matthew wanted to say was that you couldn't use ACPI S3 as
a very deep CPU idle state, because of the way wakeup sources are set up
for it, while you could use it for aggressive power management with suspend
blockers as proposed by Arve.

Rafael
