From: Kovacs Peter Tamas <p.kovacs@holografika.com>
Subject: Re: Enabling HSUSB1 port on OMAP3430 labrador
Date: Thu, 26 Nov 2009 15:57:21 +0100
Message-ID: <4B0E9751.9090207@holografika.com>
References: <4B0BEED4.1060005@holografika.com> <5A47E75E594F054BAF48C5E4FC4B92AB0309DAC237@dbde02.ent.ti.com> <4B0E5E81.6030706@holografika.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail02d.mail.t-online.hu ([84.2.42.7]:54929 "EHLO
	mail02d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbZKZO5U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 09:57:20 -0500
Received: from holoiroda.com (holoiroda.com [81.182.243.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail02d.mail.t-online.hu (Postfix) with ESMTPSA id 87D90758D7B
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2009 15:56:26 +0100 (CET)
In-Reply-To: <4B0E5E81.6030706@holografika.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dear Anand, All,

>>> We are trying to make the HSUSB1 port on the OMAP3430 work as an USB 
>>> host.
>>> To do that, an ISP1507A ULPI HighSpeed USB transceiver is connected 
>>> to the HSUSB1pins (HSUSB1_STP, CLK, D-0..D7, DIR, NXT).
>>>
>>> I have all these USB related kernel config options enabled:
>>> USB_EHCI_HCD
>>> USB_OHCI_HCD
>>> USB_MUSB_HDRC
>>> TWL4030_USB
>>>
>>> My guess was that either EHCI or the Inventra should be the one 
>>> enabling that USB port on the OMAP, but no luck.
>>> The external USB port on the MDK works fine with this configuration.
>>>
>>> The pin multiplexing configuration in the board file 
>>> omap3430-labrador.c in u-boot also seems to be correct (although the 
>>> config of USB1_STP seems to be strange, but changing that didn't 
>>> work either).  
>> Not sure why the pad conf is done in u-boot for this board, but maybe
>> it was a copy-paste thing. That being said, if you've got the part
>> installed correctly, it ought to work.
>>   
> Yes, I can also see these pin multiplexing configs in 
> arch/arm/mach-omap2/usb-ehci.c.
> I have defined CONFIG_OMAP_EHCI_PHY_MODE there to make sure they are 
> PHY (couldn't find it in menuconfig, but this macro seems to be used 
> in this single file).
> Still, the clock goes high when powering the board on, and it remains 
> there forever.
>
> I recall seeing a TI-specific kernel source in another git repository, 
> which had menuconfig options for setting PHY/TLL, maybe the USB code 
> is different too?
After having no clock signal on the HSUSB1_CLK with the kernel pulled 
from from git.kernel.org/linux/kernel/linux-omap-2.6.git, I've tried 
some older ti-2.6.xx kernel branches from 
git.omapzoom.org/repo/omapkernel.git

branch ti-2.6.27-omap3 didn't compile.
branch ti-2.6.26-omap3 kind of works, but the HSUSB1_CLK is still dead.
branch ti-2.6.24-omap3 works, and during booting I can see a clock 
signal on HSUSB1_CLK, and also the STP signal seems to go high and back 
low as expected!

Is it possible that this feature is broken some months ago? I'll go and 
compare the relevant files, but your suggestions on how to make this 
work again in newer kernels are welcome.

Thanks,
Peter

