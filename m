From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] select NOP_USB_XCEIV for OMAP4
Date: Wed, 23 Jun 2010 17:53:05 -0500
Message-ID: <4C229051.5090308@ti.com>
References: <1277318873-8260-1-git-send-email-x0132446@ti.com> <87k4ppqyk2.fsf@deeprootsystems.com> <7B4574D56E4ADF438756313E9A172A879A845653@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35282 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287Ab0FWWxQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jun 2010 18:53:16 -0400
In-Reply-To: <7B4574D56E4ADF438756313E9A172A879A845653@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anders, David" <x0132446@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On 6/23/2010 4:10 PM, Anders, David wrote:
>> Shouldn't this be a board-specific option, and not set for every
>> OMAP4-based config?
>>
>
> As I understand it, any of the omap4 devices that are using the Inventra need to have at a minimum of the NOP USB Transceiver. Enabling the NOP transceiver doesn't preclude the use of other external transceivers. The NOP USB Transceiver will still need to be registered in the board-specific machine file therefore doesn't impact a board that doesn't use it.

The OMAP4 TRM states:

"The high-speed USB OTG controller supports a single USB port, which 
uses the ULPI interface mode, to connect to an off-chip transceiver 
(12-pin/8-bit data SDR mode) and to connect on D+/D- (+ID) USB bus 
thanks to an embedded USB-HS OTG PHY."

So I read this as you can use either the on-chip PHY or an external PHY. 
Therefore, if you did opt to use an external PHY I am not sure I 
understand why the NOP transceiver I still needed. The OMAP4 an external 
configuration looks the same as OMAP3 to me...

Cheers
Jon
