From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Wed, 23 Jan 2013 10:18:15 +0000
Message-ID: <50FFB8E7.8070607@mimc.co.uk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com> <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna> <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com> <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk> <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com> <50FE66AC.2090306@mimc.co.uk> <B5906170F1614E41A8A28DE3B8D121433ECF3DD3@DBDE01.ent.ti.com> <50FE9692.2090001@mimc.co.uk> <20130122182331.GO22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:47893 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754210Ab3AWKSR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 05:18:17 -0500
In-Reply-To: <20130122182331.GO22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Porter, Matt" <mporter@ti.com>, Paul Walmsley <paul@pwsan.com>, Richard Cochran <richardcochran@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>

On 22/01/13 18:23, Tony Lindgren wrote:
> * Mark Jackson <mpfj-list@mimc.co.uk> [130122 05:46]:
>> On 22/01/13 13:32, Bedia, Vaibhav wrote:
>>
>> <snip>
>>
>>> Following works for me:
>>>
>>> Kernel
>>> ===
>>> git checkout next-20130122
>>> make distclean
>>> make omap2plus_defconfig
>>> <Enable the appended DTB related options via menuconfig>
>>> make -j7
>>> cat arch/arm/boot/zImage arch/arm/boot/dts/am335x-bone.dtb > arch/arm/boot/zImage-dtb.am335x-bone
>>> mkimage -A arm -O linux -C none -T kernel -a 0x80008000 -e 0x80008000 -n 'Linux' -d arch/arm/boot/zImage-dtb.am335x-bone arch/arm/boot/uImage-dtb.am335x-bone
>>>
>>> U-Boot
>>> ===
>>> Built from v2013.01
>>
>> <snip>
>>
>>> A dumb question... in your case what's the bootargs set? Note that the mainline
>>> kernel for AM335x doesn't have MMC support yet and the default bootargs is set to
>>> rootfs on MMC.
>>
>> Yes ... I'm trying to boot from a rootfs on MMC:-
>>
>> Kernel command line: console=ttyO0,115200n8 earlyprintk debug root=/dev/mmcblk0p2 ro rootfstype=ext2
>> rootwait
>>
>> But I should get *something* from the kernel before it starts trying to access the rootfs ?
> 
> Here's something Kevin fixed but did not send it out before going to
> a vacation. Can you give it a try with earlyprintk enabled?
> 
> Note that this does not help with no output early on, that sounds
> like a bug configuring the DEBUG_LL port somewhere.
> 
> Regards,
> 
> Tony
> 
> 
> 
> From: Kevin Hilman <khilman@deeprootsystems.com>
> Date: Tue, 15 Jan 2013 14:12:24 -0800
> Subject: [PATCH] Fix omap_serial as module with debug_ll and earlyprintk
> 
> Otherwise we can race with the earlyconsole getting turned off
> which can cause a non-booting system with earlyprintk enabled.
> 
> [tony@atomide.com: updated description]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Kevin, can I add your Signed-off-by to this one?
> 
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -1298,4 +1298,4 @@ static int __init omap_device_late_init(void)
>  	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
>  	return 0;
>  }
> -omap_late_initcall(omap_device_late_init);
> +late_initcall_sync(omap_device_late_init);
> 

Sorry ... still no joy:-

U-Boot# askenv bootargs
Please enter 'bootargs':ttyO0,115200n8 earlyprintk root=/dev/mmcblk0p2 ro rootfstype=ext2 rootwait
U-Boot# dhcp 80000000 10.0.0.100:/nanobone/uImage-dtb;bootm 80000000
link up on port 0, speed 100, full duplex
BOOTP broadcast 1
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
DHCP client bound to address 10.0.0.112
Using cpsw device
TFTP from server 10.0.0.100; our IP address is 10.0.0.112
Filename '/nanobone/uImage-dtb'.
Load address: 0x80000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ###########
         625 KiB/s
done
Bytes transferred = 3972199 (3c9c67 hex)
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux 3.8.0-rc3-12154-gac00f0e-d
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3972135 Bytes = 3.8 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

My .config can be found at http://pastebin.com/rj5ptt7W

Cheers
Mark J.
