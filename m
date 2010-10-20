From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Wed, 20 Oct 2010 10:46:49 +0300
Message-ID: <4CBE9E69.6060803@nokia.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>	<1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>	<4CBD9FD5.506@nokia.com> <AANLkTinRRyrXzqEu=u+CCYkmSNGm03SSo1tVG=5_wdpo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41804 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab0JTHpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 03:45:44 -0400
In-Reply-To: <AANLkTinRRyrXzqEu=u+CCYkmSNGm03SSo1tVG=5_wdpo@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On 10/19/2010 05:33 PM, ext Felipe Contreras wrote:
> Hi Roger,
>
> On Tue, Oct 19, 2010 at 4:40 PM, Roger Quadros<roger.quadros@nokia.com>  wrote:
>>> @@ -843,6 +841,7 @@ config USB_CDC_COMPOSITE
>>>   config USB_G_NOKIA
>>>         tristate "Nokia composite gadget"
>>>         depends on PHONET
>>> +       depends on USB_GADGET_MUSB_HDRC
>>
>> This is wrong. Is there a build problem or run-time problem without this?
>
> Try:
> CONFIG_USB_G_NOKIA=y
> CONFIG_USB_GADGET_MUSB_HDRC=n
>
> At least g_nokia doesn't seem to work correctly on my N900.
>
It won't work on N900 because N900 has MUSB USB gadget controller and it needs 
to be selected somehow while building for N900.

You should set CONFIG_USB_GADGET_MUSB_HDRC to y somewhere else while building 
for N900 and not here because g_nokia is not MUSB specific.

-- 
regards,
-roger
