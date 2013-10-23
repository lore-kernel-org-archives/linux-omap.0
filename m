From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v10 04/10] mtd: nand: omap: fix device scan:
 NAND_CMD_READID, NAND_CMD_RESET, CMD_CMD_PARAM use only x8 bus
Date: Wed, 23 Oct 2013 05:07:48 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA29DB8@DBDE04.ent.ti.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-5-git-send-email-pekon@ti.com>
 <20131022201624.GL23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47349 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab3JWFIz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Oct 2013 01:08:55 -0400
In-Reply-To: <20131022201624.GL23337@ld-irv-0074.broadcom.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

Hi Brian,

> From: Brian Norris [mailto:computersforpeace@gmail.com]
> On Sat, Oct 19, 2013 at 02:14:08PM +0530, Pekon Gupta wrote:
[...]

> >
> > Thus this patch run nand_scan_ident() with driver configured as x8 device.
> 
> So are you saying that the driver currently doesn't work if you started
> in x16 buswidth? Are you having problems with a particular setup? What
> sort of devices are you testing?
> 
No, I'm saying that you cannot read ONFI params in x16 mode.
And, that is what was pointed out in following commit log also ..
(Reference to 3.3.2. Target Initialization: given above)
So, if I run nand_scan_ident() in x16 mode, my ONFI detection would 
fail for sure ..


> Running nand_scan_ident() with x8 when the device is actualy x16 will
> just cause nand_scan_ident() to abort with an error. It doesn't help you
> with the fact that RESET/READID/PARAM need special 8-bit handling on x16
> devices, so you're not solving the problem alluded to by Matthieu.
> 
Yes, absolutely agree.. 
The original code was calling nand_scan_ident() twice, without taking
into consideration whether the first nand_scan_ident() failed because
of bus-width mismatch or something else.

I'm also calling nand_scan_ident() twice, but only when the failure may
be due to bus-width mis-match. I'm just avoiding an extra call to
nand_scan_ident() if the failure was genuine.

If the device actually was x8 then nand_scan_ident() should not fail
for the first-time (in my patch), but if it still fails, then it's a genuine failure
_not_ because of bus-width mismatch.
I'm avoiding the call to nand_scan_ident() again .. 
(same is in my comments below..)

[...]

> What is your patch trying to solve? It seems like it's just a distortion
> of the same code that existed previously. It tries running
> nand_scan_ident() in one buswidth configuration, and then it tries the
> other if it failed. You still aren't doing either of the options we
> talked about previously. I'll repeat them:
> 
Absolutely.. probably you missed my replies in [PATCH v9 4/9]...


> (1) You specify the buswidth given by device-tree/platform-data; if this
>     is incorrect, you fail
> 
Absolutely this is what I'm doing.
But tell me how would you know the actual device-width if
nand_scan_ident()  fails 
(a) to probe ONFI params and 
- your device is  not in nand_ids[]
So get the actual device width, I call the first nand_scan_ident() in x8 mode.
so that ONFI params are read.
Now, if it nand_scan_ident() fails then it means actual device *may* be x16
So, I re-invoke nand_scan_ident() with chip->option |= pdata->devsize;


> (2) You auto-configure using NAND_BUSWIDTH_AUTO, and you use that to
>     validate the platform data; you just warn if the buswidth provided
>     by device-tree/platform-data was incorrect
> 
I have removed NAND_BUSWIDTH_AUTO implementation, as per feedbacks
This is <new> patch. May be you are confusing it with earlier version...
*please re-review*


> Am I sensing that you are having some implementation problem with one of
> these? You really shouldn't need to run nand_scan_ident() twice.
> 
> Or perhaps the "solution" in this patch is just that you're moving
> around the reassignment of the callback functions? If so, this is not
> obvious... see below.
> 
I'm repost my replies from [PATCH v9 4/9] in-case you missed...

------------------------------------
The GPMC driver will be touched by NAND_BUSWIDTH_AUTO change.
There are two set of configurations in GPMC controller..
(a) device based configurations:
  These are static configurations derived on DT bindings for each
  chip-select (like NAND signal timings, etc). These done on GPMC probe.
