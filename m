From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/2] OMAP4+: Get rid of internal SRAM handling
Date: Wed, 28 Aug 2013 11:59:13 +0530
Message-ID: <521D98B9.4070902@ti.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com> <521CA8DF.9040400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34502 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab3H1G3l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Aug 2013 02:29:41 -0400
In-Reply-To: <521CA8DF.9040400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, Paul Walmsley <paul@pwsan.com>

On Tuesday 27 August 2013 06:55 PM, Santosh Shilimkar wrote:
> + Paul,
> 
> On Tuesday 27 August 2013 06:11 AM, Rajendra Nayak wrote:
>> Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
>> use drivers/misc/sram.c driver instead of the omap internal
>> implementation for SRAM handling.
>>
>> Rajendra Nayak (2):
>>   ARM: AM335x: Get rid of unused sram init function
>>   ARM: OMAP4+: Move SRAM data to DT
>>
>>  arch/arm/boot/dts/am33xx.dtsi        |    5 +++++
>>  arch/arm/boot/dts/am4372.dtsi        |    5 +++++
>>  arch/arm/boot/dts/omap4.dtsi         |    5 +++++
>>  arch/arm/boot/dts/omap5.dtsi         |    5 +++++
>>  arch/arm/configs/omap2plus_defconfig |    1 +
>>  arch/arm/mach-omap2/sram.c           |   39 +---------------------------------
>>  arch/arm/mach-omap2/sram.h           |    1 -
>>  7 files changed, 22 insertions(+), 39 deletions(-)
>>
> Really nice to see the SRAM code getting moved now. Thanks
> a lot Rajendra.
> 
> - The sram_init() seems to be the post core init call.
> Hope this is not a problem for SDRC init which needs to have
> SRAM ready to update the DDR parameters.

It should be fine given its needed only during core dvfs. Besides
drivers/misc/sram.c is useful only on DT platforms, so for now OMAP2/3
continue to use the omap specific sram handling.

> 
> Regards,
> Santosh
> 
> 

