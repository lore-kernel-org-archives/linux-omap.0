From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/3] Add pinmux DT nodes to CPSW for AM335x
Date: Wed, 19 Jun 2013 04:52:00 -0500
Message-ID: <51C17F40.8090607@ti.com>
References: <1370604775-21264-1-git-send-email-mugunthanvnm@ti.com> <51C14772.4090701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36055 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934026Ab3FSJw4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jun 2013 05:52:56 -0400
In-Reply-To: <51C14772.4090701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: benoit.cousson@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On 06/19/2013 12:53 AM, Mugunthan V N wrote:
> On 6/7/2013 5:02 PM, Mugunthan V N wrote:
>> Add pinmux DT nodes to CPSW for the following AM335x boards
>> * AM335x Beaglebone
>> * AM335x EVM
>> * AM335x EVMsk
>> default state contains the pinmux required for active mode and
>> sleep mode contains pinmux reset values for energy saving.
>>
>> Mugunthan V N (3):
>>    ARM: dts: AM33XX: Add pinmux configuration for CPSW to beaglebone
>>    ARM: dts: AM33XX: Add pinmux configuration for CPSW to EVMsk
>>    ARM: dts: AM33XX: Add pinmux configuration for CPSW to am335x EVM
>>
>>   arch/arm/boot/dts/am335x-bone.dts  |   67 ++++++++++++++++++++++++++
>>   arch/arm/boot/dts/am335x-evm.dts   |   64 +++++++++++++++++++++++++
>>   arch/arm/boot/dts/am335x-evmsk.dts |   92
>> ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 223 insertions(+)
>>
> Benoit
>
> Do you have any comments on this patch series,
> if not can you queue it for v3.11

The series looks good to me. I've just applied it.

Thanks,
Benoit

