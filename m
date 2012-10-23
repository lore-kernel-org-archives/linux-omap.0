From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH 1/4] mtd: nand: omap2: Update nerrors using ecc.strength
Date: Tue, 23 Oct 2012 10:17:55 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9D29BE@DBDE01.ent.ti.com>
References: <1349274589-11389-1-git-send-email-avinashphilip@ti.com>
	<1349274589-11389-2-git-send-email-avinashphilip@ti.com>
 <87obk3va1j.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <87obk3va1j.fsf@macbook.be.48ers.dk>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Mohammed, Afzal" <afzal@ti.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 16, 2012 at 00:26:40, Peter Korsgaard wrote:
> >>>>> Philip, Avinash <avinashphilip@ti.com> writes:
> 
>  > Update number of errors using nand ecc strength.
>  > Also add macro definitions BCH8_ERROR_MAX & BCH4_ERROR_MAX
> 
>  > Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
>  > ---
>  > :100644 100644 5b31386... af511a9... M	drivers/mtd/nand/omap2.c
>  >  drivers/mtd/nand/omap2.c |   12 ++++++++----
>  >  1 files changed, 8 insertions(+), 4 deletions(-)
> 
>  > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>  > index 5b31386..af511a9 100644
>  > --- a/drivers/mtd/nand/omap2.c
>  > +++ b/drivers/mtd/nand/omap2.c
>  > @@ -111,6 +111,9 @@
>  >  #define	ECCCLEAR			0x100
>  >  #define	ECC1				0x1
>  
>  > +#define BCH8_MAX_ERROR		8	/* upto 8 bit coorectable */
>  > +#define BCH4_MAX_ERROR		4	/* upto 4 bit correctable */
> 
> First 'correctable' misspelled.

I will correct it

> 
> I don't personally think these defines improve readability very much
> compared to to just using 4/8, though.

Thought of removing magic numbers & provide information also.

Thanks
Avinash

> 
> -- 
> Bye, Peter Korsgaard
> 

