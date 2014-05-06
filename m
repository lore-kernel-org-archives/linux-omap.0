From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 0/7] USB support for DRA7-evm
Date: Tue, 6 May 2014 13:49:19 +0530
Message-ID: <53689B07.8030407@ti.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com> <53688D13.4000409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45961 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934235AbaEFITZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2014 04:19:25 -0400
In-Reply-To: <53688D13.4000409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com, balbi@ti.com, bcousson@baylibre.com
Cc: george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org



On Tuesday 06 May 2014 12:49 PM, Roger Quadros wrote:
> Hi Kishon,
> 
> Could you please pick the first 2 patches in this series for phy-next?
> They are independent of the rest. Thanks.

sure.. will be queuing it shortly.

Thanks
Kishon

> 
> cheers,
> -roger
> 
> On 05/05/2014 12:54 PM, Roger Quadros wrote:
>> Hi,
>>
>> This series enables the 2 USB ports on the DRA7-evm.
>>
>> NOTE: USB1 port is hard coded to work in peripheral mode and USB2 port
>> in host mode. This is due to missing ID pin interrupt in pre ver.E boards.
>>
>> USB1 port doesn't in peripheral mode out of the box due to missing VBUS detection
>> and mailbox write. To test this I had to do a manual write to enable VBUSVALID
>> in the USB_UTMI_OTG_STATUS register.
>> 	omapconf set bit 0x48880084 1
>>
>> USB2 port works well in host mode.
>>
>> Patches are based on 3.15-rc3.
>>
>> cheers,
>> -roger
>>
>> Changelog:
>>
>> v3:
>> -Rearraged patches. PHY related stuff first.
>> -Addressed backward compatibility issue for phy-omap-usb2.
>>
>> v2:
>> -Rebased on v3.15-rc3
>>
>> ---
>> Roger Quadros (7):
>>   phy: omap-usb2: Use generic clock names "wkupclk" and "refclk"
>>   phy: omap-usb2: Add clock names to Documentation binding
>>   ARM: dts: omap4+: Add clocks to USB2 PHY node
>>   ARM: dts: dra7-clock: Add "l3init_960m_gfclk" clock gate
>>   ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss
>>   ARM: dts: dra7: Add USB related nodes
>>   dts: dra7-evm: add USB support
>>
>>  Documentation/devicetree/bindings/phy/ti-phy.txt |   7 ++
>>  arch/arm/boot/dts/dra7-evm.dts                   |  24 ++++
>>  arch/arm/boot/dts/dra7.dtsi                      | 149 +++++++++++++++++++++++
>>  arch/arm/boot/dts/dra7xx-clocks.dtsi             |  12 +-
>>  arch/arm/boot/dts/omap4.dtsi                     |   2 +
>>  arch/arm/boot/dts/omap5.dtsi                     |   2 +
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c        |  22 ++--
>>  drivers/phy/phy-omap-usb2.c                      |  30 +++--
>>  8 files changed, 229 insertions(+), 19 deletions(-)
>>
> 
