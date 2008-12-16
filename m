From: Tony Lindgren <tony@atomide.com>
Subject: Re: N810 suspend
Date: Tue, 16 Dec 2008 08:29:52 -0800
Message-ID: <20081216162951.GP19551@atomide.com>
References: <20081215210823.GD5334@swansys> <20081215211430.GJ10664@atomide.com> <20081216092531.c440dc26.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54947 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755970AbYLPQ3y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 11:29:54 -0500
Content-Disposition: inline
In-Reply-To: <20081216092531.c440dc26.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Linux-OMAP List <linux-omap@vger.kernel.org>

* Jarkko Nikula <jarkko.nikula@nokia.com> [081215 23:26]:
> On Mon, 15 Dec 2008 13:14:32 -0800
> "ext Tony Lindgren" <tony@atomide.com> wrote:
> 
> > > I'm running Debian on an N810.  With the current state of power management in 
> > > linux-omap, the N810 will only run (with LCD off) for about 12 hours on a 
> > > charge.
> > 
> > Well you need to make sure the serial clocks are not enabled. Kevin
> > has some patches for that in his pm branch. So you'll most likely want
> > to use his whole pm branch.
> > 
> > Also, you need to make sure you have sleep while idle enabled:
> > 
> > # echo 1 > /sys/power/sleep_while_idle
> > 
> > It used to work, but I have not tried for six months or so.
> > 
> How did you disable the LCD and FB clocks? Does
> xserver-xorg-video-fbdev from Debian (it works!) do necessary steps with
> omap fb driver or is xomap required?

Oh, I just tested that sleep-while-idle worked when fb was blanked. I
had a script that forced the LCD off via /sys, sorry don't remember
the path now. Will be also heading to catch a plane in few hours, may
not be able to check it right now.

Regards,

Tony
