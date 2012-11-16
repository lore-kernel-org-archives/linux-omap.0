From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: OMAP baseline test results for v3.7-rc5
Date: Fri, 16 Nov 2012 13:01:43 +0100
Message-ID: <50A62B27.8060107@visionsystems.de>
References: <alpine.DEB.2.00.1211121921160.12551@utopia.booyaka.com> <50A61A36.10708@visionsystems.de> <50A629EB.4030700@gmail.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:52922 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab2KPMCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 07:02:10 -0500
In-Reply-To: <50A629EB.4030700@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i.mazanov@gmail.com
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On 16.11.2012 12:56, Igor Mazanov wrote:
> Yegor Yefremov wrote:
>>> Boot tests:
>>>
>>> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>>>   - May be fixed now, pending retest:
>>>     - http://marc.info/?l=linux-omap&m=135082257727502&w=2
>>>   - Not yet part of the automated test suite
>>>   * May be due to an old U-boot with FDT support problems used here?
>>>     Pending local investigation and re-test
>>
>> I'm also trying to boot 3.7-rc5, but my board has console on ttyO3. So I took arch/arm/boot/dts/am335x-evm.dts and replaced uart definition to
>>
>>  uart4: serial@481a6000 {
>>                         status = "okay";
>>                 };
>>
>> is it sufficient?
>>
>> In u-boot
>> commit 59852d03867108217fe88e3bfc3e1e9cedfe63c5
>> Merge: 22b6fcb b3e5cd1
>> Author: Tom Rini <trini@ti.com>
>> Date:   Fri Nov 9 08:47:25 2012 -0700
>>
>>     Merge branch 'master' of git://www.denx.de/git/u-boot-microblaze
>>
>> I use following commands and get following output:
>>
>> U-Boot#   mmc rescan ; fatload mmc 0 82000000 uImage;fatload mmc 0 80000000 am335x-evm.dtb
>> reading uImage
>> 4222584 bytes read
>> reading am335x-evm.dtb
>> 5172 bytes read
>> U-Boot# fdt addr 80000000; fdt resize; bootm 82000000 - 80000000
>> ## Booting kernel from Legacy Image at 82000000 ...
>>    Image Name:   Linux-3.7.0-rc5-00028-g79e979e
>>    Image Type:   ARM Linux Kernel Image (uncompressed)
>>    Data Size:    4222520 Bytes = 4 MiB
>>    Load Address: 80008000
>>    Entry Point:  80008000
>>    Verifying Checksum ... OK
>> ## Flattened Device Tree blob at 80000000
>>    Booting using the fdt blob at 0x80000000
>>    Loading Kernel Image ... OK
>> OK
>>    reserving fdt memory region: addr=80000000 size=2000
>>    Loading Device Tree to 8fe64000, end 8fe68fff ... OK
>>
>> Starting kernel ...
>>
>> I force kernel to use default params, so I don't specify them in u-boot. Any idea?
>
> Did you try to set console=ttyO3,115200 in u-boot bootargs settings?
>

Got the stuff working by just invoking make omap2plus_config once again. Perhaps I changed something viable and didn't notice that. Now waiting for MMC device tree support ;-)

Thanks.

Yegor
