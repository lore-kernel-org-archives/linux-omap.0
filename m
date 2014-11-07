From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mtd: nand: omap: Fix NAND enumeration on 3430 LDP
Date: Fri, 7 Nov 2014 14:48:32 -0800
Message-ID: <20141107224832.GG31454@atomide.com>
References: <1415185258-11747-1-git-send-email-rogerq@ti.com>
 <20141106180333.GZ31454@atomide.com>
 <545C9267.7060301@ti.com>
 <545C97AB.4040402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <545C97AB.4040402@ti.com>
Sender: stable-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon@pek-sem.com, computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [141107 01:59]:
> On 11/07/2014 11:35 AM, Roger Quadros wrote:
> > On 11/06/2014 08:03 PM, Tony Lindgren wrote:
> >> * Roger Quadros <rogerq@ti.com> [141105 03:02]:
> >>> In commit 7d5929c1f343 ("mtd: nand: omap: Revert to using software ECC by default"),
> >>> we switched back to using 1-bit SW ECC scheme by default. However
> >>> commit b491da7233d5 ("mtd: nand: omap: clean-up ecc layout for BCH ecc schemes")
> >>> didn't take into account the 1-bit SW scheme (i.e. OMAP_ECC_HAM1_CODE_SW)
> >>> when checking for small page devices because it was already got rid of
> >>> one commit earlier. Consider OMAP_ECC_HAM1_CODE_SW while deciding
> >>> if we can proceed with small page devices or not.
> >>>
> >>> Fixes: 7d5929c1f34 ("mtd: nand: omap: Revert to using software ECC by default")
> >>>
> >>> Cc: <stable@vger.kernel.org>        [3.17+]
> >>> Reported-by: Tony Lindgren <tony@atomide.com>
> >>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >>> ---
> >>>  drivers/mtd/nand/omap2.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> >>> index 3b357e9..758e594 100644
> >>> --- a/drivers/mtd/nand/omap2.c
> >>> +++ b/drivers/mtd/nand/omap2.c
> >>> @@ -1742,7 +1742,8 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>>  	}
> >>>  
> >>>  	/* check for small page devices */
> >>> -	if ((mtd->oobsize < 64) && (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW)) {
> >>> +	if ((mtd->oobsize < 64) && (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW) &&
> >>> +	    (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_SW)) {
> >>>  		dev_err(&info->pdev->dev, "small page devices are not supported\n");
> >>>  		err = -EINVAL;
> >>>  		goto return_error;
> >>
> >> Should this maybe have || instead of && For the OMAP_ECC_HAM1_CODE_SW?
> > 
> > The code is right.
> > 
> > there is a bug in omap3-ldp.dts.
> > 
> > there it says 
> > ti,nand-ecc-opt = "bch8";
> > 
> > This is wrong. OMAP3 doesn't support bch8. I think you should use either "ham1" or "sw"
> 
> Well I'm wrong about the OMAP3 information. OMAP3 does support BCH4 and BCH8 as well.
> 
> I'm don't thinkg small page check is right. For BCH8 we need 13 bytes per 512 bytes.
> In the LDP case we have page size:1024 and OOB size: 32.
> Thus for BCH8 we need 26 bytes per page. which should fit in 32 bytes OOB.
> So this check is bogus in that case.
> 
> Pekon,
> 
> can you please explain why you check for 64 bytes OOB size for all ECC schemes?
> 
> Tony,
> 
> The question for backward compatibility still remains. Even if OMAP3 supports bch8
> do we stick to the scheme that was used in legacy boot or do we switch?

Well for the boards that had a standard file system, we should support
that. But at least for the LDP, there was only the "bootable microSD card"
AFAIK:

http://support.logicpd.com/ProductDownloads/LegacyProducts/ZoomOMAP34xMDK.aspx
 
> Then there is the question of boot rom compatibility. OMAP3 bootloaders use HAM1 scheme.
> So if you want to be able to flash bootloader from the kernel we have to stick with HAM1.
> 
> changing the ECC scheme would mean that NAND filesystems created earlier won't work
> and will have to be erased and recreated.

Right. I doubt anybody has bch8 rootfs on LDP.. And considering u-boot
must be ham1 to boot at all, that's what we should change for the
devices that do not have not standardized on bch8.

Regards,

Tony
