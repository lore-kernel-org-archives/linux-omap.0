From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC v2 01/18] mailbox: OMAP2+: Add support for AM33XX
Date: Tue, 1 Jan 2013 10:25:06 -0800
Message-ID: <20130101182506.GD22106@atomide.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-2-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45335 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752433Ab3AASZI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jan 2013 13:25:08 -0500
Content-Disposition: inline
In-Reply-To: <1356959231-17335-2-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Vaibhav Bedia <vaibhav.bedia@ti.com> [121231 05:10]:
> Mailbox IP on AM33XX is the same as that present in OMAP4.
> The single instance of Mailbox IP on AM33XX contains
> 8 sub-modules and facilitates communication between MPU,
> PRUs and WKUP_M3.
> 
> The first mailbox sub-module is assigned for communication
> between MPU and WKUP-M3.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Russ Dill <russ.dill@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> v1->v2:
> 	Address the comment on operator usage from Russ Dill
> 
>  drivers/mailbox/mailbox-omap2.c |   35 ++++++++++++++++++++++++++++++++++-
>  1 files changed, 34 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mailbox/mailbox-omap2.c b/drivers/mailbox/mailbox-omap2.c
> index 7c26bed..6d61159 100644
> --- a/drivers/mailbox/mailbox-omap2.c
> +++ b/drivers/mailbox/mailbox-omap2.c
> @@ -151,7 +151,7 @@ static void omap2_mbox_disable_irq(struct mailbox *mbox,
>  	struct omap_mbox2_priv *p = mbox->priv;
>  	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
>  
> -	if (!cpu_is_omap44xx())
> +	if (!cpu_is_omap44xx() && !soc_is_am33xx())
>  		bit = mbox_read_reg(p->irqdisable) & ~bit;
>  
>  	mbox_write_reg(bit, p->irqdisable);

The cpu_is/soc_is macros are no longer available to drivers
with 8d91a42e (Merge tag 'omap-late-cleanups'...). So you'll
have to pass whatever flags the driver needs in platform_data
or as device tree properties.

> @@ -386,6 +412,13 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  		list[0]->irq = list[1]->irq = platform_get_irq(pdev, 0);
>  	}
>  #endif
> +#if defined(CONFIG_SOC_AM33XX)
> +	else if (soc_is_am33xx()) {
> +		list = am33xx_mboxes;
> +
> +		list[0]->irq = platform_get_irq(pdev, 0);
> +	}
> +#endif
>  	else {
>  		pr_err("%s: platform not supported\n", __func__);
>  		return -ENODEV;

Here too.

Tony
