From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:20:58 +0100
Message-ID: <20100527182058.GL3543@srcf.ucam.org>
References: <20100527140655.GA28048@srcf.ucam.org> <alpine.LFD.2.00.1005271642440.3032@localhost.localdomain> <20100527155201.GA31937@srcf.ucam.org> <alpine.LFD.2.00.1005271808340.3032@localhost.localdomain> <20100527165931.GB1062@srcf.ucam.org> <alpine.LFD.2.00.1005271905000.3032@localhost.localdomain> <20100527172343.GB2468@srcf.ucam.org> <20100527184918.3d090921@lxorguk.ukuu.org.uk> <20100527175030.GA3543@srcf.ucam.org> <20100527191716.16b4a8e3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100527191716.16b4a8e3@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 07:17:16PM +0100, Alan Cox wrote:
> > Actually, the reverse - there's no terribly good way to make PCs work 
> > with scheduler-based suspend, but there's no reason why they wouldn't 
> > work with the current opportunistic suspend implementation.
> 
> If one works so does the other.

Not at all. The entire point of opportunistic suspend is that I don't 
care is currently in TASK_RUNNABLE or has a timer that's due to expire 
in 100msec - based on policy (through not having any held suspend 
blockers), I'll go to sleep. That's easily possible on PCs.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
