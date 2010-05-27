From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 22:08:08 +0100
Message-ID: <20100527210808.GB8865@srcf.ucam.org>
References: <20100527165210.GA1062@srcf.ucam.org> <20100527190204.14546caa@lxorguk.ukuu.org.uk> <20100527181239.GF3543@srcf.ucam.org> <20100527194840.5bca973f@lxorguk.ukuu.org.uk> <20100527185658.GA5703@srcf.ucam.org> <20100527202538.7d2d7f3c@lxorguk.ukuu.org.uk> <20100527192926.GA6977@srcf.ucam.org> <20100527205333.676ad65e@lxorguk.ukuu.org.uk> <20100527201155.GB7449@srcf.ucam.org> <20100527215347.431c4934@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100527215347.431c4934@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 09:53:47PM +0100, Alan Cox wrote:
> > Not lost, but not delivered. So you need your policy agent to send 
> 
> it will be delivered next time the process wakes. It's not lost.
> 
> > SIGCONT when you receive any wakeup event, which either means proxying 
> > all your network traffic through your policy agent or having some 
> > mechanism for alerting the policy agent whenever you leave the deep idle 
> > state.
> 
> You didn't mention that requirement last time.

I thought it was pretty obvious that wakeup events had to actually be 
delivered to the applications that are listening for them.

> > > > also the race of an application being in the middle of handling a wakeup 
> > > > event when you send it the signal.
> > > 
> > > sigmask()
> > 
> > Doesn't help - I may be hit by the signal between the poll() unblocking 
> > and me having the opportunity to call sigmask().
> 
> ppoll(). This is all existing solved stuff.

Isn't that the inverse of what we want? The application should default 
to being SIGSTOPpable except in the case of it being in the process of 
having a specific event delivered.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
