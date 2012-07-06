From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: config : disable the usb host configuration in omap2plus_defconfig
Date: Fri, 06 Jul 2012 11:11:07 -0700
Message-ID: <87sjd4bw04.fsf@ti.com>
References: <1341575380-11972-1-git-send-email-keshava_mgowda@ti.com>
	<87d349c70t.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87d349c70t.fsf-l0cyMroinI0@public.gmane.org> (Kevin Hilman's message of "Fri, 06 Jul
	2012 07:13:06 -0700")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> writes:

> Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:
>
>> The usb host is disabled in the omap2 build; This is because
>> usb host is causing the retention to break in cpu idle.
>
> ... and causes warnings during boot, and hangs in suspend, can't suspend
> using NFSroot, etc. etc.
>
> Thank you for disabling this by default, But I don't think this fix
> is targetted enough (more below.)
>
> Tony, when v3.5 came out, I asked them to fix this properly, but nothing
> was done.  So I've resorted to requesting that this feature be disabled
> by default since it introduced PM regressions.  Of course, I'd like to
> see this fixed properly instead, but we've run out of time for v3.5 and
> IMO, this PM regression needs to be fixed for v3.5.  See my more
> targetted patches below.
>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/configs/omap2plus_defconfig |   11 -----------
>>  1 file changed, 11 deletions(-)
>>
>> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
>> index 9854ff4..7b32da6 100644
>> --- a/arch/arm/configs/omap2plus_defconfig
>> +++ b/arch/arm/configs/omap2plus_defconfig
>> @@ -170,17 +170,6 @@ CONFIG_SND_USB_AUDIO=m
>>  CONFIG_SND_SOC=m
>>  CONFIG_SND_OMAP_SOC=m
>>  CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
>> -CONFIG_USB=y
>> -CONFIG_USB_DEBUG=y
>> -CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>> -CONFIG_USB_DEVICEFS=y
>> -CONFIG_USB_SUSPEND=y
>> -CONFIG_USB_MON=y
>> -CONFIG_USB_EHCI_HCD=y
>> -CONFIG_USB_WDM=y
>> -CONFIG_USB_STORAGE=y
>> -CONFIG_USB_LIBUSUAL=y
>> -CONFIG_USB_TEST=y
>
> Why disable all of these?  With that, it's not terribly clear what is
> going on, or why.
>
> Instead, what you need is a targetted fix to just disable the problem
> driver by default:
>
> Either this:
>
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 9854ff4..11828e6 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -176,7 +176,6 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_DEVICEFS=y
>  CONFIG_USB_SUSPEND=y
>  CONFIG_USB_MON=y
> -CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_WDM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_LIBUSUAL=y
>
> or this:
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index e129c82..3747826 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -825,7 +825,7 @@ config MFD_WL1273_CORE
>  config MFD_OMAP_USB_HOST
>  	bool "Support OMAP USBHS core driver"
>  	depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
> -	default y
> +	default n
>  	help
>  	  This is the core driver for the OAMP EHCI and OHCI drivers.
>  	  This MFD driver does the required setup functionalities for
>
> Will have the inteded affect with the benefit of being much clearer
> about what is actually being disabled, and why.

Since I'm primarily concerned about automated PM testing of
omap2plus_defconfig, I think the first one is better since it just
affects the default omap2plus_defconfig and allows custom defconfigs to
continue to work as usual.

I'll send a patch.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
