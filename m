From: Roger Quadros <rogerq@ti.com>
Subject: Re: USB ehci suspend/resume on beagleboard
Date: Fri, 5 Apr 2013 14:55:35 +0300
Message-ID: <515EBBB7.3070503@ti.com>
References: <Pine.LNX.4.44L0.1302061038310.1893-100000@iolanthe.rowland.org> <511370D7.9070509@ti.com> <CANOLnOODiu+rEqCQH5BAzTXhWi4cUZO-OXO=-1xxyhMFW77UZQ@mail.gmail.com> <515D65D3.40006@ti.com> <515D68E9.5070404@ti.com> <CANOLnOPpkhSXZVa2CFsD33QT5XOxtrscNGVwZLy7vGZ1Oq5zGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36826 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab3DELzm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Apr 2013 07:55:42 -0400
In-Reply-To: <CANOLnOPpkhSXZVa2CFsD33QT5XOxtrscNGVwZLy7vGZ1Oq5zGw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Vivek Gautam <gautamvivek1987@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jason Kridner <jkridner@beagleboard.org>

On 04/05/2013 02:11 PM, Grazvydas Ignotas wrote:
> On Thu, Apr 4, 2013 at 2:50 PM, Roger Quadros <rogerq@ti.com> wrote:
>> correcting misleading subject line.
>> was (Re: MUSB regression in linux next at least for pandboard)
>>
>> On 04/04/2013 02:36 PM, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 02/07/2013 04:10 PM, Grazvydas Ignotas wrote:
>>>> On Thu, Feb 7, 2013 at 11:16 AM, Roger Quadros <rogerq@ti.com> wrote:
>>>> <snip>
>>>>> It seems the beagleboard problem is related to OMAP silicon errata [1].
>>>>> Apparently, remote wakeup as well as host issued wakeup break omap-ehci and have
>>>>> nothing to do with the hub or it's driver.
>>>>>
>>>>> I'll work on this issue after I'm done with device tree migration.
>>>>
>>>> Looking forward to this, mainline has been suffering from this since
>>>> almost forever..
>>>>
>>>>
>>>
>>> Unfortunately, there is another errata [2] that makes it impossible to
>>> support suspend/resume on the beagleboard.
> 
> You could fix it for BeagleBoard-xM at least, I think it is not
> affected by this as it has DM3730 (only early revisions with 1.0
> silicon of that are affected with [2]). This would also fix it for
> DM3730-based pandoras.
> 

Yes you are right. I need to get a beagleboard-xM.

cheers,
-roger

>>>
>>> [2] Advisory 3.1.1.195 HSUSB Interoperability Issue With SMSC USB3320 PHY
>>> http://www.ti.com/general/docs/lit/getliterature.tsp?literatureNumber=sprz278f&fileType=pdf


