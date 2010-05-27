From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:18:49 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005272015360.3032@localhost.localdomain>
References: <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com> <20100527003943.07c17f85@lxorguk.ukuu.org.uk> <20100527140655.GA28048@srcf.ucam.org> <alpine.LFD.2.00.1005271642440.3032@localhost.localdomain> <20100527155201.GA31937@srcf.ucam.org>
 <alpine.LFD.2.00.1005271808340.3032@localhost.localdomain> <20100527165931.GB1062@srcf.ucam.org> <alpine.LFD.2.00.1005271905000.3032@localhost.localdomain> <20100527172343.GB2468@srcf.ucam.org> <20100527184918.3d090921@lxorguk.ukuu.org.uk>
 <20100527175030.GA3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527175030.GA3543@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010, Matthew Garrett wrote:

> On Thu, May 27, 2010 at 06:49:18PM +0100, Alan Cox wrote:
> > > ACPI provides no guarantees about what level of hardware functionality 
> > > remains during S3. You don't have any useful ability to determine which 
> > > events will generate wakeups. And from a purely practical point of view, 
> > > since the latency is in the range of seconds, you'll never have a low 
> > > enough wakeup rate to hit it.
> > 
> > So PCs with current ACPI don't get opportunistic suspend capability. It
> > probably won't be supported on the Commodore Amiga either - your point ?
> 
> Actually, the reverse - there's no terribly good way to make PCs work 
> with scheduler-based suspend, but there's no reason why they wouldn't 
> work with the current opportunistic suspend implementation.

How does that solve the problems you mentioned above ? Wakeup
guarantees, latencies ...

It's not a prove of the technical correctness of the approach if it
can provide a useless functionality.
 
Thanks,

	tglx
