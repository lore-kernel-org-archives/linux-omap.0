From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: dra72-evm: Add i2c1 and tps65917 nodes
Date: Mon, 28 Jul 2014 14:52:11 +0530
Message-ID: <53D61643.4070005@ti.com>
References: <1406528334-4415-1-git-send-email-j-keerthy@ti.com> <53D5EE21.1040000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57554 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbaG1JYb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Jul 2014 05:24:31 -0400
In-Reply-To: <53D5EE21.1040000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, nm@ti.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, galak@codeaurora.org

On Monday 28 July 2014 12:00 PM, Lokesh Vutla wrote:
> On Monday 28 July 2014 11:48 AM, Keerthy wrote:
>> The patch series adds i2c1 and tps65917 and related nodes.
>> The patch series is boot tested on DRA72-EVM.
>>
>> Thanks to Lokesh <lokeshvutla@ti.com> for testing the series.

Correcting the 'to' list.

> For booting, this is dependent on recent hwmod fix patch series posted by me:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg108001.html
>
> Boot log for this series can be found here:
> http://paste.ubuntu.com/7881545/

Thanks Lokesh!

> Thanks and regards,
> Lokesh
>> Keerthy J (2):
>>    ARM: dts: dra72-evm: Enable I2C1 node
>>    ARM: dts: dra72-evm: Add tps65917 PMIC node
>>
>>   arch/arm/boot/dts/dra72-evm.dts |  120 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 120 insertions(+)
>>

