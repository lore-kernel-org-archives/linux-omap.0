From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v8 3/6] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC
 configurations in device_probe
Date: Sat, 12 Oct 2013 23:58:20 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA218B5@DBDE04.ent.ti.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-4-git-send-email-pekon@ti.com>
 <20131011192833.GL23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131011192833.GL23337@ld-irv-0074.broadcom.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "tony@atomide.com" <tony@atomide.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi,
 Felipe" <balbi@ti.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "olof@lixom.net" <olof@lixom.net>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Brian,

Thanks for such detailed review, please see some replies below..

> From: Brian Norris [mailto:computersforpeace@gmail.com]
> > On Fri, Oct 11, 2013 at 07:06:40PM +0530, Pekon Gupta wrote:
[...]
> Why do you even need the #ifdef's for the #include's? It is not harmful
> to include headers for stuff that is only conditionally used. In fact,
> this creates a problem later when you try to use nand_bch_free(), and
> you have to surround it with extra #ifdef's.
> 
> In short: these #ifdef's just breed more #ifdef's and cause the code to
> become harder to read and less maintainable.
> 
There are 2 problems here:
(1) 
I have removed #ifdef across headers in next version. But I cannot remove
#ifdef across some callbacks for  cc.hwctl(), ecc.calculate(), ecc.correct(),
because then compilation would throw warnings for un-used functions.
(2)
OMAP driver uses generic lib/bch.c which is compiled only when
CONFIG_MTD_NAND_ECC_BCH is enabled. So to avoid compilation
issues, I had to put #ifdefs on all wrapper functions which use lib/bch.c
or nand_bch.c

I myself have tried in previous versions to avoid #ifdefs, but I ended
up in one or the other problem like (1) |  (2) above.
And this is where randconfig test failed earlier when Arnd Bergmann
commented, so some #ifdef would hv to be carried till be deprecate
some legacy ecc-schemes.
However, with patch split many redundant #ifdefs are now removed.


> (I commented about the #ifdef's around nand_bch_free() in v6, and you
> did not address the comment.)
> 
Done now.. My bad again, I somehow mis-interpreted nand_bch.c earlier.


> > @@ -1846,20 +1726,18 @@ static int omap_nand_probe(struct
> > -	info->nand.options	|= NAND_SKIP_BBTSCAN;
> > -#ifdef CONFIG_MTD_NAND_OMAP_BCH
> > +	nand_chip->options	|= NAND_SKIP_BBTSCAN |
> NAND_BUSWIDTH_AUTO;
> 
> I recommended (in v6) you split the NAND_BUSWIDTH_AUTO change to a
> new
> patch and to describe it in the commit. You did neither.
> 
Sorry missed this purposely because I could not separate out the changes.
But now I have re-worked this in next revision as a separate patch.


> > +	/* scan NAND device conncted to controller */
> > +	if (nand_scan_ident(mtd, 1, NULL)) {
> > +		err = -ENXIO;
> > +		goto out_release_mem_region;
> > +	}
> > +	pr_info("%s: detected %s NAND flash\n", DRIVER_NAME,
> > +			(nand_chip->options & NAND_BUSWIDTH_16) ?
> "x16" : "x8");
> 
> I recommended you kill this in v6, and you did not address my comments.
> 
Sorry, this was my bad.


with regards, pekon

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
