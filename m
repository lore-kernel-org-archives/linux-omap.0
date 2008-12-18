From: Kalle Valo <kalle.valo@nokia.com>
Subject: Re: N810 suspend
Date: Thu, 18 Dec 2008 23:40:12 +0200
Message-ID: <87ljud88n7.fsf@nokia.com>
References: <20081215210823.GD5334@swansys>
	<20081215211430.GJ10664@atomide.com>
	<20081216092531.c440dc26.jarkko.nikula@nokia.com>
	<20081216162951.GP19551@atomide.com> <20081216165632.GF25056@swansys>
	<20081216172237.GR19551@atomide.com>
	<20081217140911.b30d7194.jarkko.nikula@nokia.com>
	<20081218090147.c6e5c4a0.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64324 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbYLRVkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 16:40:21 -0500
In-Reply-To: <20081218090147.c6e5c4a0.jarkko.nikula@nokia.com> (ext Jarkko Nikula's message of "Thu\, 18 Dec 2008 09\:01\:47 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Linux-OMAP List <linux-omap@vger.kernel.org>

Jarkko Nikula <jarkko.nikula@nokia.com> writes:

> xorg.conf's Option "SuspendTime" seems to equal to blanking command 3
> (VESA_POWERDOWN). Look drivers/video/omap/omapfb_main.c: omapfb_blank.
>
> Section "ServerFlags"
>         Option  "BlankTime"     "0"
>         Option  "StandbyTime"   "0"
>         Option  "SuspendTime"   "1"
>         Option  "OffTime"       "0"
> EndSection
>
> I just tried this with xserver-xorg-video-fbdev from Debian/testing on
> N800 and it went perfectly into retention.

Cool.

> N810 didn't went and think reason is that bootloader enables UART3
> for the GPS chip.

I noticed this as well. Any hacks to workaround this? Or do I really
need to start searching for N800? :)

-- 
Kalle Valo
