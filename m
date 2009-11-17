From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: Is the OMAP patch process badly flawed?
Date: Tue, 17 Nov 2009 14:00:56 +0000
Message-ID: <4B02AC98.8030507@blueyonder.co.uk>
References: <20091116160402.deb0cc82.sfr@canb.auug.org.au> <4B0213AC.6050502@blueyonder.co.uk> <4B02A583.8090602@blueyonder.co.uk> <5A47E75E594F054BAF48C5E4FC4B92AB030A8C911F@dbde02.ent.ti.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:39019 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752968AbZKQOA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 09:00:57 -0500
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NAOcA-0002Cj-BL
	for linux-omap@vger.kernel.org; Tue, 17 Nov 2009 14:01:02 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NAOc9-0008Lx-Qz
	for linux-omap@vger.kernel.org; Tue, 17 Nov 2009 14:01:01 +0000
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C911F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 17/11/09 13:34, Gadiyar, Anand wrote:
> Sid Boyce wrote: 
>> I'm curious - I download, build and test kernels on x86 and x86_64
>> platforms, -rc, -rc-git and -git all build and run.
>> On the OMAP platform I have so far not been able to do that with
>> omap-git, omap-dss2-git trees and snapshots all missing basic hardware
>> support, e.g:- I get the latest from gitorious.org, make
>> omap3_beagle_defconfg, make xconfig, but there is no EHCI config
>> available. I hunt down the patch and hand apply "default y if
>> ARCH_OMAP34XX" to drivers/usb/Kconfig, next the build complains that
>> drivers/usb/host/ehci-hcd.c: 1143:2: error: #error "missing 
>> bus glue for
>> ehci-hcd"
>>
>> The bus glue patch ... ehci-omap.c no longer exists.
>> --- a/drivers/usb/host/ehci-hcd.c
>> +++ b/drivers/usb/host/ehci-hcd.c
>> @@ -1108,6 +1108,11 @@ MODULE_LICENSE ("GPL");
>>  #define        PLATFORM_DRIVER         ehci_hcd_au1xxx_driver
>>  #endif
>>
>> +#ifdef CONFIG_ARCH_OMAP34XX
>> +#include "ehci-omap.c"
>> +#define        PLATFORM_DRIVER         ehci_hcd_omap_driver
>> +#endif
>> +
>>  #ifdef CONFIG_PPC_PS3
>>  #include "ehci-ps3.c"
>>  #define        PS3_SYSTEM_BUS_DRIVER   ps3_ehci_driver
>>
>> I would expect patches sent upstream would result in all the basics for
>> long established platforms to be fully covered. Appreciating that
>> development is quite fast paced with mods and supporting new platforms.
>> Could someone please enlighten me?
> 
> Sid,
> 
> Speaking purely for EHCI, this is now queued up in Greg's USB queue
> for upstream and will get merged in the next cycle.
> 
> Until then, the linux-omap code does have working EHCI support
> on beagle, evm and the other boards. If you're cloning from
> gitorious, you're probably picking the wrong tree.
> 
> - Anand
> 
> 

Thanks, that explains a lot as I can't remember seeing those patches on
the linux-usb list for submission upstream.
What tree is best to clone?
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

