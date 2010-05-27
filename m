From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 22:36:35 +0100
Message-ID: <20100527213635.GA9916@srcf.ucam.org>
References: <20100527155201.GA31937@srcf.ucam.org> <20100527171615.15a1fd3d@lxorguk.ukuu.org.uk> <20100527161943.GA32764@srcf.ucam.org> <alpine.LFD.2.00.1005271901020.3032@localhost.localdomain> <20100527170740.GA1980@srcf.ucam.org> <1274980391.27810.5552.camel@twins> <20100527171644.GA2468@srcf.ucam.org> <1274980856.27810.5582.camel@twins> <20100527172510.GC2468@srcf.ucam.org> <20100527223751.7af3b5ee@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100527223751.7af3b5ee@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 10:37:51PM +0100, Alan Cox wrote:
> On Thu, 27 May 2010 18:25:10 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > How (and why) does the WoL (which may be *any* packet, not just a magic 
> > one) turn the screen back on?
> 
> Well on my laptop today it works like this
> 
> A WoL packet arrives
> The CPU resumes
> Depp process, chipset and laptop BIOS magic happens
> The kernel gets called
> The kernel lets interested people know a resume occurred

No it doesn't. The kernel continues executing anything that was on the 
runqueue before the scheduler stopped. If you're using idle-based 
suspend then there's nothing on the runqueue - the application that 
should be scheduled because of the event is blocked on writing to the 
screen.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
