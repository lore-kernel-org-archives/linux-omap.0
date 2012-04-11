From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC] dt: export of_have_populated_dt
Date: Wed, 11 Apr 2012 09:48:30 +0530
Message-ID: <4F850616.1000608@ti.com>
References: <1334070672-11252-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58200 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750929Ab2DKESk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 00:18:40 -0400
Received: by pbcuo5 with SMTP id uo5so781819pbc.32
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 21:18:39 -0700 (PDT)
In-Reply-To: <1334070672-11252-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: robherring2@gmail.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, cjb@laptop.org, bigeasy@linutronix.de

On Tuesday 10 April 2012 08:41 PM, Balaji T K wrote:
> If of_have_populated_dt is called from module, build fails with "allnodes"
> undefined error, so remove inline and export of_have_populated_dt.

Thanks Balaji, for taking care of this while I was out.
But like Rob and Sebastian mentioned, looks like the usage of
of_have_populated_dt() itself is wrong in the first place.
So I will fix that up with a patch shortly.

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

