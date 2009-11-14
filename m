From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes
 to support OMAP4 mailbox
Date: Fri, 13 Nov 2009 16:45:57 -0800
Message-ID: <20091114004557.GH3684@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C499A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52119 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491AbZKNApz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 19:45:55 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C499A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>

Hi,

Just noticed all the iffdef else stuff here, that should be easy to
remove.

* C.A, Subramaniam <subramaniam.ca@ti.com> [091113 04:33]:
> From 1a5865e67ce5fae94ae283882411cd01f48e07a7 Mon Sep 17 00:00:00 2001
> From: C A Subramaniam <subramaniam.ca@ti.com>
> Date: Fri, 13 Nov 2009 16:42:40 +0530
> Subject: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes to support OMAP4 mailbox.
> 
> This patch adds code changes in the mailbox driver module to
> add support for OMAP4 mailbox.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |  118 +++++++++++++++++++++++++++++++++++------
>  arch/arm/plat-omap/mailbox.c  |   25 +++++++--
>  2 files changed, 122 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 5ba3aa6..3b21a5d 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -18,17 +18,26 @@
>  #include <plat/mailbox.h>
>  #include <mach/irqs.h>
>  
> +#define DRV_NAME "omap2-mailbox"
> +
>  #define MAILBOX_REVISION		0x000
>  #define MAILBOX_SYSCONFIG		0x010
>  #define MAILBOX_SYSSTATUS		0x014
>  #define MAILBOX_MESSAGE(m)		(0x040 + 4 * (m))
>  #define MAILBOX_FIFOSTATUS(m)		(0x080 + 4 * (m))
>  #define MAILBOX_MSGSTATUS(m)		(0x0c0 + 4 * (m))
> +
> +#ifdef CONFIG_ARCH_OMAP4
> +#define MAILBOX_IRQSTATUS(u)		(0x104 + 10 * (u))
> +#define MAILBOX_IRQENABLE(u)		(0x108 + 10 * (u))
> +#define MAILBOX_IRQENABLE_CLR(u)	(0x10c + 10 * (u))
> +#else
>  #define MAILBOX_IRQSTATUS(u)		(0x100 + 8 * (u))
>  #define MAILBOX_IRQENABLE(u)		(0x104 + 8 * (u))
> +#endif

How about just have separate defines for OMAP4:

#define OMAP4_MAILBOX_IRQSTATUS(u)         (0x104 + 10 * (u))
#define OMAP4_MAILBOX_IRQENABLE(u)         (0x108 + 10 * (u))
#define OMAP4_MAILBOX_IRQENABLE_CLR(u)     (0x10c + 10 * (u))


> -#define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
> -#define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
> +#define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
> +#define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
>  
>  /* SYSCONFIG: register bit definition */
>  #define AUTOIDLE	(1 << 0)
> @@ -38,7 +47,12 @@
>  /* SYSSTATUS: register bit definition */
>  #define RESETDONE	(1 << 0)
>  
> +#ifdef CONFIG_ARCH_OMAP4
> +#define MBOX_REG_SIZE			0x130
> +#else
>  #define MBOX_REG_SIZE			0x120
> +#endif
> +

#define OMAP4_MBOX_REG_SIZE			0x130


