From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Query: Regulator framework in EHCI driver
Date: Wed, 4 Nov 2009 18:02:48 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436F9375B@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E73940436EEB912@dbde02.ent.ti.com>
 <20091103153046.GA30320@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53256 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755841AbZKDMcw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 07:32:52 -0500
In-Reply-To: <20091103153046.GA30320@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

> >
> > This is regarding regulator framework for 1V8 supply to EHCI PHY from
> twl4030 device.
> >
> > [EHCI port on OMAP3EVM uses SMSC USB3320 PHY and uses 1V8 supply from
> twl4030 chip.]
> >
> > I found twl4030_usb_ldo_init () function in drivers/usb/otg/twl4030-
> usb.c, which uses regulator framework but it can not be used by all the
> board which are not using twl4030 PHY. Don't you think this function need
> to be moved to some other common location?
> >
> > Currently we are not enabling 1V8 supply explicitly but still EHCI works
> on EVM as most of the twl4030 supplies are enabled by default.
> >
> > I was thinking of adding regulator framework in EHCI driver which will
> enable the required supplies based on one of the board_data passed (same
> as reset_gpio) from board files.
> 
> You should be able to regulator_get() the 1v8 supply and
> regulator_enable() it. The regulator was already setup in twl4030-core.c
> so that should work just fine. 

I can do regulator_get() and regulator_enable() but where ? Are you referring to board file?

I was thinking of doing it in a generic form within EHCI driver (ehci-omap.c).

> It's not a good idea to export
> twl4030_ldo_init() since that's only for twl4030-usb itself.

I am not asking for exporting twl4030_ldo_init() but to remove EHCI specific
regulator part from this file to ehci-omap.c in a generic form.

> If you regulator_get()/regulator_enable() then the regulator will be
> refcounted.
> 
> You might want to add more consumers to the same supply based on board
> information though.

It can be done but the issue it to make regulator_get()/regulator_enable() calls at a common location.

-Ajay

> Today it's hardcoded to one for every board in
> twl4030-core.c
> 
> --
> balbi

