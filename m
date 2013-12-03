From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/1] mfd: omap-usb-host: Fix USB device detection problems
 on OMAP4 Panda
Date: Tue, 3 Dec 2013 11:43:18 +0200
Message-ID: <529DA7B6.4020402@ti.com>
References: <1385730118-26402-1-git-send-email-rogerq@ti.com> <1385730118-26402-2-git-send-email-rogerq@ti.com> <AE90C24D6B3A694183C094C60CF0A2F6026B744D@saturn3.aculab.com> <529C4726.6080708@ti.com> <AE90C24D6B3A694183C094C60CF0A2F6026B7455@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7455@saturn3.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>, lee.jones@linaro.org, sameo@linux.intel.com
Cc: tomi.valkeinen@ti.com, balbi@ti.com, sr@denx.de, ljkenny.mailinglists@gmail.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/02/2013 06:28 PM, David Laight wrote:
>> From: Roger Quadros [mailto:rogerq@ti.com]
>> On 11/29/2013 03:17 PM, David Laight wrote:
> ...
>>>> +	timeout = jiffies + msecs_to_jiffies(100);
>>>> +	while (!(usbhs_read(omap->uhh_base, OMAP_UHH_SYSSTATUS)
>>>> +			& OMAP_UHH_SYSSTATUS_RESETDONE)) {
>>>> +		cpu_relax();
>>
>> You mean use msleep(1) here instead of cpu_relax()?
>> Shouldn't be a problem IMO, but can you please tell me why that is better
>> as the reset seems to complete usually in the first iteration.
> 
> If it doesn't finish in the first iteration you don't want to
> spin the cpu for 100ms.
> 
> If it hasn't finished in the first millisecond, you probably expect
> it to actually time out - so you might as well look (say) every 10ms.
> 

Understood now. Thanks.

cheers,
-roger
