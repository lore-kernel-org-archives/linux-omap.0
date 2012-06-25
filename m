From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] memory: emif: add device tree support to emif
 driver
Date: Mon, 25 Jun 2012 11:28:30 -0700
Message-ID: <20120625182830.GA23850@kroah.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
 <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
 <20120614154820.GG17140@kroah.com>
 <CAMQu2gx5CCDyrvozX06neBnA8J2heg+HL7DOewDm5voxqbpetw@mail.gmail.com>
 <CAMQu2gy7oj-+1qCteAFMXEeOL-Wdrs6e4gKWM=HsOukXcPuv-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46871 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719Ab2FYS2f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 14:28:35 -0400
Received: by pbbrp8 with SMTP id rp8so6903805pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 11:28:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMQu2gy7oj-+1qCteAFMXEeOL-Wdrs6e4gKWM=HsOukXcPuv-A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>

On Tue, Jun 19, 2012 at 02:33:11PM +0530, Shilimkar, Santosh wrote:
> @@ -1644,11 +1923,23 @@ static void __attribute__((unused))
> freq_post_notify_handling(void)
>  	spin_unlock_irqrestore(&emif_lock, irq_state);
>  }
> 
> +#if defined(CONFIG_OF)
> +static const struct of_device_id emif_of_match[] = {
> +		{ .compatible = "ti,emif-4d" },
> +		{ .compatible = "ti,emif-4d5" },
> +		{},
> +};
> +MODULE_DEVICE_TABLE(of, emif_of_match);
> +#endif
> +
>  static struct platform_driver emif_driver = {
>  	.remove		= __exit_p(emif_remove),
>  	.shutdown	= emif_shutdown,
>  	.driver = {
>  		.name = "emif",
> +#if defined(CONFIG_OF)
> +		.of_match_table = of_match_ptr(emif_of_match),
> +#endif

Are these two still #if defined needed?

Also, what about the IS_DEFINED macro?

And, if you resend, please resend the whole series, I don't have the old
ones around anymore.

thanks,

greg k-h
