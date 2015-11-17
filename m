From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 14/27] mtd: nand: use the mtd instance embedded in struct
 nand_chip
Date: Tue, 17 Nov 2015 10:05:03 +0100 (CET)
Message-ID: <alpine.DEB.2.10.1511170957100.2455@hadrien>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447681080-31232-15-git-send-email-boris.brezillon@free-electrons.com>
 <20151117030019.GY8456@google.com> <20151117093836.052c86b5@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20151117093836.052c86b5@bbrezillon>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Stefan Agner <stefan@agner.ch>, linux-sunxi@googlegroups.com, linux-mtd@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, devel@driverdev.osuosl.org, Jesper Nilsson <jesper.nilsson@axis.com>, linux-samsung-soc@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Marek Vasut <marek.vasut@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Josh Wu <josh.wu@atmel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Wan ZongShun <mcuos.com@gmail.com>, Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, Ha
List-Id: linux-omap@vger.kernel.org

> > (This isn't the worst one, but it just happens to be one of the first.)
> > There are many cases where the typical style would be to declare a new
> > variable at the top of the function, where you perform the
> > macro/function-call to convert from one abstraction to another. Like
> >
> > static int nfc_set_sram_bank(struct atmel_nand_host *host, unsigned int bank)
> > {
> > 	struct mtd_info *mtd = nand_to_mtd(&hot->nand_chip);
> > 	...
> >
> > and then use it later. Can that be done very easily?
> >
> > >  			return -EINVAL;
> > >  		nfc_writel(host->nfc->hsmc_regs, BANK, ATMEL_HSMC_NFC_BANK1);
> > >  	} else {
> >
> > ...
>
> Honestly, I don't know how to do that with a coccinelle script, and it
> will probably take me more time to find how to do it than addressing
> those problems manually.
>
> Julia, could you give us some hint?

Probably something like the following would be easiest.  You can just run
it after your other transformations:

@r exists@
identifier f;
expression e;
@@

f(...) { <+...  nand_to_mtd(e) ...+> }

@@
identifier r.f;
expression r.e;
@@

f(...) {
+ struct mtd_info *mtd = nand_to_mtd(e);
...
}

This won't work if there is more than one possible value of e.  If that is
likely, then I could come up with something more complex.  It also assumes
that you want to convert all such calls.  If you only want to convert calls
that occur in a particular context, eg a field reference, then you could
enhance the pattern inside the <+... ...+> in the first rule.

julia
