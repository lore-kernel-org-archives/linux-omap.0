From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: USB ehci suspend/resume on beagleboard
Date: Fri, 5 Apr 2013 14:11:54 +0300
Message-ID: <CANOLnOPpkhSXZVa2CFsD33QT5XOxtrscNGVwZLy7vGZ1Oq5zGw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1302061038310.1893-100000@iolanthe.rowland.org>
	<511370D7.9070509@ti.com>
	<CANOLnOODiu+rEqCQH5BAzTXhWi4cUZO-OXO=-1xxyhMFW77UZQ@mail.gmail.com>
	<515D65D3.40006@ti.com>
	<515D68E9.5070404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63887 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3DELLz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Apr 2013 07:11:55 -0400
In-Reply-To: <515D68E9.5070404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Vivek Gautam <gautamvivek1987@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jason Kridner <jkridner@beagleboard.org>

On Thu, Apr 4, 2013 at 2:50 PM, Roger Quadros <rogerq@ti.com> wrote:
> correcting misleading subject line.
> was (Re: MUSB regression in linux next at least for pandboard)
>
> On 04/04/2013 02:36 PM, Roger Quadros wrote:
>> Hi,
>>
>> On 02/07/2013 04:10 PM, Grazvydas Ignotas wrote:
>>> On Thu, Feb 7, 2013 at 11:16 AM, Roger Quadros <rogerq@ti.com> wrot=
e:
>>> <snip>
>>>> It seems the beagleboard problem is related to OMAP silicon errata=
 [1].
>>>> Apparently, remote wakeup as well as host issued wakeup break omap=
-ehci and have
>>>> nothing to do with the hub or it's driver.
>>>>
>>>> I'll work on this issue after I'm done with device tree migration.
>>>
>>> Looking forward to this, mainline has been suffering from this sinc=
e
>>> almost forever..
>>>
>>>
>>
>> Unfortunately, there is another errata [2] that makes it impossible =
to
>> support suspend/resume on the beagleboard.

You could fix it for BeagleBoard-xM at least, I think it is not
affected by this as it has DM3730 (only early revisions with 1.0
silicon of that are affected with [2]). This would also fix it for
DM3730-based pandoras.

>>
>> cheers,
>> -roger
>>
>> [2] Advisory 3.1.1.195 HSUSB Interoperability Issue With SMSC USB332=
0 PHY
>> http://www.ti.com/general/docs/lit/getliterature.tsp?literatureNumbe=
r=3Dsprz278f&fileType=3Dpdf
>>
>

--
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