(b) ecc-scheme based configurations:
  These are dynamic configurations done in NAND driver in
  chip->ecc.hwctl() and are refreshed at each NAND accesss.

However, 'nand-bus-width' configuration is part of both (1) and (2).
Thus, both 'OMAP NAND driver' and 'GPMC driver' need to be
consistent in programming  'nand-bus-width' otherwise ecc-engine
would not work.

Thus, I'm proceeding with (1) DT based parsing of 'nand-bus-width'.
I have re-posted [PATCH v10 4/10] with this updates. However, please
take into account that some limitation of dual programming require
such probe. New patch also call nand_scan_ident() twice, but only
on certain pre-determined conditions, not in all failure.
Once I convert to NAND_BUSWIDTH_AUTO these should get clean,
 as I would update both GPMC and NAND driver for this.
(Till then this was most optimal solution I could think of)..
------------------------------------





> > ---
> >  drivers/mtd/nand/omap2.c | 45
> +++++++++++++++++++++++++++++++++------------
> >  1 file changed, 33 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > index 5596368..d29edda 100644
> > --- a/drivers/mtd/nand/omap2.c
> > +++ b/drivers/mtd/nand/omap2.c
> > @@ -1856,7 +1856,6 @@ static int omap_nand_probe(struct
> platform_device *pdev)
> >  	mtd->name		= dev_name(&pdev->dev);
> >  	mtd->owner		= THIS_MODULE;
> >  	nand_chip		= &info->nand;
> > -	nand_chip->options	= pdata->devsize;
> >  	nand_chip->options	|= NAND_SKIP_BBTSCAN;

See there is no NAND_BUSWIDTH_AUTO here ....



> > +	/* re-populate low-level callbacks based on xfer modes */
> >  	switch (pdata->xfer_type) {
> >  	case NAND_OMAP_PREFETCH_POLLED:
> >  		nand_chip->read_buf   = omap_read_buf_pref;
> 
> So am I to understand that the main purpose of this patch is not about
> the detection of the buswidth type, but about the (re)assignment of the
> callback functions? If so, you aren't making it very clear. (I wasn't
> paying too much attention to the fact that this code block is being
> moved across all the callback assignments.) The above code is just a
> more verbose way of doing the same thing as the code you're replacing,
> with an extra check to compare with the device-tree/platform-data.
> 
Nope, this is just the comment clean-up.. Please drop it if it confuses you.
One main request please review this patch by locally including it.
May be then you can understand that it has *nothing* to do with 
(re)assignment of callbacks.. rather there is no re-assignment at all
in this patch..
See there is no change in the lines below this comment change
Probably this comment clean-up confused you..


> > @@ -2011,17 +2043,6 @@ static int omap_nand_probe(struct
> platform_device *pdev)
> >  		}
> >  	}
> >
> > -	/* DIP switches on some boards change between 8 and 16 bit
> > -	 * bus widths for flash.  Try the other width if the first try fails.
> > -	 */
> > -	if (nand_scan_ident(mtd, 1, NULL)) {
> > -		nand_chip->options ^= NAND_BUSWIDTH_16;
> > -		if (nand_scan_ident(mtd, 1, NULL)) {
> > -			err = -ENXIO;
> > -			goto out_release_mem_region;
> > -		}
> > -	}
> > -
> >  	/* rom code layout */
> >  	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
> >
> 
> Anyway, I'm just going to have to flat out NAK this patch for now.
> Please rework the series without this patch and we can continue
> discussion of this patch independently (for one, this thread does not
> need to CC all of the device-tree folks).
> 

I think there was some confusion here..
So, I hv explained my patch above. Request you to please re-review this. 

I'll take NAND_BUSWIDTH_AUTO implementation as a separate patch,
because it would require changes in GPMC driver as stated above.
And so it would be all together independent patch-set.

I would wait for your reply.. 


with regards, pekon
