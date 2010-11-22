From: Gabi Voiculescu <boy3dfx2@yahoo.com>
Subject: Re: newbie: can I ask a question about linux-omap-pm on this mailing list?
Date: Mon, 22 Nov 2010 06:05:43 -0800 (PST)
Message-ID: <891232.80252.qm@web113817.mail.gq1.yahoo.com>
References: <AANLkTin0jiOn2FWhrnG0e+nuF1i22r8bv5YM2DGzkF3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm26.bullet.mail.sp2.yahoo.com ([98.139.91.96]:24408 "HELO
	nm26.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755373Ab0KVOFp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 09:05:45 -0500
In-Reply-To: <AANLkTin0jiOn2FWhrnG0e+nuF1i22r8bv5YM2DGzkF3g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Thank you for your reply.

I am a newbie when it comes down to Linux git repositories.
I am trying to do a 2.6.32 paravirtualization on top of L4, to run on the beagleboard(omap3 CPU), using as native kernel one from the linux-omap-pm repository. 

Why 2.6.32? It seems we have to run some userland modules that were written to be compatible with that version of Linux.

One part of the problem is to select the best suitable native commit for this purpose.

I am now trying to identify the best native commit from linux-omap-pm that fits the bill: working 2.6.32 + pm features for omap3 processors.

My initial attempt was to use pm-2.6.32 branch (git checkout --track -b pm-2.6.32 origin/pm-2.6.32). 

I realized there are issues with some devices: the USB host (EHCI) detecting hubs.

I have some problems navigating the linux-omap-pm git repository and I would really appreciate some feedback on these questions:

1. Was the pm-2.6.32 branch designed to add pm features to the TI 2.6.32-omap and Torvalds 2.6.32?
 1.1. if true, the pm-2.6.32 was focused on omap1 (not omap3) features?
 1.2. if not true, is there a better branch/commit/tag that deals with pm features on the omap3 SOC?
 1.3. As far as you know has any testing been performed on omap3 with a version of Linux close to 2.6.32?


Thank you for your input,
Gabi Voiculescu
--- On Mon, 11/22/10, S, Venkatraman <svenkatr@ti.com> wrote:

> From: S, Venkatraman <svenkatr@ti.com>
> Subject: Re: newbie: can I ask a question about linux-omap-pm on this mailing list?
> To: "Gabi Voiculescu" <boy3dfx2@yahoo.com>
> Cc: "linux-omap" <linux-omap@vger.kernel.org>
> Date: Monday, November 22, 2010, 12:36 PM
> > Hi.
> >
> > I want to ask a newbie questions regarding
> linux-omap-pm repositories(http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary).
> >
> > I know this mailing list is for the linux-omap
> repository. I have searched the web for a mailing list
> specific for linux-omap-pm without success.
> >
> > Is this the right mailing list to pose my question?
> > If not, can you point me to a better one?
> >
> 
> You have come to the right place. The linux-omap-pm tree is
> maintained
> by Kevin Hilman, and he checks this mailing list
> regularly.
> Ask away...
> 


      
