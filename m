From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v7 1/6] mtd: nand: omap: combine different flavours of
 1-bit hamming ecc schemes
Date: Mon, 7 Oct 2013 11:42:19 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA1F3DC@DBDE04.ent.ti.com>
References: <1380916188-24206-1-git-send-email-pekon@ti.com>
 <1380916188-24206-2-git-send-email-pekon@ti.com>
 <20131007112728.GA15365@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131007112728.GA15365@e106331-lin.cambridge.arm.com>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "tony@atomide.com" <tony@atomide.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi,
 Felipe" <balbi@ti.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "olof@lixom.net" <olof@lixom.net>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> From: Mark Rutland [mailto:mark.rutland@arm.com]
> > On Fri, Oct 04, 2013 at 08:49:43PM +0100, Pekon Gupta wrote:
> > OMAP NAND driver currently supports multiple flavours of 1-bit Hamming
> > ecc-scheme, like:
> > - OMAP_ECC_HAMMING_CODE_DEFAULT
> > 	1-bit hamming ecc code using software library
> > - OMAP_ECC_HAMMING_CODE_HW
> > 	1-bit hamming ecc-code using GPMC h/w engine
> > - OMAP_ECC_HAMMING_CODE_HW_ROMCODE
> > 	1-bit hamming ecc-code using GPMC h/w engin with ecc-layout
> compatible
> > 	to ROM code.
> >
> > This patch combines above multiple ecc-schemes into single
> implementation:
> > - OMAP_ECC_HAM1_CODE_HW
> > 	1-bit hamming ecc-code using GPMC h/w engine with ROM-code
> compatible
> > 	ecc-layout.
> 
> If I have my NAND formatted with one of the existing ECC schemes (e.g.
> OMAP_ECC_HAMMING_CODE_DEFAULT) will it work with the new
> OMAP_ECC_HAM1_CODE_HW scheme?
> 
> Are they all compatible?
> 
Yes, they all are 1-bit hamming code, the only difference between 
xx_Default and xx_HW was who was doing the ECC calculation.
For xx_DEFAULT: ECC calculation was done on CPU via s/w library
For xx_HW: ECC calculation was done by in-build h/w engine.
So, all HAMMING_xx can be replaced by HAM1_HW.

[snip]

> > @@ -1342,9 +1342,7 @@ static void __maybe_unused
> gpmc_read_timings_dt(struct device_node *np,
> >  #ifdef CONFIG_MTD_NAND
> >
> >  static const char * const nand_ecc_opts[] = {
> > -	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "sw",
> > -	[OMAP_ECC_HAMMING_CODE_HW]		= "hw",
> > -	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hw-
> romcode",
> > +	[OMAP_ECC_HAM1_CODE_HW]			= "ham1",
> >  	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
> >  	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
> 
> Won't this break existing dts which have "sw", "hw", or "hw-romcode"?
> 
> Someone may try to use a new kernel with an old dt, and we marked them
> as deprecated, not removed.
> 
HAMMING_xx ECC scheme was used only on legacy platforms, when
BCH8 was not available, I have not seen anyone using this scheme
*from mainline kernel* from quite a long time. So, it's safe to remove them.

This is what was concluded as per below email.
http://lists.infradead.org/pipermail/linux-mtd/2013-September/048876.html

with regards, pekon

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
