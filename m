From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes
 to support OMAP4 mailbox.
Date: Mon, 07 Sep 2009 11:25:55 +0300 (EEST)
Message-ID: <20090907.112555.235705393.Hiroshi.DOYU@nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108F2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57604 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbZIGI0Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 04:26:25 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108F2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: subramaniam.ca@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rmk@arm.linux.org.uk, h-kanigeri2@ti.com, grgupta@ti.com

Hi Subbu,

From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes to support OMAP4 mailbox.
Date: Fri, 4 Sep 2009 13:48:11 +0200

> From eeaa22aff9df8027f91884ee78328028bd5a6782 Mon Sep 17 00:00:00 2001
> From: C A Subramaniam <subramaniam.ca@ti.com>
> Date: Thu, 3 Sep 2009 17:53:27 +0530
> Subject: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes to support OMAP4 mailbox.
> 
> This patch adds code changes in the mailbox driver module to
> add support for OMAP4 mailbox.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |  156 +++++++++++++++++++++++++++++++++--------
>  1 files changed, 125 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 6f71f37..4ab3e1d 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -18,21 +18,36 @@
>  #include <mach/mailbox.h>
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
>  
> -#define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
> -#define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
> +#define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
> +#define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
>  
> +#ifdef CONFIG_ARCH_OMAP4
> +#define MBOX_REG_SIZE			0x130
> +#else
>  #define MBOX_REG_SIZE			0x120
> +#endif
> +
>  #define MBOX_NR_REGS			(MBOX_REG_SIZE / sizeof(u32))
>  
> +
>  static void __iomem *mbox_base;
>  
>  struct omap_mbox2_fifo {
> @@ -49,9 +64,13 @@ struct omap_mbox2_priv {
>  	u32 newmsg_bit;
>  	u32 notfull_bit;
>  	u32 ctx[MBOX_NR_REGS];
> +#ifdef CONFIG_ARCH_OMAP4
> +	unsigned long irqdisable;
> +#endif
>  };
>  
>  static struct clk *mbox_ick_handle;
> +static int mbox_configured;
>  
>  static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
>  				  omap_mbox_type_t irq);
> @@ -70,31 +89,37 @@ static inline void mbox_write_reg(u32 val, size_t ofs)
>  static int omap2_mbox_startup(struct omap_mbox *mbox)
>  {
>  	unsigned int l;
> +	if (!mbox_configured) {

I think that this kind of checking can be done in "omap_mbox_get()" in
"plat-omap/mailbox.c" and it would be more logical since
"mach-omap2/mailbox.c" is supposed to provide quite bacic feature
simply which omap mailbox h/w has. So keeing this code simple, but
adding some logic onto "omap_mbox_get()" would make sense.


> +		mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
> +		if (IS_ERR(mbox_ick_handle)) {
> +			printk(KERN_ERR "Could not get mailboxes_ick\n");
> +			return -ENODEV;
> +		}
> +		clk_enable(mbox_ick_handle);
>  
> -	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
> -	if (IS_ERR(mbox_ick_handle)) {
> -		printk("Could not get mailboxes_ick\n");
> -		return -ENODEV;
> -	}
> -	clk_enable(mbox_ick_handle);
> -
> -	l = mbox_read_reg(MAILBOX_REVISION);
> -	pr_info("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
> -
> -	/* set smart-idle & autoidle */
> -	l = mbox_read_reg(MAILBOX_SYSCONFIG);
> -	l |= 0x00000011;
> -	mbox_write_reg(l, MAILBOX_SYSCONFIG);
> +		l = mbox_read_reg(MAILBOX_REVISION);
> +		pr_info("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4,
> +							(l & 0x0f));
>  
> +		/* set smart-idle & autoidle */
> +		l = mbox_read_reg(MAILBOX_SYSCONFIG);
> +		l |= 0x00000011;
> +		mbox_write_reg(l, MAILBOX_SYSCONFIG);
> +	}
> +	mbox_configured++;
>  	omap2_mbox_enable_irq(mbox, IRQ_RX);
>  
>  	return 0;
>  }
>  
>  static void omap2_mbox_shutdown(struct omap_mbox *mbox)
> -{
> -	clk_disable(mbox_ick_handle);
> -	clk_put(mbox_ick_handle);
> +{	if (mbox_configured > 0)
> +		mbox_configured--;
> +		if (!mbox_configured) {
> +			clk_disable(mbox_ick_handle);
> +			clk_put(mbox_ick_handle);
> +			mbox_ick_handle = NULL;
> +		}
>  }
>  
>  /* Mailbox FIFO handle functions */
> @@ -123,7 +148,7 @@ static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
>  {
>  	struct omap_mbox2_fifo *fifo =
>  		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
> -	return (mbox_read_reg(fifo->fifo_stat));
> +	return mbox_read_reg(fifo->fifo_stat);
>  }
>  
>  /* Mailbox IRQ handle functions */
> @@ -143,10 +168,9 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
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
> @@ -156,6 +180,8 @@ static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
>  	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
>  
>  	mbox_write_reg(bit, p->irqstatus);
> +	/* Flush post writing */
> +	 mbox_read_reg(p->irqstatus);
>  }
>  
>  static int omap2_mbox_is_irq(struct omap_mbox *mbox,
> @@ -166,7 +192,7 @@ static int omap2_mbox_is_irq(struct omap_mbox *mbox,
>  	u32 enable = mbox_read_reg(p->irqenable);
>  	u32 status = mbox_read_reg(p->irqstatus);
>  
> -	return (enable & status & bit);
> +	return (int)(enable & status & bit);
>  }
>  
>  static void omap2_mbox_save_ctx(struct omap_mbox *mbox)
> @@ -219,9 +245,12 @@ static struct omap_mbox_ops omap2_mbox_ops = {
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
> @@ -234,7 +263,19 @@ static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
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
> @@ -242,6 +283,33 @@ struct omap_mbox mbox_dsp_info = {
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
> @@ -282,17 +350,31 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
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
> @@ -310,8 +392,14 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
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
> @@ -322,7 +410,13 @@ static int __devexit omap2_mbox_remove(struct platform_device *pdev)
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
> @@ -331,7 +425,7 @@ static struct platform_driver omap2_mbox_driver = {
>  	.probe = omap2_mbox_probe,
>  	.remove = __devexit_p(omap2_mbox_remove),
>  	.driver = {
> -		.name = "omap2-mailbox",
> +		.name = DRV_NAME,
>  	},
>  };
>  
> @@ -351,4 +445,4 @@ module_exit(omap2_mbox_exit);
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("omap mailbox: omap2/3 architecture specific functions");
>  MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Paul Mundt");
> -MODULE_ALIAS("platform:omap2-mailbox");
> +MODULE_ALIAS("platform:"DRV_NAME);
> -- 
> 1.5.3.2
