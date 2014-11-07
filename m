From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] mtd: nand: omap: Fix NAND enumeration on 3430 LDP
Date: Fri, 7 Nov 2014 11:35:35 +0200
Message-ID: <545C9267.7060301@ti.com>
References: <1415185258-11747-1-git-send-email-rogerq@ti.com> <20141106180333.GZ31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20141106180333.GZ31454@atomide.com>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, pekon@pek-sem.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/06/2014 08:03 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [141105 03:02]:
>> In commit 7d5929c1f343 ("mtd: nand: omap: Revert to using software ECC by default"),
>> we switched back to using 1-bit SW ECC scheme by default. However
>> commit b491da7233d5 ("mtd: nand: omap: clean-up ecc layout for BCH ecc schemes")
>> didn't take into account the 1-bit SW scheme (i.e. OMAP_ECC_HAM1_CODE_SW)
>> when checking for small page devices because it was already got rid of
>> one commit earlier. Consider OMAP_ECC_HAM1_CODE_SW while deciding
>> if we can proceed with small page devices or not.
>>
>> Fixes: 7d5929c1f34 ("mtd: nand: omap: Revert to using software ECC by default")
>>
>> Cc: <stable@vger.kernel.org>        [3.17+]
>> Reported-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/mtd/nand/omap2.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>> index 3b357e9..758e594 100644
>> --- a/drivers/mtd/nand/omap2.c
>> +++ b/drivers/mtd/nand/omap2.c
>> @@ -1742,7 +1742,8 @@ static int omap_nand_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	/* check for small page devices */
>> -	if ((mtd->oobsize < 64) && (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW)) {
>> +	if ((mtd->oobsize < 64) && (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW) &&
>> +	    (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_SW)) {
>>  		dev_err(&info->pdev->dev, "small page devices are not supported\n");
>>  		err = -EINVAL;
>>  		goto return_error;
> 
> Should this maybe have || instead of && For the OMAP_ECC_HAM1_CODE_SW?

The code is right.

there is a bug in omap3-ldp.dts.

there it says 
ti,nand-ecc-opt = "bch8";

This is wrong. OMAP3 doesn't support bch8. I think you should use either "ham1" or "sw"

Ideally we want "ham1" but to be compatible with with NAND partitions created
using legacy boot we need to stick with "sw"

see board_nand_init() in mach-omap2/board-flash.c

cheers,
-roger

> 
> With this patch applied on top of the other pending fixes, I still
> get:
> 
> nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xba
> nand: Micron MT29F2G16ABD
> nand: 128MiB, SLC, page size: 1024, OOB size: 32
> omap2-nand omap2-nand.0: small page devices are not supported
> omap2-nand: probe of omap2-nand.0 failed with error -22
> 
> Regards,
> 
> Tony
> 
