From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:18:58 +0100
Message-ID: <20100527181858.GK3543@srcf.ucam.org>
References: <20100527170740.GA1980@srcf.ucam.org> <1274980391.27810.5552.camel@twins> <20100527171644.GA2468@srcf.ucam.org> <1274980856.27810.5582.camel@twins> <20100527172510.GC2468@srcf.ucam.org> <1274981288.27810.5609.camel@twins> <20100527173218.GF2468@srcf.ucam.org> <1274981750.27810.5641.camel@twins> <20100527174140.GB3187@srcf.ucam.org> <alpine.LFD.2.00.1005272009380.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005272009380.3032@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 08:12:15PM +0200, Thomas Gleixner wrote:
> On Thu, 27 May 2010, Matthew Garrett wrote:
> > How long do you wait for applications to respond that they've stopped 
> > drawing? What if the application is heavily in swap at the time?
> 
> Very realistic scenario on a mobile phone. 

If the aim is to produce a solution that isn't special-cased to specific 
devices, thinking about how long an application may take to respond is 
entirely relevant.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
