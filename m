From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/3] OMAP_LDP support in linux-git tree
Date: Mon, 8 Dec 2008 09:30:15 -0800
Message-ID: <20081208173014.GQ7388@atomide.com>
References: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com> <20081126231240.GM11997@atomide.com> <1227800406.14497.123.camel@localhost> <20081205185816.GG9714@atomide.com> <1228733044.22433.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56798 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYLHRaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 12:30:17 -0500
Content-Disposition: inline
In-Reply-To: <1228733044.22433.13.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

* stanley.miao <stanley.miao@windriver.com> [081208 02:37]:
> 
> > Sorry for the delay. If you want to use the same patch for the mainline
> > kernel and linux-omap kernel, you may need to edit the Makefile and Kconfig
> > manually.
> > 
> > But since you have the ldp board already in the mainline kernel, all you
> > need to do is to send me patches against the mainline kernel to add
> > various support bits still missing from the mainline board file. Exactly
> > what you did with for smc support (Well I had to cut out the smc driver
> > bits):
> > 
> > ARM: OMAP3: LDP: Add Ethernet device support to make ldp boot succeess
> > 
> > in the current omap3-upstream series:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=omap3-upstream
> > 
> > So just send patches to add the rest of the devices, OK? Make sure it
> > compiles with the mainline kernel, so exclude the drivers that are not
> > there yet.
> > 
> 
> LCD_LDP driver patch has been integrated into l-o tree. Do I need to
> re-send it against mainline kernel ?

Yes please if it does not apply as it is. Basically please send all
LDP, Beagle, Overo and OSK patches against the mainline tree from now
on.

Regards,

Tony
