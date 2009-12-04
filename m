From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: EHCI support on beagleboard missing
Date: Fri, 04 Dec 2009 01:51:25 +0000
Message-ID: <4B186B1D.3080903@blueyonder.co.uk>
References: <20091201174333.GA31972@kroah.com> <1259690320-12415-1-git-send-email-gregkh@suse.de>,<4B169D4E.7050100@blueyonder.co.uk> <5A47E75E594F054BAF48C5E4FC4B92AB0309C8638F@dbde02.ent.ti.com> <4B16A18C.20108@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:41274 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754742AbZLDBvW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 20:51:22 -0500
Received: from [172.23.170.137] (helo=anti-virus01-08)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NGNKR-0005a5-Nt
	for linux-omap@vger.kernel.org; Fri, 04 Dec 2009 01:51:27 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NGNKQ-0008G2-Bt
	for linux-omap@vger.kernel.org; Fri, 04 Dec 2009 01:51:26 +0000
In-Reply-To: <4B16A18C.20108@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 02/12/09 17:19, Sid Boyce wrote:
> On 02/12/09 17:04, Gadiyar, Anand wrote:
>> Sid Boyce wrote:
>>> Greg,
>>> I've been told you have had the patch on your queue for quite some time.
>>> I don't have the patch details to hand, but drivers/usb/Kconfig and may
>>> be 2 other files affected. I have to search for the patch later.
>>> linux-omap-2.6 # ARCH=arm make
>>> CROSS_COMPILE=/opt/arm-2009q3/bin/arm-none-eabi- defconfig
>>>   HOSTCC  scripts/basic/fixdep
>>>   HOSTCC  scripts/basic/docproc
>>>   HOSTCC  scripts/basic/hash
>>>   HOSTCC  scripts/kconfig/conf.o
>>>   HOSTCC  scripts/kconfig/kxgettext.o
>>>   SHIPPED scripts/kconfig/zconf.tab.c
>>>   SHIPPED scripts/kconfig/lex.zconf.c
>>>   SHIPPED scripts/kconfig/zconf.hash.c
>>>   HOSTCC  scripts/kconfig/zconf.tab.o
>>>   HOSTLD  scripts/kconfig/conf
>>> *** Default configuration is based on 'versatile_defconfig'
>>> #
>>> # configuration written to .config
>>> #
>>
>>
>> Looks incorrect to me. Shouldn't you be doing omap3_beagle_config?
>>
>>> slipstream:/home/lancelot/OE/openembedded/linux-omap-2.6 # grep EHCI .config
>>> # CONFIG_USB_ARCH_HAS_EHCI is not set
>>>
>>
>> And this seems to be the linux-omap kernel. So the patch should be there,
>> and if it isn't then the correct list to ping would probably be linux-omap.
>>
>>
>> There's a patch in Greg's queue to set this with OMAP3 [1].
>> And there was a newer version that was sent by Olaf recently [2], not
>> sure if it was picked up. Either of these should get you going.
>>
>> - Anand
>>
>> [1] <http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usb-ehci-allow-ehci-to-be-built-on-omap3.patch>
>> [2] <http://marc.info/?l=linux-usb&m=125913935405310&w=2>
>>
> 
> That's the one.
> Thanks and Regards
> Sid.
> 

The patch is not on Greg's queue and he knows nothing about it.
When "default y if ARCH_OMAP34XX" is added to drivers/usb/Kconfig, it
still missing the glue patch which via google I can't find a recent patch.
It's somehow fallen down the plug hole and needs resubmitting as it's an
ever present problem in all but the launchpad 2.6.31 kernel.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

