From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/9 v3] usb: musb: Using omap_device_build for musb device
 registration
Date: Fri, 24 Sep 2010 10:01:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009240956160.10678@utopia.booyaka.com>
References: <1285201750-26438-1-git-send-email-hemahk@ti.com> <20100923062044.GB2563@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46332 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab0IXQBf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 12:01:35 -0400
In-Reply-To: <20100923062044.GB2563@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Kalliguddi, Hema" <hemahk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi Felipe,

On Thu, 23 Sep 2010, Felipe Balbi wrote:

> Paul, Kevin, to me it looks like a duplication that all devices will
> have to:
> 
> oh = omap_hwmod_lookup("my_hwmod_name");
> omap_device_build("my_device_name", bus_id, oh, pdata, sizeof(*pdata));
> 
> could the omap_hwmod_lookup() part be moved to omap_device_build ? Or
> maybe create a omap_hwmod_lookup_and_build(oh_name, dev_name, bus_id,
> pdata, sizeof(*pdata)) ??

... (re dma mask) ...

> I think this is also a duplication, it's gonna on all hwmod device
> registration, no ?

Probably at some point in the future, once a larger set of hwmod 
conversions are done, we can look at the way that most of the integration 
code initializes.  Ideally, we can combine as much common code together as 
possible into some data-driven approach.  But right now I think it's a 
little early to do that, since I personally am not sure what most 
drivers/devices will need to do in their integration code.  On the other 
hand, it's not too early to start thinking about it :-)


- Paul
