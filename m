From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 0/3] ARM: omap3: add Seagate Wireless Plus board
Date: Thu, 9 May 2013 09:05:52 -0700
Message-ID: <20130509160551.GC31554@atomide.com>
References: <cover.1368038129.git.jason@lakedaemon.net>
 <20130508194504.GD32546@atomide.com>
 <20130509003606.GE31290@titan.lakedaemon.net>
 <20130509155645.GB31554@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16416 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059Ab3EIQFy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 May 2013 12:05:54 -0400
Content-Disposition: inline
In-Reply-To: <20130509155645.GB31554@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130509 09:03]:
> * Jason Cooper <jason@lakedaemon.net> [130508 17:41]:
> > On Wed, May 08, 2013 at 12:45:04PM -0700, Tony Lindgren wrote:
> > > * Jason Cooper <jason@lakedaemon.net> [130508 12:29]:
> > > > 
> > > > Tony has been helping me out offline with this, and he suggested trying the
> > > > gpmc against Linus' ToT.  Which locks up before it even has a chance to get
> > > > going.  So this series is against v3.9.
> > > 
> > > You may have better luck with today's mainline treeand the following fix:
> > > 
> > > http://lkml.org/lkml/2013/5/8/374#
> > 
> > Ok, I'm attempting to do that, but got this for 'make dtbs':
> > 
> > ERROR (phandle_references): Reference to non-existent node or label "usb2_phy"
> > 
> > ERROR: Input tree has errors, aborting (use -f to force output)
> > make[1]: *** [arch/arm/boot/dts/omap3-wireless_plus.dtb] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [dtbs] Error 2
> > 
> > which was created by:
> > 
> >   ad871c10 ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+ boards
> > 
> > It assumes the board has twl4030 (and then includes it).  Bootlogs from
> > the vendor provided kernel don't show a single message from twl4030, so
> > I've omitted it.
> > 
> > Assuming I did the correct thing by omitting the twl4030, I think the
> > correct answer is to declare the phy in the dts files, like so:
> 
> Thanks, that is correct. We should not assume any PMIC with a processor
> as it can also be a custom chip. For example, Nokia n8x0 is using their
> retu + tahvo chips instead of tps chips.
> 
> I'll apply your patch into omap-for-v3.10/fixes.

I mean omap-for-v3.10/dt-fixes instead of fixes since it's .dts changes.
 
> Regards,
> 
> Tony
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
