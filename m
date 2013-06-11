From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info
 clean up
Date: Tue, 11 Jun 2013 09:44:52 +0530
Message-ID: <51B6A43C.10301@ti.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com> <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com> <87zjv2ooxi.fsf@linaro.org> <51B58FE9.5040309@ti.com> <877gi1ew3r.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57630 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab3FKEPb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 00:15:31 -0400
In-Reply-To: <877gi1ew3r.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>, Sricharan R <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi Kevin,
On Monday 10 June 2013 10:33 PM, Kevin Hilman wrote:
> Hi Lokesh,
>
> Lokesh Vutla <lokeshvutla@ti.com> writes:
>
>> Hi Kevin,
>>
>> On Friday 07 June 2013 03:57 AM, Kevin Hilman wrote:
>>> Paul Walmsley <paul@pwsan.com> writes:
>>>
>>>> On Wed, 29 May 2013, Santosh Shilimkar wrote:
>>>>
>>>>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>>>>>
>>>>> AM33XX only supports DT boot mode and with addition of
>>>>> extracting module resources like, irq, dma and address space
>>>>> from DT block, so now we can remove duplicate information from
>>>>> hwmod data file.
>>>>
>>>> OK, guess I'll take your word for it that it all works.  The
>>>> BeagleBone-white with appended DTB hasn't booted here since v3.7.
>>>> And the BeagleBone-black with discrete DTB doesn't boot at all with
>>>> current mainline, only with the TI vendor kernel & DTB...
>>>
>>> Anyone care to shed light on what's missing for BeagleBone boot with
>>> mainline currently?
>> I have tested BeagleBone boot with today's mainline bootloader and
>> kernel. It boots perfectly fine.
>
> Can you post git trees + branch names (and/or commit IDs) and also
> kernel config please?
Following are the details:
U-Boot:
url: 			git://git.denx.de/u-boot.git
branch :  	master
config:		am335x_evm
Top commit: 	"842033e pci: introduce CONFIG_PCI_INDIRECT_BRIDGE option"

Kernel:
url:			git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
branch:		master
config:		omap2plus_defocnfig
dtb file:		am335x-bone.dtb
Top commit:	"317ddd2 Linux 3.10-rc5" (On top of this I have a local 
patch for appending dtb)
You can find the logs here: http://pastebin.com/vcBr0UhM

Thanks and regards,
Lokesh
  		
>
> Thanks,
>
> Kevin
>

