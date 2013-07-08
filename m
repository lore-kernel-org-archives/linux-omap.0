From: Tony Lindgren <tony@atomide.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Mon, 8 Jul 2013 05:16:36 -0700
Message-ID: <20130708121635.GZ5523@atomide.com>
References: <51D577E6.5010507@newflow.co.uk>
 <51D59146.3070002@newflow.co.uk>
 <51D59C0E.8080003@newflow.co.uk>
 <B5906170F1614E41A8A28DE3B8D121433EE93C23@DBDE04.ent.ti.com>
 <20130705115959.GQ5523@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34240 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3GHMQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jul 2013 08:16:40 -0400
Content-Disposition: inline
In-Reply-To: <20130708112553.GU5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Mark Jackson <mpfj-list@newflow.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tony Lindgren <tony@atomide.com> [130708 04:32]:
> * Bedia, Vaibhav <vaibhav.bedia@ti.com> [130705 06:37]:
> > On Fri, Jul 05, 2013 at 18:50:10, Bedia, Vaibhav wrote:
> > > Hi Tony,
> > > 
> > > On Fri, Jul 05, 2013 at 17:29:59, Tony Lindgren wrote:
> > > > * Bedia, Vaibhav <vaibhav.bedia@ti.com> [130705 01:17]:
> > > > > 
> > > > > I just checked the behavior on my AM335x-EVM. Current mainline boots fine
> > > > > provided I don't use earlyprintk.  The offending patch [1] in this case is the one
> > > > > that tries to get rid of omap_serial_early_init() for DT boot. This change inadvertently
> > > > > also results in the console UART getting reset and idled during bootup and that's where
> > > > > the boot stops for you. I think if you skip earlyprintk from the bootargs you should see
> > > > > the system booting fine. 
> > > > > 
> > > > > I guess we need to retain the NO_IDLE and NO_RESET aspect for the console UART in
> > > > > omap_serial_early_init() to get earlyprintk working again.
> > > > 
> > > > Hmm nothing should get idled while earlyprintk is running, and then when the
> > > > serial driver kicks in it should not idle anything by default. And for DT based
> > > > booting we should not have mach-omap2/serial.c initialize anything.
> > > > 
> > > 
> > > If I add in the HWMOD flags without any reverts I get to the point where the serial driver
> > > comes up but the boot eventually stops [1]. Without the flags the boot stops much earlier [2]
> > > just like Mark reported.
> > > 
> > 
> > Err.. the log with HWMOD flags added is [2] and without flags is [1]. Sorry for the confusion.
> 
> It sounds like something needs to be fixed for am33xx as omap3 and omap4
> won't hang with earlyprintk. Almost certainly mach-omap2/serial.c should not
> be needed at all for am33xx, and the bug is somewhere else.

Oops, sorry correction: I'm seeing it, I did not have console=ttyO
earlier in my cmdline. It seems that omap-serial.c console suspends
the hardware while earlyprintk is still trying to access it?

Regards,

Tony
