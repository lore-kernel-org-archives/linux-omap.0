From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Tue, 16 Jul 2013 18:19:07 +0200
Message-ID: <51E5727B.2010500@denx.de>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com> <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com> <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com> <51DEA7F1.1050902@denx.de> <51DEC2CE.70400@ti.com> <51DED076.3040000@denx.de> <51DEF0DE.4050607@denx.de> <51DFC92F.1050701@ti.com> <51DFDFD4.3040900@denx.de> <51E3AFF4.7060607@ti.com> <51E3B1B1.3060202@denx.de> <51E55AAE.3000209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:26841 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933240Ab3GPQT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jul 2013 12:19:57 -0400
In-Reply-To: <51E55AAE.3000209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Alan Stern <stern@rowland.harvard.edu>

Hi Roger,

On 07/16/2013 04:37 PM, Roger Quadros wrote:
> On 07/15/2013 11:24 AM, Stefan Roese wrote:
>> On 07/15/2013 10:16 AM, Roger Quadros wrote:
>>>>> I can only test on beagle-xm (which is also rev. C2) with integrated SMSC ethernet chip
>>>>> as I don't have an external USB-ethernet adapter.
>>>>
>>>> Too bad. This difference in boards makes the tests a bit less
>>>> meaningful. Is there really no USB-ethernet adapter somewhere in your
>>>> department (perhaps a non-SMSC95xx might serve as well?)? I might
>>>> send/order you one if necessary. ;)
>>>
>>> Thanks for the offer :). I'll just get one for myself by today/tomorrow.
>>> The one available here uses this driver "drivers/net/usb/asix.c"
>>
>> Great.
>>
> 
> OK. Finally managed to reproduce the problem.

Ahh, great. Thanks for the effort.

> Don't know the root cause yet. Will need to investigate.

Thanks. Just let me know if I can be of any assistance (testing etc).

Cheers,
Stefan
