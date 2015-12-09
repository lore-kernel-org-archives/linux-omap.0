From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 bis 12/25] mtd: nand: use the mtd
 instance embedded in struct nand_chip
Date: Wed, 9 Dec 2015 09:32:10 +0100
Message-ID: <20151209093210.007a63b3@bbrezillon>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
	<1449046201-22921-1-git-send-email-boris.brezillon@free-electrons.com>
	<20151209001741.GT120110@google.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBC6PT6ZQKGQEEVA5F3Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151209001741.GT120110-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
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

On Tue, 8 Dec 2015 16:17:41 -0800
Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> 
> > diff --git a/drivers/mtd/nand/cmx270_nand.c b/drivers/mtd/nand/cmx270_nand.c
> > index 43bded6..84d027e 100644
> > --- a/drivers/mtd/nand/cmx270_nand.c
> > +++ b/drivers/mtd/nand/cmx270_nand.c
> > @@ -160,10 +160,8 @@ static int __init cmx270_init(void)
> >  	gpio_direction_input(GPIO_NAND_RB);
> >  
> >  	/* Allocate memory for MTD device structure and private data */
> > -	cmx270_nand_mtd = kzalloc(sizeof(struct mtd_info) +
> > -				  sizeof(struct nand_chip),
> > -				  GFP_KERNEL);
> > -	if (!cmx270_nand_mtd) {
> > +	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
> > +	if (!this) {
> >  		ret = -ENOMEM;
> >  		goto err_kzalloc;
> >  	}
> > @@ -175,8 +173,7 @@ static int __init cmx270_init(void)
> >  		goto err_ioremap;
> >  	}
> >  
> > -	/* Get pointer to private data */
> > -	this = (struct nand_chip *)(&cmx270_nand_mtd[1]);
> > +	cmx270_nand_mtd = nand_to_mtd(this);
> 
> So, you make cmx270_nand_mtd no longer kzalloc()'d, but I still see the
> cmx270_init() function end with:
> 
> err_scan:
>         iounmap(cmx270_nand_io);
> err_ioremap:
>         kfree(cmx270_nand_mtd);  <----- *** this! ***

Oh, crap.

> err_kzalloc:
>         gpio_free(GPIO_NAND_RB);
> err_gpio_request:
> 	gpio_free(GPIO_NAND_CS);
> 
> 	return ret;
> 
> }
> 
> I have a feeling there's a failing in your coccinelle script somewhere.

These changes are not automated, because it's kind of hard to address
all the different cases where the following pattern is employed;

var = kzalloc(sizeof(struct mtd_info) +
	      sizeof(struct nand_chip) + ..., ...);

Sometime var is an mtd_info pointer, sometime it's a nand_chip pointer
or directly a pointer to the private struct.

I'm pretty sure we could come up with a valid coccinelle script, but
given the number of drivers using this approach I'm not sure it is
worth it...

> 
> Given that I was only through 10 of 49 files changes, I think you might
> need to take a comb over your patch better.

I'll go over those changes one more time, but from my experience, these
kind of bugs are spotted more easily by people who didn't write the
code, so other reviews are more than welcome.

Also, as you suggested, I'll split the changes in several commits (one
per driver) so that you can pick them independently.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
