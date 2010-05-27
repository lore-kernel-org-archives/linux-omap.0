From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:04:38 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005271901020.3032@localhost.localdomain>
References: <20100526133721.602633b2@schatten.dmk.lab> <AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com> <20100526142430.327ccbc4@schatten.dmk.lab> <20100526141612.3e2e0443@lxorguk.ukuu.org.uk> <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
 <20100527003943.07c17f85@lxorguk.ukuu.org.uk> <20100527140655.GA28048@srcf.ucam.org> <alpine.LFD.2.00.1005271642440.3032@localhost.localdomain> <20100527155201.GA31937@srcf.ucam.org> <20100527171615.15a1fd3d@lxorguk.ukuu.org.uk>
 <20100527161943.GA32764@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527161943.GA32764@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010, Matthew Garrett wrote:

> On Thu, May 27, 2010 at 05:16:15PM +0100, Alan Cox wrote:
> 
> > I can't speak for Thomas, but I'm certainly not arguing that you don't
> > need something that looks more like the blocker side of the logic *in
> > kernel*, because there is stuff that you want to express which isn't tied
> > to the task.
> 
> Sure, if you're not using opportunistic suspend then I don't think 
> there's any real need for the userspace side of this. The question is 
> how to implement something with the useful properties of opportunistic 
> suspend without without implementing something pretty much equivalent to 
> the userspace suspend blockers. I've sent another mail expressing why I 
> don't think your proposed QoS style behaviour provides that.

Opportunistic suspend is just a deep idle state, nothing else. If the
overall QoS requirements allow to enter that deep idle state then the
kernel goes there. Same decision as for all other idle states. You
don't need any user space blocker for this decision, just sensible QoS
information.

Stop thinking about suspend as a special mechanism. It's not - except
for s2disk, which is an entirely different beast.

Thanks,

	tglx
