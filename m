From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 18:07:40 +0100
Message-ID: <20100527170740.GA1980@srcf.ucam.org>
References: <20100526142430.327ccbc4@schatten.dmk.lab> <20100526141612.3e2e0443@lxorguk.ukuu.org.uk> <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com> <20100527003943.07c17f85@lxorguk.ukuu.org.uk> <20100527140655.GA28048@srcf.ucam.org> <alpine.LFD.2.00.1005271642440.3032@localhost.localdomain> <20100527155201.GA31937@srcf.ucam.org> <20100527171615.15a1fd3d@lxorguk.ukuu.org.uk> <20100527161943.GA32764@srcf.ucam.org> <alpine.LFD.2.00.1005271901020.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005271901020.3032@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 07:04:38PM +0200, Thomas Gleixner wrote:
> On Thu, 27 May 2010, Matthew Garrett wrote:
> > Sure, if you're not using opportunistic suspend then I don't think 
> > there's any real need for the userspace side of this. The question is 
> > how to implement something with the useful properties of opportunistic 
> > suspend without without implementing something pretty much equivalent to 
> > the userspace suspend blockers. I've sent another mail expressing why I 
> > don't think your proposed QoS style behaviour provides that.
> 
> Opportunistic suspend is just a deep idle state, nothing else.

No. The useful property of opportunistic suspend is that nothing gets 
scheduled. That's fundamentally different to a deep idle state.

> Stop thinking about suspend as a special mechanism. It's not - except
> for s2disk, which is an entirely different beast.

On PCs, suspend has more in common with s2disk than it does C states.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
