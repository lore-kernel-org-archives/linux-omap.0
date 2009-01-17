From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 07/10] omap mailbox: add save_/restore_ctx() for PM
Date: Sat, 17 Jan 2009 17:10:44 +0000
Message-ID: <20090117171044.GE12341@n2100.arm.linux.org.uk>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com> <20090116082737.17571.53738.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55919 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762729AbZAQRK5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2009 12:10:57 -0500
Content-Disposition: inline
In-Reply-To: <20090116082737.17571.53738.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jan 16, 2009 at 10:27:37AM +0200, Hiroshi DOYU wrote:
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index a877305..544dde9 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -32,6 +32,8 @@
>  #define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
>  #define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
>  
> +#define MBOX_REG_SIZE			0x120
> +
>  static void __iomem *mbox_base;
>  
>  struct omap_mbox2_fifo {
> @@ -47,6 +49,7 @@ struct omap_mbox2_priv {
>  	unsigned long irqstatus;
>  	u32 newmsg_bit;
>  	u32 notfull_bit;
> +	char ctx[MBOX_REG_SIZE];

	u32 ctx[MOX_REG_SIZE / sizeof(u32)];

?

>  };
>  
>  static struct clk *mbox_ick_handle;
> @@ -167,6 +170,36 @@ static int omap2_mbox_is_irq(struct omap_mbox *mbox,
>  	return (enable & status & bit);
>  }
>  
> +static void omap2_mbox_save_ctx(struct omap_mbox *mbox)
> +{
> +	int i;
> +	struct omap_mbox2_priv *p = mbox->priv;
> +
> +	for (i = 0; i < MBOX_REG_SIZE; i += sizeof(u32)) {
> +		u32 val;
> +
> +		val = mbox_read_reg(i);
> +		*(u32 *)(p->ctx + i) = val;

		p->ctx[i] = mbox_read_reg(i);

?

> +
> +		dev_dbg(mbox->dev, "%s\t[%02d] %08x\n", __func__, i, val);

tabs aren't nice in kernel messages.

		dev_dbg(mbox->dev, "%s: [%02d] %08x\n", __func__,
			i, p->ctx[i]);

also, mixing decimal and octal as bare numbers can be rather confusing.

> +	}
> +}
> +
> +static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
> +{
> +	int i;
> +	struct omap_mbox2_priv *p = mbox->priv;
> +
> +	for (i = 0; i < MBOX_REG_SIZE; i += sizeof(u32)) {
> +		u32 val;
> +
> +		val = *(u32 *)(p->ctx + i);
> +		mbox_write_reg(val, i);

		mbox_write_reg(p->ctx[i], i);

> +
> +		dev_dbg(mbox->dev, "%s\t[%02d] %08x\n", __func__, i, val);

		dev_dbg(mbox->dev, "%s: [%02d] %08x\n@, __func__,
			i, p->ctx[i]);
