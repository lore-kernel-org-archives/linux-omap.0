From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 18:26:35 +0100
Message-ID: <20100527172635.GD2468@srcf.ucam.org>
References: <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com> <20100527003943.07c17f85@lxorguk.ukuu.org.uk> <20100527140655.GA28048@srcf.ucam.org> <alpine.LFD.2.00.1005271642440.3032@localhost.localdomain> <20100527155201.GA31937@srcf.ucam.org> <20100527171615.15a1fd3d@lxorguk.ukuu.org.uk> <20100527161943.GA32764@srcf.ucam.org> <alpine.LFD.2.00.1005271901020.3032@localhost.localdomain> <20100527170740.GA1980@srcf.ucam.org> <20100527183041.0487bdf8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100527183041.0487bdf8@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 06:30:41PM +0100, Alan Cox wrote:
> > > Opportunistic suspend is just a deep idle state, nothing else.
> > 
> > No. The useful property of opportunistic suspend is that nothing gets 
> > scheduled. That's fundamentally different to a deep idle state.
> 
> Nothing gets scheduled in a deep idle state either - its idle. We leave
> the idle state to schedule anything.

Certainly, if you can force the system to be idle then you don't need 
opportunistic suspend. But you haven't shown how to do that without it 
being racey.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
