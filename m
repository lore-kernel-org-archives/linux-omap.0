From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH 3/6] ARM: dts: am437x-gp-evm: Don't use read/write wait
 monitoring
Date: Wed, 03 Sep 2014 22:59:30 +0530
Message-ID: <54074FFA.2020406@pek-sem.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com> <1409666227-20622-4-git-send-email-rogerq@ti.com> <54061439.1030909@pek-sem.com> <5406D213.6020603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us2.outbound.mailhostbox.com ([162.210.70.53]:57041 "EHLO
	us2.outbound.mailhostbox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932711AbaICR3q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 13:29:46 -0400
In-Reply-To: <5406D213.6020603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-mtd <linux-mtd@lists.infradead.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Hi Roger,

On Wednesday 03 September 2014 02:02 PM, Roger Quadros wrote:
> Hi Pekon,
>
> On 09/02/2014 10:02 PM, pekon wrote:
>> Hi Roger,
>>
>>
>> On Tuesday 02 September 2014 07:27 PM, Roger Quadros wrote:
>>> NAND uses wait pin only to indicate device readiness after
>>> a block/page operation. It is not use to extend individual
>>> read/write cycle and so read/write wait pin monitoring must
>>> be disabled for NAND.
>>>
>> I think this is incorrect assumption. NAND framework allows
>> wait-pin monitoring at end of each read/write cycle. Please
>> refer following code in drivers/mtd/nand/nand_base.c
>>      @@ void nand_wait_ready(...)
>>
>> - nand_wait_ready() calls controller-driver specific call-back
>>    for chip->dev_ready().
>
> It is important to note that this NAND device ready mechanism is diff=
erent from
> GPMC inter cycle wait state mechanism controlled by the read/write mo=
nitoring
> bits. The same WAIT pin is used in both the cases.
>
> For more details about NAND use case refer to
>
> AM437x TRM:
> Section: 9.1.3.3.12.2 NAND Device-Ready Pin
>
> below excerpt from there
> "To avoid a time-out caused by a block/page opening delay in NAND fla=
sh, disable the wait pin monitoring
> for read and write accesses (that is, set the GPMC_CONFIG1_i[[21] WAI=
TWRITEMONITORING and
> GPMC_CONFIG1_i[[22] WAITREADMONITORING bits to 0):
>

I re-read the AM437x TRM, and the section you mentioned above.

-----------------
*9.1.3.3.12.2 NAND Device-Ready Pin*
The NAND memory device provides a ready pin to indicate data=20
availability after a block/page opening and to indicate that data=20
programming is complete. The ready pin can be connected to one of the=20
WAIT GPMC input pins; data read accesses must not be tried when the=20
ready pin is sampled inactive (device is not ready) even if the=20
associated chip-select WAITREADMONITORING bit field is set. The duratio=
n=20
of the NAND device busy state after the block/page opening is so long=20
(up to 50 =CE=BCs) that accesses occurring when the ready pin is sample=
d=20
inactive can stall GPMC access and eventually cause a system time-out.
If a read access to a NAND flash is done using the wait monitoring mode=
,=20
the device is blocked during a page opening, and so is the GPMC. If the=
=20
correct settings are used, other chip-selects can be used while
the memory processes the page opening command.
=2E..
-----------------

It's clearly written that wait-pin monitoring is used for read/write=20
(programs) access, and GPMC is blocked till wait signal is asserted=20
during reads.
Also, on NAND there can be no read/write access except at page-level
so wait-pin monitoring is implicitly related to read/write accesses.
However, whether you use it or not is purely user's choice, but it
has performance impact.

You are probably seeing timeout condition when enabling wait-pin
monitoring, and this can be due to multiple reasons like;
(1) incorrect pin-mux configuration (like directions, pull-up etc)
(2) incorrect board-level pull-up
(3) incorrect driver setting, like though wait-pin is enabled but
     wrong wait-pin is being monitored.

I request you to fix this instead of disabling it completely,
as you should see significant NAND throughput increase once this
feature works correctly.

>>
>> - chip->dev_ready in-case of OMAP NAND drivers is set in
>>    drivers/mtd/nand/omap2.c  during probe.
>>      if (pdata->dev_ready) {
>>          nand_chip->dev_ready =3D omap_dev_ready;
>>          nand_chip->chip_delay =3D 0;
>>      }
>>
>> Problem is we don't set pdata->dev_ready correctly as part
>> of platform-data dring GPMC initialization. This was what my
>> earlier patch for wait-pin monitoring about. But it was a
>> quick fix for NAND devices.
>>
>> So, I suggest to fix wait-pin monitoring instead of de-scoping
>> it from DTS as wait-pin monitoring should boast the NAND
>> performance significantly.
>> (please see if you can find an old mail thread which had some
>> good feedbacks from Ezequiel and Javier about wait-pin monitoring).
>
> This is to get the device ready mechanism work and has nothing to do =
with
> GPMC wait monitoring. Instead the WAIT pin is used to generate the GP=
MC
> interrupt based on the WAIT pin polarity.
>
> To monitor NAND device ready status
> from TRM
> "-Use software to poll the WAITnSTS bit (n =3D 0 to 1) of the GPMC_ST=
S register.
> OR
> -Configure an interrupt that is generated on the WAIT signal change (=
through the GPMC_IRQEN [11-8] bits)"
>
>>
>> [...]
>>
>>> This patch also gets rid of the below warning when NAND is
>>> accessed for the first time.
>>>
>>> omap_l3_noc 44000000.ocp: L3 application error: target 13 mod:1 (un=
clearable)
>>>
>> Can you debug this further.
>> This warning probably comes when driver tries to access some
>> "reserved" addresses. Or violate read/write bits.
>
> It is caused because of incorrectly enabled the GPMC wait monitoring.=
 Disabling the
> wait monitoring gets rid of this error. I don't understand what else =
I should debug

I'm not sure how a NAND or GPMC feature can cause omap_l3_noc: L3=20
application error ?
But now as I re-read the text, its probably the L3 interconnect timeout
error due to no response from GPMC. There is a timer in L3 which=20
monitors if the L3 interconnect is stalled/blocked waiting for response
from a target. I think it's that timer which is getting timeout. (but=20
just my guess).


 > and why.
 >
As there were number of users on linux-mtd list wanted to use
NAND wait-pin monitoring on OMAP devices, so I have just looped
them if they see any concerns.
Otherwise, no further concerns from me.


with regards, pekon

------------------------
Powered by BigRock.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
