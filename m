From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 13/14] omap: mailbox: simplify omap_mbox_register()
Date: Mon, 24 May 2010 17:42:33 +0300 (EEST)
Message-ID: <20100524.174233.26958915.Hiroshi.DOYU@nokia.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-14-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43537 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab0EXOm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 10:42:56 -0400
In-Reply-To: <1274548465-20208-14-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 13/14] omap: mailbox: simplify omap_mbox_register()
Date: Sat, 22 May 2010 19:14:24 +0200

> No need to dynamically register mailboxes one by one.

Can you squash this into [PATCH 10/14]?

I think that the "struct omap_mbox **list" would make more sense
without those reworking of modifications in this patch.

> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-omap1/mailbox.c             |   25 ++------
>  arch/arm/mach-omap2/mailbox.c             |   22 ++-----
>  arch/arm/plat-omap/include/plat/mailbox.h |    5 +-
>  arch/arm/plat-omap/mailbox.c              |   95 +++++++++++------------------
>  4 files changed, 50 insertions(+), 97 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
> index 4210896..e50b3c2 100644
> --- a/arch/arm/mach-omap1/mailbox.c
> +++ b/arch/arm/mach-omap1/mailbox.c
> @@ -29,8 +29,6 @@
>  
>  static void __iomem *mbox_base;
>  
> -static struct omap_mbox **list;
> -
>  struct omap_mbox1_fifo {
>  	unsigned long cmd;
>  	unsigned long data;
> @@ -151,38 +149,29 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int ret;
>  	int i;
> +	struct omap_mbox **list;
>  
>  	res = pdev->resource;
>  
>  	list = omap1_mboxes;
> -
>  	list[0]->irq = platform_get_irq_byname(pdev, "dsp");
>  
>  	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
>  	if (!mbox_base)
>  		return -ENOMEM;
>  
> -	for (i = 0; list[i]; i++) {
> -		ret = omap_mbox_register(&pdev->dev, list[i]);
> -		if (ret)
> -			goto err_out;
> +	ret = omap_mbox_register(&pdev->dev, list);
> +	if (ret) {
> +		iounmap(mbox_base);
> +		return ret;
>  	}
> -	return 0;
>  
> -err_out:
> -	while (i--)
> -		omap_mbox_unregister(list[i]);
> -	iounmap(mbox_base);
> -	return ret;
> +	return 0;
>  }
>  
>  static int __devexit omap1_mbox_remove(struct platform_device *pdev)
>  {
> -	int i;
> -
> -	for (i = 0; list[i]; i++)
> -		omap_mbox_unregister(list[i]);
> -
> +	omap_mbox_unregister();
>  	iounmap(mbox_base);
>  	return 0;
>  }
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index a433ca7..66d366d 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -54,8 +54,6 @@
>  
>  static void __iomem *mbox_base;
>  
> -static struct omap_mbox **list;
> -
>  struct omap_mbox2_fifo {
>  	unsigned long msg;
>  	unsigned long fifo_stat;
> @@ -393,7 +391,7 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
>  	int ret;
> -	int i;
> +	struct omap_mbox **list;
>  
>  	res = pdev->resource;
>  
> @@ -430,27 +428,19 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  	if (!mbox_base)
>  		return -ENOMEM;
>  
> -	for (i = 0; list[i]; i++) {
> -		ret = omap_mbox_register(&pdev->dev, list[i]);
> -		if (ret)
> -			goto err_out;
> +	ret = omap_mbox_register(&pdev->dev, list);
> +	if (ret) {
> +		iounmap(mbox_base);
> +		return ret;
>  	}
>  	return 0;
>  
> -err_out:
> -	while (i--)
> -		omap_mbox_unregister(list[i]);
> -	iounmap(mbox_base);
>  	return ret;
>  }
>  
>  static int __devexit omap2_mbox_remove(struct platform_device *pdev)
>  {
> -	int i;
> -
> -	for (i = 0; list[i]; i++)
> -		omap_mbox_unregister(list[i]);
> -
> +	omap_mbox_unregister();
>  	iounmap(mbox_base);
>  	return 0;
>  }
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
> index aad8bf8..c44fde3 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -55,7 +55,6 @@ struct omap_mbox {
>  	struct omap_mbox_queue	*txq, *rxq;
>  	struct omap_mbox_ops	*ops;
>  	struct device		*dev;
> -	struct omap_mbox	*next;
>  	void			*priv;
>  };
>  
> @@ -65,8 +64,8 @@ void omap_mbox_init_seq(struct omap_mbox *);
>  struct omap_mbox *omap_mbox_get(const char *);
>  void omap_mbox_put(struct omap_mbox *);
>  
> -int omap_mbox_register(struct device *parent, struct omap_mbox *);
> -int omap_mbox_unregister(struct omap_mbox *);
> +int omap_mbox_register(struct device *parent, struct omap_mbox **);
> +int omap_mbox_unregister(void);
>  
>  static inline void omap_mbox_save_ctx(struct omap_mbox *mbox)
>  {
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index 38a6cb1..a8e22e1 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -33,8 +33,7 @@
>  #include <plat/mailbox.h>
>  
>  static struct workqueue_struct *mboxd;
> -static struct omap_mbox *mboxes;
> -static DEFINE_SPINLOCK(mboxes_lock);
> +static struct omap_mbox **mboxes;
>  static bool rq_full;
>  
>  static int mbox_configured;
> @@ -307,31 +306,20 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
>  	}
>  }
>  
> -static struct omap_mbox **find_mboxes(const char *name)
> -{
> -	struct omap_mbox **p;
> -
> -	for (p = &mboxes; *p; p = &(*p)->next) {
> -		if (strcmp((*p)->name, name) == 0)
> -			break;
> -	}
> -
> -	return p;
> -}
> -
>  struct omap_mbox *omap_mbox_get(const char *name)
>  {
>  	struct omap_mbox *mbox;
>  	int ret;
>  
> -	spin_lock(&mboxes_lock);
> -	mbox = *(find_mboxes(name));
> -	if (mbox == NULL) {
> -		spin_unlock(&mboxes_lock);
> -		return ERR_PTR(-ENOENT);
> -	}
> +	if (!mboxes)
> +		return ERR_PTR(-EINVAL);
>  
> -	spin_unlock(&mboxes_lock);
> +	for (mbox = *mboxes; mbox; mbox++)
> +		if (!strcmp(mbox->name, name))
> +			break;
> +
> +	if (!mbox)
> +		return ERR_PTR(-ENOENT);
>  
>  	ret = omap_mbox_startup(mbox);
>  	if (ret)
> @@ -349,57 +337,44 @@ EXPORT_SYMBOL(omap_mbox_put);
>  
>  static struct class omap_mbox_class = { .name = "mbox", };
>  
> -int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
> +int omap_mbox_register(struct device *parent, struct omap_mbox **list)
>  {
> -	int ret = 0;
> -	struct omap_mbox **tmp;
> +	int ret;
> +	int i;
>  
> -	if (!mbox)
> +	mboxes = list;
> +	if (!mboxes)
>  		return -EINVAL;
> -	if (mbox->next)
> -		return -EBUSY;
> -
> -	mbox->dev = device_create(&omap_mbox_class,
> -				  parent, 0, mbox, "%s", mbox->name);
> -	if (IS_ERR(mbox->dev))
> -		return PTR_ERR(mbox->dev);
> -
> -	spin_lock(&mboxes_lock);
> -	tmp = find_mboxes(mbox->name);
> -	if (*tmp) {
> -		ret = -EBUSY;
> -		spin_unlock(&mboxes_lock);
> -		goto err_find;
> -	}
> -	*tmp = mbox;
> -	spin_unlock(&mboxes_lock);
>  
> +	for (i = 0; mboxes[i]; i++) {
> +		struct omap_mbox *mbox = mboxes[i];
> +		mbox->dev = device_create(&omap_mbox_class,
> +				parent, 0, mbox, "%s", mbox->name);
> +		if (IS_ERR(mbox->dev)) {
> +			ret = PTR_ERR(mbox->dev);
> +			goto err_out;
> +		}
> +	}
>  	return 0;
>  
> -err_find:
> +err_out:
> +	while (i--)
> +		device_unregister(mboxes[i]->dev);
>  	return ret;
>  }
>  EXPORT_SYMBOL(omap_mbox_register);
>  
> -int omap_mbox_unregister(struct omap_mbox *mbox)
> +int omap_mbox_unregister(void)
>  {
> -	struct omap_mbox **tmp;
> -
> -	spin_lock(&mboxes_lock);
> -	tmp = &mboxes;
> -	while (*tmp) {
> -		if (mbox == *tmp) {
> -			*tmp = mbox->next;
> -			mbox->next = NULL;
> -			spin_unlock(&mboxes_lock);
> -			device_unregister(mbox->dev);
> -			return 0;
> -		}
> -		tmp = &(*tmp)->next;
> -	}
> -	spin_unlock(&mboxes_lock);
> +	int i;
>  
> -	return -EINVAL;
> +	if (!mboxes)
> +		return -EINVAL;
> +
> +	for (i = 0; mboxes[i]; i++)
> +		device_unregister(mboxes[i]->dev);
> +	mboxes = NULL;
> +	return 0;
>  }
>  EXPORT_SYMBOL(omap_mbox_unregister);
>  
> -- 
> 1.7.1
> 
