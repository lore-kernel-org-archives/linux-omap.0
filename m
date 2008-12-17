From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: N810 suspend
Date: Wed, 17 Dec 2008 14:09:11 +0200
Message-ID: <20081217140911.b30d7194.jarkko.nikula@nokia.com>
References: <20081215210823.GD5334@swansys>
	<20081215211430.GJ10664@atomide.com>
	<20081216092531.c440dc26.jarkko.nikula@nokia.com>
	<20081216162951.GP19551@atomide.com>
	<20081216165632.GF25056@swansys>
	<20081216172237.GR19551@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56789 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbYLQMJk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2008 07:09:40 -0500
In-Reply-To: <20081216172237.GR19551@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP List <linux-omap@vger.kernel.org>

On Tue, 16 Dec 2008 09:22:38 -0800
"ext Tony Lindgren" <tony@atomide.com> wrote:

> > > Oh, I just tested that sleep-while-idle worked when fb was blanked. I
> > > had a script that forced the LCD off via /sys, sorry don't remember
> > > the path now. Will be also heading to catch a plane in few hours, may
> > > not be able to check it right now.
> > 
> > 'echo 3 > /sys/class/graphics/fb0/blank' turns off the LCD, if that is what you 
> > mean.
> 
> Thanks, that's what I did.
> 
And it worked with N800. Battery current dropped below 10 mA after
unplugging the USB cable so OMAP was going into retention.

'echo 1 >/sys/power/clocks_off_while_idle' seems to not have any effect?


Jarkko
