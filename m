From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:28:08 +0200
Message-ID: <1274981288.27810.5609.camel@twins>
References: <20100527140655.GA28048@srcf.ucam.org>
	 <alpine.LFD.2.00.1005271642440.3032@localhost.localdomain>
	 <20100527155201.GA31937@srcf.ucam.org>
	 <20100527171615.15a1fd3d@lxorguk.ukuu.org.uk>
	 <20100527161943.GA32764@srcf.ucam.org>
	 <alpine.LFD.2.00.1005271901020.3032@localhost.localdomain>
	 <20100527170740.GA1980@srcf.ucam.org> <1274980391.27810.5552.camel@twins>
	 <20100527171644.GA2468@srcf.ucam.org> <1274980856.27810.5582.camel@twins>
	 <20100527172510.GC2468@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527172510.GC2468@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-05-27 at 18:25 +0100, Matthew Garrett wrote:
> On Thu, May 27, 2010 at 07:20:56PM +0200, Peter Zijlstra wrote:
> 
> > Suppose X (or whatever windowing system) will block all clients that try
> > to draw when you switch off your screen.
> > 
> > How would we not wake them when we do turn the screen back on and start
> > servicing the pending requests again?
> 
> How (and why) does the WoL (which may be *any* packet, not just a magic 
> one) turn the screen back on?

Why would you care about the screen for a network event?
