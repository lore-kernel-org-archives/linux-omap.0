From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH 11/11] AM3517: Add mmc platform data for am3517evm
Date: Wed, 14 Apr 2010 15:14:17 +0800
Message-ID: <4BC56B49.8010106@windriver.com>
References: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com> <1271151270-13038-3-git-send-email-stanley.miao@windriver.com> <4BC46CD0.6060601@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:54862 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab0DNHFw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 03:05:52 -0400
In-Reply-To: <4BC46CD0.6060601@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>

Adrian Hunter wrote:
> Stanley.Miao wrote:
>> Add mmc platform data. Besides, the mmc slot on UI board has a pin 
>> conflict
>> with LCD, so add macros to resolve it.
>>
>> <snip>
>>  
>> +static struct omap2_hsmmc_info mmc[] = {
>> +    {
>> +        .mmc            = 1,
>> +        .wires          = 4,
>> +        .gpio_cd        = 127,
>> +        .gpio_wp        = 126,
>> +        .ocr_mask       = MMC_VDD_165_195 |
>> +                MMC_VDD_26_27 | MMC_VDD_27_28 |
>> +                MMC_VDD_29_30 |
>> +                MMC_VDD_30_31 | MMC_VDD_31_32,
>
> How can you support 1.8V and 3V cards without controlling power
> to the card?

Just modify the MMCHS_HCTL register.
I don't have a 1.8V card, so I didn't test the 1.8V mode. I just wrote 
it according to TRM.

Stanley.


