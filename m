From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 01/15] ARM: OMAP2+: mailbox: Add an API for flushing the
 FIFO
Date: Sat, 3 Nov 2012 21:33:47 +0530
Message-ID: <50954063.5010901@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-2-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756400Ab2KCQD6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 3 Nov 2012 12:03:58 -0400
In-Reply-To: <1351859566-24818-2-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> On AM33XX, the mailbox module between the MPU and the
> WKUP-M3 co-processor facilitates a one-way communication.
> MPU uses the assigned mailbox sub-module to issue the
> interrupt to the WKUP-M3 co-processor which then goes
> and reads the the IPC data from registers in the control
> module.
>
> WKUP-M3 is in the L4_WKUP and does not have any access to
> the Mailbox module. Due to this limitation, the MPU is
> completely responsible for FIFO maintenance and interrupt
> generation. MPU needs to ensure that the FIFO does not
> overflow by reading by the assigned mailbox sub-module.
>
> This patch adds an API in the mailbox code which the MPU
> can use to empty the FIFO by issuing a readback command.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>   arch/arm/mach-omap2/mailbox.c             |   42 ++++++++++++++++++++---------
>   arch/arm/plat-omap/include/plat/mailbox.h |    3 ++
>   arch/arm/plat-omap/mailbox.c              |   35 ++++++++++++++++++++++++
>   3 files changed, 67 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 0d97456..f38b4fa 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -123,6 +123,20 @@ static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
>   	return mbox_read_reg(fifo->fifo_stat);
>   }
>
> +static int omap2_mbox_fifo_needs_flush(struct omap_mbox *mbox)
> +{
> +	struct omap_mbox2_fifo *fifo =
> +		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
type casting is generally avoided in linux code.
> +	return mbox_read_reg(fifo->msg_stat);
> +}
> +
> +static mbox_msg_t omap2_mbox_fifo_readback(struct omap_mbox *mbox)
> +{
> +	struct omap_mbox2_fifo *fifo =
> +		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
> +	return (mbox_msg_t) mbox_read_reg(fifo->msg);
same here.
> +}
> +
>   /* Mailbox IRQ handle functions */
>   static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
>   		omap_mbox_type_t irq)
> @@ -205,19 +219,21 @@ static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
>   }
>
>   static struct omap_mbox_ops omap2_mbox_ops = {
> -	.type		= OMAP_MBOX_TYPE2,
> -	.startup	= omap2_mbox_startup,
> -	.shutdown	= omap2_mbox_shutdown,
> -	.fifo_read	= omap2_mbox_fifo_read,
> -	.fifo_write	= omap2_mbox_fifo_write,
> -	.fifo_empty	= omap2_mbox_fifo_empty,
> -	.fifo_full	= omap2_mbox_fifo_full,
> -	.enable_irq	= omap2_mbox_enable_irq,
> -	.disable_irq	= omap2_mbox_disable_irq,
> -	.ack_irq	= omap2_mbox_ack_irq,
> -	.is_irq		= omap2_mbox_is_irq,
> -	.save_ctx	= omap2_mbox_save_ctx,
> -	.restore_ctx	= omap2_mbox_restore_ctx,
> +	.type			= OMAP_MBOX_TYPE2,
> +	.startup		= omap2_mbox_startup,
> +	.shutdown		= omap2_mbox_shutdown,
> +	.fifo_read		= omap2_mbox_fifo_read,
> +	.fifo_write		= omap2_mbox_fifo_write,
> +	.fifo_empty		= omap2_mbox_fifo_empty,
> +	.fifo_full		= omap2_mbox_fifo_full,
> +	.fifo_needs_flush	= omap2_mbox_fifo_needs_flush,
> +	.fifo_readback		= omap2_mbox_fifo_readback,
> +	.enable_irq		= omap2_mbox_enable_irq,
> +	.disable_irq		= omap2_mbox_disable_irq,
> +	.ack_irq		= omap2_mbox_ack_irq,
> +	.is_irq			= omap2_mbox_is_irq,
> +	.save_ctx		= omap2_mbox_save_ctx,
> +	.restore_ctx		= omap2_mbox_restore_ctx,
You should do the indentation fix in another patch.

>   };
>
>   /*
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
> index cc3921e..e136529 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -29,6 +29,8 @@ struct omap_mbox_ops {
>   	void		(*fifo_write)(struct omap_mbox *mbox, mbox_msg_t msg);
>   	int		(*fifo_empty)(struct omap_mbox *mbox);
>   	int		(*fifo_full)(struct omap_mbox *mbox);
> +	int		(*fifo_needs_flush)(struct omap_mbox *mbox);
> +	mbox_msg_t	(*fifo_readback)(struct omap_mbox *mbox);
Do you think passing the msg structure as an argument and letting the
function populate it will be better instead of returning the msg
structure ? No strong opinion since from read_foo() point of view
what you have done might be right thing. In either case, please
get rid of typecasting.

Regards
Santosh
