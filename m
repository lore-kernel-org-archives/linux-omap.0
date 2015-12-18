From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 55/58] mtd: nand: add helpers to access ->priv
Date: Fri, 18 Dec 2015 14:17:58 -0800
Message-ID: <20151218221758.GQ10460@google.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449734442-18672-56-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZ6PSPVXMNBBGUM2KZQKGQEWCIQYQI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449734442-18672-56-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek
List-Id: linux-omap@vger.kernel.org

Hi Boris,

On Thu, Dec 10, 2015 at 09:00:39AM +0100, Boris Brezillon wrote:
> Add two helpers to access the field reserved for private controller data.
> This makes it clearer what this field is reserved for and ease future
> refactoring.

I agree with the refactoring part, but I'm not sure about the name. Is
it really "controller" data? That sounds like something that has 1
instance per controller. But the way this is sometimes used, we get 1
instance per NAND chip, and there may be more than one NAND chip per
controller.

So at the moment, this is more like opaque "driver data", like
dev_{get,set}_drvdata(), which doesn't really have a prescribed use --
it's up to the driver.

Notably, we already have a (sort of) 1-per-controler-instance field:
struct nand_hw_control (I notice we have both the 'controller' and
'hwcontrol' fields in nand_chip; that's pretty ugly too...). Those don't
have private data fields, but we could of course extend that if we
really want "controller" data.

Anyway, I don't feel like this question is resolved well enough to say
that we should go change all drivers to use these accessors. I know you
have bigger plans for putting more "controller" infrastructure into the
core drivers/mtd/nand/ code, so I'd like to see how that fits in here.

(If we're going to discuss this much more, I'd suggest a smaller CC
list. I'm mostly putting this here to show why I'm not taking the last
4 patches right now.)

Regards,
Brian

> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  include/linux/mtd/nand.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 2bee2e4..4aed4b2 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -739,6 +739,16 @@ static inline struct mtd_info *nand_to_mtd(struct nand_chip *chip)
>  	return &chip->mtd;
>  }
>  
> +static inline void *nand_get_controller_data(struct nand_chip *chip)
> +{
> +	return chip->priv;
> +}
> +
> +static inline void nand_set_controller_data(struct nand_chip *chip, void *priv)
> +{
> +	chip->priv = priv;
> +}
> +
>  /*
>   * NAND Flash Manufacturer ID Codes
>   */
> -- 
> 2.1.4
> 
