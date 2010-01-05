From: "Maulik" <x0082077@ti.com>
Subject: RE: [PATCH v2 1/2] ARM : OMAP : Add empty functions in header file
Date: Tue, 5 Jan 2010 10:45:19 +0530
Message-ID: <016d01ca8dc6$168f6de0$808918ac@apr.dhcp.ti.com>
References: <1262603399-13036-1-git-send-email-x0082077@ti.com> <20100104123423.GA1439@gandalf> <016301ca8d3c$2d2b7f60$808918ac@apr.dhcp.ti.com> <20100104152534.GA16974@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab0AEFPx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jan 2010 00:15:53 -0500
In-Reply-To: <20100104152534.GA16974@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Olof Johansson' <olof@lixom.net>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, 'Tony Lindgren' <tony@atomide.com>, 'Felipe Balbi' <felipe.balbi@nokia.com>, 'Greg Kroah-Hartman' <gregkh@suse.de>, 'Sergei Shtylyov' <sshtylyov@ru.mvista.com>, "'Gupta, Ajay Kumar'" <ajay.gupta@ti.com>


>>It needs to be static inline:

[Maulik] Yes that's true. 

>>And you need to make sure that the actual body of the function in the
>>C file is encapsulated with #ifdef too, since the very point of having
>>it under a config option is to not include it if it's not selected
>>and needed.

[Maulik] The actual body of the function is defined in 
drivers/usb/otg/nop-usb-xceiv.c. This file is compiled only if
CONFIG_NOP_USB_XCEIV option is selected. 

Hence I think we won't need to explicitly protect it with a #ifdef.

I shall post a new version of the patch with the changes.

Regards,
Maulik



