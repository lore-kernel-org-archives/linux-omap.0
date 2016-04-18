From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 00/17] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Mon, 18 Apr 2016 15:52:58 +0300
Message-ID: <5714D8AA.9040304@ti.com>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
 <20160413212500.GD5995@atomide.com> <5710B58C.7050108@ti.com>
 <20160415120942.3131eac1@bbrezillon> <5710C86A.9060108@ti.com>
 <20160415135108.63716f06@bbrezillon> <20160415154139.GS5995@atomide.com>
 <20160415180531.15d790d2@bbrezillon> <20160415161950.GT5995@atomide.com>
 <20160416105711.5310d2d0@bbrezillon> <5714D3A4.2050405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5714D3A4.2050405@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>
Cc: javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 18/04/16 15:31, Roger Quadros wrote:
> On 16/04/16 11:57, Boris Brezillon wrote:
>> On Fri, 15 Apr 2016 09:19:51 -0700
>> Tony Lindgren <tony@atomide.com> wrote:
>>
>>>
>>>> Or should I just pull this immutable branch in my current nand/next and
>>>> let you pull the same immutable branch in omap-soc. I mean, would this
>>>> prevent conflicts when our branches are merged into linux-next, no
>>>> matter the order.
>>>
>>> Ideally just one or more branches with just minimal changes in
>>> them against -rc1. But you may have other dependencies in
>>> your NAND tree so that may no longer be doable :) Usually if
>>> I merge something that may need to get merged into other
>>> branches, I just apply them into a separate branch against -rc1
>>> to start with, then merge that branch in.
>>
>> Okay, in this case, that's pretty much what I did from the beginning,
>> except the immutable branch was provided by Roger (based on 4.6-rc1).
>> Thanks for this detailed explanation, I'll try to remember that when
>> I'll need to provide an immutable branch for another subsystem.
>>
>> Roger, my request remains, could you check/test my conflict resolution
>> (branch nand/next-with-gpmc-rework)?
> 
> I couldn't test that branch yet as nand/next is broken on omap platforms
> (at least on dra7-evm).
> 
> The commit where it breaks is:
> a662ef4 mtd: nand: omap2: use mtd_ooblayout_xxx() helpers where appropriate
> 
> I'm trying to figure out what went wrong there. Failure log below.

OK. I was able to fix it when at commit a662ef4 with the below patch.

Looks like we need to read exactly the ECC bytes through the ECC engine and not
the entire OOB region.

--cheers,
-oger

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index e622a1b..46b61d2 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1547,8 +1547,8 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->read_buf(mtd, buf, mtd->writesize);
 
 	/* Read oob bytes */
-	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, mtd->writesize, -1);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, mtd->writesize + chip->ecc.layout->eccpos[0], -1);
+	chip->read_buf(mtd, chip->oob_poi, chip->ecc.total);
 
 	/* Calculate ecc bytes */
 	chip->ecc.calculate(mtd, buf, ecc_calc);
