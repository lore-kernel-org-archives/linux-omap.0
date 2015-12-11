From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 01/58] mtd: nand: denali: add missing
 nand_release() call in denali_remove()
Date: Fri, 11 Dec 2015 23:03:05 +0100
Message-ID: <20151211230305.506e2071@bbrezillon>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
	<1449734442-18672-2-git-send-email-boris.brezillon@free-electrons.com>
	<20151211004008.GQ144338@google.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBIUQVWZQKGQEWKCRYWY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151211004008.GQ144338-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek
List-Id: linux-omap@vger.kernel.org

Hi Brian,

On Thu, 10 Dec 2015 16:40:08 -0800
Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, Dec 10, 2015 at 08:59:45AM +0100, Boris Brezillon wrote:
> > Unregister the NAND device from the NAND subsystem when removing a denali
> > NAND controller, otherwise the MTD attached to the NAND device is still
> > exposed by the MTD layer, and accesses to this device will likely crash
> > the system.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> #3.8+
> 
> Does this follow these rules, from
> Documentation/stable_kernel_rules.txt?
> 
>  - It must be obviously correct and tested.
> 
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing).

Sorry to bring the "stable or not stable (that is the question :-))"
debate back, but after thinking a bit more about the implications of
this missing nand_release() call, I think it is worth backporting the
fix to all stable kernels.
The reason is, it can potentially introduce a security hole, because if
the mtd device is not unregister but the underlying mtd object is freed
and the kernel reuses the same memory region for a different object,
the MTD layer will possibly call one of the mtd->_method() function,
and this field might point to another completely different function.

You'll say that denali devices are probably never removed and this is
the reason why people have never seen this problem before, which would
be a good reason to not bother backporting the patch.
But, given that the driver can be compiled as a module (the user can
possibly load/unload it, which will in turn create/destroy the
NAND/MTD device), and that the denali controller can be exposed through
a PCI bus (which, AFAIK is hotpluggable), I really think this fix
should be sent to stable.

Best Regards,

Boris

> 
> > Fixes: 2a0a288ec258 ("mtd: denali: split the generic driver and PCI layer")
> > ---
> >  drivers/mtd/nand/denali.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
> > index 67eb2be..8feece3 100644
> > --- a/drivers/mtd/nand/denali.c
> > +++ b/drivers/mtd/nand/denali.c
> > @@ -1622,6 +1622,7 @@ EXPORT_SYMBOL(denali_init);
> >  /* driver exit point */
> >  void denali_remove(struct denali_nand_info *denali)
> >  {
> > +	nand_release(&denali->mtd);
> >  	denali_irq_cleanup(denali->irq, denali);
> >  	dma_unmap_single(denali->dev, denali->buf.dma_buf,
> >  			 denali->mtd.writesize + denali->mtd.oobsize,
> 
> It feels a bit odd to allow usage of MTD fields after it has been
> unregistered. Maybe precompute this before the nand_release()?
> 
> Brian



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
