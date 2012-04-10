From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC] dt: export of_have_populated_dt
Date: Tue, 10 Apr 2012 18:19:37 +0200
Message-ID: <4F845D99.7020705@ti.com>
References: <1334070672-11252-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50500 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab2DJQUI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 12:20:08 -0400
In-Reply-To: <1334070672-11252-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: robherring2@gmail.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, rnayak@ti.com, cjb@laptop.org, bigeasy@linutronix.de

Hi Balaji,

On 4/10/2012 5:11 PM, Balaji T K wrote:
> If of_have_populated_dt is called from module, build fails with "allnodes"
> undefined error, so remove inline and export of_have_populated_dt.

Is this function really called from the MMC driver?

Regards,
Benoit

>
> Signed-off-by: Balaji T K<balajitk@ti.com>
> ---
>   drivers/of/base.c  |    6 ++++++
>   include/linux/of.h |    6 +-----
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 5806449..dc1af42 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -186,6 +186,12 @@ struct property *of_find_property(const struct device_node *np,
>   }
>   EXPORT_SYMBOL(of_find_property);
>
> +bool of_have_populated_dt(void)
> +{
> +	return allnodes != NULL;
> +}
> +EXPORT_SYMBOL(of_have_populated_dt);
> +
>   /**
>    * of_find_all_nodes - Get next node in global list
>    * @prev:	Previous node or NULL to start iteration
> diff --git a/include/linux/of.h b/include/linux/of.h
> index fa7fb1d..28e933e 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -92,11 +92,6 @@ extern struct device_node *of_chosen;
>   extern struct device_node *of_aliases;
>   extern rwlock_t devtree_lock;
>
> -static inline bool of_have_populated_dt(void)
> -{
> -	return allnodes != NULL;
> -}
> -
>   static inline bool of_node_is_root(const struct device_node *node)
>   {
>   	return node&&  (node->parent == NULL);
> @@ -112,6 +107,7 @@ static inline void of_node_set_flag(struct device_node *n, unsigned long flag)
>   	set_bit(flag,&n->_flags);
>   }
>
> +extern bool of_have_populated_dt(void);
>   extern struct device_node *of_find_all_nodes(struct device_node *prev);
>
>   /*

