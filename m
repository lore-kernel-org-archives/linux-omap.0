From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] twl4030-usb: Report correct vbus value for accessory
 charger adapters1
Date: Wed, 13 Apr 2011 16:47:16 -0700
Message-ID: <20110413234716.GA22557@kroah.com>
References: <4D963D4F.2050203@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:38589 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932150Ab1DMXtE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 19:49:04 -0400
Content-Disposition: inline
In-Reply-To: <4D963D4F.2050203@tomtom.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias.kaehlcke@tomtom.com>
Cc: Felipe Balbi <balbi@ti.com>, David Brownell <dbrownell@users.sourceforge.net>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, Apr 01, 2011 at 11:02:07PM +0200, Matthias Kaehlcke wrote:
> The twl4030-usb driver exports the status of VBUS as sysfs attribute.
> In case an accessory charger adapter (ACA) is connected to the OTG
> transceiver the attribute is always 'off', even when the charger
> provides VBUS. Added a variable to keep track of the status of VBUS
> and report it correctly
> 
> Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@tomtom.com>

Ick, your email software turned the patch into a mess.  I've edited it
by hand, fixing it up, but next time, please fix your email client so
this doesn't happen again.

thanks,

greg k-h
