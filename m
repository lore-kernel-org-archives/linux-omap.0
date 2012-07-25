From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] omap: usb: host: remove deprecated flag 'es2_compatibility'
Date: Wed, 25 Jul 2012 18:04:12 +0530
Message-ID: <CAP05o4Kcsz8sjJc6xHJYB2cRuixBojXuz0bgyjLxEu8xjUbd-A@mail.gmail.com>
References: <1343153320-4628-1-git-send-email-ruslan.bilovol@ti.com>
	<20120725075413.GS3630@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:32787 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932089Ab2GYMeN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 08:34:13 -0400
Received: by vcbf13 with SMTP id f13so481682vcb.9
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 05:34:12 -0700 (PDT)
In-Reply-To: <20120725075413.GS3630@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, tony@atomide.com, ajay.gupta@ti.com, gadiyar@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Jul 25, 2012 at 1:24 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Tue, Jul 24, 2012 at 09:08:40PM +0300, Ruslan Bilovol wrote:
>> Currently this flag is not used anywhere and may be safely removed.
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
>
> looks good to me. Keshava ?

Ruslan
     please remove the structure ohci_hcd_omap_platform_data too.
the ohci port configuration is any taken care by omap-usb-host.c file..

regards
keshava


>
>> ---
>>  arch/arm/mach-omap2/usb-host.c        |    1 -
>>  arch/arm/plat-omap/include/plat/usb.h |    4 ----
>>  2 files changed, 0 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
>> index dde8a11..5e1cb53 100644
>> --- a/arch/arm/mach-omap2/usb-host.c
>> +++ b/arch/arm/mach-omap2/usb-host.c
>> @@ -500,7 +500,6 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
>>               ehci_data.regulator[i] = pdata->regulator[i];
>>       }
>>       ehci_data.phy_reset = pdata->phy_reset;
>> -     ohci_data.es2_compatibility = pdata->es2_compatibility;
>>       usbhs_data.ehci_data = &ehci_data;
>>       usbhs_data.ohci_data = &ohci_data;
>>
>> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
>> index 762eeb0..f8c1eb8 100644
>> --- a/arch/arm/plat-omap/include/plat/usb.h
>> +++ b/arch/arm/plat-omap/include/plat/usb.h
>> @@ -32,9 +32,6 @@ struct usbhs_omap_board_data {
>>       /* have to be valid if phy_reset is true and portx is in phy mode */
>>       int     reset_gpio_port[OMAP3_HS_USB_PORTS];
>>
>> -     /* Set this to true for ES2.x silicon */
>> -     unsigned                        es2_compatibility:1;
>> -
>>       unsigned                        phy_reset:1;
>>
>>       /*
>> @@ -53,7 +50,6 @@ struct ehci_hcd_omap_platform_data {
>>
>>  struct ohci_hcd_omap_platform_data {
>>       enum usbhs_omap_port_mode       port_mode[OMAP3_HS_USB_PORTS];
>> -     unsigned                        es2_compatibility:1;
>>  };
>>
>>  struct usbhs_omap_platform_data {
>> --
>> 1.7.1
>>
>
> --
> balbi
