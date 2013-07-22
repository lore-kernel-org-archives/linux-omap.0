From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 0/4] dra7: I2C/MCSPI/UART pin control datas
Date: Mon, 22 Jul 2013 17:51:40 +0530
Message-ID: <51ED23D4.50005@ti.com>
References: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com> <51E969D3.2080804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41752 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab3GVMVs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 08:21:48 -0400
In-Reply-To: <51E969D3.2080804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: tony@atomide.com, benoit.cousson@linaro.org, balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Friday 19 July 2013 10:01 PM, Nishanth Menon wrote:
> On 07/19/2013 11:24 AM, Sourav Poddar wrote:
>> These series add support for I2C/MCSPI/UART pin control datas.
>>
>> The series is done on top of Rajendra Nayak series[1](posted to the 
>> list),
>> which has basic dt boot enable for dra7.
>> These patches has been tested, along with I2C and UART patches from
>> wolfram sang patch series[2].
>>
>>
>> [1]: http://www.spinics.net/lists/linux-omap/msg93535.html
>> [2]: https://lkml.org/lkml/2013/7/10/335
>>
>> Sourav Poddar (4):
>>    arm: dts: omap5-evm: Add I2c pinctrl data
>>    arm: dts: omap5-evm: Add I2c pinctrl data
>>    arm: dts: dra7-evm: Add SPI pinctrl data
>>    arm: dts: dra7-evm: Add UART pinctrl data
>>
>>   arch/arm/boot/dts/dra7-evm.dts |  123 
>> ++++++++++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/dra7.dtsi    |   15 +++++
>>   2 files changed, 138 insertions(+), 0 deletions(-)
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> DRA7 DTS is not merged yet, If I am not mistaken.
> Ref[1] [2]
> So why not squash these to [2]?
>
> [1] http://marc.info/?t=137335517900001&r=1&w=2
> [2] http://marc.info/?l=linux-arm-kernel&m=137335590702349&w=2
>
>
Yes, its not merged.
We can squash these series.
