From: Kovacs Peter Tamas <p.kovacs@holografika.com>
Subject: Re: Enabling HSUSB1 port on OMAP3430 labrador
Date: Thu, 26 Nov 2009 11:54:57 +0100
Message-ID: <4B0E5E81.6030706@holografika.com>
References: <4B0BEED4.1060005@holografika.com> <5A47E75E594F054BAF48C5E4FC4B92AB0309DAC237@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail01d.mail.t-online.hu ([84.2.42.6]:63865 "EHLO
	mail01d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbZKZKzH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 05:55:07 -0500
Received: from holoiroda.com (holoiroda.com [81.182.243.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail01d.mail.t-online.hu (Postfix) with ESMTPSA id A2A02758E8C
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2009 11:54:00 +0100 (CET)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309DAC237@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dear Anand,

thank you very much for your exhaustive answer and help. Unfortunately 
it seems there is no clock signal coming out of the HSUSB1_CLK line.

>> We are trying to make the HSUSB1 port on the OMAP3430 work as an USB host.
>> To do that, an ISP1507A ULPI HighSpeed USB transceiver is connected to 
>> the HSUSB1pins (HSUSB1_STP, CLK, D-0..D7, DIR, NXT).
>>
>> I have all these USB related kernel config options enabled:
>> USB_EHCI_HCD
>> USB_OHCI_HCD
>> USB_MUSB_HDRC
>> TWL4030_USB
>>
>> My guess was that either EHCI or the Inventra should be the one enabling 
>> that USB port on the OMAP, but no luck.
>> The external USB port on the MDK works fine with this configuration.
>>
>> The pin multiplexing configuration in the board file omap3430-labrador.c 
>> in u-boot also seems to be correct (although the config of USB1_STP 
>> seems to be strange, but changing that didn't work either).
>>     
>
> HSUSB1 is not supposed to be used with the labrador (do you have a link
> to the board schematics with the mods?). HSUSB1 is the EHCI port.
>   
What do you mean not supposed to be used? HSUSB0 goes to the TWL4030 and 
then out of the casing. HSUSB2 goes to the ISP1702, but the pins are not 
wired out on the Logic MDK baseboard so we cannot use that. Thus only 
one possibility remains if we need an extra USB port inside the casing, 
which is HSUSB1.
> Not sure why the pad conf is done in u-boot for this board, but maybe
> it was a copy-paste thing. That being said, if you've got the part
> installed correctly, it ought to work.
>   
Yes, I can also see these pin multiplexing configs in 
arch/arm/mach-omap2/usb-ehci.c.
I have defined CONFIG_OMAP_EHCI_PHY_MODE there to make sure they are PHY 
(couldn't find it in menuconfig, but this macro seems to be used in this 
single file).
Still, the clock goes high when powering the board on, and it remains 
there forever.

I recall seeing a TI-specific kernel source in another git repository, 
which had menuconfig options for setting PHY/TLL, maybe the USB code is 
different too?

>> Note, the ISP1507A is connected to the following pins of the BGA:
>> HSUSB1_STP (AF10)
>> HSUSB1_CLK (AE10)
>> HSUSB1_DIR (AF9)
>> HSUSB1_NXP (AG9)
>> HSUSB1_D0 (AF11)
>> HSUSB1_D1 (AG12)
>> HSUSB1_D2 (AH12)
>> HSUSB1_D3 (AH14)
>> HSUSB1_D4 (AE11)
>> HSUSB1_D5 (AH9)
>> HSUSB1_D6 (AF13)
>> HSUSB1_D7 (AE13)
>>     
>
> These are the pads for EHCI. So I suppose that's what you're trying to use.
>   
We suspect there might be a confusion here.
According to the Logic 3430 SOM board schematic, HSUSB1_CLK is AE10 (and 
also ETK_CLK, MMC3_CMD, GPIO_13).
According to the OMAP3430 Multimedia Processor Data Manual version N 
(OMAP3430_ES1.0_POP_DM_V_N.pdf), the AE10 pin can be ETK_CLK, HW_DBG1, 
GPIO_13 and SYS_NDMAREQ1, so it mentions HW_DBG1 as Mode3 instead of USB.
Then, in mach_omap2/usb-ehci.c, I can see  
omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK); Does this mean that Y8 is 
configured as USB? According to the Logic schematic pin Y8 is UART1_RX 
or GPIO_151, but not USB at all.

So far we have used the pins as seen in the Logic schematic for creating 
an extension board with a number of SPI and GPIO signals, and everything 
worked perfectly. Why are the pins described differently?

> Note that EHCI on the OMAP3 supports only the input clocking mode. This
> might mean you need to check if you've configured the PHY correctly for
> this mode. (No XTAL required, OMAP provides the clock to the PHY).
> NXP seems to have removed all mention of this mode from their
> data sheets, so you might want to check with them.
>   
Thanks, this is our fault. The clock pin of the ISP1507 is output only, 
so it seems not to be compatible with the OMAP3430.
The clock pin of the ISP1504 can be configured for I/O, however this 
component is quite difficult to get, but it seems it's necessary.
> Also, do you see a 60MHz clock when you probe the HSUSB1_CLK line?
>   
Unfortunately not. There is a constant high in the CLK line during the 
whole poweron and boot process, no matter if I configure the USB to PHY 
or TLL. We've also tried another Logic OMAP MDK unit and the effect is 
the same.

Could you please suggest what can be the cause of no clock signal (and 
other ULPI signals) appearing at all?

Thanks,
Peter
