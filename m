From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Wed, 20 Oct 2010 11:01:25 +0300
Message-ID: <20101020080125.GA30965@legolas.emea.dhcp.ti.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
 <1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
 <4CBD9FD5.506@nokia.com>
 <AANLkTinRRyrXzqEu=u+CCYkmSNGm03SSo1tVG=5_wdpo@mail.gmail.com>
 <4CBE9E69.6060803@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35501 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab0JTIBs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Oct 2010 04:01:48 -0400
Content-Disposition: inline
In-Reply-To: <4CBE9E69.6060803@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <roger.quadros@nokia.com>
Cc: ext Felipe Contreras <felipe.contreras@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On Wed, Oct 20, 2010 at 02:46:49AM -0500, Roger Quadros wrote:
>On 10/19/2010 05:33 PM, ext Felipe Contreras wrote:
>> Hi Roger,
>>
>> On Tue, Oct 19, 2010 at 4:40 PM, Roger Quadros<roger.quadros@nokia.com>  wrote:
>>>> @@ -843,6 +841,7 @@ config USB_CDC_COMPOSITE
>>>>   config USB_G_NOKIA
>>>>         tristate "Nokia composite gadget"
>>>>         depends on PHONET
>>>> +       depends on USB_GADGET_MUSB_HDRC
>>>
>>> This is wrong. Is there a build problem or run-time problem without this?
>>
>> Try:
>> CONFIG_USB_G_NOKIA=y
>> CONFIG_USB_GADGET_MUSB_HDRC=n
>>
>> At least g_nokia doesn't seem to work correctly on my N900.
>>
>It won't work on N900 because N900 has MUSB USB gadget controller and
>it needs to be selected somehow while building for N900.
>
>You should set CONFIG_USB_GADGET_MUSB_HDRC to y somewhere else while
>building for N900 and not here because g_nokia is not MUSB specific.

It's the same thing I've been trying to say. No gadget driver is
controller-specific. Even though this one is called g_nokia.ko it
doesn't only Nokia can use it, neither does it mean nokia will always
use MUSB.

-- 
balbi
