From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: MUSB OTG Interrupts
Date: Fri, 26 Sep 2008 20:54:28 +0300
Message-ID: <20080926175427.GE9890@frodo>
References: <1f11a5490809260900q43d1524fn8811e9516663bc12@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39948 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbYIZRyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 13:54:36 -0400
Content-Disposition: inline
In-Reply-To: <1f11a5490809260900q43d1524fn8811e9516663bc12@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 26, 2008 at 12:00:17PM -0400, Ashwin Bihari wrote:
> Greetings,
> 
> I've got a very curious problem with my OMAP3 based  board. I'm using
> the OMAPZOOM kernel v2.6.27-rc3 and have enabled MUSB in OTG mode
> (both host and perihperhal). I've got the file-backed-storage gadget.
> If I plug the mini-B connector to the board, it gets the appropriate
> interrupt and recognizes that it needs to be operate in peripheral
> mode and goes about it's business. However, when I plug in the mini-A
> connector to the board, there is no interrupt and no activity. I can
> then unplug the mini-A connector, and plug in the mini-B connector to
> get the interrupts and activity again.
> 
> If I boot the board up with the mini-A connector plugged in, it is
> properly found/recognized during driver installation and any devices
> attached are properly found and can be used. The IRQs at this time
> fire properly. I have a thumb drive connected to a high speed hub
> connected to the OMAP board, and the drive is found, I can mount it
> and do everything. Now, in this particular case, if I unplug the
> mini-A connector and plug either the mini-A or mini-B connector,
> nothing happens at all.
> 
> Why am I only getting interrupts with the mini-B connector and not the
> mini-A connector? Additionally, why does everything fail after my
> second scenario above?

Id pin interrupt handling is not done yet on twl4030-usb, I'm planning
to finish that part when we finish fixing twl children registration.

If you have to do that and send a patch, that's ok. Just be sure to make
it on top of latest twl4030-usb.c which I moved to platform_driver.

-- 
balbi
