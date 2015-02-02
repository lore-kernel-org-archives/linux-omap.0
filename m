From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/7] usb: extcon: Fix USB-Host cable name
Date: Mon, 2 Feb 2015 12:01:56 +0200
Message-ID: <54CF4B14.4050802@ti.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com> <1422274532-9488-3-git-send-email-rogerq@ti.com> <54CB6539.1040703@ti.com> <54CB8FBD.6050701@ti.com> <54CF0555.4080004@samsung.com> <54CF3EE7.2050705@ti.com> <54CF4974.7080404@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54CF4974.7080404-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 02/02/15 11:55, Chanwoo Choi wrote:
> Hi Roger,
> 
> On 02/02/2015 06:09 PM, Roger Quadros wrote:
>> Chanwoo,
>>
>> On 02/02/15 07:04, Chanwoo Choi wrote:
>>> Hi Roger,
>>>
>>> On 01/30/2015 11:05 PM, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> On 30/01/15 13:04, Roger Quadros wrote:
>>>>> Felipe & Chanwoo,
>>>>>
>>>>> On 26/01/15 14:15, Roger Quadros wrote:
>>>>>> The recommended name for USB-Host cable state is "USB-Host" and not
>>>>>> "USB-HOST" as per drivers/extcon/extcon-class.c extcon_cable_name.
>>>>>>
>>>>>> Change all instances of "USB-HOST" to "USB-Host".
>>>>>>
>>>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>>>> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>>>>> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>>>>
>>>>> This patch has no dependency to the rest so can be picked up as soon as possible.
>>>>>
>>>>> Do you think it is better to go via the USB tree?
>>>>> If yes then Chanwoo, can you please Ack this one? Thanks.
>>>>>
>>>>> This would mean that only the first patch needs to go through extcon tree as Tony
>>>>> will pick the rest.
>>>>
>>>> Hold on. Let's first decide what we really want to go ahead with
>>>> "USB-Host" or "USB-HOST".
>>>
>>> Currently, extcon driver have used the specific cable name(USB-Host or USB-HOST)
>>> without any standard way. So, I have plan to define common cable name in extcon
>>> header file by using capital letter.
>>
>> OK. In that case, this patch is not required.
>> I will resend patch 1 with cable name corrected to "USB-HOST".
> 
> If you possbile, I want to use 'USB-HOST' cable name in drivers related to extcon.
> If we use different cable name, this cause the confusion to control cable.
> 

Kernel tree shows following users of "USB-Host" that will have to be changed to
"USB-HOST".

extcon-class.c:	[EXTCON_USB_HOST]	= "USB-Host",
extcon-max77693.c:	[EXTCON_CABLE_USB_HOST]			= "USB-Host",
extcon-max77693.c:		extcon_set_cable_state(info->edev, "USB-Host", attached);
extcon-max8997.c:	[EXTCON_CABLE_USB_HOST]			= "USB-Host",
extcon-max8997.c:		extcon_set_cable_state(info->edev, "USB-Host", attached);
extcon-rt8973a.c:	[EXTCON_CABLE_USB_HOST]		= "USB-Host",
extcon-sm5502.c:	[EXTCON_CABLE_USB_HOST]	= "USB-Host",

I'm not aware if any user space programs depend on this name. Do you know of any?

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
