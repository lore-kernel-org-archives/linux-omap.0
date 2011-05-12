From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/5] arm: omap: usb: device name change for the clk names
 of usbhs
Date: Thu, 12 May 2011 14:28:04 +0300
Message-ID: <4DCBC444.10506@compulab.co.il>
References: <1305122676-27236-1-git-send-email-keshava_mgowda@ti.com> <1305122676-27236-2-git-send-email-keshava_mgowda@ti.com> <1305122676-27236-3-git-send-email-keshava_mgowda@ti.com> <1305122676-27236-4-git-send-email-keshava_mgowda@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024CE66B4A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:44289
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752569Ab1ELL2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:28:14 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CE66B4A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "parthab@india.ti.com" <parthab@india.ti.com>



On 05/12/11 13:49, Premi, Sanjeev wrote:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
>> Munegowda, Keshava
>> Sent: Wednesday, May 11, 2011 7:35 PM
>> To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
>> Cc: Munegowda, Keshava; Balbi, Felipe; Gadiyar, Anand; 
>> parthab@india.ti.com
>> Subject: [PATCH 3/5] arm: omap: usb: device name change for 
>> the clk names of usbhs
> [snip]...[snip]
>
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -27,7 +27,7 @@
>>  #include <linux/gpio.h>
>>  #include <plat/usb.h>
>>  
>> -#define USBHS_DRIVER_NAME	"usbhs-omap"
>> +#define USBHS_DRIVER_NAME	"usbhs_omap"
>>  #define OMAP_EHCI_DEVICE	"ehci-omap"
>>  #define OMAP_OHCI_DEVICE	"ohci-omap3"
>
> [sp] Shouldn't we be consistent in using minus/dash and
>      underscore in the device names?

Also, can't we avoid once again changing the clock names
(at least for a while...)?
Is that really necessary? Can't hwmod use current clock names?
Because, Linus is sooo happy each time he sees that kind of changes....


-- 
Regards,
Igor.

