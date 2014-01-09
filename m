From: Michele Paolino <m.paolino@virtualopensystems.com>
Subject: Re: [PATCH v4 0/5] USB Host support for OMAP5 uEVM (for 3.14)
Date: Thu, 09 Jan 2014 12:22:38 +0100
Message-ID: <52CE867E.1090203@virtualopensystems.com>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com> <52CE824D.2090905@virtualopensystems.com> <52CE8314.2000000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:64338 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbaAILWk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jan 2014 06:22:40 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so2668652wes.27
        for <linux-omap@vger.kernel.org>; Thu, 09 Jan 2014 03:22:39 -0800 (PST)
In-Reply-To: <52CE8314.2000000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 09/01/2014 12:08, Roger Quadros wrote:
> Hi Michele,
>
> Did you enable CONFIG_USB_EHCI_HCD_OMAP in the kernel config?
> It is not enabled by default in omap2plus_defconfig.
Indeed it works.  Thank you!

>
> cheers,
> -roger
>
> On 01/09/2014 04:34 PM, Michele Paolino wrote:
>> Hello Roger,
>>
>> I'm testing your patch on an OMAP5430 EVM board. The ethernet is not working in my case. The kernel I'm using is (Tero Kristo's repo - branch 3.13-rc7-dt-clks-v13). Is there something that I'm missing?
>>
>> Here below you can find more info about my configuration:
>>
>> boot error messages:
>> eth0: ERROR while getting interface flags: No such device
>> SIOCSIFADDR: No such device
>> eth0: ERROR while getting interface flags: No such device
>> SIOCADDRT: Network is unreachable
>>
>> root@OMAP5:~# /usr/lib/klibc/bin/ipconfig eth0
>> ipconfig: eth0: SIOCGIFINDEX: No such device
>> /usr/lib/klibc/bin/ipconfig: no devices to configure
>>
>> root@OMAP5:~# uname -a
>> Linux OMAP5 3.13.0-rc7-g2a4526d-dirty #0 SMP Wed Jan 8 10:41:48 CET 2014x
>>
>> root@OMAP5:~# dmesg | grep eth
>> [    1.661434] usbcore: registered new interface driver cdc_ether
>>
>> Regards,
>>
>>
>> On 08/01/2014 07:15, Roger Quadros wrote:
>>> Hi Benoit & Tony,
>>>
>>> This patchset brings up USB Host ports and Ethernet port on
>>> the OMAP5 uEVM board.
>>>
>>> It depends on the TI Clock DT conversion patches [1] and is based
>>> on 3.13-rc7
>>>
>>> [1] - http://article.gmane.org/gmane.linux.ports.arm.kernel/289895
>>>
>>> Changelog:
>>>
>>> v4:
>>> - Updated DT binding document for clock binding
>>>
>>> v3:
>>> - Rebased on top of 3.13-rc7
>>>
>>> cheers,
>>> -roger
>>>
>>> Roger Quadros (5):
>>>    mfd: omap-usb-host: Update DT clock binding information
>>>    ARM: dts: OMAP5: Add 60MHz clock reference to USB Host module
>>>    ARM: dts: omap4-panda: Provide USB PHY clock
>>>    ARM: dts: omap5-uevm: Provide USB PHY clock
>>>    ARM: OMAP2+: Remove legacy_init_ehci_clk()
>>>
>>>   Documentation/devicetree/bindings/mfd/omap-usb-host.txt |  4 ++++
>>>   arch/arm/boot/dts/omap4-panda-common.dtsi               |  8 ++------
>>>   arch/arm/boot/dts/omap5-uevm.dts                        |  8 ++------
>>>   arch/arm/boot/dts/omap5.dtsi                            |  2 ++
>>>   arch/arm/mach-omap2/pdata-quirks.c                      | 16 ----------------
>>>   5 files changed, 10 insertions(+), 28 deletions(-)
>>>
>>
>> -- 
>> *Michele Paolino*, Virtualization R&D Engineer
>> Virtual Open Systems
>> /Open Source  KVM  Virtualization  Developments/
>> /Multicore Systems Virtualization Porting Services/
>> Web/:/ www.virtualopensystems. <http://www.virtualopensystems.com/>com <http://www.virtualopensystems.com/>
>>
>>
--
Michele Paolino, Virtualization R&D Engineer
Virtual Open Systems
