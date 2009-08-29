From: Eric Witcher <ewitcher@mindspring.com>
Subject: Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v3
Date: Sat, 29 Aug 2009 18:38:07 -0400
Message-ID: <05DA4554-3E97-4545-B2FC-E458E3C0F078@mindspring.com>
References: <17586781.1251256830061.JavaMail.root@elwamui-hybrid.atl.sa.earthlink.net> <20090828181352.GN25828@atomide.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:44419 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752709AbZH2WiM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Aug 2009 18:38:12 -0400
In-Reply-To: <20090828181352.GN25828@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


On Aug 28, 2009, at 2:13 PM, Tony Lindgren wrote:

> Hi Eric & Felipe,
>
> * Eric Witcher <ewitcher@mindspring.com> [090825 20:20]:
>>
>> -----Original Message-----
>>> From: Felipe Balbi <felipe.balbi@nokia.com>
>>> Sent: Aug 19, 2009 9:40 AM
>>> To: ext Tony Lindgren <tony@atomide.com>
>>> Cc: Eric Witcher <ewitcher@mindspring.com>, "linux-omap@vger.kernel.org 
>>> " <linux-omap@vger.kernel.org>
>>> Subject: Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v3
>>>
>>> Hi,
>>>
>>> On Sun, Aug 16, 2009 at 05:42:00PM +0200, ext Tony Lindgren wrote:
>>>> From f9356c9b5ca663feb3a985b42d0409da5625d537 Mon Sep 17 00:00:00  
>>>> 2001
>>>> From: Paul Walmsley <paul@pwsan.com>
>>>> Date: Sun, 16 Aug 2009 18:29:49 +0300
>>>> Subject: [PATCH] OMAP3: update OMAP3 Beagle defconfig
>>>>
>>>> Update the OMAP3 Beagle defconfig to add EHCI, MMC, TWL4030 GPIO  
>>>> support.
>>>> Beagle can again use MMC rootfs after this patch.  Tested on  
>>>> BeagleBoard
>>>> rev C2.
>>>>
>>>> Patch updated to enable PM and OTG options as suggested by
>>>> Eric Witcher <ewitcher@mindspring.com>.
>>>>
>>>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>>>> Cc: Jason Kridner <jkridner@beagleboard.org>
>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>
>>> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
>>>
>>> now that we have REGULATOR and TWL4030_USB it will work.
>
> Updated the patch with Felipe's Ack. Then see below on how
> we should deal with the remaining parts.
>
>>>
>> Hi everyone,
>>
>> I just tested this again at the top of for-next at
>> 6e083649e19ba4aa3b8a65d75f394ab8a06feb78
>> and we are still short 2 changes in order to get a working
>> boot using omap3_beagle_defconfig.
>>
>> The changes are shown below.
>>
>> The code deltas were discussed before
>> but I didn't follow how the twl4030-usb.c change was going to make
>> it into the tree.
>>
>> With respect to the .config change, it was shown in my earlier post
>> but it didn't get put into the commit at
>> OMAP3: update OMAP3 Beagle defconfig
>> af9d536a65251a547864e3be87f53a22a6966b7a
>>
>> In that check-in configuration CONFIG_USB_M66592 overrides
>> CONFIG_USB_GADGET_MUSB_HDRC and we fail during compile.
>>
>> Eric
>>
>> ---
>> arch/arm/configs/omap3_beagle_defconfig |    4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/ 
>> configs/omap3_beagle_defconfig
>> index b213e3b..51c0fa8 100644
>> --- a/arch/arm/configs/omap3_beagle_defconfig
>> +++ b/arch/arm/configs/omap3_beagle_defconfig
>> @@ -899,8 +899,8 @@ CONFIG_USB_GADGET_SELECTED=y
>> # CONFIG_USB_GADGET_FSL_USB2 is not set
>> # CONFIG_USB_GADGET_NET2280 is not set
>> # CONFIG_USB_GADGET_PXA25X is not set
>> -CONFIG_USB_GADGET_M66592=y
>> -CONFIG_USB_M66592=y
>> +# CONFIG_USB_GADGET_M66592 is not set
>> +# CONFIG_USB_M66592 is not set
>> # CONFIG_USB_GADGET_PXA27X is not set
>> # CONFIG_USB_GADGET_GOKU is not set
>> # CONFIG_USB_GADGET_LH7A40X is not set
>
> Thanks, merged this part into the patch.
>
>
>> -- 
>> 1.6.2.2
>>
>> ---
>> arch/arm/mach-omap2/serial.c  |    1 -
>> drivers/usb/otg/twl4030-usb.c |    2 +-
>> 2 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/ 
>> serial.c
>> index 021130d..1cf8078 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -475,7 +475,6 @@ static void omap_uart_idle_init(struct  
>> omap_uart_state *uart)
>> 		uart->padconf = 0;
>> 	}
>>
>> -	p->irqflags |= IRQF_SHARED;
>> 	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
>> 			  "serial idle", (void *)uart);
>> 	WARN_ON(ret);
>
> The related serial irqflags changes are already queued up in for-next,
> so this we can ignore until the omap for-next is merged.
>
>
>> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/ 
>> twl4030-usb.c
>> index 9e3e7a5..d1852d4 100644
>> --- a/drivers/usb/otg/twl4030-usb.c
>> +++ b/drivers/usb/otg/twl4030-usb.c
>> @@ -774,7 +774,7 @@ static int __init twl4030_usb_init(void)
>> {
>> 	return platform_driver_register(&twl4030_usb_driver);
>> }
>> -subsys_initcall(twl4030_usb_init);
>> +subsys_initcall_sync(twl4030_usb_init);
>>
>> static void __exit twl4030_usb_exit(void)
>> {
>
> But this should be a separate patch and Felipe should take a look at  
> it.
Thanks Tony.

For Felipe to reference, here is the original patch (with a Tested-by  
added).

List:       linux-usb
Subject:    [PATCH] USB:otg:twl4030-usb.c: mark .init as  
subsys_initcall_sync
From:       tom.leiming () gmail ! com
Date:       2009-08-01 12:39:57
Message-ID: 1249130397-20971-1-git-send-email-tom.leiming () gmail ! com
[Download message RAW]

From: Ming Lei <tom.leiming@gmail.com>

This patch fixes the .probe failure of twl4030_usb driver if
it is compiled into kernel.

Since twl4030_usb USB transceiver .probe depends on
twl4030-regulator, marking twl4030_usb_init as subsys_initcall_sync
can make it called after twl4030-regulator initialization is finished,
then twl4030_usb USB transceiver driver can be probed successfully.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Tested-by: Eric Witcher <ewitcher@mindspring.com>
---
  drivers/usb/otg/twl4030-usb.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030- 
usb.c
index 9e3e7a5..d1852d4 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -774,7 +774,7 @@ static int __init twl4030_usb_init(void)
  {
  	return platform_driver_register(&twl4030_usb_driver);
  }
-subsys_initcall(twl4030_usb_init);
+subsys_initcall_sync(twl4030_usb_init);

  static void __exit twl4030_usb_exit(void)
  {
-- 
1.6.0.GIT

--




>
>
> Regards,
>
> Tony

