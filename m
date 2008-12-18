From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: N810 suspend
Date: Thu, 18 Dec 2008 15:01:38 +0200
Message-ID: <20081218150138.c5054a89.jarkko.nikula@nokia.com>
References: <20081215210823.GD5334@swansys>
	<20081215211430.GJ10664@atomide.com>
	<20081216092531.c440dc26.jarkko.nikula@nokia.com>
	<20081216162951.GP19551@atomide.com>
	<20081216165632.GF25056@swansys>
	<20081216172237.GR19551@atomide.com>
	<20081217140911.b30d7194.jarkko.nikula@nokia.com>
	<20081218090147.c6e5c4a0.jarkko.nikula@nokia.com>
	<94a0d4530812180451t7f9da6a7y9fe9ccc2c7ab49a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25410 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbYLRNCl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 08:02:41 -0500
In-Reply-To: <94a0d4530812180451t7f9da6a7y9fe9ccc2c7ab49a4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Linux-OMAP List <linux-omap@vger.kernel.org>

On Thu, 18 Dec 2008 14:51:20 +0200
"ext Felipe Contreras" <felipe.contreras@gmail.com> wrote:

> > xorg.conf's Option "SuspendTime" seems to equal to blanking command 3
> > (VESA_POWERDOWN). Look drivers/video/omap/omapfb_main.c: omapfb_blank.
> 
> Yes, but it should be FB_BLANK_POWERDOWN (4), shouldn't it?
> 
Good question, no idea, probably yes? Only omapfb_main.c, fs1100fb.c
and au1100fb.c are using VESA_xxx and rest of the fb drivers
FB_BLANK_xxx modes.


Jarkko
