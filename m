From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: Query: Regulator framework in EHCI driver
Date: Tue, 3 Nov 2009 17:25:53 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436EEB912@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44563 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbZKCLz5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 06:55:57 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Hi Anand/Felipe,

This is regarding regulator framework for 1V8 supply to EHCI PHY from twl4030 device.

[EHCI port on OMAP3EVM uses SMSC USB3320 PHY and uses 1V8 supply from twl4030 chip.]

I found twl4030_usb_ldo_init () function in drivers/usb/otg/twl4030-usb.c, which uses regulator framework but it can not be used by all the board which are not using twl4030 PHY. Don't you think this function need to be moved to some other common location? 

Currently we are not enabling 1V8 supply explicitly but still EHCI works on EVM as most of the twl4030 supplies are enabled by default.

I was thinking of adding regulator framework in EHCI driver which will enable the required supplies based on one of the board_data passed (same as reset_gpio) from board files.

Regards,
Ajay Gupta
