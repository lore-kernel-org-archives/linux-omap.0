From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: Re: [PATCH 0/4] ARM/dts: Update OMAP5 with address space and interrupts
Date: Mon, 22 Oct 2012 17:21:13 +0200
Message-ID: <50856469.8080409@ti.com>
References: <1350901328-3525-1-git-send-email-s-guiriec@ti.com> <5085541C.5040209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40327 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384Ab2JVPVU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 11:21:20 -0400
In-Reply-To: <5085541C.5040209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi Benoit,

On 10/22/2012 04:11 PM, Benoit Cousson wrote:
> Hi Seb,
>
> Good work. Thanks for that series.
>
> Just update it with all the acked-by you've got from the TI driver folks
> + the minor comment and I'll pull it in the for_3.8/dts branch.
>
> That's a detail but you should update the subject with "ARM: dts: OMAP5:
> XXX" prefix for consistency with the latest naming convention.
Thanks for the information I will update the series. I was thinking that 
it was the convention according to a past talk. I will update our full 
audio/display feature tree with this convention.

>
> Please, Cc the DT list as well.
>
> Regards,
> Benoit
>
> On 10/22/2012 12:22 PM, Sebastien Guiriec wrote:
>> Since kernel 3.7 the DTS data are not overwriten by hwmod data we can add the address space
>> and interrupt line description inside dtsi file for OMAP5. This serie is updating the
>> current OMAP5 IP with missing entry.
>>
>> It has been tested on OMAP5 with 3.7-audio-display feature tree.
>> - MMC is probing and functional
>> - TWL6041 probing (GPIO/I2C)
>> - booting (UART)
>>
>> Sebastien Guiriec (4):
>>    ARM/dts: omap5: Update GPIO with address space and interrupt
>>    ARM/dts: omap5: Update I2C with address space and interrupts
>>    ARM/dts: omap5: Update UART with address space and interrupts
>>    ARM/dts: omap5: Update MMC with address space and interrupts
>>
>>   arch/arm/boot/dts/omap5.dtsi |   56 +++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 52 insertions(+), 4 deletions(-)
>>
>

