From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:12:15 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005272009380.3032@localhost.localdomain>
References: <20100527161943.GA32764@srcf.ucam.org> <alpine.LFD.2.00.1005271901020.3032@localhost.localdomain> <20100527170740.GA1980@srcf.ucam.org> <1274980391.27810.5552.camel@twins> <20100527171644.GA2468@srcf.ucam.org> <1274980856.27810.5582.camel@twins>
 <20100527172510.GC2468@srcf.ucam.org> <1274981288.27810.5609.camel@twins> <20100527173218.GF2468@srcf.ucam.org> <1274981750.27810.5641.camel@twins> <20100527174140.GB3187@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527174140.GB3187@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010, Matthew Garrett wrote:
> On Thu, May 27, 2010 at 07:35:50PM +0200, Peter Zijlstra wrote:
> > On Thu, 2010-05-27 at 18:32 +0100, Matthew Garrett wrote:
> > > On Thu, May 27, 2010 at 07:28:08PM +0200, Peter Zijlstra wrote:
> > > > Why would you care about the screen for a network event?
> > > 
> > > Because the application that needs to handle the network packet is 
> > > currently blocked trying to draw something to the screen.
> > 
> > Then that's an application bug right there, isn't it?
> > 
> > If should have listened to the window server telling its clients it was
> > going to go away. Drawing after you get that is your own damn fault ;-)
> 
> How long do you wait for applications to respond that they've stopped 
> drawing? What if the application is heavily in swap at the time?

Very realistic scenario on a mobile phone. 
