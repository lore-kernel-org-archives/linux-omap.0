From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] mtd: nand: omap2: Fix subpage write
Date: Thu, 19 Oct 2017 16:37:26 +0200
Message-ID: <20171019163726.2256ccdc@bbrezillon>
References: <1508402489-7436-1-git-send-email-rogerq@ti.com>
        <20171019155140.027d9b32@bbrezillon>
        <6ca33c39-e425-ff8b-f50a-3ce30b6c2d34@ti.com>
        <20171019162009.30e0c2df@bbrezillon>
        <c50a70b6-0b1b-274d-a8d9-1f4822584c0b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <c50a70b6-0b1b-274d-a8d9-1f4822584c0b@ti.com>
Sender: stable-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: richard@nod.at, tony@atomide.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "# v4 . 12+" <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 19 Oct 2017 17:23:24 +0300
Roger Quadros <rogerq@ti.com> wrote:

> On 19/10/17 17:20, Boris Brezillon wrote:
> > On Thu, 19 Oct 2017 17:11:34 +0300
> > Roger Quadros <rogerq@ti.com> wrote:
> >   
> >> On 19/10/17 16:51, Boris Brezillon wrote:  
> >>> On Thu, 19 Oct 2017 11:41:29 +0300
> >>> Roger Quadros <rogerq@ti.com> wrote:
> >>>     
> >>>> Since v4.12, NAND subpage writes were causing a NULL pointer
> >>>> dereference on OMAP platforms (omap2-nand) using OMAP_ECC_BCH4_CODE_HW,
> >>>> OMAP_ECC_BCH8_CODE_HW and OMAP_ECC_BCH16_CODE_HW.
> >>>>
> >>>> This is because for those ECC modes, omap_calculate_ecc_bch()
> >>>> generates ECC bytes for the entire (multi-sector) page and this can
> >>>> overflow the ECC buffer provided by nand_write_subpage_hwecc()
> >>>> as it expects ecc.calculate() to return ECC bytes for just one sector.
> >>>>
> >>>> However, the root cause of the problem is present much before
> >>>> v4.12 but was not seen then as NAND buffers were being allocated
> >>>> as one big chunck prior to
> >>>> commit 3deb9979c731 ("mtd: nand: allocate aligned buffers if NAND_OWN_BUFFERS is unset")
> >>>>
> >>>> Fix the issue by providing a OMAP optimized write_subpage() implementation.
> >>>>
> >>>> cc: <stable@vger.kernel.org> # v4.12+
> >>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >>>> ---
> >>>>  drivers/mtd/nand/omap2.c | 338 +++++++++++++++++++++++++++++++----------------
> >>>>  1 file changed, 225 insertions(+), 113 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> >>>> index 54540c8..a0bd456 100644
> >>>> --- a/drivers/mtd/nand/omap2.c
> >>>> +++ b/drivers/mtd/nand/omap2.c
> >>>> @@ -1133,129 +1133,172 @@ static u8  bch8_polynomial[] = {0xef, 0x51, 0x2e, 0x09, 0xed, 0x93, 0x9a, 0xc2,
> >>>>  				0x97, 0x79, 0xe5, 0x24, 0xb5};
> >>>>      
> >>
> >> <snip>
> >>  
> >>>> +
> >>>> +/**
> >>>>   * omap_read_page_bch - BCH ecc based page read function for entire page
> >>>>   * @mtd:		mtd info structure
> >>>>   * @chip:		nand chip info structure
> >>>> @@ -2044,7 +2153,7 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>>>  		nand_chip->ecc.strength		= 4;
> >>>>  		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
> >>>>  		nand_chip->ecc.correct		= nand_bch_correct_data;
> >>>> -		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
> >>>> +		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
> >>>>  		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
> >>>>  		/* Reserve one byte for the OMAP marker */
> >>>>  		oobbytes_per_step		= nand_chip->ecc.bytes + 1;
> >>>> @@ -2066,9 +2175,10 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>>>  		nand_chip->ecc.strength		= 4;
> >>>>  		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
> >>>>  		nand_chip->ecc.correct		= omap_elm_correct_data;
> >>>> -		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
> >>>> +		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_multi;
> >>>>  		nand_chip->ecc.read_page	= omap_read_page_bch;
> >>>>  		nand_chip->ecc.write_page	= omap_write_page_bch;
> >>>> +		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
> >>>>  		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
> >>>>  		oobbytes_per_step		= nand_chip->ecc.bytes;
> >>>>  
> >>>> @@ -2087,7 +2197,7 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>>>  		nand_chip->ecc.strength		= 8;
> >>>>  		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
> >>>>  		nand_chip->ecc.correct		= nand_bch_correct_data;
> >>>> -		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
> >>>> +		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
> >>>>  		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
> >>>>  		/* Reserve one byte for the OMAP marker */
> >>>>  		oobbytes_per_step		= nand_chip->ecc.bytes + 1;
> >>>> @@ -2109,9 +2219,10 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>>>  		nand_chip->ecc.strength		= 8;
> >>>>  		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
> >>>>  		nand_chip->ecc.correct		= omap_elm_correct_data;
> >>>> -		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
> >>>> +		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_multi;    
> >>>
> >>> Hm, it still looks wrong. omap_calculate_ecc_bch_multi() will generate
> >>> the same overflow when called by the core, or am I missing something?
> >>>     
> >> In the current setup core will never call ecc.calculate as we're overriding every op
> >> that can be used.  
> > 
> > Do you have a custom ->read_subpage()? If you don't, the core will use
> > nand_read_subpage(), and it's calling ->calculate() internally.  
> 
> read_subpage() will only be used if NAND_SUBPAGE_READ is set. We don't set it for omap2-nand.

Right, I always forget NAND_SUBPAGE_READ is an opt-in flag.

> 
> >   
> >>
> >> The thing is that omap driver code uses these hooks as is so I wasn't sure
> >> if I should change the caller code to call the multi versions directly and fix these
> >> hooks to single sector versions.  
> > 
> > I'd prefer this solution.
> >   
> >>
> >> Alternatively, is it OK to set them to NULL?  
> > 
> > Hm, I'm pretty sure it's not, see my comment about ->read_subpage().
> >   
> 
> Now is it?

It should be. Note that ->hwctl() shouldn't be used by the core either,
so if the only user is the driver itself, it might be good to get rid of
the ecc->hwctl = omap_enable_hwecc_bch assignement and call
omap_enable_hwecc_bch() directly. Just suggesting that as a follow-up
patch, let's try to keep the fix as small as possible.

> 
> >>
> >>  
> >>>>  		nand_chip->ecc.read_page	= omap_read_page_bch;
> >>>>  		nand_chip->ecc.write_page	= omap_write_page_bch;
> >>>> +		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
> >>>>  		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
> >>>>  		oobbytes_per_step		= nand_chip->ecc.bytes;
> >>>>  
> >>>> @@ -2131,9 +2242,10 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>>>  		nand_chip->ecc.strength		= 16;
> >>>>  		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
> >>>>  		nand_chip->ecc.correct		= omap_elm_correct_data;
> >>>> -		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
> >>>> +		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_multi;
> >>>>  		nand_chip->ecc.read_page	= omap_read_page_bch;
> >>>>  		nand_chip->ecc.write_page	= omap_write_page_bch;
> >>>> +		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
> >>>>  		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
> >>>>  		oobbytes_per_step		= nand_chip->ecc.bytes;
> >>>>      
> >>>     
> >>  
> >   
> 
