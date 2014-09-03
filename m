From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/6] ARM: dts: am437x-gp-evm: Don't use read/write wait
 monitoring
Date: Wed, 3 Sep 2014 11:32:19 +0300
Message-ID: <5406D213.6020603@ti.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com> <1409666227-20622-4-git-send-email-rogerq@ti.com> <54061439.1030909@pek-sem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59519 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbaICIcq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Sep 2014 04:32:46 -0400
In-Reply-To: <54061439.1030909@pek-sem.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pekon <pekon@pek-sem.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-mtd <linux-mtd@lists.infradead.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Hi Pekon,

On 09/02/2014 10:02 PM, pekon wrote:
> Hi Roger,
> 
> 
> On Tuesday 02 September 2014 07:27 PM, Roger Quadros wrote:
>> NAND uses wait pin only to indicate device readiness after
>> a block/page operation. It is not use to extend individual
>> read/write cycle and so read/write wait pin monitoring must
>> be disabled for NAND.
>>
> I think this is incorrect assumption. NAND framework allows
> wait-pin monitoring at end of each read/write cycle. Please
> refer following code in drivers/mtd/nand/nand_base.c
>     @@ void nand_wait_ready(...)
> 
> - nand_wait_ready() calls controller-driver specific call-back
>   for chip->dev_ready().

It is important to note that this NAND device ready mechanism is different from
GPMC inter cycle wait state mechanism controlled by the read/write monitoring
bits. The same WAIT pin is used in both the cases.

For more details about NAND use case refer to 

AM437x TRM:
Section: 9.1.3.3.12.2 NAND Device-Ready Pin

below excerpt from there
"To avoid a time-out caused by a block/page opening delay in NAND flash, disable the wait pin monitoring
for read and write accesses (that is, set the GPMC_CONFIG1_i[[21] WAITWRITEMONITORING and
GPMC_CONFIG1_i[[22] WAITREADMONITORING bits to 0):

> 
> - chip->dev_ready in-case of OMAP NAND drivers is set in
>   drivers/mtd/nand/omap2.c  during probe.
>     if (pdata->dev_ready) {
>         nand_chip->dev_ready = omap_dev_ready;
>         nand_chip->chip_delay = 0;
>     }
> 
> Problem is we don't set pdata->dev_ready correctly as part
> of platform-data dring GPMC initialization. This was what my
> earlier patch for wait-pin monitoring about. But it was a
> quick fix for NAND devices.
> 
> So, I suggest to fix wait-pin monitoring instead of de-scoping
> it from DTS as wait-pin monitoring should boast the NAND
> performance significantly.
> (please see if you can find an old mail thread which had some
> good feedbacks from Ezequiel and Javier about wait-pin monitoring).

This is to get the device ready mechanism work and has nothing to do with
GPMC wait monitoring. Instead the WAIT pin is used to generate the GPMC
interrupt based on the WAIT pin polarity.

To monitor NAND device ready status
from TRM
"-Use software to poll the WAITnSTS bit (n = 0 to 1) of the GPMC_STS register.
OR
-Configure an interrupt that is generated on the WAIT signal change (through the GPMC_IRQEN [11-8] bits)"

> 
> [...]
> 
>> This patch also gets rid of the below warning when NAND is
>> accessed for the first time.
>>
>> omap_l3_noc 44000000.ocp: L3 application error: target 13 mod:1 (unclearable)
>>
> Can you debug this further.
> This warning probably comes when driver tries to access some
> "reserved" addresses. Or violate read/write bits.

It is caused because of incorrectly enabled the GPMC wait monitoring. Disabling the
wait monitoring gets rid of this error. I don't understand what else I should debug and why.

cheers,
-roger
