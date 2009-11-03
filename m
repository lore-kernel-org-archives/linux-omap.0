From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Query: Regulator framework in EHCI driver
Date: Tue, 3 Nov 2009 17:30:46 +0200
Message-ID: <20091103153046.GA30320@nokia.com>
References: <19F8576C6E063C45BE387C64729E73940436EEB912@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22467 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbZKCPbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 10:31:36 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436EEB912@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

On Tue, Nov 03, 2009 at 12:55:53PM +0100, ext Gupta, Ajay Kumar wrote:
> Hi Anand/Felipe,
> 
> This is regarding regulator framework for 1V8 supply to EHCI PHY from twl4030 device.
> 
> [EHCI port on OMAP3EVM uses SMSC USB3320 PHY and uses 1V8 supply from twl4030 chip.]
> 
> I found twl4030_usb_ldo_init () function in drivers/usb/otg/twl4030-usb.c, which uses regulator framework but it can not be used by all the board which are not using twl4030 PHY. Don't you think this function need to be moved to some other common location?
> 
> Currently we are not enabling 1V8 supply explicitly but still EHCI works on EVM as most of the twl4030 supplies are enabled by default.
> 
> I was thinking of adding regulator framework in EHCI driver which will enable the required supplies based on one of the board_data passed (same as reset_gpio) from board files.

You should be able to regulator_get() the 1v8 supply and
regulator_enable() it. The regulator was already setup in twl4030-core.c
so that should work just fine. It's not a good idea to export
twl4030_ldo_init() since that's only for twl4030-usb itself. If you
regulator_get()/regulator_enable() then the regulator will be
refcounted.

You might want to add more consumers to the same supply based on board
information though. Today it's hardcoded to one for every board in
twl4030-core.c

-- 
balbi
