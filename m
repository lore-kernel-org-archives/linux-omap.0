From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 14/27] mtd: nand: use the mtd instance embedded in struct
 nand_chip
Date: Tue, 17 Nov 2015 16:32:24 +0100 (CET)
Message-ID: <alpine.DEB.2.10.1511171630210.2455@hadrien>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com> <1447681080-31232-15-git-send-email-boris.brezillon@free-electrons.com> <20151117030019.GY8456@google.com> <20151117093836.052c86b5@bbrezillon> <alpine.DEB.2.10.1511170957100.2455@hadrien>
 <20151117152216.539fc09b@bbrezillon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20151117152216.539fc09b@bbrezillon>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian
List-Id: linux-omap@vger.kernel.org

On Tue, 17 Nov 2015, Boris Brezillon wrote:

> Hi Julia,
>
> On Tue, 17 Nov 2015 10:05:03 +0100 (CET)
> Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> > > > (This isn't the worst one, but it just happens to be one of the first.)
> > > > There are many cases where the typical style would be to declare a new
> > > > variable at the top of the function, where you perform the
> > > > macro/function-call to convert from one abstraction to another. Like
> > > >
> > > > static int nfc_set_sram_bank(struct atmel_nand_host *host, unsigned int bank)
> > > > {
> > > > 	struct mtd_info *mtd = nand_to_mtd(&hot->nand_chip);
> > > > 	...
> > > >
> > > > and then use it later. Can that be done very easily?
> > > >
> > > > >  			return -EINVAL;
> > > > >  		nfc_writel(host->nfc->hsmc_regs, BANK, ATMEL_HSMC_NFC_BANK1);
> > > > >  	} else {
> > > >
> > > > ...
> > >
> > > Honestly, I don't know how to do that with a coccinelle script, and it
> > > will probably take me more time to find how to do it than addressing
> > > those problems manually.
> > >
> > > Julia, could you give us some hint?
> >
> > Probably something like the following would be easiest.  You can just run
> > it after your other transformations:
> >
> > @r exists@
> > identifier f;
> > expression e;
> > @@
> >
> > f(...) { <+...  nand_to_mtd(e) ...+> }
> >
> > @@
> > identifier r.f;
> > expression r.e;
> > @@
> >
> > f(...) {
> > + struct mtd_info *mtd = nand_to_mtd(e);
> > ...
> > }
>
> Thanks for the the suggestion...
>
> >
> > This won't work if there is more than one possible value of e.  If that is
> > likely, then I could come up with something more complex.  It also assumes
> > that you want to convert all such calls.  If you only want to convert calls
> > that occur in a particular context, eg a field reference, then you could
> > enhance the pattern inside the <+... ...+> in the first rule.
>
> ... unfortunately, as you've guessed, it's a bit more complicated.
> This mtd local variable is usually extracted from another local
> variable (struct nand_chip *chip), so we have to declare
>
> struct mtd_info *mtd = nand_to_mtd(e);
>
> after
>
> struct nand_chip *chip = expression;
>
> But this is not the only particular case. Sometime the chip variable is
> not assigned where it's declared (especially when it is dynamically
> allocated), and sometime it does not exist at all (we just extract it
> from a private struct: &priv->chip).
> The mtd variable can also be declared in sub-code blocks (loop or
> conditional statements).
> And, as you stated, we might want to keep direct calls to nand_to_mtd()
> if it's only called once in a function context.
>
> I'm pretty sure we could describe all those cases with specific context
> description, but I must admit that it takes less time for me to fix
> those specific cases manually than figuring out how to describe them
> correctly in a coccinelle script :).
>
> This being said, I'd be happy to see how you would handle all these
> different cases.

Maybe the following would be useful.  It won't handle all the cases, but
maybe it will take care of a good number of the nontrivial ones.

julia

@r@
local idexpression x;
identifier fld,y;
@@

nand_to_mtd(&x->fld)->y

@exists@
type T;
local idexpression r.x;
identifier xx,r.y,r.fld;
@@

T xx;
+ struct mtd_info *mtd = nand_to_mtd(&x->fld);
...
nand_to_mtd(&x@xx->fld)->y

@@
local idexpression r.x;
identifier r.fld;
@@

struct mtd_info *mtd = nand_to_mtd(&x->fld);
<...
- nand_to_mtd(&x->fld)
+ mtd
...>

