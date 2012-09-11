From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] arm/dts: Add omap3-beagle.dts
Date: Tue, 11 Sep 2012 13:57:30 +0200
Message-ID: <504F272A.7010402@ti.com>
References: <1347317870-13419-1-git-send-email-jon-hunter@ti.com> <504F208C.8030507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39293 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab2IKL5k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 07:57:40 -0400
In-Reply-To: <504F208C.8030507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 09/11/2012 01:29 PM, Benoit Cousson wrote:
> Hi Jon,
> 
> On 09/11/2012 12:57 AM, Jon Hunter wrote:
>> Add a minimal dts for original OMAP3430/3530 version of the Beagle board. This
>> version of the Beagle board has 256MB of DDR and features the same TWL4030
>> power management IC (PMIC) as the Beagle board XM.
> 
> Thanks for the patch.
> 
>> Given that the Beagle and Beagle-XM boards use the same PMIC, move the
>> definition of the VSIM regulator into the TWL4030.dtsi file so that we do not
>> need to duplicate in the Beagle board dts file.
> 
> Good, catch, regulator definition has indeed nothing to do outside the
> twl4030.dtsi.
> 
>> This has been boot tested on an OMAP3530 Beagle board and verifing that the
>> SD/MMC interface is working with a SD card.
>>
>> This patch is generated on top of Tony's patch for adding the Beagle board XM
>> dts file [1].
> 
> Tony has just updated his devel-dt with the DTS series I pushed plus the
> beagle-xm introduction, so I'm gonna put this one on top and built a
> for_3.7/dts_part2 branch sinec there are a couplf of USB / AM33xx pending.

OK, so in fact, it does not apply very well due to all the changes I
introduced in my for_3.7/dts pull and then the beagle is now missing all
the LEDs support recently added.

So you should refresh that patch taking the latest devel-dt branch as a
base and copying the latest beagle-xm.dts file.

>> diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
>> index 0e602b7..a469a55 100644
>> --- a/arch/arm/mach-omap2/Makefile.boot
>> +++ b/arch/arm/mach-omap2/Makefile.boot
>> @@ -3,7 +3,8 @@ params_phys-y		:= 0x80000100
>>  initrd_phys-y		:= 0x80800000
>>  
>>  dtb-$(CONFIG_SOC_OMAP2420)	+= omap2420-h4.dtb
>> -dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle-xm.dtb omap3-evm.dtb
>> +dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle.dtb omap3-beagle-xm.dtb \
>> +				   omap3-evm.dtb

You'd better duplicate the whole line like it is done for OMAP4 instead
of using the "\"

+dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-evm.dtb

Regards,
Benoit
