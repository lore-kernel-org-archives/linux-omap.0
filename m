From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] OMAP: config : disable the usb host configuration in omap2plus_defconfig
Date: Fri, 6 Jul 2012 17:31:41 +0530
Message-ID: <CAP05o4LBpbCHmXi_J1C6wtKX9SFHrntcZz7uWwMJvYHwPZsM+g@mail.gmail.com>
References: <1341575380-11972-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4LAQXzPs_gLBn70X-VbRWTCHOk0b4afH9gn0aUur2C7FQ@mail.gmail.com>
	<CAMQu2gwYDz10QcZvN1BSCr4TQLG2PEwshTN7VVk10PYzj6B2QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36992 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030372Ab2GFMBu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 08:01:50 -0400
Received: by lbjn8 with SMTP id n8so7360346lbj.0
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 05:01:42 -0700 (PDT)
In-Reply-To: <CAMQu2gwYDz10QcZvN1BSCr4TQLG2PEwshTN7VVk10PYzj6B2QQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Partha Basak <parthab@india.ti.com>, sameo@linux.intel.com, balbi@ti.com, Kevin Hilman <khilman@ti.com>

On Fri, Jul 6, 2012 at 5:29 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Fri, Jul 6, 2012 at 5:25 PM, Munegowda, Keshava
> <keshava_mgowda@ti.com> wrote:
>> On Fri, Jul 6, 2012 at 5:19 PM, Keshava Munegowda <keshava_mgowda@ti.com> wrote:
>>> The usb host is disabled in the omap2 build; This is because
>>> usb host is causing the retention to break in cpu idle.
>>>
>>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>>> ---
>>>  arch/arm/configs/omap2plus_defconfig |   11 -----------
>>>  1 file changed, 11 deletions(-)
>>>
>>> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
>>> index 9854ff4..7b32da6 100644
>>> --- a/arch/arm/configs/omap2plus_defconfig
>>> +++ b/arch/arm/configs/omap2plus_defconfig
>>> @@ -170,17 +170,6 @@ CONFIG_SND_USB_AUDIO=m
>>>  CONFIG_SND_SOC=m
>>>  CONFIG_SND_OMAP_SOC=m
>>>  CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
>>> -CONFIG_USB=y
>>> -CONFIG_USB_DEBUG=y
>>> -CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>>> -CONFIG_USB_DEVICEFS=y
>>> -CONFIG_USB_SUSPEND=y
>>> -CONFIG_USB_MON=y
>>> -CONFIG_USB_EHCI_HCD=y
>>> -CONFIG_USB_WDM=y
>>> -CONFIG_USB_STORAGE=y
>>> -CONFIG_USB_LIBUSUAL=y
>>> -CONFIG_USB_TEST=y
>>>  CONFIG_USB_GADGET=y
>>>  CONFIG_USB_GADGET_DEBUG=y
>>>  CONFIG_USB_GADGET_DEBUG_FILES=y
>>> --
>>> 1.7.9.5
>>>
>>
>> Sameo
>>     please merge this patch ; this makes the core retention to work in
>> omap2plus_defconfig
>>
> If at all this patch has to be merged, it should be via Tony's tree,
> otherwise you
> might have merge conflicts.
>
> Regards
> Santosh

Thanks Santosh
           looping Tony........

regards
keshava
