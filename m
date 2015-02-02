From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 2/7] usb: extcon: Fix USB-Host cable name
Date: Mon, 02 Feb 2015 18:55:00 +0900
Message-ID: <54CF4974.7080404@samsung.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com>
 <1422274532-9488-3-git-send-email-rogerq@ti.com> <54CB6539.1040703@ti.com>
 <54CB8FBD.6050701@ti.com> <54CF0555.4080004@samsung.com>
 <54CF3EE7.2050705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <54CF3EE7.2050705@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, myungjoo.ham@samsung.com, george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On 02/02/2015 06:09 PM, Roger Quadros wrote:
> Chanwoo,
> 
> On 02/02/15 07:04, Chanwoo Choi wrote:
>> Hi Roger,
>>
>> On 01/30/2015 11:05 PM, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 30/01/15 13:04, Roger Quadros wrote:
>>>> Felipe & Chanwoo,
>>>>
>>>> On 26/01/15 14:15, Roger Quadros wrote:
>>>>> The recommended name for USB-Host cable state is "USB-Host" and not
>>>>> "USB-HOST" as per drivers/extcon/extcon-class.c extcon_cable_name.
>>>>>
>>>>> Change all instances of "USB-HOST" to "USB-Host".
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>>>>> Acked-by: Felipe Balbi <balbi@ti.com>
>>>>
>>>> This patch has no dependency to the rest so can be picked up as soon as possible.
>>>>
>>>> Do you think it is better to go via the USB tree?
>>>> If yes then Chanwoo, can you please Ack this one? Thanks.
>>>>
>>>> This would mean that only the first patch needs to go through extcon tree as Tony
>>>> will pick the rest.
>>>
>>> Hold on. Let's first decide what we really want to go ahead with
>>> "USB-Host" or "USB-HOST".
>>
>> Currently, extcon driver have used the specific cable name(USB-Host or USB-HOST)
>> without any standard way. So, I have plan to define common cable name in extcon
>> header file by using capital letter.
> 
> OK. In that case, this patch is not required.
> I will resend patch 1 with cable name corrected to "USB-HOST".

If you possbile, I want to use 'USB-HOST' cable name in drivers related to extcon.
If we use different cable name, this cause the confusion to control cable.

Thanks,
Chanwoo
