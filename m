From: Tony Lindgren <tony@atomide.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Fri, 5 Jul 2013 04:59:59 -0700
Message-ID: <20130705115959.GQ5523@atomide.com>
References: <51D577E6.5010507@newflow.co.uk>
 <51D59146.3070002@newflow.co.uk>
 <51D59C0E.8080003@newflow.co.uk>
 <B5906170F1614E41A8A28DE3B8D121433EE93C23@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55764 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757055Ab3GEMAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jul 2013 08:00:05 -0400
Content-Disposition: inline
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EE93C23@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Mark Jackson <mpfj-list@newflow.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Bedia, Vaibhav <vaibhav.bedia@ti.com> [130705 01:17]:
> On Thu, Jul 04, 2013 at 21:30:14, Mark Jackson wrote:
> > On 04/07/13 16:14, Mark Jackson wrote:
> > > On 04/07/13 14:25, Mark Jackson wrote:
> > >> Our custom AM335x board has been booting just fine under 3.10.0-rc4.
> > >>
> > >> I've just done a git pull to update to 3.10 (now that it's released)
> > >> and the board now hangs.
> > >>
> > >> Before I start trying to bisect the issue, does anyone have an clues ?
> > > 
> > > Okay ... I've now bisected it to:-
> > > 
> > > a630fbfbb1beeffc5bbe542a7986bf2068874633 is the first bad commit
> > > commit a630fbfbb1beeffc5bbe542a7986bf2068874633
> > > Author: Tony Lindgren <tony@atomide.com>
> > > Date:   Mon Jun 10 07:39:09 2013 -0700
> > > 
> > >     serial: omap: Fix device tree based PM runtime
> > 
> > However, reverting the commit does *not* fix the issue, weird !!
> > 
> > But I have now tested:-
> > 
> > v3.10-rc4     -> works
> > v3.10-rc5     -> works
> > v3.10-rc6     -> works
> > v3.10-rc7     -> works
> > v3.10         -> works
> > origin/master -> hangs
> > 
> > Any ideas ?
> 
> I just checked the behavior on my AM335x-EVM. Current mainline boots fine
> provided I don't use earlyprintk.  The offending patch [1] in this case is the one
> that tries to get rid of omap_serial_early_init() for DT boot. This change inadvertently
> also results in the console UART getting reset and idled during bootup and that's where
> the boot stops for you. I think if you skip earlyprintk from the bootargs you should see
> the system booting fine. 
> 
> I guess we need to retain the NO_IDLE and NO_RESET aspect for the console UART in
> omap_serial_early_init() to get earlyprintk working again.

Hmm nothing should get idled while earlyprintk is running, and then when the
serial driver kicks in it should not idle anything by default. And for DT based
booting we should not have mach-omap2/serial.c initialize anything.

I wonder if this is because the timeouts get now initialized to 0 instead
of -1 for the serial driver?

Regards,

Tony
 
> [1] http://www.spinics.net/lists/linux-omap/msg91825.html
> 
