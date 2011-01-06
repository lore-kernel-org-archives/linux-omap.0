From: Paul Walmsley <paul@pwsan.com>
Subject: Re: linux-next: manual merge of the usb tree with the omap tree
Date: Thu, 6 Jan 2011 11:27:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101061126440.31961@utopia.booyaka.com>
References: <20101223171859.f6842045.sfr@canb.auug.org.au> <4D139517.3010608@ti.com> <AANLkTi=pTNg2iWN+=uEv=CyZHHCoddF51pmmCMjPeMUF@mail.gmail.com> <4ce0f816f951f24ca3de9c84d9f70842@mail.gmail.com> <4D25E313.4060202@heeltoe.com>
 <8B3471BB-CB3F-4CE6-B523-D9C5E87B9CEC@dominion.thruhere.net> <87pqs9vqya.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pqs9vqya.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, Brad Parker <brad@heeltoe.com>, Anand Gadiyar <gadiyar@ti.com>, Ming Lei <tom.leiming@gmail.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 6 Jan 2011, Kevin Hilman wrote:

> Koen Kooi <koen@dominion.thruhere.net> writes:
> 
> > Op 6 jan 2011, om 16:43 heeft Brad Parker het volgende geschreven:
> >
> >> It's probably expected, but I can't get the EHCI USB port  to work
> >> on a beagle board XM (36xx) using the current omap tree.
> >> 
> >> It this most likely due to these clock issues?
> >
> > You need this patch: http://thread.gmane.org/gmane.linux.ports.arm.omap/47807/
> >
> > I'm currently too lazy to split it up like Nishant wants as I don't
> > see the point splitting for the sake of splitting.--
> 
> IMO, it doesn't need to be split up.
> 
> But it does have to fix the other comments I made on the same thread[1]
> 
> 1) add a descriptive changelog, and
> 2) Cc linux-arm-kernel

and glancing at the patch

3) Fix the multiline comments to conform to Documentation/CodingStyle

as I think Nishanth mentioned.


- Paul
