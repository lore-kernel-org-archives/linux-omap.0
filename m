From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] CBUS Patches
Date: Tue, 14 Jun 2011 07:35:10 -0700
Message-ID: <20110614143510.GJ23145@atomide.com>
References: <1307994058-25486-1-git-send-email-balbi@ti.com>
 <20110614100643.GM3352@atomide.com>
 <20110614131139.GE23145@atomide.com>
 <20110614131415.GM2353@legolas.emea.dhcp.ti.com>
 <20110614134434.GF23145@atomide.com>
 <20110614135959.GN2353@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28000 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751156Ab1FNOfN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 10:35:13 -0400
Content-Disposition: inline
In-Reply-To: <20110614135959.GN2353@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110614 06:55]:
> Hi,
> 
> On Tue, Jun 14, 2011 at 06:44:35AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [110614 06:12]:
> > > On Tue, Jun 14, 2011 at 06:11:39AM -0700, Tony Lindgren wrote:
> > > > 
> > > > Hmm the second patch "cbus: pass device as argument" breaks
> > > > booting on n800. Anyways pushed out already so that will
> > > > need to be fixed in a separate patch.
> > > 
> > > any good dmesg output for me to take a look at ?
> > 
> > Here's the trace with DEBUG_LL + EARLY_PRINTK + earlyprintk in the
> > added to the CMDLINE in .config.
> 
> fix attached.

Thanks, pushing to cbus branch and also applying to master branch.

Tony
