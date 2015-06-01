From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: dts: AM35xx: fix system control module clocks
Date: Mon, 1 Jun 2015 21:21:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506012120020.14902@utopia.booyaka.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com> <1433172627-28052-1-git-send-email-t-kristo@ti.com> <556C8ED5.5050000@myspectrum.nl> <20150601173126.GY30984@atomide.com> <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
 <20150601180429.GA30984@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57803 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbFAVWA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 17:22:00 -0400
In-Reply-To: <20150601180429.GA30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jeroen Hofstee <linux-arm@myspectrum.nl>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 1 Jun 2015, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [150601 10:45]:
> 
> > http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150601012139/README.txt
> 
> OK somehow 3517evm is listed under "skip" there? 

Yep that board is down right now; something's wrong with it and I haven't 
had the time to figure out whether it's fixable, or if it's fried.

> > The best way to make this work IMHO would be for us not to accept any new 
> > feature addition patches as long as there are warnings reported in the 
> > test results.  The only real exception that I would foresee is if those 
> > warnings are due to something outside of our control, e.g., a crappy 
> > bootloader, as I suspect the USB_OTG initiator warnings are for the 
> > CM-T3517.
> 
> Right. Also seems we should diff dmesg output too (after stripping out
> the timestamps). Pretty much the only things that should change are
> the sysfs paths for devices in the dmesg output unless some warnings
> get fixed. That output probably still also needs to be manually looked
> at though..

Yep, there are still some other minor loose ends to be tied up too that 
don't show up as full warnings, such as the broken UART4 idle protocol 
integration on AM35xx...

- Paul
