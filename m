From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 18:16:44 +0100
Message-ID: <20100527171644.GA2468@srcf.ucam.org>
References: <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com> <20100527003943.07c17f85@lxorguk.ukuu.org.uk> <20100527140655.GA28048@srcf.ucam.org> <alpine.LFD.2.00.1005271642440.3032@localhost.localdomain> <20100527155201.GA31937@srcf.ucam.org> <20100527171615.15a1fd3d@lxorguk.ukuu.org.uk> <20100527161943.GA32764@srcf.ucam.org> <alpine.LFD.2.00.1005271901020.3032@localhost.localdomain> <20100527170740.GA1980@srcf.ucam.org> <1274980391.27810.5552.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1274980391.27810.5552.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 07:13:11PM +0200, Peter Zijlstra wrote:
> On Thu, 2010-05-27 at 18:07 +0100, Matthew Garrett wrote:
> > No. The useful property of opportunistic suspend is that nothing gets 
> > scheduled. That's fundamentally different to a deep idle state.
> 
> I think Alan and Thomas but certainly I am saying is that you can get to
> the same state without suspend.
> 
> Either you suspend (forcefully don't schedule stuff), or you end up
> blocking all tasks on QoS/resource limits and end up with an idle system
> that goes into a deep idle state (aka suspend).
>
> So why isn't blocking every task on a QoS/resource good enough for you?

Because you may then block them in such a way that they never handle an 
event that should wake them.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
