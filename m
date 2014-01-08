From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: 3.13-rc2 phy-twl4030-usb.c - Timeout setting T2 HSUSB PHY DPLL
Date: Wed, 8 Jan 2014 22:01:24 +0100
Message-ID: <CAAfyv36sNyEiEHEOKfZWN1xRYLGUt-NW18uhcJbSTWRBA5=2BA@mail.gmail.com>
References: <CAAfyv37aM6SrpuU9fzKA6GKsWn=To5ANOpG_kSX509NjMjdecA@mail.gmail.com>
	<529F1E89.6080700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <529F1E89.6080700@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Any pointers? Still present in 3.13-rc7.

On Wed, Dec 4, 2013 at 1:22 PM, Roger Quadros <rogerq@ti.com> wrote:
> +Kishon
>
> On 12/03/2013 11:33 PM, Belisko Marek wrote:
>> Hi,
>>
>> current 3.13-rcX break usb support on gta04 board (similar to
>> beagleboard) when booting via board file.
>>
>> In console we can see messages:
>>  [ 5227.287841] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>> [ 5232.936096] omap_musb_mailbox: musb core is not yet ready
>> [ 5233.958160] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>> [ 5235.058227] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>>
>> Any pointer what could cause that? (in 3.12 usb works fine)
>>
>> BR,
>>
>> marek
>>
>

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
