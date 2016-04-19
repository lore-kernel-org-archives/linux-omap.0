From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 00/17] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Tue, 19 Apr 2016 17:49:49 +0300
Message-ID: <5716458D.1070903@ti.com>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
 <20160413212500.GD5995@atomide.com> <5710B58C.7050108@ti.com>
 <20160415120942.3131eac1@bbrezillon> <5710C86A.9060108@ti.com>
 <20160415135108.63716f06@bbrezillon> <20160415154139.GS5995@atomide.com>
 <20160415180531.15d790d2@bbrezillon> <20160415161950.GT5995@atomide.com>
 <20160416105711.5310d2d0@bbrezillon> <5714D3A4.2050405@ti.com>
 <5714D8AA.9040304@ti.com> <20160418151305.17a42437@bbrezillon>
 <5714E5AA.5050200@ti.com> <20160418161001.2a1c0bed@bbrezillon>
 <5714F185.5080103@ti.com> <20160419152250.6fc3f441@bbrezillon>
 <57164014.3040603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57164014.3040603-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 19/04/16 17:26, Roger Quadros wrote:
> On 19/04/16 16:22, Boris Brezillon wrote:
>> On Mon, 18 Apr 2016 17:39:01 +0300
>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>>
>>> On 18/04/16 17:10, Boris Brezillon wrote:
>>>> On Mon, 18 Apr 2016 16:48:26 +0300
>>>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>>>>
>>>>> Boris,
>>>>>
>>>>> On 18/04/16 16:13, Boris Brezillon wrote:
>>>>>> Hi Roger,
>>>>>>
>>>>>> On Mon, 18 Apr 2016 15:52:58 +0300
>>>>>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>>>>>>
>>>>>>> On 18/04/16 15:31, Roger Quadros wrote:
>>>>>>>> On 16/04/16 11:57, Boris Brezillon wrote:
>>>>>>>>> On Fri, 15 Apr 2016 09:19:51 -0700
>>>>>>>>> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Or should I just pull this immutable branch in my current nand/next and
>>>>>>>>>>> let you pull the same immutable branch in omap-soc. I mean, would this
>>>>>>>>>>> prevent conflicts when our branches are merged into linux-next, no
>>>>>>>>>>> matter the order.
>>>>>>>>>>
>>>>>>>>>> Ideally just one or more branches with just minimal changes in
>>>>>>>>>> them against -rc1. But you may have other dependencies in
>>>>>>>>>> your NAND tree so that may no longer be doable :) Usually if
>>>>>>>>>> I merge something that may need to get merged into other
>>>>>>>>>> branches, I just apply them into a separate branch against -rc1
>>>>>>>>>> to start with, then merge that branch in.
>>>>>>>>>
>>>>>>>>> Okay, in this case, that's pretty much what I did from the beginning,
>>>>>>>>> except the immutable branch was provided by Roger (based on 4.6-rc1).
>>>>>>>>> Thanks for this detailed explanation, I'll try to remember that when
>>>>>>>>> I'll need to provide an immutable branch for another subsystem.
>>>>>>>>>
>>>>>>>>> Roger, my request remains, could you check/test my conflict resolution
>>>>>>>>> (branch nand/next-with-gpmc-rework)?
>>>>>>>>
>>>>>>>> I couldn't test that branch yet as nand/next is broken on omap platforms
>>>>>>>> (at least on dra7-evm).
>>>>>>>>
>>>>>>>> The commit where it breaks is:
>>>>>>>> a662ef4 mtd: nand: omap2: use mtd_ooblayout_xxx() helpers where appropriate
>>>>>>>>
>>>>>>>> I'm trying to figure out what went wrong there. Failure log below.
>>>>>>>
>>>>>>> OK. I was able to fix it when at commit a662ef4 with the below patch.
>>>>>>
>>>>>> Thanks for debugging that.
>>>>>>
>>>>>>>
>>>>>>> Looks like we need to read exactly the ECC bytes through the ECC engine and not
>>>>>>> the entire OOB region.
>>>>>>
>>>>>> Hm, it looks like there's a bug somewhere else, because I don't see any
>>>>>> reason why the controller wouldn't be able to read the full OOB region.
>>>>>
>>>>> The controller can read the full OOB region but we only want it to read just
>>>>> the ECC bytes because that is the way the ELM ECC engine works.
>>>>
>>>> Ok, I think I got it: the ECC correction is pipelined with data read,
>>>> and the controller expect to have ECC bytes right after the in-band
>>>> data, is that correct?
>>>
>>> That is correct.
>>>
>>>>
>>>>>
>>>>>>>
>>>>>>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>>>>>>> index e622a1b..46b61d2 100644
>>>>>>> --- a/drivers/mtd/nand/omap2.c
>>>>>>> +++ b/drivers/mtd/nand/omap2.c
>>>>>>> @@ -1547,8 +1547,8 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
>>>>>>>  	chip->read_buf(mtd, buf, mtd->writesize);
>>>>>>>  
>>>>>>>  	/* Read oob bytes */
>>>>>>> -	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, mtd->writesize, -1);
>>>>>>> -	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
>>>>>>> +	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, mtd->writesize + chip->ecc.layout->eccpos[0], -1);
>>>>>>
>>>>>> The whole point of this series is to get rid of chip->ecc.layout, so
>>>>>> we'd rather use the mtd_ooblayout_find_eccregion() instead of
>>>>>> chip->ecc.layout->eccpos[0].
>>>>>
>>>>> We just need the position of the first ECC byte offset.
>>>>> Is that the most optimal way to get it?
>>>>
>>>> For the BCH case, it seems that ECC bytes always start at offset
>>>> BADBLOCK_MARKER_LENGTH, so you can just pass
>>>> mtd->writesize + BADBLOCK_MARKER_LENGTH.
>>>>
>>>> Let me know if this works, and I'll squash those changes into the
>>>> faulty commit (I know this implies a rebase + push -f, but IMO that's
>>>> better than breaking bisectability).
>>>>
>>>>
>>>
>>> So, the below patch works as well. Please feel free to fold it with your patch.
>>>
>>> --
>>> cheers,
>>> -roger
>>>
>>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>>> index e622a1b..eb85d6b 100644
>>> --- a/drivers/mtd/nand/omap2.c
>>> +++ b/drivers/mtd/nand/omap2.c
>>> @@ -1547,8 +1547,8 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
>>>  	chip->read_buf(mtd, buf, mtd->writesize);
>>>  
>>>  	/* Read oob bytes */
>>> -	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, mtd->writesize, -1);
>>> -	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
>>> +	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, mtd->writesize + BADBLOCK_MARKER_LENGTH, -1);
>>> +	chip->read_buf(mtd, chip->oob_poi, chip->ecc.total);
>>
>> Are you sure this patch works? Cause it seems to me that it should be
> 
> For my limited test case yes. My test case involves reading an existing ubifs partition
> and creating a new one and then reading it back using an older kernel.
> 
>>
>> 	chip->read_buf(mtd, chip->oob_poi + BADBLOCK_MARKER_LENGTH,
>> 		       chip->ecc.total);
>>
> 
> You are right. Else we'd have wrong OOB data during reads.

Strange, but nanddump is showing the correct OOB data with or without this
change. I'm puzzled.

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
