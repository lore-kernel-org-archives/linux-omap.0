From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: 3.13-rc2 phy-twl4030-usb.c - Timeout setting T2 HSUSB PHY DPLL
Date: Thu, 9 Jan 2014 10:54:59 +0530
Message-ID: <52CE32AB.1050204@ti.com>
References: <CAAfyv37aM6SrpuU9fzKA6GKsWn=To5ANOpG_kSX509NjMjdecA@mail.gmail.com>	<529F1E89.6080700@ti.com> <CAAfyv36sNyEiEHEOKfZWN1xRYLGUt-NW18uhcJbSTWRBA5=2BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAfyv36sNyEiEHEOKfZWN1xRYLGUt-NW18uhcJbSTWRBA5=2BA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Marek,

I have no idea what is happening there. Have you tried using device tree boot?
Board file boot support would be dropped eventually.

Did you try if I2C read write to the twl4030 device works and all necessary clocks/supplies are
present?

Kishon, do you know what is causing the USB DPLL failure there?

cheers,
-roger

On 01/09/2014 02:31 AM, Belisko Marek wrote:
> Any pointers? Still present in 3.13-rc7.
> 
> On Wed, Dec 4, 2013 at 1:22 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>> +Kishon
>>
>> On 12/03/2013 11:33 PM, Belisko Marek wrote:
>>> Hi,
>>>
>>> current 3.13-rcX break usb support on gta04 board (similar to
>>> beagleboard) when booting via board file.
>>>
>>> In console we can see messages:
>>>  [ 5227.287841] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>>> [ 5232.936096] omap_musb_mailbox: musb core is not yet ready
>>> [ 5233.958160] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>>> [ 5235.058227] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>>>
>>> Any pointer what could cause that? (in 3.12 usb works fine)
>>>
>>> BR,
>>>
>>> marek
>>>
>>
> 
> BR,
> 
> marek
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
