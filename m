From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/27] cbus: tahvo: convert spinlock into mutex
Date: Mon, 17 Oct 2011 11:19:27 -0700
Message-ID: <20111017181926.GC27515@atomide.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
 <20111017172035.GB27515@atomide.com>
 <20111017180411.GA31828@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59535 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751076Ab1JQST3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Oct 2011 14:19:29 -0400
Content-Disposition: inline
In-Reply-To: <20111017180411.GA31828@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [111017 10:30]:
> On Mon, Oct 17, 2011 at 10:20:35AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [111013 01:01]:
> > > GPIO operations can sleep, so move to a
> > > mutex.
> > 
> > Great, seems to boot on n800 so pushing all into
> > cbus branch.
> 
> cool thanks. I think this is pretty much ready for mainline. At least
> retu. Unless you have any other plans for these little guys.

Well I guess they should be in drivers/mfd, but other than that yeah
these are the last pieces of non-mainline code dragging around.
 
> They have been missing from mainline for a loooong time though. I'm
> still concerned about the whole cbus bus implementation. Maybe we should
> the i2c framework (which already supports a few buses) and implement
> i2c-cbus-gpio.c ?? What do you think ?

Heh I guess that's doable too :) Or drivers/spi maybe?

Tony