>  #define MBOX_NR_REGS			(MBOX_REG_SIZE / sizeof(u32))
>  
>  static void __iomem *mbox_base;
> @@ -57,6 +71,9 @@ struct omap_mbox2_priv {
>  	u32 newmsg_bit;
>  	u32 notfull_bit;
>  	u32 ctx[MBOX_NR_REGS];
> +#ifdef CONFIG_ARCH_OMAP4
> +	unsigned long irqdisable;
> +#endif
>  };
>  
>  static struct clk *mbox_ick_handle;
> @@ -82,8 +99,9 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
>  
>  	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
>  	if (IS_ERR(mbox_ick_handle)) {
> -		pr_err("Can't get mailboxes_ick\n");
> -		return -ENODEV;
> +		printk(KERN_ERR "Could not get mailboxes_ick: %d\n",
> +			PTR_ERR(mbox_ick_handle));
> +		return PTR_ERR(mbox_ick_handle);
>  	}
>  	clk_enable(mbox_ick_handle);
>  
> @@ -115,6 +133,7 @@ static void omap2_mbox_shutdown(struct omap_mbox *mbox)
>  {
>  	clk_disable(mbox_ick_handle);
>  	clk_put(mbox_ick_handle);
> +	mbox_ick_handle = NULL;
>  }
>  
>  /* Mailbox FIFO handle functions */
> @@ -143,7 +162,7 @@ static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
>  {
>  	struct omap_mbox2_fifo *fifo =
>  		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
> -	return (mbox_read_reg(fifo->fifo_stat));
> +	return mbox_read_reg(fifo->fifo_stat);
>  }
>  
>  /* Mailbox IRQ handle functions */
> @@ -163,10 +182,9 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
>  {
>  	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
>  	u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
> -
> -	l = mbox_read_reg(p->irqenable);
> +	l = mbox_read_reg(p->irqdisable);
>  	l &= ~bit;
> -	mbox_write_reg(l, p->irqenable);
> +	mbox_write_reg(l, p->irqdisable);
>  }
>  
>  static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
> @@ -189,7 +207,7 @@ static int omap2_mbox_is_irq(struct omap_mbox *mbox,
>  	u32 enable = mbox_read_reg(p->irqenable);
>  	u32 status = mbox_read_reg(p->irqstatus);
>  
> -	return (enable & status & bit);
> +	return (int)(enable & status & bit);
>  }
>  
>  static void omap2_mbox_save_ctx(struct omap_mbox *mbox)
> @@ -242,9 +260,12 @@ static struct omap_mbox_ops omap2_mbox_ops = {
>   */
>  
>  /* FIXME: the following structs should be filled automatically by the user id */
> -
> +#ifdef CONFIG_ARCH_OMAP4
> +static struct omap_mbox2_priv omap2_mbox_1_priv = {
> +#else
>  /* DSP */
>  static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
> +#endif
>  	.tx_fifo = {
>  		.msg		= MAILBOX_MESSAGE(0),
>  		.fifo_stat	= MAILBOX_FIFOSTATUS(0),

Just create a separate struct for omap4, the ifdef else here
is not nice. Then select the struct to use during init.


> @@ -257,7 +278,19 @@ static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
>  	.irqstatus	= MAILBOX_IRQSTATUS(0),
>  	.notfull_bit	= MAILBOX_IRQ_NOTFULL(0),
>  	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(1),
> +#ifdef CONFIG_ARCH_OMAP4
> +	.irqdisable	= MAILBOX_IRQENABLE_CLR(0),
> +#endif
> +};
> +
> +#ifdef CONFIG_ARCH_OMAP4
> +struct omap_mbox mbox_1_info = {
> +	.name	= "mailbox-1",
> +	.ops	= &omap2_mbox_ops,
> +	.priv	= &omap2_mbox_1_priv,
>  };
> +EXPORT_SYMBOL(mbox_1_info);
> +#else
>  
>  struct omap_mbox mbox_dsp_info = {
>  	.name	= "dsp",

Here too.


> @@ -265,6 +298,33 @@ struct omap_mbox mbox_dsp_info = {
>  	.priv	= &omap2_mbox_dsp_priv,
>  };
>  EXPORT_SYMBOL(mbox_dsp_info);
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP4
> +static struct omap_mbox2_priv omap2_mbox_2_priv = {
> +	.tx_fifo = {
> +		.msg		= MAILBOX_MESSAGE(3),
> +		.fifo_stat	= MAILBOX_FIFOSTATUS(3),
> +	},
> +	.rx_fifo = {
> +		.msg		= MAILBOX_MESSAGE(2),
> +		.msg_stat	= MAILBOX_MSGSTATUS(2),
> +	},
> +	.irqenable	= MAILBOX_IRQENABLE(0),
> +	.irqstatus	= MAILBOX_IRQSTATUS(0),
> +	.notfull_bit	= MAILBOX_IRQ_NOTFULL(3),
> +	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(2),
> +	.irqdisable     = MAILBOX_IRQENABLE_CLR(0),
> +};
> +
> +struct omap_mbox mbox_2_info = {
> +	.name	= "mailbox-2",
> +	.ops	= &omap2_mbox_ops,
> +	.priv	= &omap2_mbox_2_priv,
> +};
> +EXPORT_SYMBOL(mbox_2_info);
> +#endif
> +
>  
>  #if defined(CONFIG_ARCH_OMAP2420) /* IVA */
>  static struct omap_mbox2_priv omap2_mbox_iva_priv = {
> @@ -305,17 +365,31 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* DSP or IVA2 IRQ */
> -	ret = platform_get_irq(pdev, 0);
> -	if (ret < 0) {
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +
> +	if (unlikely(!res)) {
>  		dev_err(&pdev->dev, "invalid irq resource\n");
> +		ret = -ENODEV;
>  		goto err_dsp;
>  	}
> -	mbox_dsp_info.irq = ret;
> -
> +#ifdef CONFIG_ARCH_OMAP4
> +	mbox_1_info.irq = res->start;
> +	ret = omap_mbox_register(&pdev->dev, &mbox_1_info);
> +#else
> +	mbox_dsp_info.irq = res->start;
>  	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
> +#endif
>  	if (ret)
>  		goto err_dsp;
>  

You can select what to register with cpu_is_omapXXXX() here.


> +#ifdef CONFIG_ARCH_OMAP4
> +
> +	mbox_2_info.irq = res->start;
> +	ret = omap_mbox_register(&pdev->dev, &mbox_2_info);
> +	if (ret)
> +		goto err_mbox_2;
> +#endif
> +
>  #if defined(CONFIG_ARCH_OMAP2420) /* IVA */
>  	if (cpu_is_omap2420()) {
>  		/* IVA IRQ */
> @@ -333,8 +407,14 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  #endif
>  	return 0;
>  
> +#ifdef CONFIG_ARCH_OMAP4
> +err_mbox_2:
> +	omap_mbox_unregister(&mbox_1_info);
> +#else
>  err_iva1:
>  	omap_mbox_unregister(&mbox_dsp_info);
> +#endif
> +
>  err_dsp:
>  	iounmap(mbox_base);
>  	return ret;

Here too.


> @@ -345,7 +425,13 @@ static int __devexit omap2_mbox_remove(struct platform_device *pdev)
>  #if defined(CONFIG_ARCH_OMAP2420)
>  	omap_mbox_unregister(&mbox_iva_info);
>  #endif
> +
> +#ifdef CONFIG_ARCH_OMAP4
> +	omap_mbox_unregister(&mbox_2_info);
> +	omap_mbox_unregister(&mbox_1_info);
> +#else
>  	omap_mbox_unregister(&mbox_dsp_info);
> +#endif
>  	iounmap(mbox_base);
>  	return 0;
>  }

And here.


> @@ -354,7 +440,7 @@ static struct platform_driver omap2_mbox_driver = {
>  	.probe = omap2_mbox_probe,
>  	.remove = __devexit_p(omap2_mbox_remove),
>  	.driver = {
> -		.name = "omap2-mailbox",
> +		.name = DRV_NAME,
>  	},
>  };
>  
> @@ -374,4 +460,4 @@ module_exit(omap2_mbox_exit);
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("omap mailbox: omap2/3 architecture specific functions");
>  MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Paul Mundt");
> -MODULE_ALIAS("platform:omap2-mailbox");
> +MODULE_ALIAS("platform:"DRV_NAME);
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index d5377a3..4d7947e 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -31,6 +31,8 @@
>  static struct omap_mbox *mboxes;
>  static DEFINE_RWLOCK(mboxes_lock);
>  
> +static int mbox_configured;
> +
>  /* Mailbox FIFO handle functions */
>  static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
>  {
> @@ -266,13 +268,20 @@ static void mbox_queue_free(struct omap_mbox_queue *q)
>  
>  static int omap_mbox_startup(struct omap_mbox *mbox)
>  {
> -	int ret;
> +	int ret = 0;
>  	struct omap_mbox_queue *mq;
>  
>  	if (likely(mbox->ops->startup)) {
> -		ret = mbox->ops->startup(mbox);
> -		if (unlikely(ret))
> +		write_lock(&mboxes_lock);
> +		if (!mbox_configured)
> +			ret = mbox->ops->startup(mbox);
> +
> +		if (unlikely(ret)) {
> +			write_unlock(&mboxes_lock);
>  			return ret;
> +		}
> +		mbox_configured++;
> +		write_unlock(&mboxes_lock);
>  	}
>  
>  	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
> @@ -317,8 +326,14 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
>  
>  	free_irq(mbox->irq, mbox);
>  
> -	if (unlikely(mbox->ops->shutdown))
> -		mbox->ops->shutdown(mbox);
> +	if (unlikely(mbox->ops->shutdown)) {
> +		write_lock(&mboxes_lock);
> +		if (mbox_configured > 0)
> +			mbox_configured--;
> +		if (!mbox_configured)
> +			mbox->ops->shutdown(mbox);
> +		write_unlock(&mboxes_lock);
> +	}
>  }
>  
>  static struct omap_mbox **find_mboxes(const char *name)
> -- 
> 1.5.3.2
