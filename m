From: Tony Lindgren <tony@atomide.com>
Subject: Re: 2.6.38 not booting on sbc8100 (aka devkit8000)
Date: Thu, 24 Mar 2011 12:00:30 -0700
Message-ID: <20110324190030.GW2811@atomide.com>
References: <AANLkTikAO+FA+0fCNiVj=9wVZ3t+vfx9tJX_SnJ7FGSd@mail.gmail.com>
 <20110324151844.GT2811@atomide.com>
 <AANLkTik8PW4ad2_4=UxzvL-V7HcpH0=dg-Un5NLkj6Yi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15264 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933332Ab1CXTAb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Mar 2011 15:00:31 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik8PW4ad2_4=UxzvL-V7HcpH0=dg-Un5NLkj6Yi@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: linux-omap@vger.kernel.org

* Belisko Marek <marek.belisko@gmail.com> [110324 08:18]:
> On Thu, Mar 24, 2011 at 4:18 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Belisko Marek <marek.belisko@gmail.com> [110324 02:50]:
> > > Hi,
> > >
> > > Try to run 2.6.38 on my sbc8100
> > > (use mach-type for devkit8000 because boards are similar) board but
> > > when u-boot load it to ram I see just:
> > > ## Booting kernel from Legacy Image at 80300000 ...
> > >    Image Name:   Linux-2.6.38-06570-g79c21b4
> > >    Image Type:   ARM Linux Kernel Image (uncompressed)
> > >    Data Size:    2967164 Bytes =  2.8 MB
> > >    Load Address: 80008000
> > >    Entry Point:  80008000
> > >    Verifying Checksum ... OK
> > >    Loading Kernel Image ... OK
> > > OK
> > > Starting kernel ...
> > >
> > > I have changed bootargs to: bootargs=console=ttyO2,115200n8 doesn't
> > > help. Any ideas what could be checked?
> >
> > Can you enable DEBUG_LL and EARLY_PRINTK in your .config
> > and add earlyprintk to your cmdline? Then you should see
> > what goes wrong.
> >
> Forgot to mention. I already test this options but result is same like I
> report in
> first email.

Maybe add some printk statements to start_kernel function in
init/main.c and see if you get any output?

Tony
