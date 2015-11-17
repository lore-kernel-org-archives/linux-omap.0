From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 14/27] mtd: nand: use the mtd instance
 embedded in struct nand_chip
Date: Tue, 17 Nov 2015 15:22:16 +0100
Message-ID: <20151117152216.539fc09b@bbrezillon>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
	<1447681080-31232-15-git-send-email-boris.brezillon@free-electrons.com>
	<20151117030019.GY8456@google.com>
	<20151117093836.052c86b5@bbrezillon>
	<alpine.DEB.2.10.1511170957100.2455@hadrien>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBHXQVSZAKGQEF7XCHNY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.10.1511170957100.2455@hadrien>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert
List-Id: linux-omap@vger.kernel.org

Hi Julia,

On Tue, 17 Nov 2015 10:05:03 +0100 (CET)
Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org> wrote:

> > > (This isn't the worst one, but it just happens to be one of the first.)
> > > There are many cases where the typical style would be to declare a new
> > > variable at the top of the function, where you perform the
> > > macro/function-call to convert from one abstraction to another. Like
> > >
> > > static int nfc_set_sram_bank(struct atmel_nand_host *host, unsigned int bank)
> > > {
> > > 	struct mtd_info *mtd = nand_to_mtd(&hot->nand_chip);
> > > 	...
> > >
> > > and then use it later. Can that be done very easily?
> > >
> > > >  			return -EINVAL;
> > > >  		nfc_writel(host->nfc->hsmc_regs, BANK, ATMEL_HSMC_NFC_BANK1);
> > > >  	} else {
> > >
> > > ...
> >
> > Honestly, I don't know how to do that with a coccinelle script, and it
> > will probably take me more time to find how to do it than addressing
> > those problems manually.
> >
> > Julia, could you give us some hint?
> 
> Probably something like the following would be easiest.  You can just run
> it after your other transformations:
> 
> @r exists@
> identifier f;
> expression e;
> @@
> 
> f(...) { <+...  nand_to_mtd(e) ...+> }
> 
> @@
> identifier r.f;
> expression r.e;
> @@
> 
> f(...) {
> + struct mtd_info *mtd = nand_to_mtd(e);
> ...
> }

Thanks for the the suggestion...

> 
> This won't work if there is more than one possible value of e.  If that is
> likely, then I could come up with something more complex.  It also assumes
> that you want to convert all such calls.  If you only want to convert calls
> that occur in a particular context, eg a field reference, then you could
> enhance the pattern inside the <+... ...+> in the first rule.

... unfortunately, as you've guessed, it's a bit more complicated.
This mtd local variable is usually extracted from another local
variable (struct nand_chip *chip), so we have to declare

struct mtd_info *mtd = nand_to_mtd(e);

after

struct nand_chip *chip = expression;

But this is not the only particular case. Sometime the chip variable is
not assigned where it's declared (especially when it is dynamically
allocated), and sometime it does not exist at all (we just extract it
from a private struct: &priv->chip).
The mtd variable can also be declared in sub-code blocks (loop or
conditional statements).
And, as you stated, we might want to keep direct calls to nand_to_mtd()
if it's only called once in a function context.

I'm pretty sure we could describe all those cases with specific context
description, but I must admit that it takes less time for me to fix
those specific cases manually than figuring out how to describe them
correctly in a coccinelle script :).

This being said, I'd be happy to see how you would handle all these
different cases.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
