From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes
	to support OMAP4 mailbox.
Date: Mon, 7 Sep 2009 16:05:20 +0100
Message-ID: <20090907150520.GC6538@flint.arm.linux.org.uk>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108F2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33882 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbZIGPFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 11:05:30 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108F2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

On Fri, Sep 04, 2009 at 05:18:11PM +0530, C.A, Subramaniam wrote:
> @@ -70,31 +89,37 @@ static inline void mbox_write_reg(u32 val, size_t ofs)
>  static int omap2_mbox_startup(struct omap_mbox *mbox)
>  {
>  	unsigned int l;
> +	if (!mbox_configured) {
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

I assume you're doing this because this function can be called multiple
times.  What protects this against races?

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

Same concern - what protects mbox_configured and the associated code against
races?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
