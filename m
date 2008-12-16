From: Tony Lindgren <tony@atomide.com>
Subject: Re: N810 suspend
Date: Tue, 16 Dec 2008 09:22:38 -0800
Message-ID: <20081216172237.GR19551@atomide.com>
References: <20081215210823.GD5334@swansys> <20081215211430.GJ10664@atomide.com> <20081216092531.c440dc26.jarkko.nikula@nokia.com> <20081216162951.GP19551@atomide.com> <20081216165632.GF25056@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61388 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYLPRWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 12:22:39 -0500
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LCdd0-0009ou-Ax
	for linux-omap@vger.kernel.org; Tue, 16 Dec 2008 17:22:38 +0000
Content-Disposition: inline
In-Reply-To: <20081216165632.GF25056@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>

* green <greenfreedom10@gmail.com> [081216 08:57]:
> On Tue, 2008.12.16, 351, Tony Lindgren wrote:
> > * Jarkko Nikula <jarkko.nikula@nokia.com> [081215 23:26]:
> > > On Mon, 15 Dec 2008 13:14:32 -0800 "ext Tony Lindgren" <tony@atomide.com> wrote:
> > > > Well you need to make sure the serial clocks are not enabled. Kevin
> > > > has some patches for that in his pm branch. So you'll most likely want
> > > > to use his whole pm branch.
> > > > 
> > > > Also, you need to make sure you have sleep while idle enabled:
> > > > 
> > > > # echo 1 > /sys/power/sleep_while_idle
> > > > 
> > > > It used to work, but I have not tried for six months or so.
> > > > 
> > > How did you disable the LCD and FB clocks? Does
> > > xserver-xorg-video-fbdev from Debian (it works!) do necessary steps with
> > > omap fb driver or is xomap required?
> > 
> > Oh, I just tested that sleep-while-idle worked when fb was blanked. I
> > had a script that forced the LCD off via /sys, sorry don't remember
> > the path now. Will be also heading to catch a plane in few hours, may
> > not be able to check it right now.
> 
> 'echo 3 > /sys/class/graphics/fb0/blank' turns off the LCD, if that is what you 
> mean.

Thanks, that's what I did.

Tony
