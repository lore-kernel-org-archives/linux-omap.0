From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2 11/25] coccinelle: nand: detect and correct drivers
 embedding an mtd_info object
Date: Tue, 1 Dec 2015 12:17:44 +0100 (CET)
Message-ID: <alpine.DEB.2.10.1512011207580.2736@hadrien>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com> <1448967802-25796-12-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1448967802-25796-12-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ro
List-Id: linux-omap@vger.kernel.org



On Tue, 1 Dec 2015, Boris Brezillon wrote:

> Add nand-priv-no-mtd.cocci to detect and correct NAND controller drivers
> directly embedding an mtd_info struct in their private struct.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> ---
> Hi Julia,
>
> Not sure this is the correct way to detect and fix offending drivers,
> but I get some warnings when launching coccicheck in org or report mode:
>
> "warning: fix2: inherited metavariable __chipfield not used in the -, +,
> or context code"
>
> Note that I don't get those warnings when running in patch mode.
>
> Any idea (feel free to propose a better solution to detect and fix those
> offending drivers)?

Hi,

Is this code generated with sgen?  If so, could you send me the original
semantic patch?

Another thing that is immediately apparent is that you have <... ...> on
the outside of one of the rules.  This should never be needed.

The warning suggests that your org and report versions are not doing as
much as the patch version.  If you have used sgen to generate the semantic
patch then that would be strange.  If you have hand written the whole
thing, then maybe you could simplify it to just do the patch version, and
then I can check it and run sgen on it to make a complete version.

julia

>
> Best Regards,
>
> Boris
> ---
>  scripts/coccinelle/api/nand-priv-no-mtd.cocci | 91 +++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 scripts/coccinelle/api/nand-priv-no-mtd.cocci
>
> diff --git a/scripts/coccinelle/api/nand-priv-no-mtd.cocci b/scripts/coccinelle/api/nand-priv-no-mtd.cocci
> new file mode 100644
> index 0000000..b2c0c22
> --- /dev/null
> +++ b/scripts/coccinelle/api/nand-priv-no-mtd.cocci
> @@ -0,0 +1,91 @@
> +/// Fix NAND controller drivers declaring their own mtd_info struct instead
> +/// of the one provided in struct nand_chip.
> +///
> +// Confidence: Low
> +// Copyright: (C) 2015 Boris Brezillon GPL v2.
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@match1@
> +identifier __chipfield, __mtdfield;
> +type __type;
> +@@
> +(
> +	__type {
> +		...
> +		struct nand_chip __chipfield;
> +		...
> +		struct mtd_info __mtdfield;
> +		...
> +	};
> +|
> +	__type {
> +		...
> +		struct mtd_info __mtdfield;
> +		...
> +		struct nand_chip __chipfield;
> +		...
> +	};
> +)
> +
> +@fix1 depends on match1 && patch && !context && !org && !report@
> +identifier match1.__mtdfield;
> +type match1.__type;
> +@@
> +	__type {
> +		...
> +-		struct mtd_info __mtdfield;
> +		...
> +	};
> +
> +@fix2 depends on match1 && patch && !context && !org && !report@
> +identifier match1.__chipfield, match1.__mtdfield;
> +identifier __subfield;
> +type match1.__type;
> +__type *__priv;
> +@@
> +<...
> +(
> +-	__priv->__mtdfield.__subfield
> ++	nand_to_mtd(&__priv->__chipfield)->__subfield
> +|
> +-	&(__priv->__mtdfield)
> ++	nand_to_mtd(&__priv->__chipfield)
> +)
> +...>
> +
> +// ----------------------------------------------------------------------------
> +
> +@fix1_context depends on match1 && !patch && (context || org || report)@
> +identifier match1.__mtdfield;
> +type match1.__type;
> +position j0;
> +@@
> +
> +	__type {
> +		...
> +*		struct mtd_info __mtdfield@j0;
> +		...
> +	};
> +
> +// ----------------------------------------------------------------------------
> +
> +@script:python fix1_org depends on org@
> +j0 << fix1_context.j0;
> +@@
> +
> +msg = "struct nand_chip already embeds an mtd_info object (use nand_to_mtd())."
> +coccilib.org.print_todo(j0[0], msg)
> +
> +// ----------------------------------------------------------------------------
> +
> +@script:python fix1_report depends on report@
> +j0 << fix1_context.j0;
> +@@
> +
> +msg = "struct nand_chip already embeds an mtd_info object (use nand_to_mtd())."
> +coccilib.report.print_report(j0[0], msg)
> +
> --
> 2.1.4
>
>
