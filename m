From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: ARM: dts: omap3: NAND support - how?
Date: Thu, 18 Apr 2013 18:26:41 -0500
Message-ID: <51708131.2040208@ti.com>
References: <1366311829.4085.90.camel@mars>  <51704C05.4030200@ti.com>  <1366316595.4085.113.camel@mars>  <5170738F.8050305@ti.com> <1366325282.4232.6.camel@lovely> <51708097.6070102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36867 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936608Ab3DRX0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 19:26:44 -0400
In-Reply-To: <51708097.6070102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <daniel@zonque.org>, linux-omap@vger.kernel.org


On 04/18/2013 06:24 PM, Jon Hunter wrote:
> 
> On 04/18/2013 05:48 PM, Christoph Fritz wrote:
>> On Thu, 2013-04-18 at 17:28 -0500, Jon Hunter wrote:
>>> On 04/18/2013 03:23 PM, Christoph Fritz wrote:
>>
>>
>>>> OMAP3_EVM # md 0x6E000060 7
>>>> 6e000060: 00001800 00141400 00141400 0f010f01    ................
>>>> 6e000070: 010c1414 1f0f0a80 00000870             ........p...
>>
>>>
>>> I don't see any other errors in the log. So I am wondering if the
>>> chip-select mapping is setup correctly. Can you share a dump of the gpmc
>>> registers from u-boot?
>>
>> I already did, please see the "md 0x6E000060 7" from above. Below is my
>> work-sheet how I configured the values:
> 
> Sorry I missed that.
> 
>> ---
>>
>> To get the values right for dt-GPMC-NAND-Config, here are the GPMC
>> config registers for chip-select 0, they are taken from u-boot
>> by doing "md 0x6E000060 7" on the u-boot shell:
>>
>> 	GPMC_CONFIG1: 0x6e000060: 0x00001800
>> 	GPMC_CONFIG2: 0x6e000064: 0x00141400
>> 	GPMC_CONFIG3: 0x6e000068: 0x00141400
>> 	GPMC_CONFIG4: 0x6e00006c: 0x0F010F01
>> 	GPMC_CONFIG5: 0x6e000070: 0x010C1414
>> 	GPMC_CONFIG6: 0x6e000074: 0x1F0F0A80
>> 	GPMC_CONFIG7: 0x6e000078: 0x00000870


I would advise you dump the gpmc registers at the end of the gpmc probe.
I am sure you will see something completely different to the above based
upon your dt configuration.

Cheers
Jon
