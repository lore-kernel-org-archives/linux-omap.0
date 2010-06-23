From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] select NOP_USB_XCEIV for OMAP4
Date: Thu, 24 Jun 2010 02:15:17 +0400
Message-ID: <4C228775.6030705@ru.mvista.com>
References: <1277318873-8260-1-git-send-email-x0132446@ti.com> <87k4ppqyk2.fsf@deeprootsystems.com> <61951E1F-DEBF-450C-AF06-E0119DA3B33E@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:51224 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455Ab0FWWQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 18:16:15 -0400
In-Reply-To: <61951E1F-DEBF-450C-AF06-E0119DA3B33E@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, David Anders <x0132446@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, ajay.gupta@ti.com, felipe.balbi@nokia.com

Hello.

Koen Kooi wrote:

>>> Add select statement to force selection of NOP_USB_XCEIV for OMAP4.

>>> Signed-off-by: David Anders <x0132446@ti.com>
>>> ---
>>> drivers/usb/musb/Kconfig |    1 +
>>> 1 files changed, 1 insertions(+), 0 deletions(-)

>>> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
>>> index cfd38ed..e4624bc 100644
>>> --- a/drivers/usb/musb/Kconfig
>>> +++ b/drivers/usb/musb/Kconfig
>>> @@ -11,6 +11,7 @@ config USB_MUSB_HDRC
>>> 	depends on (USB || USB_GADGET)
>>> 	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
>>> 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
>>> +	select NOP_USB_XCEIV if ARCH_OMAP4
>>> 	select TWL4030_USB if MACH_OMAP_3430SDP
>>> 	select USB_OTG_UTILS
>>> 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'

>> Shouldn't this be a board-specific option, and not set for every
>> OMAP4-based config?

> If that's true, why do the  davinci and blackfin archs force it?

    DaVincis have an integrated transceiver.

WBR, Sergei
