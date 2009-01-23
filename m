From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: [PATCH 0/1] TWL: USB: disable VUSB regulators
Date: Fri, 23 Jan 2009 12:55:19 +0200
Message-ID: <1232708119.6515.443.camel@ubuntu>
References: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com>
	 <200901211238.33229.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sally.edelkey.net ([213.138.147.136]:47250 "EHLO
	sally.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbZAWKzc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 05:55:32 -0500
In-Reply-To: <200901211238.33229.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

Hi Dave,

Sorry for the late response, I was out of office yesterday.

On Wed, 2009-01-21 at 12:38 -0800, David Brownell wrote:
> On Wednesday 21 January 2009, Kalle Jokiniemi wrote:
> > The TWL5030/4030 internal VUSB regulators are eating current
> > like small piggies.
> 
> Feral pigs are a big problem in many places ...
> no surprise that feral code is too!
> 
> 
> > The following patch makes an aptempt at 
> > making the twl4030-usb consumer driver dynamically disable
> > and enable the regulators it needs.
> 
> Thanks, I'll have a look.  It's a bit different
> from some old hacks I didn't finish debugging.
> 
> Shouldn't the power down sequence mirror the
> power up sequence?  Up 1.5, 1.8, 3.1 ... then
> down 3.1, 1.8, 1.5?  Or does that matter?

Good question. The TRM tells quite little on these VUSB regulators,
other than they supply the USB sub-chip in TWL. For VUSB3V1 there is a
bit more information, telling that it supplies USB PHY, CEA Carkit
modules and MCPC (seems to be some special usb UART specification). 

I would think they all can be shut down in whatever order, if there is
nothing connected to the usb connector.

> 
> Also, I'm thinking that the DEV_GRP and TYPE
> register updates belong in regulator code, not
> transceiver code.  That's something to take care
> of with a separate patch though.

I agree.

- Kalle 

> 
> - Dave
