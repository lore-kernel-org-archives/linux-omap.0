From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: N810 suspend
Date: Tue, 16 Dec 2008 09:25:31 +0200
Message-ID: <20081216092531.c440dc26.jarkko.nikula@nokia.com>
References: <20081215210823.GD5334@swansys>
	<20081215211430.GJ10664@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35516 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbYLPH0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 02:26:36 -0500
In-Reply-To: <20081215211430.GJ10664@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP List <linux-omap@vger.kernel.org>

On Mon, 15 Dec 2008 13:14:32 -0800
"ext Tony Lindgren" <tony@atomide.com> wrote:

> > I'm running Debian on an N810.  With the current state of power management in 
> > linux-omap, the N810 will only run (with LCD off) for about 12 hours on a 
> > charge.
> 
> Well you need to make sure the serial clocks are not enabled. Kevin
> has some patches for that in his pm branch. So you'll most likely want
> to use his whole pm branch.
> 
> Also, you need to make sure you have sleep while idle enabled:
> 
> # echo 1 > /sys/power/sleep_while_idle
> 
> It used to work, but I have not tried for six months or so.
> 
How did you disable the LCD and FB clocks? Does
xserver-xorg-video-fbdev from Debian (it works!) do necessary steps with
omap fb driver or is xomap required?


Jarkko
