From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7x-evm: beagle-x14: Fix USB Peripheral
Date: Wed, 18 Mar 2015 11:38:00 +0200
Message-ID: <55094778.6090304@ti.com>
References: <1426585431-29914-1-git-send-email-rogerq@ti.com> <20150317145428.GA5001@saruman.tx.rr.com> <20150317180257.GH31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45371 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755343AbbCRJiE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 05:38:04 -0400
In-Reply-To: <20150317180257.GH31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
Cc: nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On 17/03/15 20:02, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150317 07:55]:
>> Hi,
>>
>> On Tue, Mar 17, 2015 at 11:43:51AM +0200, Roger Quadros wrote:
>>> Now that we have EXTCON_USB_GPIO queued for v4.1, revert
>>> commit addfcde7c485 ("ARM: dts: dra7x-evm: beagle-x15: Fix USB Host")
>>>
>>> On these EVMs, the USB cable state has to be determined via the
>>> ID pin tied to a GPIO line. We use the gpio-usb-extcon driver
>>> to read the ID pin and the extcon framework to forward
>>> the USB cable state information to the USB driver so the
>>> controller can be configured in the right mode (host/peripheral).
>>>
>>> Gets USB peripheral mode to work on this EVM.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>
>> on subject: x14 ? other than that

oops :P

>>
>> Reviewed-by: Felipe Balbi <balbi@ti.com>
> 
> Applying into omap-for-v4.1/dt-v2 with the subject line fixed.

Thanks Tony.

cheers,
-roger
