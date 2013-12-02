From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] mfd: omap-usb-host: Fix USB device detection problems
 on OMAP4 Panda
Date: Mon, 2 Dec 2013 14:05:59 +0200
Message-ID: <529C77A7.1000209@ti.com>
References: <1385730118-26402-1-git-send-email-rogerq@ti.com>	<1385730118-26402-2-git-send-email-rogerq@ti.com>	<CAOf5uwnttvOQ26USuDK1naq1nNtVbHo4c0UAfdep64bK2wyvBA@mail.gmail.com>	<529C5537.3080300@ti.com> <CAOf5uwmpiOv_GED23hWDArcOvs6DpHNEy=OJ9vnKem1pg8jSgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uwmpiOv_GED23hWDArcOvs6DpHNEy=OJ9vnKem1pg8jSgw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, ljkenny.mailinglists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Michael,

On 12/02/2013 11:51 AM, Michael Trimarchi wrote:
> Hi Roger
> 
> On Mon, Dec 2, 2013 at 10:39 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>> +Benoit, Tony, Paul.
>>
>> Hi Michael,
>>
>> On 11/30/2013 06:48 AM, Michael Trimarchi wrote:
>>> Hi Roger
>>>
>>> On Fri, Nov 29, 2013 at 2:01 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>>>> With u-boot 2013.10, USB devices are sometimes not detected
>>>> on OMAP4 Panda. To make us independent of what bootloader does
>>>> with the USB Host module, we must RESET it to get it to a known
>>>> good state. This patch Soft RESETs the USB Host module.
>>>>
>>>> Reported-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
>>>> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 3.10+
>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>  drivers/mfd/omap-usb-host.c | 115 +++++++++++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 109 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>>>> index 142650f..d4bd464 100644
>>>> --- a/drivers/mfd/omap-usb-host.c
>>>> +++ b/drivers/mfd/omap-usb-host.c
>>>> @@ -43,14 +43,18 @@
>>>>  /* UHH Register Set */
>>>>  #define        OMAP_UHH_REVISION                               (0x00)
>>>>  #define        OMAP_UHH_SYSCONFIG                              (0x10)
>>>> -#define        OMAP_UHH_SYSCONFIG_MIDLEMODE                    (1 << 12)
>>>> +#define        OMAP_UHH_SYSCONFIG_MIDLEMASK                    (3 << 12)
>>>> +#define OMAP_UHH_SYSCONFIG_MIDLESHIFT                  (12)
>>>>  #define        OMAP_UHH_SYSCONFIG_CACTIVITY                    (1 << 8)
>>>> -#define        OMAP_UHH_SYSCONFIG_SIDLEMODE                    (1 << 3)
>>>> +#define        OMAP_UHH_SYSCONFIG_SIDLEMASK                    (3 << 3)
>>>> +#define        OMAP_UHH_SYSCONFIG_SIDLESHIFT                   (3)
>>>>  #define        OMAP_UHH_SYSCONFIG_ENAWAKEUP                    (1 << 2)
>>>>  #define        OMAP_UHH_SYSCONFIG_SOFTRESET                    (1 << 1)
>>>>  #define        OMAP_UHH_SYSCONFIG_AUTOIDLE                     (1 << 0)
>>>>
>>>>  #define        OMAP_UHH_SYSSTATUS                              (0x14)
>>>> +#define OMAP_UHH_SYSSTATUS_RESETDONE                   (1 << 0)
>>>> +
>>>>  #define        OMAP_UHH_HOSTCONFIG                             (0x40)
>>>>  #define        OMAP_UHH_HOSTCONFIG_ULPI_BYPASS                 (1 << 0)
>>>>  #define        OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS              (1 << 0)
>>>> @@ -66,10 +70,10 @@
>>>>  #define OMAP4_UHH_HOSTCONFIG_APP_START_CLK             (1 << 31)
>>>>
>>>>  /* OMAP4-specific defines */
>>>> -#define OMAP4_UHH_SYSCONFIG_IDLEMODE_CLEAR             (3 << 2)
>>>> -#define OMAP4_UHH_SYSCONFIG_NOIDLE                     (1 << 2)
>>>> -#define OMAP4_UHH_SYSCONFIG_STDBYMODE_CLEAR            (3 << 4)
>>>> -#define OMAP4_UHH_SYSCONFIG_NOSTDBY                    (1 << 4)
>>>> +#define OMAP4_UHH_SYSCONFIG_MIDLEMASK                  (3 << 2)
>>>> +#define OMAP4_UHH_SYSCONFIG_MIDLESHIFT                 (2)
>>>> +#define OMAP4_UHH_SYSCONFIG_SIDLEMASK                  (3 << 4)
>>>> +#define OMAP4_UHH_SYSCONFIG_SIDLESHIFT                 (4)
>>>>  #define OMAP4_UHH_SYSCONFIG_SOFTRESET                  (1 << 0)
>>>>
>>>>  #define OMAP4_P1_MODE_CLEAR                            (3 << 16)
>>>> @@ -81,6 +85,12 @@
>>>>
>>>>  #define        OMAP_UHH_DEBUG_CSR                              (0x44)
>>>>
>>>> +/* MIDLE modes */
>>>> +#define OMAP_UHH_SYSCONFIG_MIDLE_NOSTANDBY             (1)
>>>> +
>>>> +/* SIDLE modes */
>>>> +#define OMAP_UHH_SYSCONFIG_SIDLE_NOIDLE                        (1)
>>>> +
>>>>  /* Values of UHH_REVISION - Note: these are not given in the TRM */
>>>>  #define OMAP_USBHS_REV1                0x00000010      /* OMAP3 */
>>>>  #define OMAP_USBHS_REV2                0x50700100      /* OMAP4 */
>>>> @@ -474,6 +484,97 @@ static unsigned omap_usbhs_rev2_hostconfig(struct usbhs_hcd_omap *omap,
>>>>         return reg;
>>>>  }
>>>>
>>>
>>> I'm digging in the code but as I understand this should be done by
>>> omap_hwmod and
>>> i660 avoid reset of the ehci module. This is done by ocp_softreset?
>>>
>>
>> It won't be done by omap_hwmod as we set HWMOD_INIT_NO_RESET flag in the hwmod data [1].
>>
>> Question is do we do it in the driver of leave it to hwmod?
>>
>> The other concern about i660 is in this comment [1]
>>
> 
> I don't find any description of this errata for omap4. Is this errata valid?

I can't say for sure. You might have to try it out without those flags and see if it works
reliably.

> 
> My change was to remove the NO_INIT and add 2uS as you have done

The 2uS delay that I added was my mistake and I don't think it is required.
Just removing HWMOD_INIT_NO_RESET should work.

cheers,
-roger

> 
>>         /*
>>          * During system oot; If the hwmod framework resets the module
>>          * the module will have smart idle settings; which can lead to deadlock
>>          * (above Errata Id:i660); so, dont reset the module during boot;
>>          * Use HWMOD_INIT_NO_RESET.
>>          */
>>
>> But if you look at the errata document [2], Advisory 1.108, it doesn't say that we can't be in smart-idle, but
>> only that we should put the module in force-idle, before cutting the module's functional clock. It also states
>> that the only way to recover from a lockup condition is to soft reset the module. So I'm not sure if the above comment
>> in the code is really valid. What if the lockup happens in the bootloader? In that case we will have to reset the module in
>> the kernel.
> 
> Michael
> 
>>
>> Doing the reset in probe does solve a problem for now i.e. eliminates dependency on bootloader.
>>
>> [1] - http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c#n2024
>> [2] - http://www.ti.com/litv/pdf/sprz318e
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
