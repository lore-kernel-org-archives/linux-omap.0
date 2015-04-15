From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] genirq: Set IRQCHIP_SKIP_SET_WAKE flag for dummy_irq_chip
Date: Wed, 15 Apr 2015 11:29:44 +0200
Message-ID: <552E2F88.4000400@free-electrons.com>
References: <1427721345-6402-1-git-send-email-rogerq@ti.com> <552E1DD3.4040106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <552E1DD3.4040106-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 15/04/2015 10:14, Roger Quadros wrote:
> Without this system suspend is broken on systems that have
> drivers calling enable/disable_irq_wake() for interrupts based off
> the dummy irq hook.
> (e.g. drivers/gpio/gpio-pcf857x.c)
> 
> http://article.gmane.org/gmane.linux.kernel/1879035
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

FWIW:

Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>


> ---
>  kernel/irq/dummychip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
> index 988dc58..2feb6fe 100644
> --- a/kernel/irq/dummychip.c
> +++ b/kernel/irq/dummychip.c
> @@ -57,5 +57,6 @@ struct irq_chip dummy_irq_chip = {
>  	.irq_ack	= noop,
>  	.irq_mask	= noop,
>  	.irq_unmask	= noop,
> +	.flags		= IRQCHIP_SKIP_SET_WAKE,
>  };
>  EXPORT_SYMBOL_GPL(dummy_irq_chip);
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
