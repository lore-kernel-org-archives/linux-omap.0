From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 11/25] coccinelle: nand: detect and
 correct drivers embedding an mtd_info object
Date: Tue, 1 Dec 2015 13:27:45 +0100
Message-ID: <20151201132745.2bc1e294@bbrezillon>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
	<1448967802-25796-12-git-send-email-boris.brezillon@free-electrons.com>
	<alpine.DEB.2.10.1512011207580.2736@hadrien>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBRFE62ZAKGQEDUZI2LA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.10.1512011207580.2736@hadrien>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, 1 Dec 2015 12:17:44 +0100 (CET)
Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org> wrote:

> 
> 
> On Tue, 1 Dec 2015, Boris Brezillon wrote:
> 
> > Add nand-priv-no-mtd.cocci to detect and correct NAND controller drivers
> > directly embedding an mtd_info struct in their private struct.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Cc: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
> > ---
> > Hi Julia,
> >
> > Not sure this is the correct way to detect and fix offending drivers,
> > but I get some warnings when launching coccicheck in org or report mode:
> >
> > "warning: fix2: inherited metavariable __chipfield not used in the -, +,
> > or context code"
> >
> > Note that I don't get those warnings when running in patch mode.
> >
> > Any idea (feel free to propose a better solution to detect and fix those
> > offending drivers)?
> 
> Hi,
> 
> Is this code generated with sgen?  If so, could you send me the original
> semantic patch?

Nope, it's been hand written, which might explain the warnings :-/.
Didn't know about sgen, I thought those scripts were all hand written.

> 
> Another thing that is immediately apparent is that you have <... ...> on
> the outside of one of the rules.  This should never be needed.
> 
> The warning suggests that your org and report versions are not doing as
> much as the patch version.  If you have used sgen to generate the semantic
> patch then that would be strange.  If you have hand written the whole
> thing, then maybe you could simplify it to just do the patch version, and
> then I can check it and run sgen on it to make a complete version.

Sure, here it is:

--->8---
virtual patch

@fix1@
identifier __chipfield, __mtdfield;
type __type;
@@
(
	__type {
		...
		struct nand_chip __chipfield;
		...
-		struct mtd_info __mtdfield;
		...
	};
|
	__type {
		...
-		struct mtd_info __mtdfield;
		...
		struct nand_chip __chipfield;
		...
	};
)

@fix2 depends on fix1@
identifier fix1.__chipfield, fix1.__mtdfield;
identifier __subfield;
type fix1.__type;
__type *__priv;
@@
(
-	__priv->__mtdfield.__subfield
+	nand_to_mtd(&__priv->__chipfield)->__subfield
|
-	&(__priv->__mtdfield)
+	nand_to_mtd(&__priv->__chipfield)
)
--->8---

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
